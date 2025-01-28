using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Net;
using System.Diagnostics;
using System.IO;
using System.Web.Services;
using System.Text;


public partial class Basculas_Autorizacion_ingreso : System.Web.UI.Page
{
    // Clases para deserializar JSON de la segunda API
    public class QueueData
    {
        public QueueDataInner data { get; set; }
    }

    public class QueueDataInner
    {
        public int V { get; set; }
        public int P { get; set; }
        public int R { get; set; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        this.LogEvent("Inicio de la carga de la página Autorizacion de Ingreso.");
        if (!IsPostBack)
        {
            // URL de la primera API
            string url1 = "https://apiclientes.almapac.com:9010/api/shipping/status/3";
            // URL de la segunda API
            string url2 = "https://apiclientes.almapac.com:9010/api/queue/count/";

            // Token
            string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9uZXMiLCJzdWIiOjYsInJvbGVzIjpbImJvdCJdLCJpYXQiOjE3MzMzMjIxNDAsImV4cCI6MjUyMjI2MjE0MH0.LPLUEOv4kNsozjwc1BW6qZ5R1fqT_BwsF-MM5vY5_Cc";

            // Forzar el uso de TLS 1.2
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            using (WebClient client = new WebClient())
            {
                // Añadir el token al encabezado de autorización
                client.Headers.Add("Authorization", "Bearer " + token);
                client.Encoding = Encoding.UTF8;
                try
                {
                    // *** Primera API ***
                    string responseBody1 = client.DownloadString(url1);
                    var data1 = JsonConvert.DeserializeObject<List<Post>>(responseBody1);

                    // Filtrar y procesar datos de la primera API
                    // Filtrar por tipos de camiones
                    var truckTypeP = data1.Where(item => item.vehicle.truckType == "P" || item.vehicle.truckType == "R").ToList();
                    var truckTypeV = data1.Where(item => item.vehicle.truckType == "V").ToList();

                    // Contar registros por tipo
                    lblCountP.Text = truckTypeP.Count.ToString();
                    lblCountV.Text = truckTypeV.Count.ToString();

                    // Crear una lista de códigos de ingenio válidos
                    var validIngenios = new string[] { "001001-003", "007001-001", "007001-003", "001001-001", "001001-004", "001001-002" };

                    // Inicializar los conteos de ingenios
                    var ingenioCounts = new Dictionary<string, int>();

                    // Contar ingenios en todos los registros filtrados
                    foreach (var item in data1)
                    {
                        var ingenioNavCode = (item.ingenio != null) ? item.ingenio.ingenioNavCode : null; // Verificar nulos explícitamente
                        if (!string.IsNullOrEmpty(ingenioNavCode) && validIngenios.Contains(ingenioNavCode))
                        {
                            if (ingenioCounts.ContainsKey(ingenioNavCode))
                            {
                                ingenioCounts[ingenioNavCode]++;
                            }
                            else
                            {
                                ingenioCounts[ingenioNavCode] = 1;
                            }
                        }
                    }

                    // Procesar e insertar los conteos en las etiquetas correspondientes
                    int i = 1;
                    foreach (var ingenio in validIngenios)
                    {
                        // Usamos string.Format para construir el nombre del control de forma compatible con .NET 4.6
                        var txtIngenioQuantity = this.FindControl(string.Format("txtIngenioQuantity{0}", i.ToString())) as TextBox;
                        if (txtIngenioQuantity != null)
                        {
                            // Mostrar el conteo de ingenios o 0 si no existe
                            txtIngenioQuantity.Text = ingenioCounts.ContainsKey(ingenio) ? ingenioCounts[ingenio].ToString() : "0";
                        }
                        i++;
                    }

                    // Vincular los datos filtrados a los Repeaters correspondientes
                    rptRutas1.DataSource = truckTypeP;
                    rptRutas1.DataBind();

                    rptRutas2.DataSource = truckTypeV;
                    rptRutas2.DataBind();

                    int countP = 0;
                    int countV = 0;
                            
                    foreach (var item in data1)
                    {
                        if (item.vehicle.truckType == "P" || item.vehicle.truckType == "R")
                        {
                            countP++;
                        }
                        else if (item.vehicle.truckType == "V")
                        {
                            countV++;
                        }
                    }

                    lblCountP.Text = countP.ToString();
                    lblCountV.Text = countV.ToString();

                    // *** Segunda API ***
                    string responseBody2 = client.DownloadString(url2);

                    // Deserializar respuesta de la segunda API
                    var queueData = JsonConvert.DeserializeObject<QueueData>(responseBody2);

                    if (queueData != null && queueData.data != null)
                    {
                        // Asignar datos a etiquetas
                        lblV.Text = "" + queueData.data.V.ToString();
                        lblP.Text = "" + queueData.data.R.ToString();
                    }
                    else
                    {
                        // Si no hay datos, mostrar 0
                        lblV.Text = "0";
                        lblP.Text = "0";
                    }
                }
                catch (Exception ex)
                {
                    // Manejo de errores
                    lblV.Text = "0";
                    lblP.Text = "0";
                    lblCountP.Text = "0";
                    lblCountV.Text = "0";


                    // Puedes loguear o mostrar detalles del error para depuración.
                    Console.WriteLine("Error: " + ex.Message);
                    // Log detallado del error
                    this.LogEvent("Error al realizar la solicitud o procesar la respuesta.");
                    this.LogEvent("Mensaje de excepción: " + ex.Message);
                    this.LogEvent("Pila de llamadas: " + ex.StackTrace);
                }
            }
        }
    }

