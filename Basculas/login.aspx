<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="Basculas_login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title></title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- Tipo de letra -->
        <link href="https://fonts.cdnfonts.com/css/gilroy-bold" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

        <style>
            html, body 
            {
                margin: 0;
                padding: 0;
                height: 100%;
                background-image: url('https://raw.githubusercontent.com/MarioPortillo10/Imagenes-ALMAPAC/refs/heads/main/Imagenes/fondo-_1_.webp');
                background-size: cover; /* Hace que la imagen cubra toda la pantalla */
                background-position: center; /* Centra la imagen */
                background-repeat: no-repeat; /* Evita que la imagen se repita */
                background-attachment: fixed; /* Fija la imagen de fondo al hacer scroll */
                font-family: 'Gilroy-Bold', sans-serif;
            }

            .wrapper 
            {
                display: flex;
                justify-content: center; /* Centra horizontalmente */
                align-items: center;    /* Centra verticalmente */
                min-height: 100vh;      /* Ocupa toda la altura de la pantalla */
                background: rgba(255, 255, 255, 0.1);
            }

            #formContent 
            {
                border-radius: 10px;
                background-color: rgba(255, 255, 255, 0); 
                padding: 30px;
                width: 90%;
                max-width: 500px;
                position: relative;
                text-align: center;
                box-shadow: 0 30px 60px 0 rgba(0, 0, 0, 0);
            }

            input, select 
            {
                opacity: 0.8; /* Ajusta la opacidad */
                background-color: rgba(255, 255, 255, 0.5); /* Fondo con opacidad */
                border-radius: 15px;
                padding: 10px;
                border: 1px solid #ccc;
            }

            .input-group 
            {
                display: flex;
                align-items: center;
                margin: 15px auto; /* Espaciado entre los elementos */
                width: 100%; /* Cambia este valor para aumentar el ancho */
                max-width: 800px; /* Opcional: establece un límite máximo */
                gap: 5px; /* Espacio entre el icono y el select/input */
            }
            .input-group-icon 
            {
                background-color: #F15D06; /* Color de fondo del ícono */
                padding: 15px; /* Espaciado interno */
                display: flex;
                justify-content: center;
                align-items: center;
                border-radius: 8px 0 0 8px; /* Bordes redondeados */
            }
            .input-group input, .input-group select 
            {
                flex: 1; /* El campo de entrada ocupa el resto del espacio */
                padding: 15px; /* Aumenta el espaciado interno */
                font-size: 18px; /* Tamaño de fuente más grande */
                height: 60px; /* Altura del input */
                border: 1px solid #ccc;
                border-left: none; /* Eliminar el borde que se superpone con el ícono */
                border-radius: 8px 8px 8px 8px; /* Bordes redondeados */
                outline: none;
            }
            .input-group-icon i 
            {
                font-size: 30px; /* Tamaño del ícono */
                color: #fff; /* Color del ícono */
            }
            .fadeIn 
            {
                animation: fadeIn 1s ease-in-out;
            }

            /* Estilo de la imagen de fondo para responsive */
            @media only screen and (max-width: 768px) 
            {
                html 
                {
                    background-size: contain; /* Ajusta la imagen para que sea más pequeña y se vea bien en pantallas pequeñas */
                }

                #formContent 
                {
                    width: 100%; /* Ajusta el ancho del formulario en pantallas pequeñas */
                    padding: 20px; /* Reduce el padding para mejor ajuste */
                }
            }

            @media only screen and (max-width: 480px) 
            {
                html 
                {
                    background-size: cover; /* Asegura que la imagen cubra la pantalla en dispositivos móviles */
                }

                #formContent 
                {
                    width: 100%; /* Asegura que el formulario ocupe todo el ancho disponible */
                    padding: 15px; /* Ajusta el padding para adaptarse a la pantalla más pequeña */
                }

                h2 
                {
                    font-size: 14px; /* Ajusta el tamaño de la fuente para pantallas pequeñas */
                }

                input[type=button], input[type=submit], input[type=reset] 
                {
                    padding: 10px 40px; /* Ajusta el tamaño de los botones */
                    font-size: 11px; /* Reduce el tamaño de la fuente de los botones */
                }
            }
        </style>

    </head>

    <body>
        <form id="frm_Login1" runat="server">
            <div class="wrapper fadeInDown">
                <asp:SqlDataSource ID="sql_usuarios" SelectCommand="SELECT PK_Usuario,Usuario FROM [dbo].[LEVERANS_UsuariosBascula] where Estado <> 0" runat="server" ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>"></asp:SqlDataSource>
                <div id="formContent" style="border: solid 0px">
                
                    <!-- Usuario -->
                    <div class="input-group">
                        <div class="input-group-icon">
                            <img src="https://raw.githubusercontent.com/MarioPortillo10/Imagenes-ALMAPAC/af2e9dd30050645dbaab9fb3c72dc2b871f81fc4/Imagenes/user-svgrepo-com.svg" alt="Usuario" width="30" height="30" style="filter: invert(100%);" /> <!-- Imagen de usuario -->
                        </div>

                        <asp:TextBox ID="txt_usuario" CssClass="form-control" runat="server" placeholder="Usuario"></asp:TextBox>
                    </div>

                    <!-- Contraseña -->
                    <div class="input-group">
                        <div class="input-group-icon">
                            <img src="https://raw.githubusercontent.com/MarioPortillo10/Imagenes-ALMAPAC/ed36b0229ef6091cb74abddeccc73a9c921ee29a/key-svgrepo-com%20(1).svg" alt="Contraseña" width="30" height="30" /> <!-- Imagen de candado -->
                        </div>
                        <asp:TextBox ID="txt_contraseña" TextMode="Password" CssClass="form-control" runat="server" placeholder="Contraseña" autocomplete="off"></asp:TextBox>
                    </div>

                    <!-- Báscula -->
                    <div class="input-group">
                        <div class="input-group-icon">
                            <img src="https://raw.githubusercontent.com/MarioPortillo10/Imagenes-ALMAPAC/af2e9dd30050645dbaab9fb3c72dc2b871f81fc4/Imagenes/industrial-scales-svgrepo-com.svg" alt="Báscula" width="30" height="30" style="filter: invert(100%)" /> <!-- Imagen de báscula -->
                        </div>
                        <asp:DropDownList ID="ddl_bascula" CssClass="form-control" runat="server">
                            <asp:ListItem Value="0">-Seleccione la Báscula-</asp:ListItem>
                            <asp:ListItem Value="1">Báscula 1</asp:ListItem>
                            <asp:ListItem Value="2">Báscula 2</asp:ListItem>
                            <asp:ListItem Value="3">Báscula 3</asp:ListItem>
                            <asp:ListItem Value="4">Báscula 4</asp:ListItem>
                            <asp:ListItem Value="5">Báscula 5</asp:ListItem>
                            <asp:ListItem Value="6">Báscula 6</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <!-- Turno -->
                    <div class="input-group">
                        <div class="input-group-icon">
                            <img src="https://raw.githubusercontent.com/MarioPortillo10/Imagenes-ALMAPAC/2e9bf4df48b5c1c4b92ce2a930ecf5eed0f5adce/time-svgrepo-com%20(1).svg" alt="Usuario" width="30" height="30" style="filter: invert(100%);" /> <!-- Imagen de reloj -->
                        </div>
                        
                        <asp:DropDownList ID="select_turno" CssClass="form-control" runat="server"> 
                            <asp:ListItem value="0">-Seleccione un Turno-</asp:ListItem>
                            <asp:ListItem value="1">6:00 a 14:00 </asp:ListItem>
                            <asp:ListItem value="2">14:00 a 22:00</asp:ListItem>
                            <asp:ListItem value="3">22:00 a 6:00 </asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <!-- Botón Login -->
                    <asp:Button ID="btn_login" CssClass="fadeIn mt-4" runat="server" Text="LOGIN" OnClick="btn_login_Click" 
                        style="animation: fadeIn 1s ease-out forwards; background-color: white;  color: #333; font-size: 16px; 
                               font-weight: bold; padding: 12px 40px; border-radius: 8px; border: none; cursor: pointer; 
                               transition: background-color 0.3s ease; width: 40%; margin: 0 auto;" 
                        onmouseover="this.style.backgroundColor='#f1f1f1';"
                        onmouseout="this.style.backgroundColor='white';"/>
                </div>
            </div>
        </form>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Detectar si existe el parámetro error en la URL
                const urlParams = new URLSearchParams(window.location.search);

                // Mostrar el mensaje de alerta solo si se hizo clic en el botón y se pasó el parámetro error
                if (urlParams.get("error") === "1") {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'La contraseña es incorrecta.'
                    });
                } else if (urlParams.get("error") === "2") {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Campos vacíos',
                        text: 'Por favor, complete todos los campos.'
                    });
                }
            });
        </script>

    </body>
</html>