using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Net;
using System.Diagnostics;
using System.IO;
using System.Web.Services;
using System.Globalization;


public partial class Basculas_Prechequeo : System.Web.UI.Page
{
    string cod_rol = "";
    string baseUrl = "http://172.206.251.10/api/";
    string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9zbmVzIiwic3ViIjozLCJyb2xlcyI6WyJib3QiXSwiaWF0IjoxNzI5ODkxNDQ1LCJleHAiOjI1MTg4MzE0NDV9.iTVACWXaGz7xiKu59autzZZ-0OCv0cep37zQBxkSKOs";
    public static string baseUrlStatic = "http://172.206.251.10/api/";
    public static string tokenStatic = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9uZXMiLCJzdWIiOjIsInJvbGVzIjpbImJvdCJdLCJpYXQiOjE3MzA5MzExMjksImV4cCI6MjUxOTg3MTEyOX0.f7sPuL-bNUaxbY-D3NFs2PAM3KlghRBP4YRnfU_-jhU";
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }


    protected void lnkBuscar_Click(object sender, EventArgs e)
    {
        string transaccion = txtTransaccion.Text.Trim();
        string url = this.baseUrl + "shipping/" + transaccion;

        using (WebClient client = new WebClient())
        {
            client.Headers.Add("Authorization", "Bearer " + this.token);
            try
            {
                string responseBody = client.DownloadString(url);
                var data = JsonConvert.DeserializeObject<Post>(responseBody);
                Console.WriteLine(JsonConvert.SerializeObject(data, Formatting.Indented));  // Imprime el objeto completo

                if (data == null || string.IsNullOrEmpty(data.transporter))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "notFoundAlert", 
                        "Swal.fire('Error', 'La transacción no se encontró en la API.', 'error').then(() => { location.reload(); });", true);
                    return;
                }

                // Manejo de estatus de prechequeo
                if (data.statuses == null || (data.statuses.LastOrDefault() == null || data.statuses.LastOrDefault().id != 1))
                {
                    var lastStatus = data.statuses != null && data.statuses.Length > 0 ? data.statuses[data.statuses.Length - 1] : null;
                    string alertMessage = "Esta transacción ya ha sido prechequeada.";

                    if (lastStatus != null)
                    {
                        alertMessage += " Último estado: " + lastStatus.status;
                    }

                    // Añadir un log para verificar el flujo
                    Console.WriteLine("Transacción ya prechequeada: " + alertMessage);

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alreadyCheckedAlert",
                        "Swal.fire('Atención', 'Esta transacción ya ha sido prechequeada.', 'warning').then(() => { location.reload(); });", true);
                    return;
                }
                
                txt_ingenio.Text        = HttpUtility.HtmlEncode(data.ingenio.name.Replace("_", " "));
                //txt_producto.Text       = data.nameProduct;
                txt_transporte.Text     = data.transporter;
                txt_motorista.Text      = data.driver.name;
                txt_licencia.Text       = data.driver.license;
                txt_placaCamion.Text    = data.vehicle.plate;
                txt_placaRemolque.Text  = data.vehicle.trailerPlate;
                txtFecha.Text           = DateTime.Now.ToString("dd-MM-yyyy");
                txtHora.Text            = DateTime.Now.ToString("hh:mm tt", CultureInfo.InvariantCulture);
                

                // Lógica para los checkboxes
                chkPlana.Checked = data.truckType == "PLANA";
                chkVolteo.Checked = data.truckType == "VOLTEO";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "openModal", 
                    "$('#editModal').modal('show');", true);
            }
            catch (WebException webEx)
            {
                var response = webEx.Response as HttpWebResponse;

                if (response != null && response.StatusCode == HttpStatusCode.NotFound)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "notFoundAlert", 
                        "Swal.fire('Error', 'El código de generación ingresado no existe.', 'error').then(() => { location.reload(); });", true);
                }

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "generalErrorAlert", 
                    "swal('Error', 'Ocurrió un error: " + ex.Message + "', 'error');", true);
            }
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

    public static void LogEventS(object message, HttpContext context)
    {
        string logFilePath = context.Server.MapPath("~/Logs/MyAppLog.txt");
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
    public static string ChangeTransactionStatus(string codeGen, int predefinedStatusId, string imageData)
    {
        System.Diagnostics.Debug.WriteLine("Inicio de ChangeTransactionStatus");

        // Validar que la transacción no esté vacía
        if (string.IsNullOrEmpty(codeGen))
        {
            System.Diagnostics.Debug.WriteLine("Error: La transacción no puede estar vacía.");
            return "Error: La transacción no puede estar vacía.";
        }

        // Verificar si la foto fue subida
        if (string.IsNullOrEmpty(imageData) || imageData == "data:,")
        {
            System.Diagnostics.Debug.WriteLine("Error: La imagen no fue recibida.");
            return "Error: La imagen no fue recibida. Por favor, suba una foto antes de cambiar el estatus.";
        }

        // Aquí podrías añadir una comprobación adicional si la imagen se ha subido correctamente usando otro mecanismo (como una variable global o un estado persistente).
        // Si la foto se subió, se sigue adelante con la actualización del estatus.

        string url = "http://172.206.251.10/api/status/push/";
        string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9zbmVzIiwic3ViIjozLCJyb2xlcyI6WyJib3QiXSwiaWF0IjoxNzI5ODkxNDQ1LCJleHAiOjI1MTg4MzE0NDV9.iTVACWXaGz7xiKu59autzZZ-0OCv0cep37zQBxkSKOs";
        string responseContent;

        using (var client = new WebClient())
        {
            System.Diagnostics.Debug.WriteLine("Configurando cliente de WebClient");

            client.Headers[HttpRequestHeader.Authorization] = "Bearer " + token;
            client.Headers[HttpRequestHeader.ContentType] = "application/json";

            var requestBody = new { codeGen = codeGen, predefinedStatusId = predefinedStatusId, imageData = imageData };
            var json = JsonConvert.SerializeObject(requestBody);
            System.Diagnostics.Debug.WriteLine("Cuerpo de la solicitud JSON: " + json);

            try
            {
                // Validar si la imagen está vacía nuevamente antes de enviar la solicitud
                if (string.IsNullOrEmpty(imageData) || imageData == "data:,")
                {
                    return "Error: No se puede cambiar el estado sin haber subido una foto.";
                }

                System.Diagnostics.Debug.WriteLine("Enviando solicitud a la API: " + url);
                responseContent = client.UploadString(url, "POST", json);
                System.Diagnostics.Debug.WriteLine("Respuesta de la API: " + responseContent);
            }
            catch (WebException webEx)
            {
                System.Diagnostics.Debug.WriteLine("Error en la solicitud: " + webEx.Message);

                using (var reader = new StreamReader(webEx.Response.GetResponseStream()))
                {
                    string serverResponse = reader.ReadToEnd();
                    System.Diagnostics.Debug.WriteLine("Respuesta del servidor en error: " + serverResponse);
                    return "Error en la solicitud: " + webEx.Message + " - Respuesta del servidor: " + serverResponse;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error inesperado: " + ex.Message);
                return "Error inesperado: " + ex.Message;
            }
        }

        System.Diagnostics.Debug.WriteLine("Cambio de estatus realizado con éxito");
        return "Cambio de estatus realizado con éxito";
    }


    [WebMethod]
    public static string UploadPhoto(string imageData, string codeGen)
    {
        try
        {
            if (string.IsNullOrEmpty(imageData)) 
            {
                return "Error: La imagen no fue recibida.";
            }

            var uploadPayload = new
            {
                urlfileOrbase64file = imageData,
                type = "P",
                isBase64 = true,
                codeGen = codeGen
            };

            // Log para depuración
            System.Diagnostics.Debug.WriteLine("Datos recibidos para la foto: " + imageData);

            using (WebClient client = new WebClient())
            {
                client.Headers[HttpRequestHeader.ContentType] = "application/json";
                client.Headers[HttpRequestHeader.Authorization] = "Bearer " + tokenStatic;

                string uploadResponse = client.UploadString(baseUrlStatic + "shipping/upload", "POST", JsonConvert.SerializeObject(uploadPayload));
            }

            // Usa HttpContext.Items para almacenar la información solo para el ciclo de vida de la solicitud
            HttpContext.Current.Items["PhotoUploaded"] = true;

            return "success";
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error al subir la foto: " + ex.Message);
            return "error";
        }
    }



    public class Post
    {
        public string nameProduct { get; set; }
        public string truckType { get; set; }
        public int id { get; set; }
        public string codeGen { get; set; }
        public string product { get; set; }
        public string operationType { get; set; }
        public string loadType { get; set; }
        public string transporter { get; set; }
        public double productQuantity { get; set; }
        public double productQuantityKg { get; set; }
        public string unitMeasure { get; set; }
        public DateTime createdAt { get; set; }
        public DateTime updatedAt { get; set; }
        public Driver driver { get; set; }
        public Vehicle vehicle { get; set; }
        public Statuses[] statuses { get; set; }
        public Ingenio ingenio { get; set; }
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

    public class Statuses
    {
        public int id { get; set; }
        public string status { get; set; }
        public DateTime createdAt { get; set; }
        public string date { get; set; }
        public string time { get; set; }
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

    protected void LinkSalir1_Click(object sender, EventArgs e)
    {
       
    }
   
    [System.Web.Services.WebMethod]

    protected void lnk_perfil_Click(object sender, EventArgs e)
    {

    }

    protected void lnk_update_pret_Click(object sender, EventArgs e)
    {
       
    }

    public void valida_rol()
    {
        
    }
}