    [WebMethod]
public static string ChangeTransactionStatus(string codeGen)
{
    // Validar que codeGen no sea nulo o vacío
    if (string.IsNullOrEmpty(codeGen))
    {
        return "Error: El parámetro 'codeGen' no puede ser nulo o vacío.";
    }

    try
    {
        // Configurar la URL y el token
        string url = string.Format("https://apiclientes.almapac.com:9010/api/queue/send/{0}", codeGen);
        string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9uZXMiLCJzdWIiOjYsInJvbGVzIjpbImJvdCJdLCJpYXQiOjE3MzMzMjIxNDAsImV4cCI6MjUyMjI2MjE0MH0.LPLUEOv4kNsozjwc1BW6qZ5R1fqT_BwsF-MM5vY5_Cc";

        // Configurar el protocolo de seguridad
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

        using (var client = new WebClient())
        {
            // Configurar encabezados de solicitud
            client.Headers[HttpRequestHeader.Authorization] = "Bearer " + token;
            client.Headers[HttpRequestHeader.ContentType] = "application/json";

            // Realizar la solicitud POST
            string responseContent = client.UploadString(url, "POST", ""); // Sin cuerpo en la solicitud
            return "Cambio de estatus exitoso: " + responseContent;
        }
    }
    catch (WebException webEx)
    {
        try
        {
            // Obtener respuesta del servidor en caso de error HTTP
            using (var reader = new StreamReader(webEx.Response.GetResponseStream()))
            {
                string errorResponse = reader.ReadToEnd();
                LogEventS("Error al realizar la solicitud o procesar la respuesta.");
                LogEventS("Mensaje de excepción: " + webEx.Message);
                LogEventS("Pila de llamadas: " + webEx.StackTrace);
                return string.Format("Error en la solicitud: {0}. Respuesta del servidor: {1}", webEx.Message, errorResponse);
            }
        }
        catch
        {
            // Manejar casos donde no se pueda obtener la respuesta del servidor
            LogEventS("Error al realizar la solicitud o procesar la respuesta.");
            LogEventS("Mensaje de excepción: " + webEx.Message);
            LogEventS("Pila de llamadas: " + webEx.StackTrace);
            return string.Format("Error en la solicitud: {0}. No se pudo leer la respuesta del servidor.", webEx.Message);
            
        }
    }
    catch (Exception ex)
    {
        // Manejar errores generales
        LogEventS("Error al realizar la solicitud o procesar la respuesta.");
        LogEventS("Mensaje de excepción: " + ex.Message);
        LogEventS("Pila de llamadas: " + ex.StackTrace);
        return string.Format("Error inesperado: {0}", ex.Message);
    }
}


    private void DataBind()
    {
        sql_rutas_actividades.SelectCommand = "SELECT * FROM [dbo].[ALMAPAC$Work Type]";
        sql_rutas_actividades.DataBind();
    }

