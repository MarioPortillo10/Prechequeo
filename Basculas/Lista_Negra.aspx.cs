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
using System.IO;        
using System;
using System.Net;
using System.Web.Services;
using System.Text;
using System.Diagnostics;


public partial class Basculas_Lista_Negra : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // URL que deseas hacer el fetch
            string url = "https://apiclientes.almapac.com:9010/api/blacklist";

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
                    // Realizar la solicitud GET y leer la respuesta
                    string responseBody = client.DownloadString(url);

                    // Deserializar la respuesta JSON
                    var data = JsonConvert.DeserializeObject<List<Post>>(responseBody);

                    // Vincular los datos filtrados al control Repeater
                    rptRutas.DataSource = data;
                    rptRutas.DataBind();
                }
                catch (Exception ex)
                {
                    // Manejo de errores (por ejemplo, mostrar un mensaje de error)
                    Console.WriteLine("Error al obtener o procesar los datos: " + ex.Message);
                    // Log detallado del error
                    this.LogEvent("Error al realizar la solicitud o procesar la respuesta.");
                    this.LogEvent("Mensaje de excepción: " + ex.Message);
                    this.LogEvent("Pila de llamadas: " + ex.StackTrace);
                }
            }
        }
    }

    [WebMethod]
public static string addBlacklist(string licencia, string tiempo, string observacion)
{
    string url = "https://apiclientes.almapac.com:9010/api/blacklist";
    string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9uZXMiLCJzdWIiOjYsInJvbGVzIjpbImJvdCJdLCJpYXQiOjE3MzMzMjIxNDAsImV4cCI6MjUyMjI2MjE0MH0.LPLUEOv4kNsozjwc1BW6qZ5R1fqT_BwsF-MM5vY5_Cc";
    string responseContent = string.Empty;

    try
    {   
        // Configurar protocolo TLS
        System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12;

        // (Opcional) Ignorar validación del certificado
        System.Net.ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };

        using (var client = new WebClient())
        {
            client.Headers[HttpRequestHeader.Authorization] = "Bearer " + token;
            client.Headers[HttpRequestHeader.ContentType] = "application/json";

            var requestBody = new { license = licencia, observation = observacion, timeInDays = tiempo };
            var json = JsonConvert.SerializeObject(requestBody);

            // Log de la solicitud
            LogEventS(new { Message = "Enviando solicitud al servidor", URL = url, RequestBody = requestBody });

            responseContent = client.UploadString(url, "POST", json);

            // Log de la respuesta
            LogEventS(new { Message = "Respuesta recibida del servidor", ResponseContent = responseContent });

            // Si la respuesta es exitosa, devolver éxito
            return JsonConvert.SerializeObject(new
            {
                alertType = "success", // Tipo de alerta
                message = "El motorista fue registrado correctamente.", // Mensaje a mostrar
                serverResponse = responseContent
            });
        }
    }
    catch (WebException webEx)
    {
        string serverResponse = "";

        if (webEx.Response != null)
        {
            using (var reader = new StreamReader(webEx.Response.GetResponseStream()))
            {
                serverResponse = reader.ReadToEnd();
            }
        }

        // Verificar si los datos están vacíos o si ocurrió un error
        if (string.IsNullOrEmpty(serverResponse))
        {
            // Inyectar el script SweetAlert al frontend
            ScriptManager.RegisterStartupScript(HttpContext.Current.Handler as Page, 
                typeof(Page), 
                "notFoundAlert", 
                "Swal.fire('Error', 'La transacción no se encontró en la API.', 'error').then(() => { location.reload(); });", 
                true);
        }

        // Log del error
        LogEventS(new { Message = "WebException capturada", WebExceptionMessage = webEx.Message, ServerResponse = serverResponse });

        return JsonConvert.SerializeObject(new
        {
            alertType = "error", // Tipo de alerta en caso de error
            message = "Error en la solicitud: " + webEx.Message, // Mensaje de error
            serverResponse = serverResponse
        });
    }
    catch (Exception ex)
    {
        // Log de excepción general
        LogEventS(new { Message = "Excepción general capturada", ExceptionMessage = ex.Message, StackTrace = ex.StackTrace });

        // Inyectar el script SweetAlert al frontend
        ScriptManager.RegisterStartupScript(HttpContext.Current.Handler as Page, 
            typeof(Page), 
            "unexpectedErrorAlert", 
            "Swal.fire('Error inesperado', 'Ocurrió un error inesperado.', 'error');", 
            true);

        return JsonConvert.SerializeObject(new
        {
            alertType = "error", // Tipo de alerta en caso de excepción general
            message = "Error inesperado: " + ex.Message // Mensaje de error
        });
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
        catch (Exception ex)
        {
            // Manejar errores al escribir el log
            // Considera usar un método de respaldo como Event Viewer
            Console.WriteLine("Error al escribir el log: " + ex.Message);
        }
    }


    public class Post
    {
        public int id { get; set; }
        public string observation { get; set; }
        public string severityLevel { get; set; }
        public DateTime createdAt { get; set; }
        public string banDurationDays { get; set; }
        public string shipmentAttachments { get; set; }
        public Driver driver { get; set; }
    }

    public class Driver
    {
        public int id { get; set; }
        public string license { get; set; }
        public string name { get; set; }
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