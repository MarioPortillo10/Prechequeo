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



public partial class Basculas_Autorizacion_Camiones : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string url = "http://172.206.251.10:9010/api/shipping/status/2?includeAttachments=true";
            string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9zbmVzIiwic3ViIjozLCJyb2xlcyI6WyJib3QiXSwiaWF0IjoxNzI5ODkxNDQ1LCJleHAiOjI1MTg4MzE0NDV9.iTVACWXaGz7xiKu59autzZZ-0OCv0cep37zQBxkSKOs";

            using (WebClient client = new WebClient())
            {
                // Añadir el token al encabezado de autorización
                client.Headers.Add("Authorization", "Bearer " + token);

                try
                {
                    // Realizar la solicitud GET y leer la respuesta
                    string responseBody = client.DownloadString(url);

                    // Deserializar la respuesta JSON
                    var data = JsonConvert.DeserializeObject<List<Post>>(responseBody);

                    // Filtrar para mostrar solo aquellos registros donde el último estatus tiene id = 2
                    var filteredData = data.Where(p => p.statuses.Count > 0 && p.statuses.Last().id == 2).ToList();

                    // Vincular los datos filtrados al control Repeater
                    rptRutas.DataSource = filteredData;
                    rptRutas.DataBind();
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
    public static string ValidarDatos(string codigoGeneracion, string licencia, string placaRemolque, string placaCamion)
    {
        if (string.IsNullOrEmpty(codigoGeneracion))
        {
            return "El código de generación no puede estar vacío.";
        }

        // Token y endpoint
        string url = "http://172.206.251.10:9010/api/shipping/" + codigoGeneracion + "?includeAttachments=true";
        string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9zbmVzIiwic3ViIjozLCJyb2xlcyI6WyJib3QiXSwiaWF0IjoxNzI5ODkxNDQ1LCJleHAiOjI1MTg4MzE0NDV9.iTVACWXaGz7xiKu59autzZZ-0OCv0cep37zQBxkSKOs";

        using (WebClient client = new WebClient())
        {
            client.Headers.Add("Authorization", "Bearer " + token);
            try
            {
                string responseBody = client.DownloadString(url);
                var data = JsonConvert.DeserializeObject<Post>(responseBody);

                // Comparar los valores obtenidos con los ingresados
                if (data.driver.license == licencia && data.vehicle.trailerPlate == placaRemolque && data.vehicle.plate == placaCamion)
                {
                    return "Validación exitosa: los datos son correctos.";
                }
                else
                {
                    return "Error: los datos ingresados no coinciden con la información del servidor.";
                }
            }
            catch (WebException webEx)
            {
                var response = webEx.Response as HttpWebResponse;
                if (response != null && response.StatusCode == HttpStatusCode.NotFound)
                {
                    return "Error: El código de generación no se encontró (404).";
                }
                else
                {
                    using (var stream = webEx.Response.GetResponseStream())
                    using (var reader = new StreamReader(stream))
                    {
                        string errorResponse = reader.ReadToEnd();
                        return "Error en la solicitud: " + webEx.Message + " - Respuesta del servidor: " + errorResponse;
                    }
                }
            }
            catch (Exception ex)
            {
                return "Error en la solicitud: " + ex.Message;
            }
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
        public int productQuantity { get; set; }
        public long productQuantityKg { get; set; }
        public string unitMeasure { get; set; }
        public string requiresSweeping { get; set; }
        public DateTime createdAt { get; set; }
        public DateTime updatedAt { get; set; }
        public bool mapping { get; set; }
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
        string url = "http://172.206.251.10:9010/api/shipping/" + codigoGeneracion + "?includeAttachments=true";
        string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9zbmVzIiwic3ViIjozLCJyb2xlcyI6WyJib3QiXSwiaWF0IjoxNzI5ODkxNDQ1LCJleHAiOjI1MTg4MzE0NDV9.iTVACWXaGz7xiKu59autzZZ-0OCv0cep37zQBxkSKOs";

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

        string url = "http://172.206.251.10:9010/api/status/push/";
        string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9zbmVzIiwic3ViIjozLCJyb2xlcyI6WyJib3QiXSwiaWF0IjoxNzI5ODkxNDQ1LCJleHAiOjI1MTg4MzE0NDV9.iTVACWXaGz7xiKu59autzZZ-0OCv0cep37zQBxkSKOs";
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
}