    public void LogEvent(object message)
    {
        string logFilePath = Server.MapPath("~/Logs/MyAppLog.txt");
        string logDirectory = Path.GetDirectoryName(logFilePath);

        // Crear el directorio si no existe
        if (!Directory.Exists(logDirectory))
        {
            Directory.CreateDirectory(logDirectory);
        }

        // Convertir el mensaje a string
        string logMessage;
        try
        {
            logMessage = JsonConvert.SerializeObject(message, Formatting.Indented);
        }
        catch
        {
            // Si la serialización falla, usar el método ToString() o "null" si es nulo
            logMessage = (message != null) ? message.ToString() : "null";
        }

        // Formatear el mensaje de log
        string formattedLog = String.Format("{0:yyyy-MM-dd HH:mm:ss} - {1}{2}", DateTime.Now, logMessage, Environment.NewLine);

        // Escribir el log en el archivo
        File.AppendAllText(logFilePath, formattedLog);
    }

    // Método para escribir en el Visor de eventos
    public static void LogEventS(object message)
    {
        string logFilePath = "C:/trasacciones-almapac-main/Logs/MyAppLog.txt"; // Ruta absoluta
        string logDirectory = Path.GetDirectoryName(logFilePath);

        // Crear el directorio si no existe
        if (!Directory.Exists(logDirectory))
        {
            Directory.CreateDirectory(logDirectory);
        }

        // Convertir el mensaje a string
        string logMessage;
        try
        {
            logMessage = JsonConvert.SerializeObject(message, Formatting.Indented);
        }
        catch
        {
            // Si la serialización falla, usar el método ToString() o "null" si es nulo
            logMessage = (message != null) ? message.ToString() : "null";
        }

        // Formatear el mensaje de log
        string formattedLog = String.Format("{0:yyyy-MM-dd HH:mm:ss} - {1}{2}", DateTime.Now, logMessage, Environment.NewLine);

        // Escribir el log en el archivo
        File.AppendAllText(logFilePath, formattedLog);
    }



public class IngenioCount
    {
        public string IngenioName { get; set; }
        public int Count { get; set; }
    }


    public class Post
    {
        public string nameProduct { get; set; }
        public int id { get; set; }
        public string codeGen { get; set; }
        public string product { get; set; }
        public string operationType { get; set; }
        public string loadType { get; set; }
        public string transporter { get; set; }
        public double productQuantity { get; set; }
        public long productQuantityKg { get; set; }
        public string unitMeasure { get; set; }
        public string requiresSweeping { get; set; }
        public DateTime createdAt { get; set; }
        public DateTime updatedAt { get; set; }
        public bool mapping { get; set; }
        public int currentStatus { get; set; }
        public DateTime dateTimeCurrentStatus { get; set; }
        public DateTime dateTimePrecheckeo { get; set; }
        public Driver driver { get; set; }
        public Vehicle vehicle { get; set; }
        public Ingenio ingenio { get; set; }
        public List<Status> statuses { get; set; }
        public List<ShipmentAttachment> shipmentAttachments { get; set; } // Agregado para los adjuntos
    }

    public class Driver
    {
        public int id { get; set; }
        public string license { get; set; }
        public string name { get; set; }
        public DateTime createdAt { get; set; }
        public DateTime updatedAt { get; set; }
    }

    public class Vehicle
    {
        public int id { get; set; }
        public string plate { get; set; }
        public string trailerPlate { get; set; }
        public string truckType { get; set; }
        public DateTime createdAt { get; set; }
        public DateTime updatedAt { get; set; }
    }

    public class Ingenio
    {
        public int id { get; set; }
        public string ingenioCode { get; set; }
        public string ingenioNavCode { get; set; }
        public string name { get; set; }
        public DateTime createdAt { get; set; }
        public DateTime updatedAt { get; set; }
        public User user { get; set; }
    }

    public class User
    {
        public int id { get; set; }
        public string username { get; set; }
        public string password { get; set; }
        public string role { get; set; }
        public DateTime createdAt { get; set; }
        public DateTime updatedAt { get; set; }
    }

    public class Status
    {
        public int id { get; set; }
        public string status { get; set; }
        public DateTime createdAt { get; set; }
        public string date { get; set; }
        public string time { get; set; }
    }

    public class ShipmentAttachment
    {
        public int id { get; set; }
        public string fileUrl { get; set; }
        public string fileName { get; set; }
        public string fileType { get; set; }
        public string attachmentType { get; set; }
        public DateTime createdAt { get; set; }
        public DateTime updatedAt { get; set; }
    }
   
