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


public partial class Basculas_Tiempos_azucar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // URL que deseas hacer el fetch
            string url = "https://apiclientes.almapac.com:9010/api/shipping/status/7?includeAttachments=true";
            string url1 = "https://apiclientes.almapac.com:9010/api/shipping/status/8?includeAttachments=true";

            // Token
            string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9uZXMiLCJzdWIiOjYsInJvbGVzIjpbImJvdCJdLCJpYXQiOjE3MzMzMjIxNDAsImV4cCI6MjUyMjI2MjE0MH0.LPLUEOv4kNsozjwc1BW6qZ5R1fqT_BwsF-MM5vY5_Cc";
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

            using (WebClient client = new WebClient())
            {
                client.Headers.Add("Authorization", "Bearer " + token);
                client.Encoding = Encoding.UTF8;

                try
                {
                    //this.LogEvent("Estoy aqui");
                    string responseBody = client.DownloadString(url);
                    var data = JsonConvert.DeserializeObject<List<Post>>(responseBody);

                    var filteredData = data.Where(p => p.currentStatus == 7 && p.vehicle != null && p.vehicle.truckType == "P"  || p.vehicle.truckType == "R")
                    .Select(p =>
                    {
                        // Formatear el campo dateTimePrecheckeo directamente
                        string timeForPrecheck = p.dateTimePrecheckeo.ToString("yyyy-MM-dd HH:mm:ss");

                        p.TimeForId2 = timeForPrecheck; // Asignar el valor al campo existente o equivalente
                        return p;
                    }).ToList();

                    // Depuración: Verifica el conteo de registros
                    Console.WriteLine("Número de registros filtrados: " + filteredData.Count);

                    if (filteredData.Count > 0)
                    {
                        lblTotalRegistros.Text = filteredData.Count.ToString();
                    }
                    else
                    {
                        lblTotalRegistros.Text = "0";
                    }

                    // Vincula los datos filtrados al Repeater
                    rptRutas.DataSource = filteredData;
                    rptRutas.DataBind();

                    // Depuración: Imprime los datos en la consola
                    foreach (var item in filteredData)
                    {
                        Console.WriteLine(String.Format("ID: {0}, TimeForPrecheck: {1}", item.id, item.TimeForId2));
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error al obtener o procesar los datos: " + ex.Message);
                    this.LogEvent(ex.Message);
                    this.LogEvent(ex.StackTrace);
                    lblTotalRegistros.Text = "0";
                }
            }

            using (WebClient client = new WebClient())
            {
                // Añadir el token al encabezado de autorización
                client.Headers.Add("Authorization", "Bearer " + token);
                client.Encoding = Encoding.UTF8;

                try
                {
                    // Realizar la solicitud GET y leer la respuesta
                    string responseBody = client.DownloadString(url1);

                    // Deserializar la respuesta JSON
                    var data = JsonConvert.DeserializeObject<List<Post>>(responseBody);

                    // Filtrar para mostrar solo aquellos registros donde el currentStatus es 8
                    // y el tipo de camión es 'PLANA'
                    var filteredData = data.Where(p => p.currentStatus == 8 && p.vehicle != null && p.vehicle.truckType == "P" || p.vehicle.truckType == "R")
                    .Select(p =>
                    {
                        // Formatear el campo dateTimePrecheckeo directamente
                        string timeForPrecheck = p.dateTimePrecheckeo.ToString("yyyy-MM-dd HH:mm:ss");

                        // Asignar el valor del tiempo al campo TimeForId2
                        p.TimeForId2 = timeForPrecheck;

                        // Retornar el objeto con los datos filtrados
                        return p;
                    }).ToList();

                    // Vincular los datos filtrados al control Repeater
                    rptRutas1.DataSource = filteredData;
                    rptRutas1.DataBind();
                }
                catch (Exception ex)
                {
                    // Manejo de errores (por ejemplo, mostrar un mensaje de error)
                    Console.WriteLine("Error al obtener o procesar los datos: " + ex.Message);
                }
            }

            using (WebClient client = new WebClient())
            {
                // Añadir el token al encabezado de autorización
                client.Headers.Add("Authorization", "Bearer " + token);
                client.Encoding = Encoding.UTF8;
                try
                {
                    // Realizar la solicitud GET y leer la respuesta
                    string responseBody = client.DownloadString(url);

                    // Deserializar la respuesta JSON
                    var data = JsonConvert.DeserializeObject<List<Post>>(responseBody);

                    // Filtrar para mostrar solo aquellos registros donde el currentStatus es 7
                    // y el tipo de camión es 'VOLTEO'
                    var filteredData = data.Where(p => 
                        p.currentStatus == 7 && // Filtrar por currentStatus
                        p.vehicle != null && 
                        p.vehicle.truckType == "V"
                    )
                    .Select(p =>
                    {
                        // Asignar el tiempo directamente a TimeForId2
                        p.TimeForId2 = "No disponible"; // Este es el valor por defecto
                        // Retornar el objeto con los datos filtrados
                        return p;
                    })
                    .ToList();

                    // Asigna el conteo de los registros filtrados al Label
                    lblTotalRegistrosV.Text = String.Format("{0}", filteredData.Count);

                    // Vincular los datos filtrados al control Repeater
                    rptRutas2.DataSource = filteredData;
                    rptRutas2.DataBind();
                }
                catch (Exception ex)
                {
                    // Manejo de errores (por ejemplo, mostrar un mensaje de error)
                    Console.WriteLine("Error al obtener o procesar los datos: " + ex.Message);
                    lblTotalRegistrosV.Text = "0";
                }
            }

            using (WebClient client = new WebClient())
            {
                // Añadir el token al encabezado de autorización
                client.Headers.Add("Authorization", "Bearer " + token);
                client.Encoding = Encoding.UTF8;
                try
                {
                    // Realizar la solicitud GET y leer la respuesta
                    string responseBody = client.DownloadString(url1);

                    // Deserializar la respuesta JSON
                    var data = JsonConvert.DeserializeObject<List<Post>>(responseBody);

                    // Filtrar para mostrar solo aquellos registros donde el currentStatus es 8
                    // y el tipo de camión es 'VOLTEO'
                    var filteredData = data.Where(p => 
                        p.currentStatus == 8 && // Filtrar por currentStatus
                        p.vehicle != null && 
                        p.vehicle.truckType == "V"
                    )
                    .Select(p =>
                    {
                        // Asignar el tiempo directamente a TimeForId2
                        p.TimeForId2 = "No disponible"; // Este es el valor por defecto

                         // Retornar el objeto con los datos filtrados
                         return p;
                    })
                    .ToList();

                    // Vincular los datos filtrados al control Repeater
                    rptRutas3.DataSource = filteredData;
                    rptRutas3.DataBind();
                }
                catch (Exception ex)
                {
                    // Manejo de errores (por ejemplo, mostrar un mensaje de error)
                    Console.WriteLine("Error al obtener o procesar los datos: " + ex.Message);
                }
            
            }
        }
    }
    


    [WebMethod]
    public static string SolicitarUnidad(string Tipo_Unidad, int currentValue)
{
    // Código para solicitar una unidad
    string baseUrl = "https://apiclientes.almapac.com:9010/api/queue/call-multiple/";
    string url = baseUrl + Tipo_Unidad + "/" + currentValue;

    // Token de autenticación
    string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9uZXMiLCJzdWIiOjYsInJvbGVzIjpbImJvdCJdLCJpYXQiOjE3MzMzMjIxNDAsImV4cCI6MjUyMjI2MjE0MH0.LPLUEOv4kNsozjwc1BW6qZ5R1fqT_BwsF-MM5vY5_Cc";
    ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

    try
    {
        using (WebClient client = new WebClient())
        {
            try
            {
                // Configurar los encabezados
                client.Headers[HttpRequestHeader.Authorization] = "Bearer " + token;
                client.Headers[HttpRequestHeader.ContentType] = "application/json";

                // Log de la URL de la solicitud
                LogEventS("URL de solicitud: " + url);

                // Enviar la solicitud POST sin cuerpo
                string response = client.UploadString(url, "POST", "");

                // Log de la respuesta
                LogEventS("Respuesta de la API: " + response);

                // Verificar si la respuesta está vacía
                if (string.IsNullOrEmpty(response))
                {
                    LogEventS("El servidor no devolvió respuesta.");
                    return "El servidor no devolvió respuesta.";
                }

                // Intentar parsear la respuesta como JSON
                try
                {
                    // Deserializar la respuesta como un arreglo JSON (JArray)
                    var responseArray = JsonConvert.DeserializeObject(response) as Newtonsoft.Json.Linq.JArray;

                    // Verificar si el arreglo contiene elementos
                    if (responseArray != null && responseArray.Count > 0)
                    {
                        // Extraer información del primer objeto del arreglo
                        var firstItem = responseArray[0];
                        string status = firstItem["status"] != null ? firstItem["status"].ToString() : "No status";
                        string entryTime = firstItem["entryTime"] != null ? firstItem["entryTime"].ToString() : "No entryTime";

                        // Crear un mensaje de respuesta
                        string serverResponse = "Status: " + status + ", EntryTime: " + entryTime;

                        // Log del mensaje de respuesta
                        LogEventS("Respuesta exitosa: " + serverResponse);
                        return serverResponse;
                    }
                    else
                    {
                        LogEventS("La respuesta de la API está vacía.");
                        return "La respuesta de la API está vacía.";
                    }
                }
                catch (JsonException ex)
                {
                    // Si la respuesta no es un JSON válido
                    LogEventS("Error al procesar la respuesta JSON: " + ex.Message);
                    return "Error al procesar la respuesta JSON: " + ex.Message;
                }
            }
            catch (Exception ex)
            {
                // Captura cualquier error dentro del bloque 'using'
                LogEventS("Error al realizar la solicitud: " + ex.Message);
                return "Error al realizar la solicitud: " + ex.Message;
            }
        }
    }
    catch (Exception ex)
    {
        // Captura cualquier error inesperado fuera del 'using'
        LogEventS("Error inesperado: " + ex.Message);
        return "Error inesperado: " + ex.Message;
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
        try
        {
            // Convertir la ruta relativa a absoluta
            string logFilePath = HttpContext.Current.Server.MapPath("~/Logs/MyAppLog.txt");
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
                // Intentar serializar el mensaje en formato JSON
                logMessage = JsonConvert.SerializeObject(message, Formatting.Indented);
            }
            catch (Exception ex)
            {
                // Si la serialización falla, usa el método ToString() o "null" si es nulo
                logMessage = (message != null) ? message.ToString() : "null";

                // Log de error en caso de fallo en la serialización
                logMessage = string.Format("[Error al serializar mensaje]: {0} - {1}", ex.Message, logMessage);
            }

            // Formatear el mensaje de log con la fecha y hora
            string formattedLog = string.Format("{0:yyyy-MM-dd HH:mm:ss} - {1}{2}", DateTime.Now, logMessage, Environment.NewLine);

            // Escribir el log en el archivo, asegurándose de que no se sobrescriba el archivo existente
            File.AppendAllText(logFilePath, formattedLog);
        }
        catch (Exception ex)
        {
            // Manejar cualquier error al escribir el log
            // En este caso, se escribe un mensaje en la consola (esto puede cambiarse por otro método de logging)
            Console.WriteLine("Error al escribir el log: " + ex.Message);
        }
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
        public int currentStatus { get; set; }
        public DateTime dateTimeCurrentStatus { get; set; }
        public DateTime dateTimePrecheckeo { get; set; }
        public int idNavRecord { get; set; }
        public bool mapping { get; set; }
        public Driver driver { get; set; }
        public Vehicle vehicle { get; set; }
        public Ingenio ingenio { get; set; }
        public List<Status> statuses { get; set; }
        public List<ShipmentAttachment> shipmentAttachments { get; set; } // Agregado para los adjuntos
        public List<ShipmentSeal> shipmentSeals { get; set; }
        public NavRecord navRecord { get; set; }
        // Propiedades existentes...
        public string TimeForId2 { get; set; }  // Propiedad adicional para mostrar la hora
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

    public class ShipmentSeal
    {
        public int id { get; set; }
        public string sealCode { get; set; }
        public string sealDescription { get; set; }
        public DateTime createdAt { get; set; }
    }

    public class NavRecord
    {
        public string timestamp { get; set; }
        public int id { get; set; }
        public int transaccion { get; set; }
        public string ticket { get; set; }
        public DateTime fechaentra { get; set; }
        public string horaentra { get; set; }
        public DateTime fechasale { get; set; }
        public string horasale { get; set; }
        public string tiempo { get; set; }
        public int tarjetano { get; set; }
        public int bascula { get; set; }
        public int bascula2 { get; set; }
        public string actividad { get; set; }
        public string descActividad { get; set; }
        public string almacen { get; set; }
        public string descAlmacen { get; set; }
        public string producto { get; set; }
        public string descProducto { get; set; }
        public string categoria { get; set; }
        public int pesoin { get; set; }
        public int pesoout { get; set; }
        public int pesoneto { get; set; }
        public string cliente { get; set; }
        public string descCliente { get; set; }
        public string vehiculo { get; set; }
        public string motorista { get; set; }
        public string descMotorista { get; set; }
        public string transportista { get; set; }
        public string descTransportista { get; set; }
        public string codbuque { get; set; }
        public string buque { get; set; }
        public string envioingenio { get; set; }
        public string envioalmapac { get; set; }
        public string viajecepa { get; set; }
        public string boletacepa { get; set; }
        public int pesocepa { get; set; }
        public int tipocarga { get; set; }
        public string observaciones { get; set; }
        public string usuario { get; set; }
        public int semaforo { get; set; }
        public int semaforo2 { get; set; }
        public int semaforo3 { get; set; }
        public int semaforo4 { get; set; }
        public int estatus { get; set; }
        public int salida { get; set; }
        public int codfactor { get; set; }
        public int factor1 { get; set; }
        public int factor2 { get; set; }
        public int factor3 { get; set; }
        public int pesocliente { get; set; }
        public int equivalencia { get; set; }
        public string ticketgranel { get; set; }
        public string ticketensacado { get; set; }
        public string almacen2 { get; set; }
        public string descAlmacen2 { get; set; }
        public string ticketlimpieza { get; set; }
        public string codigounidad { get; set; }
        public string ordenretiro { get; set; }
        public int tipocamion { get; set; }
        public int tipocamionr { get; set; }
        public int pesoreal { get; set; }
        public string usuariosale { get; set; }
        public string usuariomod { get; set; }
        public int registro { get; set; }
        public int dobleticket { get; set; }
        public int ticketenano { get; set; }
        public int disponible { get; set; }
        public DateTime fechabarco { get; set; }
        public DateTime fechabarco2 { get; set; }
        public int pesoinv1 { get; set; }
        public int pesoinv2 { get; set; }
        public string remision { get; set; }
        public string licencia { get; set; }
        public string mercancia { get; set; }
        public string contenedor { get; set; }
        public int bultos { get; set; }
        public string documentos { get; set; }
        public DateTime fechaTemp { get; set; }
        public int temperatura { get; set; }
        public int basculaEntrada { get; set; }
        public int idZafra { get; set; }
        public int peso2 { get; set; }
        public int codbuque2 { get; set; }
        public int statusAuthorized { get; set; }
        public string puerta { get; set; }
        public int status { get; set; }
        public int inventory { get; set; }
        public int quantityRelasedI { get; set; }
        public int liquidacion { get; set; }
        public string codbuque21 { get; set; }
        public string codbuque3 { get; set; }
        public string codbuque4 { get; set; }
        public string codbuque5 { get; set; }
        public int agentLogTruck { get; set; }
        public string lotNo { get; set; }
        public int qtyRelasedAvailability { get; set; }
        public string marchamo1 { get; set; }
        public string marchamo2 { get; set; }
        public string marchamo3 { get; set; }
        public string marchamo4 { get; set; }
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