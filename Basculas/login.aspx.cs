using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Basculas_login : System.Web.UI.Page
{
    login ob_login = new login();


    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btn_login_Click(object sender, EventArgs e)
{
    // Validamos que los campos requeridos no estén vacíos
    if (!string.IsNullOrEmpty(txt_usuario.Text) && (select_turno.SelectedValue != "0") && 
        (ddl_bascula.SelectedValue != "0") && !string.IsNullOrEmpty(txt_contraseña.Text))
    {
        // Validamos credenciales del usuario
        int cod_usuario = ob_login.verificacion(txt_usuario.Text, txt_contraseña.Text);

        // Si es válido, autorizamos el ingreso al sistema
        if (cod_usuario > 0)
        {
            // Iniciamos la autenticación
            FormsAuthentication.SetAuthCookie(txt_usuario.Text, false);
            FormsAuthentication.RedirectFromLoginPage(txt_usuario.Text, false);

            // Guardamos datos necesarios en cookies
            Response.Cookies["username"].Value = txt_usuario.Text;
            Response.Cookies["username"].Expires = DateTime.Now.AddDays(1);

            Response.Cookies["cod_bascula"].Value = ddl_bascula.SelectedValue;
            Response.Cookies["cod_bascula"].Expires = DateTime.Now.AddDays(1);

            Response.Cookies["cod_usuario"].Value = Convert.ToString(cod_usuario);
            Response.Cookies["cod_usuario"].Expires = DateTime.Now.AddDays(1);

            Response.Cookies["cod_turno"].Value = Convert.ToString(cod_usuario);
            Response.Cookies["cod_turno"].Expires = DateTime.Now.AddDays(1);

            int codRol = ob_login.rol(cod_usuario);
            Response.Cookies["cod_rol"].Value = Convert.ToString(codRol);
            Response.Cookies["cod_rol"].Expires = DateTime.Now.AddDays(1);

            // Obtener la primera página permitida para el rol
            string paginaDestino = ObtenerPaginaPorRol(codRol);

            // Evalúa el ReturnUrl del link (si el usuario intentó acceder a otra página antes del login)
            if (!string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]) && Request.QueryString["ReturnUrl"] != "/")
            {
                Response.Redirect(Request.QueryString["ReturnUrl"], false);
            }
            else
            {
                Response.Redirect(paginaDestino, false); // Redirige a la primera página asignada por su rol
            }
        }
        else
        {
            // Redirige con un parámetro de error si las credenciales son incorrectas
            Response.Redirect("login.aspx?error=1", false);
        }
    }
    else
    {
        // Redirige con un parámetro de error si los campos están vacíos
        Response.Redirect("login.aspx?error=2", false);
    }
}

// Función que devuelve la primera página permitida según el rol
private string ObtenerPaginaPorRol(int codRol)
{
    Dictionary<int, List<string>> paginasPorRol = new Dictionary<int, List<string>>
    {
        { 1, new List<string> { "Autorizacion_Camiones.aspx", "Autorizacion_ingreso.aspx", "Autorizacion_Porton4.aspx", "Lista_Negra.aspx", "Tiempos_Azucar.aspx" } },
        { 2, new List<string> { "Autorizacion_Camiones.aspx", "Autorizacion_ingreso.aspx", "Autorizacion_Porton4.aspx" } },
        { 3, new List<string> { "Autorizacion_Camiones.aspx", "Autorizacion_ingreso.aspx", "Autorizacion_Porton4.aspx" } },
        { 4, new List<string> { "Tiempos_Azucar.aspx" } },
        { 5, new List<string> { "Autorizacion_Porton4.aspx" } }
    };

    if (paginasPorRol.ContainsKey(codRol) && paginasPorRol[codRol].Count > 0)
    {
        return "/Basculas/" + paginasPorRol[codRol][0]; // Devuelve la primera página permitida según el rol
    }

    return "/login.aspx"; // Si el rol no existe o no tiene páginas, lo redirige al login
}


}