    protected void lnk_VerRuta_Click(object sender, EventArgs e)
    {

        this.LogEvent("HOLA TEST");

        LinkButton lnk_VerRuta = (LinkButton)sender;
        GridViewRow row = (GridViewRow)lnk_VerRuta.NamingContainer;
        GridView gvw = (GridView)row.NamingContainer;
      
        //Hace el Binding.
        DataBindRutasDetalles();

        //Muestra el modal una vez hecho click en la fila.
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal-convertir", "$('#modal-detalle').modal();", true);
    }


    private void DataBindRutasDetalles()
    {
        //Delcara las variables.
        // string strWhere = " WHERE Fk_Actividad =" + hfCodigo.Value;
        string strSQL = "SELECT * FROM vw_LEVERANS_PLANTILLA_RUTAS";
        string strOrder = "";

        ////Ejecuta la consulta.
        //sql_rutas_actividadesDetalles.SelectCommand = strSQL + strWhere + strOrder;
        sql_rutas_actividadesDetalles.Select(new DataSourceSelectArguments());

        //Relaciona el recordset con el GridView
        sql_rutas_actividadesDetalles.DataBind();
        //gvw_rutasDetalles.DataBind();
    }

    protected void btn_agregar_Click(object sender, EventArgs e)
    {
        LinkButton btnAgregar = (LinkButton)sender;
        GridViewRow gvw_row = (GridViewRow)btnAgregar.NamingContainer;

        //asignamos los valores a los parametros
        sql_rutas_actividadesDetalles.InsertParameters["Correlativo"].DefaultValue = (gvw_row.FindControl("txt_correlativo") as TextBox).Text;
        sql_rutas_actividadesDetalles.InsertParameters["FK_Acceso"].DefaultValue = "1";
        //sql_rutas_actividadesDetalles.InsertParameters["FK_Actividad"].DefaultValue = hfCodigo.Value;
        //Ejecutamos el query

        sql_rutas_actividadesDetalles.Insert();
        DataBindRutasDetalles();
        Response.Redirect(Request.RawUrl, false);
    }

    [System.Web.Services.WebMethod]

    public static object getactividades(string codigo)
    {
        List<actividades> salida = new List<actividades>();

        string ConnectionString = ConfigurationManager.AppSettings["ConnStr2"];
        using (SqlConnection con = new SqlConnection(ConnectionString))
        {
            string query = string.Format("SELECT * FROM [ALMAPAC$Work Type]");
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    actividades datos = new actividades();
                    datos.codigo = int.Parse(reader["Code"].ToString());
                    datos.descripcion = reader["Description"].ToString();
                    salida.Add(datos);
                }
            }
            con.Close();
        }
        object json = new { data = salida };
        return json;
    }

    protected void gvw_rutasDetalles_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView gvw_rutasDetalles = (GridView)sender;
        sql_rutas_actividadesDetalles.DeleteParameters["PK_Rutas"].DefaultValue = gvw_rutasDetalles.DataKeys[e.RowIndex].Value.ToString();
        sql_rutas_actividadesDetalles.Delete();

        gvw_rutasDetalles.EditIndex = -1;
        Response.Redirect(Request.RawUrl, false);
    }

    protected void gvw_rutasDetalles_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView gvw_rutasDetalles = (GridView)sender;
        GridViewRow row = gvw_rutasDetalles.Rows[e.RowIndex];

        sql_rutas_actividadesDetalles.UpdateParameters["PK_Rutas"].DefaultValue = gvw_rutasDetalles.DataKeys[e.RowIndex].Value.ToString();
        sql_rutas_actividadesDetalles.UpdateParameters["Correlativo"].DefaultValue = (row.FindControl("txt_correlativo") as TextBox).Text;
        sql_rutas_actividadesDetalles.UpdateParameters["FK_Acceso"].DefaultValue = (row.FindControl("ddlAccesos") as DropDownList).SelectedValue;
        sql_rutas_actividadesDetalles.UpdateParameters["Estado"].DefaultValue = ((row.FindControl("CheckBox1") as CheckBox).Checked).ToString();
        sql_rutas_actividadesDetalles.Update();
        Response.Redirect(Request.RawUrl, false);
    }

    protected void lnk_perfil_Click(object sender, EventArgs e)
    {
        txtUsuario.Text = Request.Cookies["username"].Value;
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal-convertir", "$('#editPass').modal();", true);
    }

    protected void LinkSalir1_Click(object sender, EventArgs e)
    {
        // FormsAuthentication.SignOut();
        // FormsAuthentication.RedirectToLoginPage();
    }
}