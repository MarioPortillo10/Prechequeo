<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Autorizacion_Porton4.aspx.cs" Inherits="Basculas_Autorizacion_Porton4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chequeo de Entrada</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.6/dist/jquery.fancybox.min.css" />
    <!-- Tipo de letra -->
    <link href="https://fonts.cdnfonts.com/css/gilroy-bold" rel="stylesheet">

    <style>
        /* Establece la fuente del cuerpo de la página */
        body 
        {
        font-family: 'Roboto', sans-serif; /* Usa la fuente Roboto, con sans-serif como alternativa */
        }

        /* Estilo para botones naranjas */
        .button-orange 
        {
            background-color: #f97316; /* Color de fondo naranja */
        }

        .button-orange:hover 
        {
            background-color: #ea580c; /* Color de fondo más oscuro al pasar el mouse */
        }

        /* Estilo para una línea vertical Plano*/
        .vertical-line 
        {
            border-left: 4px solid #2b6cb0; /* Línea vertical anaranjada de 4px */
            height: 100%; /* Altura completa del contenedor */
        }

        /* Estilo para una línea vertical Volteo*/
        .vertical-line 
        {
            border-left: 4px solid #f97316; /* Línea vertical anaranjada de 4px */
            height: 100%; /* Altura completa del contenedor */
        }

        /* Estilo para una línea en el banner */
        .banner-line 
        {
            border-bottom: 6px solid #f97316; /* Línea horizontal en el banner de 6px */
        }

        /* Estilo para un banner personalizado */
        .custom-banner 
        {
            display: flex; /* Usa flexbox para el diseño */
            align-items: center; /* Alinea los elementos al centro verticalmente */
            background-color: #f97316; /* Color de fondo naranja */
            padding: 0.25rem 1rem; /* Espaciado interno reducido: 0.25rem arriba y abajo, 1rem a los lados */
            color: white; /* Color del texto blanco */
            margin-top: 105px;
            width: 45%;
            border-radius: 5px;
        }

        /* Estilo para el título dentro del banner */
        .custom-banner h1 
        {
            color: white; /* Color del texto blanco */
            font-size: 1.5rem; /* Tamaño de fuente reducido a 1.5rem */
            font-weight: bold; /* Texto en negrita */
            margin: 0; /* Elimina el margen por defecto */
            font-family: 'Gilroy-Bold', sans-serif;
        }

        /* Estilo para tarjetas */
        .card 
        {
            border-radius: 10px; /* Bordes redondeados de 10px */
            overflow: hidden; /* Oculta el contenido que se desborda */
        }

        /* Estilo para la cabecera de la tarjeta */
        .card-header 
        {
            background-color: #2b6cb0; /* Color de fondo azul */
            color: white; /* Color del texto blanco */
            padding: 10px; /* Espaciado interno de 10px */
        }

        .header 
        {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 50px;
            background-color: #fff;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 100; /* Para asegurar que esté en la parte superior de otros elementos */
            font-family: 'Gilroy-Light', sans-serif;
        }

        .logo img 
        {
            max-height: 35px;
        }

        .login-button 
        {
            border: 2px solid #FF5C00;
            padding: 10px 20px;
            border-radius: 5px;
            color: #FF5C00;
            font-weight: bold;
            transition: background-color 0.3s ease;
            display: flex;
            align-items: center;
            font-family: 'Gilroy-Bold', sans-serif;
        }

        .login-button i 
        {
            margin-right: 8px;
        }

        .login-button:hover 
        {
            background-color: #FF5C00;
            color: white;
        }

        /* Contenedor para el temporizador */
        .timer-container 
        {
            display: flex; /* Usa flexbox para el diseño */
            justify-content: space-between; /* Distribuye los elementos con espacio entre ellos */
        }

        /* Estilo para la información del temporizador */
        .timer-info 
        {
            display: flex; /* Usa flexbox para el diseño */
            align-items: center; /* Alinea los elementos al centro verticalmente */
            gap: 20px; /* Espacio de 20px entre los elementos */
        }

        /* Estilo para cada div dentro de la información del temporizador */
        .timer-info div 
        {
            background-color: white; /* Color de fondo blanco */
            width: 80px; /* Ancho de 80px */
            height: 80px; /* Altura de 80px */
            border-radius: 50%; /* Bordes redondeados para hacer un círculo */
        }

        /* Estilo para el contenedor de botones */
        .buttons 
        {
            display: flex; /* Usa flexbox para el diseño */
            gap: 10px; /* Espacio de 10px entre los botones */
        }

        .card1 
        {
            width: 175px; /* Ancho fijo */
            height: 75px; /* Alto fijo */
            background-color: #d1d5db; /* Color de fondo */
            padding: 1rem;
            text-align: center;
            border-radius: 0.5rem; /* Bordes redondeados */
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: center;
            margin: 0.5rem; /* Espaciado entre tarjetas */
        }
    </style>
