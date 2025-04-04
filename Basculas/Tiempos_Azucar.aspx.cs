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

    // Variable estática para alternar registros
    private static int lastAssignedIndex = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["username"] != null && Request.Cookies["cod_bascula"] != null && Request.Cookies["cod_usuario"] != null && Request.Cookies["cod_turno"] != null)
        {    
            if (!IsPostBack)
            {
                // URL que deseas hacer el fetch
                string url = "https://apiclientes.almapac.com:9010/api/shipping/status/7";  // Estatus 7
                string url1 = "https://apiclientes.almapac.com:9010/api/shipping/status/8"; // Estatus 8
                string url2 = "https://apiclientes.almapac.com:9010/api/shipping/status/3"; // Estatus 3 para unidades pendiente de ingresar
                string url3 = "https://apiclientes.almapac.com:9010/api/queue/count/";      // Conteo de unidades solicitadas

                // Token
                string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9uZXMiLCJzdWIiOjYsInJvbGVzIjpbImJvdCJdLCJpYXQiOjE3MzMzMjIxNDAsImV4cCI6MjUyMjI2MjE0MH0.LPLUEOv4kNsozjwc1BW6qZ5R1fqT_BwsF-MM5vY5_Cc";
                ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

                // Definir la zona horaria de UTC -6
                TimeZoneInfo gmtMinus6 = TimeZoneInfo.CreateCustomTimeZone("GMT-6", TimeSpan.FromHours(-6), "GMT-6", "GMT-6");

                using (WebClient client = new WebClient())
                {
                    client.Headers.Add("Authorization", "Bearer " + token);
                    client.Encoding = Encoding.UTF8;
    
                    try
                    {
                        string response2 = client.DownloadString(url3);
                        var queueData = JsonConvert.DeserializeObject<QueueData>(response2);

                        if (queueData != null && queueData.data != null)
                        {
                            numberInputVolteo.Text = queueData.data.V != null ? queueData.data.V.ToString() : "0";
                            numberInputPlano.Text = queueData.data.R != null ? queueData.data.R.ToString() : "0";
                        }
                        else
                        {
                            numberInputVolteo.Text = "0";
                            numberInputPlano.Text = "0";
                        }   
                    }
                    catch (Exception ex)
                    {
                        numberInputVolteo.Text = "0";
                        numberInputPlano.Text = "0";

                        this.LogEvent("Error al realizar la solicitud o procesar la respuesta.");
                        this.LogEvent("Mensaje de excepción: " + ex.Message);
                        this.LogEvent("Pila de llamadas: " + ex.StackTrace);
                    }
                }

                using (WebClient client = new WebClient())
                {
                    client.Headers.Add("Authorization", "Bearer " + token);
                    client.Encoding = Encoding.UTF8;
    
                    try
                    {
                        // Realizar la solicitud GET y leer la respuesta
                        string responseBody = client.DownloadString(url2);
                        var data = JsonConvert.DeserializeObject<List<Post>>(responseBody);

                        var filteredData = data.Where(p => p.currentStatus == 3 && p.vehicle != null && (p.vehicle.truckType == "P" || p.vehicle.truckType == "R"))
                            .Select((p, index) =>
                            {
                                p.IsFirst = (index == 0); // Nueva propiedad
                                // Comprobar si dateTimePrecheckeo es null y asignar valor predeterminado
                                p.TimeForId2 = p.dateTimePrecheckeo.HasValue
                                    ? p.dateTimePrecheckeo.Value.ToString("yyyy-MM-dd HH:mm:ss")
                                    : "No hay datos"; // Valor por defecto si es null
                                return p;
                            })
                            .OrderBy(p => p.dateTimePrecheckeo)  // Ordena los elementos por dateTimePrecheckeo (de más antiguo a más nuevo)
                            .ToList();

                            var filteredData1 = data.Where(p => p.currentStatus == 3 && p.vehicle != null && (p.vehicle.truckType == "V"))
                            .Select((p, index) =>
                            {
                                p.IsFirst = (index == 0); // Nueva propiedad
                                // Comprobar si dateTimePrecheckeo es null y asignar valor predeterminado
                                p.TimeForId2 = p.dateTimePrecheckeo.HasValue
                                    ? p.dateTimePrecheckeo.Value.ToString("yyyy-MM-dd HH:mm:ss")
                                    : "No hay datos"; // Valor por defecto si es null
                                return p;
                            })
                            .OrderBy(p => p.dateTimePrecheckeo)  // Ordena los elementos por dateTimePrecheckeo (de más antiguo a más nuevo)
                            .ToList();

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

                        if (filteredData1.Count > 0)
                        {
                            lblTotalRegistrosV.Text = filteredData1.Count.ToString();
                        }
                        else
                        {
                            lblTotalRegistrosV.Text = "0";
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
                    client.Headers.Add("Authorization", "Bearer " + token);
                    client.Encoding = Encoding.UTF8;

                    try
                    {
                        // Realizar la solicitud GET y leer la respuesta
                        string responseBody = client.DownloadString(url);
                        var data = JsonConvert.DeserializeObject<List<Post>>(responseBody);

                        // Convertir dateTimePrecheckeo a UTC -6
                        foreach (var item in data)
                        {
                            if (item.dateTimePrecheckeo.HasValue && item.dateTimePrecheckeo.Value != DateTime.MinValue)
                            {
                                // Asegúrate de que dateTimePrecheckeo sea tratado como UTC
                                DateTime utcDateTime = DateTime.SpecifyKind(item.dateTimePrecheckeo.Value, DateTimeKind.Utc);

                                // Convierte a GMT-6 (zona horaria sin horario de verano)
                                item.dateTimePrecheckeo = TimeZoneInfo.ConvertTimeFromUtc(utcDateTime, gmtMinus6);
                            }
                        }

                        var filteredData = data.Where(p => p.currentStatus == 7 && p.vehicle != null && (p.vehicle.truckType == "P" || p.vehicle.truckType == "R"))
                            .Select((p, index) =>
                            {
                                p.IsFirst = (index == 0); // Nueva propiedad
                                // Comprobar si dateTimePrecheckeo es null y asignar valor predeterminado
                                p.TimeForId2 = p.dateTimePrecheckeo.HasValue
                                    ? p.dateTimePrecheckeo.Value.ToString("yyyy-MM-dd HH:mm:ss")
                                    : "No hay datos"; // Valor por defecto si es null
                                return p;
                            })
                            .OrderBy(p => p.dateTimePrecheckeo)  // Ordena los elementos por dateTimePrecheckeo (de más antiguo a más nuevo)
                            .ToList();

                        // Depuración: Verifica el conteo de registros
                        Console.WriteLine("Número de registros filtrados: " + filteredData.Count);

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
                        //lblTotalRegistros.Text = "0";
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

                        // Convertir dateTimePrecheckeo a UTC -6
                        foreach (var item in data)
                        {
                            if (item.dateTimePrecheckeo.HasValue && item.dateTimePrecheckeo.Value != DateTime.MinValue)
                            {
                                // Asegúrate de que dateTimePrecheckeo sea tratado como UTC
                                DateTime utcDateTime = DateTime.SpecifyKind(item.dateTimePrecheckeo.Value, DateTimeKind.Utc);

                                // Convierte a GMT-6 (zona horaria sin horario de verano)
                                item.dateTimePrecheckeo = TimeZoneInfo.ConvertTimeFromUtc(utcDateTime, gmtMinus6);
                            }
                        }

                        // Filtrar para mostrar solo aquellos registros donde el currentStatus es 8
                        // y el tipo de camión es 'PLANA'
                        var filteredData = data.Where(p => p.currentStatus == 8 && p.vehicle != null && p.vehicle.truckType == "P" || p.vehicle.truckType == "R")
                        .Select((p, index) =>
                        {
                            p.IsFirst = (index == 0); // Nueva propiedad
                            // Comprobar si dateTimePrecheckeo tiene valor y formatearlo
                            string timeForPrecheck = p.dateTimePrecheckeo.HasValue
                                ? p.dateTimePrecheckeo.Value.ToString("yyyy-MM-dd HH:mm:ss")
                                : "No hay datos"; // Valor predeterminado si es null
                            p.TimeForId2 = timeForPrecheck;
                            return p;
                        }).ToList();

                        // Vincular los datos filtrados al control Repeater
                        rptRutas1.DataSource = filteredData;
                        rptRutas1.DataBind();
                        PanelTituloPlanas.Visible = filteredData.Count > 0;
                    }
                    catch (Exception ex)
                    {
                        // Manejo de errores (por ejemplo, mostrar un mensaje de error)
                        this.LogEvent(ex.Message);
                        this.LogEvent(ex.StackTrace);
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

                        // Convertir dateTimePrecheckeo a UTC -6
                        foreach (var item in data)
                        {
                            if (item.dateTimePrecheckeo.HasValue && item.dateTimePrecheckeo.Value != DateTime.MinValue)
                            {
                                // Asegúrate de que dateTimePrecheckeo sea tratado como UTC
                                DateTime utcDateTime = DateTime.SpecifyKind(item.dateTimePrecheckeo.Value, DateTimeKind.Utc);

                                // Convierte a GMT-6 (zona horaria sin horario de verano)
                                item.dateTimePrecheckeo = TimeZoneInfo.ConvertTimeFromUtc(utcDateTime, gmtMinus6);
                            }
                        }

                        // Filtrar para mostrar solo aquellos registros donde el currentStatus es 7
                        // y el tipo de camión es 'VOLTEO'
                        var filteredData = data.Where(p => p.currentStatus == 7 && p.vehicle != null && (p.vehicle.truckType == "V"))
                            .Select((p, index) =>
                            {
                                p.IsFirst = (index == 0); // Nueva propiedad
                                // Comprobar si dateTimePrecheckeo es null y asignar valor predeterminado
                                p.TimeForId2 = p.dateTimePrecheckeo.HasValue
                                    ? p.dateTimePrecheckeo.Value.ToString("yyyy-MM-dd HH:mm:ss")
                                    : "No hay datos"; // Valor por defecto si es null
                                return p;
                            })
                            .OrderBy(p => p.dateTimePrecheckeo)  // Ordena los elementos por dateTimePrecheckeo (de más antiguo a más nuevo)
                            .ToList();

                        // Asigna el conteo de los registros filtrados al Label
                        //lblTotalRegistrosV.Text = String.Format("{0}", filteredData.Count);

                        // Vincular los datos filtrados al control Repeater
                        rptRutas2.DataSource = filteredData;
                        rptRutas2.DataBind();
                    }
                    catch (Exception ex)
                    {
                        // Manejo de errores (por ejemplo, mostrar un mensaje de error)
                        Console.WriteLine("Error al obtener o procesar los datos: " + ex.Message);
                        this.LogEvent(ex.Message);
                        this.LogEvent(ex.StackTrace);
                        //lblTotalRegistrosV.Text = "0";
                    }
                }
                using (WebClient client = new WebClient())
                {
                    client.Headers.Add("Authorization", "Bearer " + token);
                    client.Encoding = Encoding.UTF8;

                    try
                    {
                        string responseBody = client.DownloadString(url1);
                        var data = JsonConvert.DeserializeObject<List<Post>>(responseBody);

                        // Convertir dateTimePrecheckeo a UTC -6
                        foreach (var item in data)
                        {
                            if (item.dateTimePrecheckeo.HasValue && item.dateTimePrecheckeo.Value != DateTime.MinValue)
                            {
                                // Asegúrate de que dateTimePrecheckeo sea tratado como UTC
                                DateTime utcDateTime = DateTime.SpecifyKind(item.dateTimePrecheckeo.Value, DateTimeKind.Utc);

                                // Convierte a GMT-6 (zona horaria sin horario de verano)
                                item.dateTimePrecheckeo = TimeZoneInfo.ConvertTimeFromUtc(utcDateTime, gmtMinus6);
                            }
                        }

                        // Filtrar registros con status 8 y truckType "V"
                        var filteredData = data.Where(p => 
                            p.currentStatus == 8 && 
                            p.vehicle != null && 
                            p.vehicle.truckType == "V"
                        ).OrderBy(p => p.dateTimePrecheckeo).ToList();

                        // Determinar qué registros se asignan a cada Repeater
                        Post recordForRpt3 = null;
                        Post recordForRpt4 = null;

                        if (filteredData.Count > 0)
                        {
                            // Alternar la asignación de registros entre rptRutas3 y rptRutas4
                            if (lastAssignedIndex % 2 == 0)
                            {
                                recordForRpt3 = filteredData[0];
                                if (filteredData.Count > 1) recordForRpt4 = filteredData[1];
                            }
                            else
                            {
                                recordForRpt4 = filteredData[0];
                                if (filteredData.Count > 1) recordForRpt3 = filteredData[1];
                            }

                            lastAssignedIndex++; // Cambiar el índice para la próxima asignación
                        }

                        // Verificar si rptRutas3 está vacío
                        bool isRutas3Empty = (recordForRpt3 == null);
                        ViewState["ShowHeaderInRutas4"] = isRutas3Empty;

                        // Enlazar a rptRutas3 y rptRutas4
                        rptRutas3.DataSource = (recordForRpt3 != null) ? new List<Post> { recordForRpt3 } : new List<Post>();
                        rptRutas3.DataBind();

                        rptRutas4.DataSource = (recordForRpt4 != null) ? new List<Post> { recordForRpt4 } : new List<Post>();
                        rptRutas4.DataBind();

                        PanelTituloVolteo.Visible = (recordForRpt3 != null || recordForRpt4 != null);
                    }
                    catch (Exception ex)
                    {
                        this.LogEvent(ex.Message);
                        this.LogEvent(ex.StackTrace);
                        Console.WriteLine("Error: " + ex.Message);
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

                    // Enviar la solicitud POST sin cuerpo
                    string response = client.UploadString(url, "POST", "");

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

    [WebMethod]
    public static string ReducirUnidad(string Tipo_Unidad, int unidadesReducidas)
    {
        // Construir la URL correctamente
        string baseUrl = "https://apiclientes.almapac.com:9010/api/queue/release-multiple/";
        string url = baseUrl + Tipo_Unidad + "/" + unidadesReducidas;

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
                    client.Headers[HttpRequestHeader.UserAgent] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)";

                    LogEventS("Enviando solicitud DELETE a: " + url);

                    // Enviar la solicitud DELETE sin cuerpo
                    string response = client.UploadString(url, "DELETE", "");

                    LogEventS("Respuesta del servidor: " + response);
                    return response;
                }
                catch (WebException ex)
                {
                    // Capturar detalles del error
                    string errorMessage = new StreamReader(ex.Response.GetResponseStream()).ReadToEnd();
                    LogEventS("Error en la solicitud: " + errorMessage);
                    return "Error en la solicitud: " + errorMessage;
                }
            }
        }
        catch (Exception ex)
        {
            LogEventS("Error inesperado: " + ex.Message);
            return "Error inesperado: " + ex.Message;
        }
    }

    [WebMethod]
    public static string TiempoAzucar(string codigoGeneracion, string tiempo, string comentario)
    {
        string baseUrl = "https://apiclientes.almapac.com:9010/api/shipping/sugartime/";
        string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9uZXMiLCJzdWIiOjYsInJvbGVzIjpbImJvdCJdLCJpYXQiOjE3MzMzMjIxNDAsImV4cCI6MjUyMjI2MjE0MH0.LPLUEOv4kNsozjwc1BW6qZ5R1fqT_BwsF-MM5vY5_Cc";
        string responseContent = string.Empty;

        try
        {
            using (var client = new WebClient())
            {
                client.Headers[HttpRequestHeader.Authorization] = "Bearer " + token;
                client.Headers[HttpRequestHeader.ContentType] = "application/json";

                var requestBody = new { codeGen = codigoGeneracion, time = tiempo, observation = comentario };
                var json = JsonConvert.SerializeObject(requestBody);

                responseContent = client.UploadString(baseUrl, "POST", json);
            }
        }
        catch (Exception ex)
        {
            // Log del error
            LogEventS(new { Message = "Error inesperado", Exception = ex.Message });
            return "Error inesperado: " + ex.Message;
        }
        return responseContent;
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
        public DateTime? dateTimePrecheckeo { get; set; }
        public int? idPreTransaccionLeverans { get; set; }
        public int? idNavRecord { get; set; }
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
        public bool IsFirst { get; set; }

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
        public float factor2 { get; set; }
        public int factor3 { get; set; }
        public double pesocliente { get; set; }
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
        public double temperatura { get; set; }
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
        public double qtyRelasedAvailability { get; set; }
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