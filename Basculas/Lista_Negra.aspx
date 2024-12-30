<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Lista_Negra.aspx.cs" Inherits="Basculas_Lista_Negra" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Autorizacion de Ingreso</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.2/css/all.css" integrity="sha384-/rXc/GQVaYpyDdyxK+ecHPVYJSN9bmVFBvjA/9eOB+pb3F2w2N6fc5qB9Ew5yIns" crossorigin="anonymous" />
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

    /* Estilo para los campos con error */
    .error-field 
    {
        border: 2px solid red !important; /* Borde rojo de 2px */
        background-color: #ffdddd; /* Fondo ligeramente rojo para resaltar el error */
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
                        <div class="block px-4 py-2 hover:bg-gray-100 text-gray-700">
                            <a href="Autorizacion_Porton4.aspx" style="text-decoration: none;">
                                <i class="fas fa-check-square mr-2"></i>Autorización Portón 4
                            </a>
                        </div>

                        <div class="block px-4 py-2 bg-primary text-white rounded hover:bg-opacity-80">
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
        <h1>Lista Negra</h1>
    </section>

    <div class="d-flex justify-content-start" style="margin-top: -35px;">
        <button type="button" class="btn" data-toggle="modal" data-target="#myModal" 
            style="margin-left: 75%; background-color: #003366; border-color: #1D3557; color: white; 
                border-radius: 5px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); padding: 10px 20px; 
                font-size: 1rem; transition: all 0.3s ease-in-out;">
            <i class="fas fa-plus"></i> <strong> Nuevo Registro </strong> 
        </button>
    </div>


    <!-- Main Content -->
    <main class="container mx-auto py-8">
        <div class="row ml-3" style="border: solid 0px;">
            <div class="col mt-2 mb-2">
                <input type="text" id="searchInput" onkeyup="filterCards()" placeholder="Busca aqui la transaccion..." class="form-control mb-3" style="border-radius: 15px; background-color: #f8f9f9; border: 1px solid #000000;">
            </div>
        </div>

        <section class="grid grid-cols-1 md:grid-cols-2 gap-8" style="font-family: 'Gilroy-Bold', sans-serif;">
            <div class="w-11/12 mx-auto bg-white" style="max-width: 900px; margin: 0 auto;">
                <div class="row g-4">
                    <asp:Repeater ID="rptRutas" runat="server">
                        <ItemTemplate>
                            <div class="col-lg-6 col-md-6 col-sm-12 mb-4">
                                <div class="card border rounded-4" style="border-color: #ddd; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); width: 100%; max-width: 450px; height: 400px;">
                                    <div class="card-img-top" style="height: 200px; overflow: hidden; border-top-left-radius: 10px; border-top-right-radius: 10px; display: flex; align-items: center; justify-content: center; background-color: #f8f9fa;">
                                        <asp:Image ID="imgShipment" runat="server"
                                            ImageUrl='<%# (Eval("shipmentAttachments") != null && ((IEnumerable<object>)Eval("shipmentAttachments")).Count() > 0)
                                                        ? ((dynamic)Eval("shipmentAttachments"))[0].fileUrl
                                                        : null %>'
                                            CssClass="img-fluid"
                                            style='<%# (Eval("shipmentAttachments") != null && ((IEnumerable<object>)Eval("shipmentAttachments")).Count() > 0) 
                                                    ? "width: 100%; height: 100%; object-fit: cover;" 
                                                    : "display: none;" %>' />
                                        <div style='<%# (Eval("shipmentAttachments") != null && ((IEnumerable<object>)Eval("shipmentAttachments")).Count() > 0) 
                                                        ? "display: none;" 
                                                        : "width: 100%; height: 100%; border: 2px dashed #ddd; display: flex; align-items: center; justify-content: center; font-size: 1rem; color: #888;" %>'>
                                            Sin imagen
                                        </div>
                                    </div>
                                
                                    <div class="card-body p-4">
                                        <!-- Información de la tarjeta con texto más pequeño -->
                                        <p class="text-start" style="font-size: 0.9rem;"><i class="fas fa-user text-primary"></i> <strong>Nombre:</strong></p>
                                        <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                            <asp:Label ID="lblNombre" runat="server"
                                                Text='<%# Eval("driver.name") != null ? HttpUtility.HtmlEncode(Eval("driver.name").ToString()) : "Sin datos" %>' />
                                        </p>

                                        <p class="text-start" style="font-size: 0.9rem;"><i class="fas fa-id-card text-primary"></i> <strong>DUI:</strong></p>
                                        <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                            
                                        </p>

                                        <!-- Línea divisoria con grosor y color especificados -->
                                        <hr style="border: 2px solid #ff7300; margin: 10px 0;" />

                                        <p class="text-start" style="font-size: 0.9rem;"><i class="fas fa-credit-card text-primary"></i> <strong>Licencia:</strong></p>
                                        <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                            <asp:Label ID="lblLicencia" runat="server"
                                                Text='<%# Eval("driver.license") != null ? HttpUtility.HtmlEncode(Eval("driver.license").ToString()) : "Sin datos" %>' />
                                        </p>
                                            
                                        <p class="text-start" style="font-size: 0.9rem;"><i class="fas fa-truck text-primary"></i> <strong>Empresa de Transporte:</strong></p>
                                        <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                        </p>

                                        <p class="text-start" style="font-size: 0.9rem;"><i class="fas fa-exclamation-circle text-primary"></i> <strong>Tipo de Incidente:</strong></p>
                                        <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                        </p>

                                        <p class="text-start" style="font-size: 0.9rem;"><i class="fas fa-ban text-primary"></i> <strong>Tipo de Castigo:</strong></p>
                                        <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                        </p>

                                        <p class="text-start" style="font-size: 0.9rem;"><i class="fas fa-comment text-primary"></i> <strong>Comentario:</strong></p>
                                        <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                            <asp:Label ID="lblComentario" runat="server"
                                                Text='<%# Eval("observation") != null ? HttpUtility.HtmlEncode(Eval("observation").ToString()) : "Sin datos" %>' />
                                        </p>

                                        <p class="text-start" style="font-size: 0.9rem;"><i class="fas fa-clock text-primary"></i> <strong>Tiempo de Sancion:</strong></p>
                                        <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                            <asp:Label ID="lblTiempoSan" runat="server"
                                                Text='<%# Eval("banDurationDays") != null ? HttpUtility.HtmlEncode(Eval("banDurationDays").ToString() + " Días") : "Sin datos" %>' />
                                        </p>

                                        <p class="text-start" style="font-size: 0.9rem;"><i class="fas fa-calendar-check text-primary"></i> <strong>Fin de Sancion:</strong></p>
                                        <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                        </p>
                                            
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </section> 
    </main>

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

        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="myModalLabel">Registrar Motorista</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="recipient-name" class="col-form-label">Licencia:</label>
                            <input type="text" class="form-control" id="txt_licencia" />
                        </div>
                        
                        <div class="form-group">
                            <label for="message-text" class="col-form-label">Tiempo:</label>
                            <input type="number" class="form-control" id="txt_tiempo"/>
                        </div> 

                        <div class="form-group">
                            <label for="message-text" class="col-form-label">Observación:</label>
                            <textarea type="text" class="form-control" id="txt_observacion"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-primary" onclick="addBlacklist();">Guardar</button>
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

    <script>
        function filterCards() 
        {
            // Obtén el valor del input de búsqueda
            var input = document.getElementById("searchInput").value.toLowerCase();

            // Selecciona todas las tarjetas dentro de los repetidores
            var cards = document.querySelectorAll(".card");

            // Recorre todas las tarjetas y muestra u oculta según el filtro
            cards.forEach(function(card) 
            {
                // Combina el texto de los elementos de la tarjeta en una sola cadena y lo compara con el input
                var cardText = card.innerText.toLowerCase();
                if (cardText.includes(input)) 
                {
                    card.style.display = "block"; // Muestra la tarjeta
                } 
                else 
                {
                    card.style.display = "none"; // Oculta la tarjeta
                }
            });
        }

        function addBlacklist() {
    // Obtener los valores de los campos
    var licencia = document.getElementById('txt_licencia').value;
    var tiempo = document.getElementById('txt_tiempo').value;
    var observacion = document.getElementById('txt_observacion').value;

    // Verificar si el campo licencia está vacío
    if (!licencia) {
        Swal.fire({
            icon: 'warning',
            title: 'Campo licencia vacío',
            text: 'Por favor, ingrese el número de licencia.',
            confirmButtonText: 'Aceptar'
        });
        return; // Detener la ejecución si el campo licencia está vacío
    }

    // Verificar si el campo tiempo está vacío
    if (!tiempo) {
        Swal.fire({
            icon: 'warning',
            title: 'Campo tiempo vacío',
            text: 'Por favor, ingrese el número de días.',
            confirmButtonText: 'Aceptar'
        });
        return; // Detener la ejecución si el campo tiempo está vacío
    }

    // Verificar si el campo observación está vacío
    if (!observacion) {
        Swal.fire({
            icon: 'warning',
            title: 'Comentario vacío',
            text: 'Por favor, ingrese un comentario antes de guardar.',
            confirmButtonText: 'Aceptar'
        });
        return; // Detener la ejecución
    }

    // Llamar al servidor para validar los datos
    $.ajax({
        type: "POST",
        url: "Lista_Negra.aspx/addBlacklist",
        data: JSON.stringify({
            licencia: licencia,
            tiempo: tiempo,
            observacion: observacion
        }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            console.log("Respuesta del servidor:", response); // Mostrar toda la respuesta
            var resultado = response.d; // Respuesta del servidor

            // Verificar el tipo de alerta y mostrar la alerta correspondiente
            if (resultado.alertType === "success") {
                Swal.fire({
                    icon: 'success',
                    title: 'Éxito',
                    text: resultado.message,
                    confirmButtonText: 'Aceptar'
                });
            } else if (resultado.alertType === "error") {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: resultado.message,
                    confirmButtonText: 'Aceptar'
                });
            } else if (resultado.alertType === "warning") {
                Swal.fire({
                    icon: 'warning',
                    title: 'Advertencia',
                    text: resultado.message,
                    confirmButtonText: 'Aceptar'
                });
            }
        },
        error: function (error) {
            console.error("Error en la solicitud:", error);
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Ocurrió un error al validar los datos. Detalles: ' + (error.responseJSON ? error.responseJSON.message : error.statusText),
                confirmButtonText: 'Aceptar'
            });
        }
    });
}


        // Función para limpiar los campos de entrada
        function resetErrorFields() {
            var campos = [
                'txt_licencia',
                'txt_tiempo',
                'txt_observacion'
            ];
            campos.forEach(function (campo) {
                var elemento = document.getElementById(campo);
                elemento.classList.remove('error-field');
                elemento.value = ''; // Limpiar el campo
            });
        }

        // Limpiar los datos cuando se cierre la modal
        $('#myModal').on('hidden.bs.modal', function () {
            resetErrorFields(); // Limpiar los campos
        });



    </script>

</body>
</html>