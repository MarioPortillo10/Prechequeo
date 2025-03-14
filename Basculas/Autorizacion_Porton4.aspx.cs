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


public partial class Basculas_Autorizacion_Porton4 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
{
    this.LogEvent("-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
    this.LogEvent("Inicio de la carga de la página Chequeo de entrada.");
    if (Request.Cookies["username"] != null && Request.Cookies["cod_bascula"] != null && Request.Cookies["cod_usuario"] != null && Request.Cookies["cod_turno"] != null)
    {
        string username = Request.Cookies["username"].Value;
        string cod_bascula = Request.Cookies["cod_bascula"].Value;
        string cod_usuario = Request.Cookies["cod_usuario"].Value;
        string cod_turno = Request.Cookies["cod_turno"].Value;

        if (!IsPostBack)
        {
            // URL que deseas hacer el fetch
            string url = "https://apiclientes.almapac.com:9010/api/shipping/status/4?page=1&size=10000&includeAttachments=true";

            // Token
            string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImZyb250ZW5kX3ByZXRyYW5zYWN0aW9uc19xdWlja3Bhc3MiLCJzdWIiOjMsInJvbGVzIjpbImJvdCJdLCJpYXQiOjE3Mzk4NDc0MTMsImV4cCI6MjUyODc4NzQxM30.eApDwV3eK7Tlf_HfoJ--V3Pay5oF7mUzazTusfrzguM";

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

                    // Definir la zona horaria de UTC -6
                    TimeZoneInfo utcMinus6 = TimeZoneInfo.FindSystemTimeZoneById("Central Standard Time"); // Ajusta según tu zona horaria

                    // Convertir dateTimePrecheckeo a UTC -6
                    foreach (var item in data)
                    {
                        if (item.dateTimePrecheckeo != DateTime.MinValue)
                        {
                            item.dateTimePrecheckeo = TimeZoneInfo.ConvertTimeFromUtc(item.dateTimePrecheckeo, utcMinus6);
                        }
                    }

                    // Filtrar para mostrar solo aquellos registros donde el último estatus tiene id = 4
                    var filteredData = data.Where(p => p.currentStatus == 4 && p.dateTimePrecheckeo != null)
                                           .OrderBy(p => p.dateTimePrecheckeo) // Ordenar por dateTimePrecheckeo
                                           .ToList();

                    // Vincular los datos filtrados y ordenados al control Repeater
                    rptRutas.DataSource = filteredData;
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
    else
    {
        Response.Redirect("login.aspx");
    }
}


    [WebMethod]
    public static string ValidarDatos(string codigoGeneracion, string marchamo1, string marchamo2, string marchamo3, string marchamo4)
    {
        if (string.IsNullOrEmpty(codigoGeneracion))
        {
            return "Error: El código de generación no puede estar vacío.";
        }

        string url = string.Format("https://apiclientes.almapac.com:9010/api/shipping/{0}?includeAttachments=true", codigoGeneracion);
        string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImZyb250ZW5kX3ByZXRyYW5zYWN0aW9uc19xdWlja3Bhc3MiLCJzdWIiOjMsInJvbGVzIjpbImJvdCJdLCJpYXQiOjE3Mzk4NDc0MTMsImV4cCI6MjUyODc4NzQxM30.eApDwV3eK7Tlf_HfoJ--V3Pay5oF7mUzazTusfrzguM";
        
        // Forzar el uso de TLS 1.2
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
        
        try
        {
            using (WebClient client = new WebClient())
            {
                client.Headers.Add("Authorization", "Bearer " + token);

                // Descarga los datos de la API
                string responseBody = client.DownloadString(url);

                // Deserializa los datos en el objeto Post
                var data = JsonConvert.DeserializeObject<Post>(responseBody);

                // Validar que haya información de sellos en la respuesta
                if (data == null || data.shipmentSeals == null || !data.shipmentSeals.Any())
                {
                    return "Error: No hay sellos disponibles en el sistema para validar.";
                }

                // Crear la lista de marchamos ingresados
                var marchamos = new List<string> { marchamo1, marchamo2, marchamo3, marchamo4 }
                                .Where(m => !string.IsNullOrEmpty(m)) // Filtrar vacíos
                                .ToList();

                if (!marchamos.Any())
                {
                    return "Error: Debes ingresar al menos un marchamo para validar.";
                }

                // Extraer los sealCodes de la respuesta
                var sealCodes = data.shipmentSeals.Select(seal => seal.sealCode).ToList();

                // Validar si todos los marchamos ingresados están en los sealCodes
                bool validacionExitosa = !marchamos.Except(sealCodes).Any();

                return validacionExitosa
                    ? "Validación exitosa: todos los marchamos son correctos."
                    : "Error: uno o más marchamos no coinciden con los datos del servidor.";
            }
        }
        catch (WebException webEx)
        { 
            // Manejar errores HTTP
            var response = webEx.Response as HttpWebResponse;
            if (response != null)
            {
                if (response.StatusCode == HttpStatusCode.NotFound)
                {
                    return "Error: El código de generación no se encontró (404).";
                }
                using (var stream = response.GetResponseStream())
                using (var reader = new StreamReader(stream))
                {
                    string errorResponse = reader.ReadToEnd();
                    return string.Format("Error en la solicitud: {0}", errorResponse);
                }
            }
            return string.Format("Error en la solicitud: {0}", webEx.Message);
            // Log detallado del error
            LogEventS("Error al realizar la solicitud o procesar la respuesta.");
            LogEventS("Mensaje de excepción: " + webEx.Message);
            LogEventS("Pila de llamadas: " + webEx.StackTrace);
        }
        catch (Exception ex)
        {
            return string.Format("Error: {0}", ex.Message);
            // Log detallado del error
            LogEventS("Error al realizar la solicitud o procesar la respuesta.");
            LogEventS("Mensaje de excepción: " + ex.Message);
            LogEventS("Pila de llamadas: " + ex.StackTrace);
        }
    }

    protected string FormatTimeDifference(DateTime dateTimePrecheckeo)
    {
        TimeSpan difference = DateTime.Now - dateTimePrecheckeo;

        if (difference.TotalHours >= 1)
        {
            // Si la diferencia es mayor o igual a una hora, mostramos horas y minutos
            int hours = (int)difference.TotalHours;
            int minutes = difference.Minutes;
            return string.Format("{0} hora{1} y {2} minuto{3}", hours, hours > 1 ? "s" : "", minutes, minutes != 1 ? "s" : "");
        }
        else
        {
            // Si la diferencia es menor a una hora, mostramos solo minutos
            int totalMinutes = (int)difference.TotalMinutes;
            return string.Format("{0} minuto{1}", totalMinutes, totalMinutes != 1 ? "s" : "");
        }
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
        public int? idNavRecord { get; set; }
        public DateTime dateTimeCurrentStatus { get; set; }
        public DateTime dateTimePrecheckeo { get; set; }
        public int? idPreTransaccionLeverans { get; set; }
        public bool mapping { get; set; }
        public Driver driver { get; set; }
        public Vehicle vehicle { get; set; }
        public Ingenio ingenio { get; set; }
        public List<Status> statuses { get; set; }
        public List<ShipmentAttachment> shipmentAttachments { get; set; } // Agregado para los adjuntos
        public List<ShipmentSeal> shipmentSeals { get; set; }
        //public NavRecord navRecord { get; set; }
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
/*
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

   */

 

    protected void lnk_VerRuta_Click(object sender, EventArgs e)
    {
        LinkButton lnk_VerRuta = (LinkButton)sender;
        GridViewRow row = (GridViewRow)lnk_VerRuta.NamingContainer;
        GridView gvw = (GridView)row.NamingContainer;
        ////Guarda el valor de la llave primaria.
        //hfCodigo.Value = gvw_rutas_plantillas.DataKeys[row.RowIndex].Value.ToString();

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
       
        //Relaciona el recordset con el GridView
       
        //gvw_rutasDetalles.DataBind();
    }

    protected void btn_agregar_Click(object sender, EventArgs e)
    {
        LinkButton btnAgregar = (LinkButton)sender;
        GridViewRow gvw_row = (GridViewRow)btnAgregar.NamingContainer;

        //asignamos los valores a los parametros
        //Ejecutamos el query

       
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
    }

    protected void gvw_rutasDetalles_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView gvw_rutasDetalles = (GridView)sender;
        GridViewRow row = gvw_rutasDetalles.Rows[e.RowIndex];
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