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



public partial class Basculas_Tiempos_azucar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // URL que deseas hacer el fetch
            string url = "https://apiclientes.almapac.com:9010/api/shipping/status/7?includeAttachments=true";

            // Token
            string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9uZXMiLCJzdWIiOjYsInJvbGVzIjpbImJvdCJdLCJpYXQiOjE3MzMzMjIxNDAsImV4cCI6MjUyMjI2MjE0MH0.LPLUEOv4kNsozjwc1BW6qZ5R1fqT_BwsF-MM5vY5_Cc";
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

            // Función para ver las que son de tipo PLANA y que están esperando
            using (WebClient client = new WebClient())
            {
                client.Headers.Add("Authorization", "Bearer " + token);

                try
                {
                    string responseBody = client.DownloadString(url);
                    var data = JsonConvert.DeserializeObject<List<Post>>(responseBody);

                    // Filtrar y mapear los datos
                    var filteredData = data
                        .Where(p =>
                            p.statuses != null &&
                            p.statuses.Count > 0 &&
                            p.statuses.Last().id == 7 &&
                            p.vehicle != null &&
                            p.vehicle.truckType == "P"
                        )
                        .Select(p =>
                        {
                            // Obtener el tiempo para status con id == 2
                            string timeForId2 = "No disponible";
                            if (p.statuses != null)
                            {
                                var statusWithId2 = p.statuses.FirstOrDefault(s => s.id == 2);
                                if (statusWithId2 != null)
                                {
                                    timeForId2 = statusWithId2.time;
                                }
                            }

                            // Agregar el tiempo (timeForId2) directamente a cada elemento de la lista
                            p.TimeForId2 = timeForId2;

                            // Retornar el objeto con los datos filtrados (sin necesidad de clase extra)
                            return p;
                        })
                        .ToList();

                    // Actualiza el conteo de registros filtrados
                    lblTotalRegistros.Text = String.Format("{0}", filteredData.Count);

                    // Vincula los datos filtrados al Repeater
                    rptRutas.DataSource = filteredData;
                    rptRutas.DataBind();

                    // Depuración: imprime los datos en la consola
                    foreach (var item in filteredData)
                    {
                        Console.WriteLine(String.Format("ID: {0}, TimeForId2: {1}", item.id, item.TimeForId2));
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error al obtener o procesar los datos: " + ex.Message);
                }
            }


            // Funcion para ver las que son de tipo PLANA y que estan en proceso de Carga/Descarga
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

                    // Filtrar para mostrar solo aquellos registros donde el último estatus tiene id = 8
                    // y el tipo de camión es 'PLANA'
                    var filteredData = data.Where(p => 
                        p.statuses != null && 
                        p.statuses.Count > 0 && 
                        p.statuses.Last().id == 8 && 
                        p.vehicle != null && 
                        p.vehicle.truckType == "P"
                    )
                    .Select(p =>
                        {
                            // Obtener el tiempo para status con id == 2
                            string timeForId2 = "No disponible";
                            if (p.statuses != null)
                            {
                                var statusWithId2 = p.statuses.FirstOrDefault(s => s.id == 2);
                                if (statusWithId2 != null)
                                {
                                    timeForId2 = statusWithId2.time;
                                }
                            }

                            // Agregar el tiempo (timeForId2) directamente a cada elemento de la lista
                            p.TimeForId2 = timeForId2;

                            // Retornar el objeto con los datos filtrados (sin necesidad de clase extra)
                            return p;
                        })
                        .ToList();

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

        
            // Funcion para ver las que son de tipo VOLTEO y que estan esperando
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

                    // Filtrar para mostrar solo aquellos registros donde el último estatus tiene id = 7
                    // y el tipo de camión es 'VOLTEO'
                    var filteredData = data.Where(p => 
                        p.statuses != null && 
                        p.statuses.Count > 0 && 
                        p.statuses.Last().id == 7 && 
                        p.vehicle != null && 
                        p.vehicle.truckType == "V"
                    )
                    .Select(p =>
                        {
                            // Obtener el tiempo para status con id == 2
                            string timeForId2 = "No disponible";
                            if (p.statuses != null)
                            {
                                var statusWithId2 = p.statuses.FirstOrDefault(s => s.id == 2);
                                if (statusWithId2 != null)
                                {
                                    timeForId2 = statusWithId2.time;
                                }
                            }

                            // Agregar el tiempo (timeForId2) directamente a cada elemento de la lista
                            p.TimeForId2 = timeForId2;

                            // Retornar el objeto con los datos filtrados (sin necesidad de clase extra)
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
                }
            }

            // Funcion para ver las que son de tipo VOLTEO y que estan en proceso de Carga/Descarga
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

                    // Filtrar para mostrar solo aquellos registros donde el último estatus tiene id = 8
                    // y el tipo de camión es 'VOLTEO'
                    var filteredData = data.Where(p => 
                        p.statuses != null && 
                        p.statuses.Count > 0 && 
                        p.statuses.Last().id == 8 && 
                        p.vehicle != null && 
                        p.vehicle.truckType == "V"
                    )
                    .Select(p =>
                        {
                            // Obtener el tiempo para status con id == 2
                            string timeForId2 = "No disponible";
                            if (p.statuses != null)
                            {
                                var statusWithId2 = p.statuses.FirstOrDefault(s => s.id == 2);
                                if (statusWithId2 != null)
                                {
                                    timeForId2 = statusWithId2.time;
                                }
                            }

                            // Agregar el tiempo (timeForId2) directamente a cada elemento de la lista
                            p.TimeForId2 = timeForId2;

                            // Retornar el objeto con los datos filtrados (sin necesidad de clase extra)
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
        // Lógica para solicitar una unidad (por ejemplo, enviar un correo electrónico o realizar// Construir la URL
        string baseUrl = "https://apiclientes.almapac.com:9010/api/queue/call-multiple/";
        string url = baseUrl + Tipo_Unidad + "/" + currentValue;

        // Token de autenticación
        string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9uZXMiLCJzdWIiOjYsInJvbGVzIjpbImJvdCJdLCJpYXQiOjE3MzMzMjIxNDAsImV4cCI6MjUyMjI2MjE0MH0.LPLUEOv4kNsozjwc1BW6qZ5R1fqT_BwsF-MM5vY5_Cc";
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

        try
        {
            using (WebClient client = new WebClient())
            {
                // Configurar los encabezados
                client.Headers[HttpRequestHeader.Authorization] = "Bearer " + token;
                client.Headers[HttpRequestHeader.ContentType] = "application/json";

                // Enviar la solicitud POST sin cuerpo
                string response = client.UploadString(url, "POST", "");

                // Devolver la respuesta del servidor
                return "Respuesta del servidor: " + response;
            }
        }
        catch (WebException webEx)
        {
            using (StreamReader reader = new StreamReader(webEx.Response.GetResponseStream()))
            {
                return "Error en la solicitud: " + webEx.Message + " - Respuesta del servidor: " + reader.ReadToEnd();
            }
        }
        catch (Exception ex)
        {
            return "Error inesperado: " + ex.Message;
        }
    }

    private void DataBind()
    {
        sql_rutas_actividades.SelectCommand = "SELECT * FROM [dbo].[ALMAPAC$Work Type]";
        sql_rutas_actividades.DataBind();
    }

    // Método para escribir en el Visor de eventos
    public void LogEvent(string message)
    {
        string logFilePath = Server.MapPath("~/Logs/MyAppLog.txt");
        string logDirectory = Path.GetDirectoryName(logFilePath);
        if (!Directory.Exists(logDirectory))
        {
            Directory.CreateDirectory(logDirectory);
        }
        File.AppendAllText(logFilePath, DateTime.Now + ": " + message + Environment.NewLine);
    }

    public class Post
    {
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
        public Driver driver { get; set; }
        public Vehicle vehicle { get; set; }
        public Ingenio ingenio { get; set; }
        public List<Status> statuses { get; set; }

        // Propiedades existentes...
        public string TimeForId2 { get; set; }  // Propiedad adicional para mostrar la hora
    }

    public class Driver
    {
        public int id { get; set; }
        public string license { get; set; }
        public string name { get; set; }
    }

    public class Vehicle
    {
        public int id { get; set; }
        public string plate { get; set; }
        public string trailerPlate { get; set; }
        public string truckType { get; set; }
    }

    public class Ingenio
    {
        public int id { get; set; }
        public string ingenioCode { get; set; }
        public User user { get; set; } // Asegúrate de que esta propiedad esté aquí
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