</head>
<body>
 <form id="form1" runat="server">
    <asp:SqlDataSource ID="sql_rutas_actividades" runat="server" ConnectionString="<%$ ConnectionStrings:ConnProduccion %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_rutas_actividadesDetalles" runat="server" ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>"
        InsertCommand="INSERT INTO [dbo].[LEVERANS_Plantilla_Rutas]([FK_Acceso],[Fk_Actividad],[Estado],[Correlativo])VALUES(@FK_Acceso,@FK_Actividad,1,@Correlativo)"
        DeleteCommand="DELETE FROM [dbo].[LEVERANS_Plantilla_Rutas] WHERE [PK_Ruta]=@PK_Rutas"
        UpdateCommand="UPDATE [dbo].[LEVERANS_Plantilla_Rutas] SET [Correlativo] = @Correlativo,[FK_Acceso]=@FK_Acceso,[Estado] = @Estado  WHERE [PK_Ruta]=@PK_Rutas">

        <InsertParameters>
            <asp:Parameter Name="FK_Acceso" Type="Int32" />
            <asp:Parameter Name="FK_Actividad" Type="Int32" />
            <asp:Parameter Name="Correlativo" Type="Int32" />
        </InsertParameters>

        <DeleteParameters>
            <asp:Parameter Name="PK_Rutas" Type="Int32" />
        </DeleteParameters>

        <UpdateParameters>
            <asp:Parameter Name="PK_Rutas" Type="Int32" />
            <asp:Parameter Name="FK_Acceso" Type="Int32" />
            <asp:Parameter Name="Correlativo" Type="Int32" />
            <asp:Parameter Name="Estado" Type="Boolean" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <!-- Header -->
    <header class="header bg-gradient-to-r from-white to-gray-200 py-4">
        <div class="container mx-auto flex items-center justify-between">
            <!-- Logo -->
            <div class="logo">
                <img src="https://github.com/MarioPortillo10/Imagenes-ALMAPAC/blob/main/Imagenes/almapac.png?raw=true" alt="Almapac Logo" class="h-12">
            </div>

            <!-- Navbar Toggler for Mobile View -->
            <button id="menu-toggle" class="md:hidden text-gray-600 focus:outline-none">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
                </svg>
            </button>

            <!-- Navbar Links -->
            <nav id="navbar" class="hidden md:flex space-x-4 text-sm text-gray-600">
                <a href="Default.aspx" class="hover:text-orange-600 flex items-center">
                    <i class="far fa-file-alt mr-2"></i>Pre-Transacciones
                </a>

                <div class="relative group hover:bg-gray-100 p-2 rounded">
                    <button class="hover:text-orange-600 px-2 py-1 flex items-center focus:outline-none">
                        <span>Rutas</span>
                        <svg class="ml-1 w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M5.23 7.21a.75.75 0 111.06-1.06L10 9.86l3.71-3.71a.75.75 0 011.06 1.06l-4 4a.75.75 0 01-1.06 0l-4-4z" />
                        </svg>
                    </button>
                    <!-- Dropdown Menu -->
                    <div class="absolute left-0 mt-2 w-48 bg-white border border-gray-200 rounded shadow-lg hidden group-hover:block group-focus-within:block">
                        <div class="block px-4 py-2 text-gray-700 hover:bg-gray-100">
                            <i class="fas fa-road mr-2"></i>Rutas Transacciones
                        </div>
                        <div class="block px-4 py-2 text-gray-700 hover:bg-gray-100">
                            <i class="fas fa-road mr-2"></i>Rutas Actividades
                        </div>
                    </div>
                </div>

                <div class="relative group hover:bg-gray-100 p-2 rounded">
                    <button class="bg-primary text-white flex items-center px-2 py-1 rounded focus:outline-none">
                        <span>Monitoreo</span>
                        <svg class="ml-1 w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M5.23 7.21a.75.75 0 111.06-1.06L10 9.86l3.71-3.71a.75.75 0 011.06 1.06l-4 4a.75.75 0 01-1.06 0l-4-4z" />
                        </svg>
                    </button>
                    <!-- Dropdown Menu -->
                    <div class="absolute left-0 mt-2 w-48 bg-white border border-gray-200 rounded shadow-lg hidden group-hover:block group-focus-within:block">
                        <div class="block px-4 py-2 hover:bg-gray-100 text-gray-700">
                            <a href="Autorizacion_Camiones.aspx" style="text-decoration: none;">
                                <i class="fa fa-truck mr-2"></i>Chequeo de Informacion
                            </a>
                        </div>
                        <div class="block px-4 py-2 hover:bg-gray-100 text-gray-700">
                            <a href="Autorizacion_ingreso.aspx" style="text-decoration: none;">
                                <i class="fas fa-unlock mr-2"></i>Autorización Ingreso
                            </a>
                        </div>
                        <div class="block px-4 py-2 bg-primary text-white rounded hover:bg-opacity-80">
                            <a href="Autorizacion_Porton4.aspx" style="text-decoration: none;">
                                <i class="fas fa-check-square mr-2"></i>Autorización Portón 4
                            </a>
                        </div>
                        <div class="block px-4 py-2 hover:bg-gray-100 text-gray-700">
                            <a href="Lista_Negra.aspx" style="text-decoration: none;">
                                <i class="fas fa-list-alt mr-2"></i>Lista Negra Motorista
                            </a>
                        </div>
                    </div>
                </div>
                <a href="Tiempos_Azucar.aspx" class="hover:text-orange-600 flex items-center" style="text-decoration: none;">
                    <i class="fas fa-clock mr-2"></i>Recepción Azúcar
                </a>
            </nav>

            <!-- Logout Button -->
            <a href="login.aspx" class="login-button" style="text-decoration:none">
                <i class="fas fa-user"></i> Cerrar Sesión
            </a>

            <!-- Mobile Menu -->
            <div id="mobile-menu" class="md:hidden hidden px-4 py-2 space-y-2 bg-gray-100">
                <a href="Default.aspx" class="block text-gray-700 hover:text-orange-600">Pre-Transacciones</a>
                <div class="block text-gray-700">Rutas Transacciones</div>
                <div class="block text-gray-700">Rutas Actividades</div>
                <div class="block text-gray-700 bg-primary text-white">Chequeo de Información</div>
                <a href="Autorizacion_ingreso.aspx" class="block text-gray-700 hover:text-orange-600">Autorización Ingreso</a>
                <a href="Autorizacion_Porton4.aspx" class="block text-gray-700 hover:text-orange-600">Autorización Portón 4</a>
                <a href="Lista_Negra.aspx" class="block text-gray-700 hover:text-orange-600">Lista Negra Motorista</a>
                <a href="Tiempos_Azucar.aspx" class="block text-gray-700 hover:text-orange-600">Recepción Azúcar</a>
                <a href="login.aspx" class="block text-gray-700 hover:text-orange-600">Cerrar Sesión</a>
            </div>
        </div>
    </header>
    

    <!-- Banner -->
    <section class="custom-banner text-center">
        <h1>Chequeo de entrada</h1>
    </section>

    <!-- Main Content -->
    <div class="container">
        <div class="row mt-3"> <!-- Agregado mt-3 para un margen superior -->
            <asp:Repeater ID="rptRutas" runat="server">
                <ItemTemplate>
                    <div class="col-lg-3 col-md-4 col-sm-6 mb-4 d-flex align-items-stretch">
                        <div class="card border rounded-4 w-100" 
                            style="border-color: #ddd; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); height: 380px; margin-top: 10px; font-family: Gilroy-Bold, sans-serif;"> <!-- Agregado margin-top -->
                            <asp:LinkButton CssClass="btn" ID="lnk_VerRuta" runat="server" data-toggle="modal" data-target="#rutaModal" data-codigo-generacion='<%# Eval("codeGen") %>'>
                                <div style="position: relative;">
                                    <!-- Badge centrado y abajo -->
                                    <div class="position-absolute bottom-0 start-50 translate-middle-x mb-4">
                                        <span class="badge 
                                            <%# Eval("vehicle.truckType").ToString() == "V" ? "bg-success" : 
                                                Eval("vehicle.truckType").ToString() == "R" ? "bg-dark" : 
                                                "bg-secondary" %> 
                                            text-white px-3 py-2 rounded-pill">
                                            <%# Eval("vehicle.truckType").ToString() == "V" ? "Volteo" : 
                                                Eval("vehicle.truckType").ToString() == "R" ? "Plana" : "Plano" %>
                                        </span>
                                    </div>
                                </div>

                                <div class="card-body p-3">
                                    <!-- Información de la tarjeta -->
                                    <p class="text-start" style="font-size: 0.9rem;"><i class="fas fa-exchange-alt text-primary">
                                        </i> <strong>Transacción:</strong></p>
                                    <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                        <asp:Label ID="lblTransaccion" runat="server"
                                            Text='<%# Eval("navRecord.id") != null ? HttpUtility.HtmlEncode(Eval("navRecord.id").ToString()) : "Sin datos" %>' />
                                    </p>
                                
                                    <p class="text-start" style="font-size: 0.9rem;">
                                        <i class="fas fa-id-card text-primary"></i> <strong>Licencia:</strong>
                                    </p>
                                    <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                        <asp:Label ID="lblHoraStatus" runat="server" Text='<%# HttpUtility.HtmlEncode(Eval("driver.license").ToString()) %>' />
                                    </p>

                                    <p class="text-start" style="font-size: 0.9rem;">
                                        <i class="fas fa-list-ol text-primary"></i> <strong>Placa Cabezal:</strong>
                                    </p>
                                    <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                        <asp:Label ID="lblplaca_cabezal" runat="server" Text='<%# HttpUtility.HtmlEncode(Eval("vehicle.plate").ToString()) %>' />
                                    </p>

                                    <p class="text-start" style="font-size: 0.9rem;">
                                        <i class="fas fa-truck text-primary"></i> <strong>Placa Remolque:</strong>
                                    </p>
                                    <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                        <asp:Label ID="lblplacaremolque" runat="server" Text='<%# HttpUtility.HtmlEncode(Eval("vehicle.trailerPlate").ToString()) %>' />
                                    </p>

                                    <!-- Línea divisoria -->
                                    <hr style="border: 2px solid #ff7300; margin: 10px 0;" />

                                    <p class="text-start" style="font-size: 0.9rem;">
                                        <i class="fas fa-calendar text-primary"></i> <strong>Fecha Autorización:</strong>
                                    </p>
                                    <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                        <asp:Label ID="lblNombre" runat="server"  Text='<%# Eval("dateTimePrecheckeo") %>' />
                                    </p>

                                    <p class="text-start" style="font-size: 0.9rem;">
                                        <i class="fas fa-hourglass-half text-primary"></i> <strong>Tiempo Transcurrido:</strong>
                                    </p>
                                    <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                        <asp:Label ID="lblTimeDifference" runat="server"
                                            Text='<%# Eval("dateTimePrecheckeo") != null 
                                                ? FormatTimeDifference(Convert.ToDateTime(Eval("dateTimePrecheckeo")))
                                                : "No disponible" %>' />
                                    </p>
                                </div>
                            </asp:LinkButton>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>



    <!-- Footer -->
    <footer class="flex items-center justify-center py-2 text-sm text-gray-300 font-bold" 
            style="font-family: 'Gilroy-Light', sans-serif; background-color: #242424; color: white; width: 100%; position: fixed; bottom: 0; left: 0;">
        <span>© 2024 Almacenadora del Pacífico S.A. de C.V. - Todos los derechos reservados</span>
    </footer>


       
        <!-- Modal RESTABLECER CONTRASEÑA -->
        <div class="modal fade" id="editPass" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class=" modal-title" id="editPass2">Cambiar contraseña</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group col-12">
                            <asp:TextBox ID="txtUsuario" Enabled="false" Text="Usuario1" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>

                        <div class="form-group col-12">
                            <asp:TextBox ID="txtPass" TextMode="Password" CssClass="form-control" placeholder="Contraseña" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="ReqtxtPass" runat="server" ControlToValidate="txtPass" CssClass="reqGeneral" ErrorMessage="*" Display="Dynamic" ValidationGroup="reset" InitialValue=""><i class="fa fa-times-circle" aria-hidden="true"></i></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>

        <div class="modal fade" id="rutaModal" tabindex="-1" role="dialog" aria-labelledby="rutaModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="rutaModalLabel">Validacion de Marchamos</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" class="form-control" id="codigoGeneracionInput" readonly />
                        <form>
                            <div class="form-group">
                                <label for="recipient-name" class="col-form-label">Marchamo 1:</label>
                                <input type="text" class="form-control" id="txt_marchamo1">
                            </div>
                            <div class="form-group">
                                <label for="message-text" class="col-form-label">Marchamo 2:</label>
                                <input type="text" class="form-control" id="txt_marchamo2">
                            </div>
                            <div class="form-group">
                                <label for="message-text" class="col-form-label">Marchamo 3:</label>
                                <input type="text" class="form-control" id="txt_marchamo3">
                            </div>
                            <div class="form-group">
                                <label for="recipient-name" class="col-form-label">Marchamo 4:</label>
                                <input type="text" class="form-control" id="txt_marchamo4">
                            </div>
                        </form>
                        <asp:Label ID="lblRuta" runat="server" Text=""></asp:Label>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-primary" onclick="validarInformacion()">Confirmar</button>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <!-- SweetAlert2 (latest version) -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.all.min.js"></script>

    <!-- Custom Scripts -->
    <script src="../src/js/spotlight.bundle.js"></script>

    <script src="https://cdn.tailwindcss.com"></script>


    <!-- JavaScript for Mobile Menu Toggle -->
    <script>
        document.getElementById('menu-toggle').addEventListener('click', function() {
            const mobileMenu = document.getElementById('mobile-menu');
            mobileMenu.classList.toggle('hidden');
        });
    </script>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <!-- SweetAlert2 (latest version) -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.all.min.js"></script>

    <!-- Custom Scripts -->
    <script src="../src/js/spotlight.bundle.js"></script>
    
    <!-- Picturefill (for responsive images) -->
    <script src="https://cdn.jsdelivr.net/picturefill/2.3.1/picturefill.min.js"></script>

    <!-- LightGallery and Plugins -->
    <script src="https://cdn.rawgit.com/sachinchoolur/lightgallery.js/master/dist/js/lightgallery.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-pager.js/master/dist/lg-pager.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-autoplay.js/master/dist/lg-autoplay.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-fullscreen.js/master/dist/lg-fullscreen.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-zoom.js/master/dist/lg-zoom.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-hash.js/master/dist/lg-hash.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-share.js/master/dist/lg-share.js"></script>

    <script>
        $(document).ready(function () 
        {
            $('#rutaModal').on('show.bs.modal', function (event) 
            {
                var button = $(event.relatedTarget); // Botón que abrió el modal
                var codigoGeneracion = button.data('codigo-generacion'); // Extraer la información del atributo data-codigo-generacion
                var modal = $(this);
                modal.find('#codigoGeneracionInput').val(codigoGeneracion); // Mostrar el código de generación en el input
            });
        });

        function filterCards() 
        {
            const input = document.getElementById('searchInput').value.toLowerCase();
            const cards = document.querySelectorAll('.card');
            
            cards.forEach(card => {
                const text = card.textContent.toLowerCase();
                card.style.display = text.includes(input) ? '' : 'none';
            });
        }

        // Evento para cuando se abre la modal
        $('#rutaModal').on('shown.bs.modal', function () 
        {
            // Establece el autofocus en el primer input
            $('#txt_marchamo1').focus();
        });

        // Función para manejar el autofocus entre los campos
