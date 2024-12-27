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
        //realizamos validacion de campos requeridos
        if (!string.IsNullOrEmpty(txt_usuario.Text) && (select_turno.SelectedValue != "0") && (ddl_bascula.SelectedValue != "0") && !string.IsNullOrEmpty(txt_contraseña.Text))
        {
            //validamos credenciales del usuario
            int cod_usuario = ob_login.verificacion(txt_usuario.Text, txt_contraseña.Text);

            //si es valido, autorizamos el ingreso al sistema
            if (cod_usuario > 0)
            {
                //iniciamos la autentificacion
                FormsAuthentication.SetAuthCookie(txt_usuario.Text, false);
                FormsAuthentication.RedirectFromLoginPage(txt_usuario.Text, false);

                //guardamos datos necesarios en cookies
                Response.Cookies["username"].Value = txt_usuario.Text;
                Response.Cookies["username"].Expires = DateTime.Now.AddDays(1);

                Response.Cookies["cod_bascula"].Value = ddl_bascula.SelectedValue;
                Response.Cookies["cod_bascula"].Expires = DateTime.Now.AddDays(1);

                Response.Cookies["cod_usuario"].Value = Convert.ToString(cod_usuario);
                Response.Cookies["cod_usuario"].Expires = DateTime.Now.AddDays(1);

                Response.Cookies["cod_turno"].Value = Convert.ToString(cod_usuario);
                Response.Cookies["cod_turno"].Expires = DateTime.Now.AddDays(1);

                Response.Cookies["cod_rol"].Value = Convert.ToString(ob_login.rol(cod_usuario));
                Response.Cookies["cod_rol"].Expires = DateTime.Now.AddDays(1);

                // Evalúa el ReturnURL del link.
                if (string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
                    Response.Redirect("/Basculas/Autorizacion_Camiones.aspx", false);
                else
                    if (Request.QueryString["ReturnUrl"] == "/")
                        Response.Redirect("/Basculas/Autorizacion_Camiones.aspx", false);               // Redirecciona al inicio.
                    else
                        Response.Redirect(Request.QueryString["ReturnUrl"], false); // Redirecciona al link especificado.
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

}