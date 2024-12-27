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


public partial class Basculas_Autorizacion_Camiones : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
         // Verificamos si las cookies están presentes
        if (Request.Cookies["username"] != null && Request.Cookies["cod_bascula"] != null && Request.Cookies["cod_usuario"] != null && Request.Cookies["cod_turno"] != null)
        {
            // Obtener los valores de las cookies
            string username = Request.Cookies["username"].Value;
            string cod_bascula = Request.Cookies["cod_bascula"].Value;
            string cod_usuario = Request.Cookies["cod_usuario"].Value;
            string cod_turno = Request.Cookies["cod_turno"].Value;

            // Aquí puedes usar estos valores como necesites
            // Por ejemplo, mostrar el nombre de usuario en una etiqueta (si lo necesitas)
            //lblUsername.Text = username;

            this.LogEvent("Inicio de la carga de la página.");
            if (!IsPostBack)
            {
                string url = "https://apiclientes.almapac.com:9010/api/shipping/status/2?includeAttachments=true";
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

                        // Filtrar por tipos de camiones
                        var truckTypeP = data.Where(item => item.vehicle.truckType == "P" || item.vehicle.truckType == "R").ToList();
                        var truckTypeV = data.Where(item => item.vehicle.truckType == "V").ToList();

                        // Contar registros por tipo
                        lblCountP.Text = truckTypeP.Count.ToString();
                        lblCountV.Text = truckTypeV.Count.ToString();

                        // Crear una lista de códigos de ingenio válidos
                        var validIngenios = new string[] { "001001-003", "007001-001", "007001-003", "001001-001", "001001-004", "001001-002" };

                        // Inicializar los conteos de ingenios
                        var ingenioCounts = new Dictionary<string, int>();

                        // Contar ingenios en todos los registros filtrados
                        foreach (var item in data)
                        {
                            var ingenioNavCode = item.ingenio != null ? item.ingenio.ingenioNavCode : null;
                            if (ingenioNavCode != null && validIngenios.Contains(ingenioNavCode))
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
                    }
                    catch (Exception ex)
                    {
                        // Manejar errores de solicitud o deserialización
                        // lblIngenioCounts.Text = "Error al cargar los datos: " + ex.Message;
                        lblCountP.Text = "0";
                        lblCountV.Text = "0";
                    }
                }    
            }
        }
        else
        {
            // Si las cookies no están presentes, redirigir al login
            Response.Redirect("login.aspx");
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

    [WebMethod]
    public static object ValidarDatos(string codigoGeneracion, string licencia, string placaRemolque, string placaCamion)
    {
        var errores = new List<string>();

        if (string.IsNullOrEmpty(codigoGeneracion))
        {
            errores.Add("codigoGeneracion");
        }

        if (string.IsNullOrEmpty(licencia))
        {
            errores.Add("licencia");
        }

        if (string.IsNullOrEmpty(placaRemolque))
        {
            errores.Add("placaRemolque");
        }

        if (string.IsNullOrEmpty(placaCamion))
        {
            errores.Add("placaCamion");
        }

        if (errores.Count == 0)
        {
            // Validación de datos contra la API
            string url = "https://apiclientes.almapac.com:9010/api/shipping/" + codigoGeneracion + "?includeAttachments=true";
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
                    string responseBody = client.DownloadString(url);
                    var data = JsonConvert.DeserializeObject<Post>(responseBody);

                    // Comparar los valores obtenidos con los ingresados
                    if (data.driver.license != licencia)
                    {
                        errores.Add("Licencia");
                    }
                    if (data.vehicle.trailerPlate != placaRemolque)
                    {
                        errores.Add("Placa Remolque");
                    }
                    if (data.vehicle.plate != placaCamion)
                    {
                        errores.Add("Placa Camion");
                    }
                }
                catch (WebException webEx)
                {
                    var response = webEx.Response as HttpWebResponse;
                    if (response != null && response.StatusCode == HttpStatusCode.NotFound)
                    {
                        errores.Add("codigoGeneracion");
                    }
                    else
                    {
                        using (var stream = webEx.Response.GetResponseStream())
                        using (var reader = new StreamReader(stream))
                        {
                            string errorResponse = reader.ReadToEnd();
                            errores.Add("codigoGeneracion");
                        }
                    }
                }
                catch (Exception ex)
                {
                    errores.Add("codigoGeneracion");
                }
            }
        }

        // Si hay errores, devolverlos; si no, devolver mensaje de éxito
        if (errores.Count > 0)
        {
            return new { error = true, camposConError = errores };
        }
        else
        {
            return new { error = false, mensaje = "Validación exitosa" };
        }
    }

    [WebMethod]
    public static string GuardarComentario(string codigoGeneracion, string comentario)
    {
        if (string.IsNullOrEmpty(codigoGeneracion))
        {
            return "Error: codeGen no puede ser nulo o vacío";
        }

        try
        {
            // URL para la solicitud DELETE, con el parametro 'codigoGeneracion'
            string url = "https://apiclientes.almapac.com:9010/api/invalidated-shipments/" + codigoGeneracion;
            string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9uZXMiLCJzdWIiOjYsInJvbGVzIjpbImJvdCJdLCJpYXQiOjE3MzMzMjIxNDAsImV4cCI6MjUyMjI2MjE0MH0.LPLUEOv4kNsozjwc1BW6qZ5R1fqT_BwsF-MM5vY5_Cc";
            
            string responseContent;
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

            // Crear la solicitud DELETE utilizando HttpWebRequest
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.Method = "DELETE"; // Especificar el método DELETE
            request.Headers.Add("Authorization", "Bearer " + token);
            request.ContentType = "application/json";

            // Crear el objeto para enviar en el body (comentario)
            var requestBody = new { reason = comentario };
            string json = JsonConvert.SerializeObject(requestBody);

            // Escribir el cuerpo de la solicitud
            using (StreamWriter writer = new StreamWriter(request.GetRequestStream()))
            {
                writer.Write(json);
            }

            // Obtener la respuesta de la solicitud
            using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
            {
                using (StreamReader reader = new StreamReader(response.GetResponseStream()))
                {
                    responseContent = reader.ReadToEnd();
                }
            }

            return "Respuesta del servidor: " + responseContent;
        }
        catch (WebException webEx)
        {
            // Manejar los errores de la solicitud
            using (var reader = new StreamReader(webEx.Response.GetResponseStream()))
            {
                return "Error en la solicitud: " + webEx.Message + " - Respuesta del servidor: " + reader.ReadToEnd();
            }
        }
        catch (Exception ex)
        {
            // Manejar errores inesperados
            return "Error inesperado: " + ex.Message;
        }
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
        public int currentStatus { get; set; }
        public DateTime dateTimeCurrentStatus { get; set; }
        public DateTime dateTimePrecheckeo { get; set; }
        public bool mapping { get; set; }
        public Driver driver { get; set; }
        public Vehicle vehicle { get; set; }
        public Ingenio ingenio { get; set; }
        public List<Statuses> statuses { get; set; }
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

    public class Statuses
    {
        public int id { get; set; }
        public string status { get; set; }
        public DateTime createdAt { get; set; }
        public List<object> observation { get; set; } // Asegúrate del tipo de datos
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
        LinkButton lnk_VerRuta = (LinkButton)sender;
        GridViewRow row = (GridViewRow)lnk_VerRuta.NamingContainer;
        GridView gvw = (GridView)row.NamingContainer;
        ////Guarda el valor de la llave primaria.
        //hfCodigo.Value = gvw_rutas_plantillas.DataKeys[row.RowIndex].Value.ToString();

        // Obtener el valor del codigoGeneracion desde el LinkButton
        LinkButton lnk = (LinkButton)sender;
        string codigoGeneracion = lnk.Attributes["data-codigo-generacion"];

        // Realizar la llamada a la API para obtener la imagen
        string imageUrl = GetImageFromApi(codigoGeneracion);

        //Muestra el modal una vez hecho click en la fila.
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal-convertir", "$('#modal-detalle').modal();", true);
        
    }

    private string GetImageFromApi(string codigoGeneracion)
    {
        // Simulación de la llamada a la API para obtener la URL de la imagen (puedes usar la lógica que ya tienes)
        string url = "http://192.168.200.112:3000/api/shipping/" + codigoGeneracion + "?includeAttachments=true";
        string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9uZXMiLCJzdWIiOjYsInJvbGVzIjpbImJvdCJdLCJpYXQiOjE3MzMzMjIxNDAsImV4cCI6MjUyMjI2MjE0MH0.LPLUEOv4kNsozjwc1BW6qZ5R1fqT_BwsF-MM5vY5_Cc";

        using (WebClient client = new WebClient())
        {
            client.Headers.Add("Authorization", "Bearer " + token);
            string response = client.DownloadString(url);
            var data = JsonConvert.DeserializeObject<Post>(response);
            
            // Devolver la URL de la imagen, asumiendo que el campo es fileUrl o similar
            return data.shipmentAttachments[0].fileUrl;
        }
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

    [WebMethod]
    public static string ChangeTransactionStatus(string codeGen, int predefinedStatusId)
    {
        if (string.IsNullOrEmpty(codeGen))
        {
            return "Error: La transacción no puede estar vacía.";
        }

        string url = "https://apiclientes.almapac.com:9010/api/status/push/";
        string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9uZXMiLCJzdWIiOjYsInJvbGVzIjpbImJvdCJdLCJpYXQiOjE3MzMzMjIxNDAsImV4cCI6MjUyMjI2MjE0MH0.LPLUEOv4kNsozjwc1BW6qZ5R1fqT_BwsF-MM5vY5_Cc";
        
        string responseContent;

        using (var client = new WebClient())
        {
            client.Headers[HttpRequestHeader.Authorization] = "Bearer " + token;
            client.Headers[HttpRequestHeader.ContentType] = "application/json";

            var requestBody = new { codeGen = codeGen, predefinedStatusId = predefinedStatusId };
            var json = JsonConvert.SerializeObject(requestBody);

            try
            {
                responseContent = client.UploadString(url, "POST", json);
            }
            catch (WebException webEx)
            {
                using (var reader = new StreamReader(webEx.Response.GetResponseStream()))
                {
                    return "Error en la solicitud: " + webEx.Message + " - Respuesta del servidor: " + reader.ReadToEnd();
                }
            }
            catch (Exception ex)
            {
                return "Error inesperado: " + ex.Message;
            }
        }

        return "Respuesta del servidor: " + responseContent;
    }

    [WebMethod]
    public static string AsignarTarjeta(string codigoGeneracion, int tarjeta)
    {
        if (string.IsNullOrEmpty(codigoGeneracion))
        {
            return "El código de generación no puede estar vacío.";
        }

         if (tarjeta == null)
        {
            return "La tarjeta no puede estar vacía.";
        }

        // Muestra los datos antes de enviarlos
        Console.WriteLine("Datos enviados: codigoGeneracion = " + codigoGeneracion + ", tarjeta = " + tarjeta);
        
        // Token y endpoint
        string url = "https://apiclientes.almapac.com:9010/api/shipping/setMagneticCard/";
        string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9uZXMiLCJzdWIiOjYsInJvbGVzIjpbImJvdCJdLCJpYXQiOjE3MzMzMjIxNDAsImV4cCI6MjUyMjI2MjE0MH0.LPLUEOv4kNsozjwc1BW6qZ5R1fqT_BwsF-MM5vY5_Cc";
        string responseContent;

        using (var client = new WebClient())
        {
            client.Headers[HttpRequestHeader.Authorization] = "Bearer " + token;
            client.Headers[HttpRequestHeader.ContentType] = "application/json";

            var requestBody = new { codeGen = codigoGeneracion, cardNumber = tarjeta };
            var json = JsonConvert.SerializeObject(requestBody);

            try
            {
                responseContent = client.UploadString(url, "POST", json);
            }
            catch (WebException webEx)
            {
                using (var reader = new StreamReader(webEx.Response.GetResponseStream()))
                {
                    return "Error en la solicitud: " + webEx.Message + " - Respuesta del servidor: " + reader.ReadToEnd();
                }
            }
            catch (Exception ex)
            {
                return "Error inesperado: " + ex.Message;
            }
        }

        return "Respuesta del servidor: " + responseContent;
    }
}