function configurarAutofocus() {
    const campos = [
        'txt_marchamo1',
        'txt_marchamo2',
        'txt_marchamo3',
        'txt_marchamo4'
    ];

    // Variable para detectar si la modal está abierta o cerrada
    let modalAbierta = false;

    // Referencia a la modal
    const modal = document.getElementById('rutaModal'); // Ajusta el id de tu modal

    // Usar el evento hidden.bs.modal de Bootstrap para detectar el cierre de la modal
    $(modal).on('hidden.bs.modal', function () {
        modalAbierta = false; // Marcar que la modal se ha cerrado
        limpiarCampos(); // Limpiar los campos cuando se cierre la modal
    });

    // Limpiar todos los campos de la modal
    function limpiarCampos() {
        campos.forEach(campoId => {
            const campo = document.getElementById(campoId);
            if (campo) {
                campo.value = ''; // Limpiar el valor del campo
            }
        });
    }

    // Cuando se abre la modal, marcarla como abierta
    const botonAbrirModal = document.getElementById('abrirRutaModal'); // Ajusta este id al de tu botón de apertura
    if (botonAbrirModal) {
        botonAbrirModal.addEventListener('click', () => {
            modalAbierta = true; // Marcar que la modal está abierta
        });
    }

    // Si el usuario hace blur (sale de un campo), manejamos el foco y validación
    campos.forEach((campo, index) => {
        const elemento = document.getElementById(campo);

        if (elemento) {
            elemento.addEventListener('blur', function () {
                // Usamos un timeout para que el foco actual se actualice correctamente
                setTimeout(() => {
                    const elementoActivo = document.activeElement;
                    const esOtroCampo = campos.includes(elementoActivo.id);

                    // Si el usuario no se movió manualmente a otro campo
                    if (!esOtroCampo) {
                        // Buscar el primer campo vacío
                        const campoVacio = campos.find(id => {
                            const input = document.getElementById(id);
                            return input && input.value.trim() === ''; // Campo vacío
                        });

                        if (campoVacio) {
                            // Mover el foco al primer campo vacío
                            document.getElementById(campoVacio).focus();
                        } else if (index === campos.length - 1 && !modalAbierta) {
                            // Si todos los campos están llenos, y la modal no está abierta, ejecutar validarInformacion
                            validarInformacion();
                        }
                    }
                }, 0);
            });
        }
    });
}

// Configurar el autofocus al cargar la página
document.addEventListener('DOMContentLoaded', configurarAutofocus);




        function validarInformacion() 
        {
            var codigoGeneracion = document.getElementById('codigoGeneracionInput').value;
            var marchamo1 = document.getElementById('txt_marchamo1').value;
            var marchamo2 = document.getElementById('txt_marchamo2').value;
            var marchamo3 = document.getElementById('txt_marchamo3').value;
            var marchamo4 = document.getElementById('txt_marchamo4').value;

            // Realizar la solicitud AJAX
            $.ajax({
                type: "POST",
                url: "Autorizacion_Porton4.aspx/ValidarDatos",
                data: JSON.stringify({
                    codigoGeneracion: codigoGeneracion,
                    marchamo1: marchamo1,
                    marchamo2: marchamo2,
                    marchamo3: marchamo3,
                    marchamo4: marchamo4
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) 
                {
                    var resultado = response.d;

                    if (resultado.includes("Validación exitosa")) 
                    {
                        // Mostrar alerta de éxito con SweetAlert2
                        Swal.fire({
                            icon: 'success',
                            title: 'Validación exitosa',
                            text: resultado,
                            confirmButtonText: 'Aceptar'
                        }).then(() => {
                            // Llamar a changeStatus después de la validación exitosa
                            changeStatus(codigoGeneracion);
                        });
                    } 
                    else 
                    {
                        // Mostrar alerta de error con SweetAlert2
                        Swal.fire({
                            icon: 'error',
                            title: 'Error en la validación',
                            text: resultado,
                            confirmButtonText: 'Aceptar'
                        });
                    }
                },
                error: function (error) 
                {
                    console.error("Error en la solicitud: ", error);

                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Ocurrió un error al validar los datos. Por favor, intenta nuevamente.',
                        confirmButtonText: 'Aceptar'
                    });
                }
            });
        }


        // Función para cambiar el estatus después de la validación exitosa
        function changeStatus(codigoGeneracion) 
        {
            var predefinedStatusId = 5; // Cambia esto al ID de estado que deseas

            if (!codigoGeneracion || codigoGeneracion.trim() === '') 
            {
                Swal.fire({
                    title: 'Error',
                    text: 'Por favor, ingrese un Código de Generación',
                    icon: 'error',
                    confirmButtonColor: '#3085d6',
                    confirmButtonText: 'Aceptar'
                });
                return;
            }

            $.ajax({
                type: "POST",
                url: "Autorizacion_Camiones.aspx/ChangeTransactionStatus",
                data: JSON.stringify({ codeGen: codigoGeneracion, predefinedStatusId: predefinedStatusId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) 
                {
                    console.log("Respuesta de la API: ", response.d);
                    
                    // Mostrar un SweetAlert indicando que el cambio fue exitoso
                    Swal.fire({
                        title: "Éxito",
                        text: "El estatus se cambió correctamente.",
                        icon: "success",
                        confirmButtonText: "Aceptar"
                    }).then(() => {
                        // Recargar la página después de aceptar
                        location.reload();
                    });
                },
                error: function(xhr, status, error) {
                    console.error("Error cambiando el estado: ", error);

                    // Mostrar un SweetAlert indicando el error
                    Swal.fire({
                        title: "Error",
                        text: "No se pudo cambiar el estatus. Motivo: " + (xhr.responseText || error),
                        icon: "error",
                        confirmButtonText: "Aceptar"
                    });
                }

            });
        }


    </script>

</body>
</html>