<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Autorizacion_ingreso.aspx.cs" Inherits="Basculas_Autorizacion_ingreso" %>

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
    <div class="relative group">
        <a href="#" class="hover:text-orange-600 px-2 py-1 flex items-center">
            <span>Rutas</span>
            <svg class="ml-1 w-4 h-4" fill="currentColor" viewBox="0 0 20 20"><path d="M5.23 7.21a.75.75 0 111.06-1.06L10 9.86l3.71-3.71a.75.75 0 011.06 1.06l-4 4a.75.75 0 01-1.06 0l-4-4z"/></svg>
        </a>
        <!-- Dropdown Menu -->
        <div class="absolute left-0 mt-2 w-48 bg-white border border-gray-200 rounded shadow-lg group-hover:block hidden">
            <a href="Rutas_Transacciones.aspx" class="block px-4 py-2 hover:bg-gray-100 text-gray-700">
                <i class="fas fa-road mr-2"></i>Rutas Transacciones
            </a>
            <a href="Rutas_Actividades.aspx" class="block px-4 py-2 hover:bg-gray-100 text-gray-700">
                <i class="fas fa-road mr-2"></i>Rutas Actividades
            </a>
        </div>
    </div>

    <div class="relative group">
        <a href="#" class="bg-primary text-white flex items-center px-2 py-1 rounded">
            <span>Monitoreo</span>
            <svg class="ml-1 w-4 h-4" fill="currentColor" viewBox="0 0 20 20"><path d="M5.23 7.21a.75.75 0 111.06-1.06L10 9.86l3.71-3.71a.75.75 0 011.06 1.06l-4 4a.75.75 0 01-1.06 0l-4-4z"/></svg>
        </a>
        <!-- Dropdown Menu -->
        <div class="absolute left-0 mt-2 w-48 bg-white border border-gray-200 rounded shadow-lg group-hover:block hidden">
            <a href="Autorizacion_Camiones.aspx" class="block px-4 py-2 hover:bg-gray-100 text-gray-700">
                <i class="fa fa-truck mr-2"></i>Chequeo de Informacion
            </a>
            <a href="Autorizacion_ingreso.aspx" class="block px-4 py-2 bg-primary text-white flex items-center px-2 py-1 rounded">
                <i class="fas fa-unlock mr-2"></i>Autorizacion Ingreso
            </a>
            <a href="Autorizacion_Porton4.aspx" class="block px-4 py-2 hover:bg-gray-100 text-gray-700">
                <i class="fas fa-check-square mr-2"></i>Autorizacion Porton 4
            </a>
            <a href="Lista_Negra.aspx" class="block px-4 py-2 hover:bg-gray-100 text-gray-700">
                <i class="fas fa-list-alt mr-2"></i>Lista Negra Motorista
            </a>
        </div>
    </div>
    <a href="Tiempos_Azucar.aspx">
        <i class="fas fa-clock mr-2"></i>Recepcion Azucar
    </a>
</nav>

<!-- Logout Button -->
<a href="login.aspx" class="login-button" style="text-decoration:none">
    <i class="fas fa-user"></i> Cerrar Sesión
</a>

<!-- Mobile Menu -->
<div id="mobile-menu" class="md:hidden hidden px-4 py-2 space-y-2 bg-gray-100">
    <a href="Default.aspx" class="block text-gray-700 hover:text-orange-600">Pre-Transacciones</a>
    <a href="Rutas_Transacciones.aspx" class="block text-gray-700 hover:text-orange-600">Rutas Transacciones</a>
    <a href="Rutas_Actividades.aspx" class="block text-gray-700 hover:text-orange-600">Rutas Actividades</a>

    <a href="Autorizacion_Camiones.aspx" class="block text-gray-700 hover:text-orange-600">Chequeo de Informacion</a>
    <a href="Autorizacion_ingreso.aspx" class="block text-gray-700 hover:text-orange-600">Autorizacion Ingreso</a>
    <a href="Autorizacion_Porton4.aspx" class="block text-gray-700 bg-primary text-white">Autorizacion Porton 4</a>
    <a href="Lista_Negra.aspx" class="block text-gray-700 hover:text-orange-600">Lista Negra Motorista</a>
    <a href="Tiempos_Azucar.aspx" class="block text-gray-700 hover:text-orange-600">Recepcion Azucar</a>
    <a href="login.aspx" class="block text-gray-700 hover:text-orange-600">Cerrar Sesión</a>
</div>

<!-- JavaScript to handle the dropdown for mobile version -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const dropdowns = document.querySelectorAll('.group');
        dropdowns.forEach(dropdown => {
            dropdown.addEventListener('click', function() {
                const menu = dropdown.querySelector('.group-hover\\:block');
                menu.classList.toggle('hidden');
            });
        });
    });
</script>


</header>

 
  <!-- Banner -->
  <section class="custom-banner text-center">
    <h1>Autorizacion de Ingreso</h1>
  </section>

    <!-- Main Content -->
    <main class="container mx-auto py-8">
        <!-- Unidad en Espera & Solicitar Unidades -->
        <section class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-8" style="font-family: 'Gilroy-Bold', sans-serif;">
            <div class="bg-white">
                <h2 class="text-lg font-bold mb-4 text-center">UNIDADES SOLICITADAS</h2>
                <div class="grid grid-cols-2 gap-4">
            
                    <!-- Plano -->
                    <div class="text-white text-center p-4 rounded-lg flex items-center justify-center" style="background-color:#182A6E;">
                        
                        <div class="flex flex-col items-center">
                            <div class="text-3xl mb-1">Plano</div>
                            <div class="text-2xl mt-1 font-bold">
                                <asp:Label ID="lblTotalRegistrosP" runat="server" CssClass="text-center font-bold mb-2"></asp:Label>
                            </div>
                        </div>
                    </div>

                    <!-- Volteo -->
                    <div class="bg-gray-800 text-white text-center p-4 rounded-lg flex items-center justify-center" style="background-color:#242424;">
                        
                        <div class="text-center">
                            <div class="text-3xl mb-1">Volteo</div>
                            <div class="text-1xl mt-2 font-bold">
                                <asp:Label ID="lblTotalRegistrosV" runat="server" CssClass="text-center font-bold mb-4"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="bg-white">
                <h2 class="text-lg font-bold mb-4 text-center">TOTAL UNIDADES</h2>
                <div class="grid grid-cols-2 gap-4">
          
                    <!-- Tarjeta de "Solicitar Plano" con altura reducida -->
                    <div class="text-white text-center rounded-lg" style="background-color: #182A6E; padding: 5px; max-height: 140px; max-width: 400px;">
                        <div class="flex flex-col items-center">
                            <!-- Texto en la parte superior -->
                            <span class="text-3xl mb-1">Plano</span>

                            <span class="text-3xl mt-1 font-bold">
                               <asp:Label ID="lblCountP" runat="server" CssClass="text-center font-bold mb-4"></asp:Label>
                            </span>
                        </div>    
                    </div>

                    <!-- Solicitar Volteo -->
                    <div class="text-white text-center rounded-lg" style="background-color:#242424; padding: 8px; max-height: 135px; max-width: 350px;">
                        <div class="flex flex-col items-center">
                            <!-- Texto en la parte superior -->
                            <span class="text-3xl mb-1">Volteo</span>
                            <div class="text-3xl mt-1 font-bold">
                               <asp:Label ID="lblCountV" runat="server" CssClass="text-center font-bold mb-4"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
       

            </div>
            </div>
        </section>

        <section>
            <div class="bg-white">
                <h2 class="text-lg font-bold mb-2 text-center">TOTAL INGENIOS</h2> <!-- Reduje el margen inferior -->
                <div class="flex flex-row gap-1 justify-center items-center flex-wrap">
                    <!-- Tarjeta 1 -->
                    <div class="bg-gray-300 p-1 max-h-[90px] max-w-[200px] text-center rounded-lg overflow-hidden flex flex-col justify-center mx-auto">
                        <h2 class="text-xs font-bold text-black mb-1">COMPAÑIA AZUCARERA SALVADOREÑA, S.A. DE C.V.</h2>
                        <div class="text-base font-bold">
                            <asp:Label ID="lblIngenioQuantity2" runat="server" /> <!-- Ingenio 34323 -->
                        </div>
                    </div>

                    <!-- Tarjeta 2 -->
                    <div class="bg-gray-300 p-1 max-h-[90px] max-w-[200px] text-center rounded-lg overflow-hidden flex flex-col justify-center mx-auto">
                        <h2 class="text-xs font-bold text-black mb-1">INGENIO CENTRAL AZUCARERO JIBOA, S.A. DE CV</h2>
                        <div class="text-base font-bold">
                            <asp:Label ID="lblIngenioQuantity4" runat="server" /> <!-- Ingenio 34323 -->
                        </div>
                    </div>

                    <!-- Tarjeta 3 -->
                    <div class="bg-gray-300 p-1 max-h-[90px] max-w-[200px] text-center rounded-lg overflow-hidden flex flex-col justify-center mx-auto">
                        <h2 class="text-xs font-bold text-black mb-1">INGENIO CHAPARRASTIQUE, S.A. DE C.V.</h2>
                        <div class="text-base font-bold">
                            <asp:Label ID="lblIngenioQuantity3" runat="server" /> <!-- Ingenio 34323 -->
                        </div>
                    </div>

                    <!-- Tarjeta 4 -->
                    <div class="bg-gray-300 p-1 max-w-[200px] text-center rounded-lg overflow-hidden flex flex-col justify-center mx-auto"
                        style="height: 68px;">
                        <h2 class="text-xs font-bold text-black mb-1">INGENIO EL ANGEL, S.A. DE C.V. </h2>
                        
                        <div class="text-base font-bold">
                            <asp:Label ID="lblIngenioQuantity6" runat="server" /> <!-- Ingenio 34323 -->
                        </div>
                    </div>

                    <!-- Tarjeta 5 -->
                    <div class="bg-gray-300 p-1 max-h-[90px] max-w-[200px] text-center rounded-lg overflow-hidden flex flex-col justify-center mx-auto">
                        <h2 class="text-xs font-bold text-black mb-1">INGENIO LA CABAÑA, S.A. DE C.V.</h2>
                        <div class="text-base font-bold">
                            <asp:Label ID="lblIngenioQuantity1" runat="server" /> <!-- Ingenio 34323 -->
                        </div>
                    </div>

                    <!-- Tarjeta 6 -->
                    <div class="bg-gray-300 p-1 max-h-[90px] max-w-[200px] text-center rounded-lg overflow-hidden flex flex-col justify-center mx-auto">
                        <h2 class="text-xs font-bold text-black mb-1">INGENIO LA MAGDALENA, S.A. DE C.V.</h2>
                        <div class="text-base font-bold">
                            <asp:Label ID="lblIngenioQuantity5" runat="server" /> <!-- Ingenio 34323 -->
                        </div>
                    </div>

                    
                </div>

            </div>
        </section>


        <div class="row ml-3 sticky-top" style="border: solid 0px;">
            <div class="col mt-2 mb-2">
                <input type="text" id="searchInput" onkeyup="filterCards()" placeholder="Busca aqui la transaccion..." class="form-control mb-3" style="border-radius: 15px; background-color: #f8f9f9; border: 1px solid #000000;">
            </div>
        </div>



        <div class="row justify-content-center" style="margin: 20px;">
            <asp:Repeater ID="rptRutas" runat="server">
                <ItemTemplate>
                    <div class="col-lg-4 col-md-6 col-sm-12 mb-4 card-container">
                     <div class="card border rounded-4" style="height: 325px; border-color: #ddd;">
                        <div class="card" style="height: 325px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); 
                            <%# Eval("vehicle.truckType").ToString() == "V" ? "border-left: 5px solid #2ecc71;" : "border-left: 5px solid #154360;" %>">
                            <div class="card-body d-flex flex-column">
                                <span style="padding: 8px 15px; border-radius: 12px; display: inline-block; font-size: 18px;" 
                                    class='<%# Eval("vehicle.truckType").ToString() == "V" ? "badge badge-success" : "badge badge-dark" %>'>
                                    <%# Eval("vehicle.truckType").ToString() == "V" ? "Volteo" : "Plano" %>
                                </span>

                               <asp:LinkButton CssClass="btn" ID="lnk_VerRuta" runat="server" 
                                    data-transporter='<%# HttpUtility.HtmlEncode(Eval("transporter").ToString()) %>' 
                                    data-trailerplate='<%# HttpUtility.HtmlEncode(Eval("vehicle.trailerPlate").ToString()) %>' 
                                    data-plate='<%# HttpUtility.HtmlEncode(Eval("vehicle.plate").ToString()) %>' 
                                    data-codigo-generacion='<%# HttpUtility.HtmlEncode(Eval("codeGen").ToString()) %>' OnClientClick="return confirmAuthorization(this);" CausesValidation="false">
                                    
                                    <asp:Label ID="lblCodT" Visible="false" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                                    <h5></h5>
                                    <h5 class="card-text text-left">
                                        <strong>Transacción:</strong>  
                                        <asp:Label ID="lblNombre" runat="server" CssClass="no-bold" Text='<%# Eval("id") %>'></asp:Label>
                                    </h5>

                                    <h5 class="card-text text-left">
                                        <strong>Fecha:</strong>        
                                        <asp:Label ID="lblFecha" runat="server" CssClass="no-bold" Text='<%# Convert.ToDateTime(Eval("createdAt")).ToString("dd/MM/yyyy") %>'></asp:Label>
                                    </h5>

                                    <h5 class="card-title text-left">
                                        <strong>Codigo generacion:</strong>
                                        <asp:Label ID="lblcodgen" runat="server" CssClass="no-bold" Text='<%# Eval("codeGen") %>'></asp:Label>
                                    </h5>

                                    <h5 class="card-text text-left">
                                        <strong>Ingenio:</strong>      
                                        <asp:Label ID="lblIngenio" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("ingenio.user.username").ToString()) %>'></asp:Label>
                                    </h5>

                                    <h5 class="card-text text-left">
                                        <strong>Motorista:</strong>      
                                        <asp:Label ID="lblMotorista" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("transporter").ToString()) %>'></asp:Label>
                                    </h5>

                                    <h5 class="card-text text-left">
                                        <strong>Placa Remolque:</strong>
                                        <asp:Label ID="lblPlacaRemolque" runat="server" CssClass="no-bold" Text='<%# Eval("vehicle.trailerPlate") %>'></asp:Label>
                                    </h5>

                                    <h5 class="card-text text-left">
                                        <strong>Placa Camión:</strong> 
                                        <asp:Label ID="lblPlacaCamion" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("vehicle.plate").ToString()) %>'></asp:Label>
                                    </h5>

                                    <div class="icon-container">
                                        <i class='<%# Eval("vehicle.truckType").ToString() == "V" ? "fa fa-arrow-up" : "fa fa-arrow-right" %>' aria-hidden="true"></i>
                                    </div>

                                    <div class="icon-container1">
                                        <span class='<%# Container.ItemIndex == 0 ? "circle-number gold" : 
                                                Container.ItemIndex == 1 ? "circle-number silver" : 
                                                Container.ItemIndex == 2 ? "circle-number bronze" : 
                                                "circle-number yellow" %>'>
                                            <%# Container.ItemIndex + 1 %>
                                        </span> <!-- Muestra el número de orden -->
                                    </div>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </main>

    <!-- Footer -->
    <footer class="text-center py-4 text-sm text-gray-600" style="font-family: 'Gilroy-Light', sans-serif; background-color: #242424; color: white; width: 100%;">
        © 2024 Almacenadora del Pacífico
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
            const input = document.getElementById('searchInput').value.toLowerCase();
            const cards = document.querySelectorAll('.card-container');

            cards.forEach(card => {
                const text = card.innerText.toLowerCase();
                //console.log("Texto de la tarjeta:", text); // Para depuración

                // Muestra la tarjeta si el texto incluye la entrada de búsqueda, de lo contrario, la oculta
                card.style.display = text.includes(input) ? 'block' : 'none';
            });

            // Alineación para evitar huecos
            const visibleCards = Array.from(cards).filter(card => card.style.display === 'block');
            visibleCards.forEach((card, index) => {
                card.style.order = index; // Alinear las tarjetas visibles
            });
        }

</script>




    <script>
    document.addEventListener('DOMContentLoaded', function() {
        // Configuración de botones y contadores para Volteo
        const decreaseButtonVolteo = document.getElementById('decreaseButtonVolteo');
        const increaseButtonVolteo = document.getElementById('increaseButtonVolteo');
        const numberInputVolteo = document.getElementById('numberInputVolteo');
        const solicitarVolteo = document.getElementById('solicitarv');
        
        // Configuración de botones y contadores para Plano
        const decreaseButtonPlano = document.getElementById('decreaseButtonPlano');
        const increaseButtonPlano = document.getElementById('increaseButtonPlano');
        const numberInputPlano = document.getElementById('numberInputPlano');
        const solicitarPlano = document.getElementById('solicitarp');

        // Función para obtener el valor como número entero
        function getValue(input) {
            let value = parseInt(input.value);
            return isNaN(value) ? 0 : value; // Si no es un número, regresa 0
        }

        // Validación para asegurarse de que la suma no pase de 4
        function validateTotal() {
            let volteoValue = getValue(numberInputVolteo);
            let planoValue = getValue(numberInputPlano);
            return (volteoValue + planoValue) <= 4;
        }

        // Decrementar Volteo
        decreaseButtonVolteo.addEventListener('click', function() {
            let currentValue = getValue(numberInputVolteo);
            if (currentValue > 0) { // Evitar valores negativos
                numberInputVolteo.value = currentValue - 1;
            }
        });

        // Incrementar Volteo
        increaseButtonVolteo.addEventListener('click', function() {
            let currentValue = getValue(numberInputVolteo);
            if (validateTotal()) {
                numberInputVolteo.value = currentValue + 1;
            } else {
                // Usar SweetAlert para mostrar el mensaje de error
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'La suma total no puede ser mayor que 4',
                    confirmButtonText: 'Aceptar',
                    background: '#f8d7da',
                    confirmButtonColor: '#721c24',
                });
            }
        });

        // Decrementar Plano
        decreaseButtonPlano.addEventListener('click', function() {
            let currentValue = getValue(numberInputPlano);
            if (currentValue > 0) { // Evitar valores negativos
                numberInputPlano.value = currentValue - 1;
            }
        });

        // Incrementar Plano
        increaseButtonPlano.addEventListener('click', function() {
            let currentValue = getValue(numberInputPlano);
            if (validateTotal()) {
                numberInputPlano.value = currentValue + 1;
            } else {
                // Usar SweetAlert para mostrar el mensaje de error
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'La suma total no puede ser mayor que 4',
                    confirmButtonText: 'Aceptar',
                    background: '#f8d7da',
                    confirmButtonColor: '#721c24',
                });
            }
        });

        // Validación al solicitar Volteo
        solicitarVolteo.addEventListener('click', function() {
            let currentValue = getValue(numberInputVolteo);
            if (validateTotal()) {
                // Usar SweetAlert para mostrar el mensaje de éxito
                Swal.fire({
                    icon: 'success',
                    title: '¡Solicitud Enviada!',
                    text: `Has solicitado ${currentValue} camiones del tipo Volteo.`,
                    confirmButtonText: 'Aceptar',
                    background: '#d4edda',
                    confirmButtonColor: '#28a745',
                });
            } else {
                // Usar SweetAlert para mostrar el mensaje de error
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'La suma total no puede ser mayor que 4',
                    confirmButtonText: 'Aceptar',
                    background: '#f8d7da',
                    confirmButtonColor: '#721c24',
                });
            }
        });

        // Validación al solicitar Plano
        solicitarPlano.addEventListener('click', function() {
            let currentValue = getValue(numberInputPlano);
            if (validateTotal()) {
                // Usar SweetAlert para mostrar el mensaje de éxito
                Swal.fire({
                    icon: 'success',
                    title: '¡Solicitud Enviada!',
                    text: `Has solicitado ${currentValue} camiones del tipo Plano.`,
                    confirmButtonText: 'Aceptar',
                    background: '#d4edda',
                    confirmButtonColor: '#28a745',
                });
            } else {
                // Usar SweetAlert para mostrar el mensaje de error
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'La suma total no puede ser mayor que 4',
                    confirmButtonText: 'Aceptar',
                    background: '#f8d7da',
                    confirmButtonColor: '#721c24',
                });
            }
        });
    });
</script>








    <script>
        function createTimer(progressCircleId, timerTextId, startButtonId, stopButtonId, storageKey, duration, redThreshold) 
        {
            let interval;
            let isRunning = false;
            let milliseconds = localStorage.getItem(`${storageKey}_milliseconds`) ? parseInt(localStorage.getItem(`${storageKey}_milliseconds`)) : 0;
            let lastTimestamp = performance.now();

            if (localStorage.getItem(`${storageKey}_lastUpdated`) && Date.now() - parseInt(localStorage.getItem(`${storageKey}_lastUpdated`)) > 3600000) 
            {
                localStorage.removeItem(`${storageKey}_milliseconds`);
            }
            localStorage.setItem(`${storageKey}_lastUpdated`, Date.now().toString());

            updateTimerDisplay(timerTextId, milliseconds);

            // Verifica si el cronómetro está en ejecución y lo arranca si es necesario
            if (localStorage.getItem(`${storageKey}_isRunning`) === 'true') 
            {
                startTimer();
            }

            window.addEventListener('storage', function(event) {
                if (event.key === `${storageKey}_milliseconds`) 
                {
                    const updatedTime = parseInt(event.newValue);
                    updateTimerDisplay(timerTextId, updatedTime);
                }
            });

            // Botón de inicio
            document.getElementById(startButtonId).addEventListener('click', function(event) {
                event.preventDefault();
                if (!isRunning) 
                {
                    startTimer();
                }
            });

            // Botón de detención
            document.getElementById(stopButtonId).addEventListener('click', function(event) {
                event.preventDefault();
                console.log(`Botón de detención presionado: ${stopButtonId}`);
                const codigoGeneracion = this.getAttribute("data-codigo-generacion");
                console.log(`Código de generación: ${codigoGeneracion}`);

                if (!isRunning) 
                {
                    Swal.fire({
                        title: 'Acción no permitida',
                        text: 'El cronómetro no está en ejecución.',
                        icon: 'warning',
                        confirmButtonText: 'Ok'
                    }).then((result) => {
                        if (result.isConfirmed) 
                        {
                            stopTimer(codigoGeneracion, stopButtonId); // Pasa el codigoGeneracion al detener
                            Swal.fire('Detenido', 'El cronómetro ha sido detenido.', 'success');
                        }
                    });
                    return;
                }

                // Lógica de detención si el cronómetro ha alcanzado el tiempo máximo
                if (milliseconds >= duration * 1000) 
                {
                    $('#confirmationModal').modal('show');  // Mostrar la modal
                } 
                else 
                {
                    Swal.fire({
                        title: '¿Estás seguro de detener el cronómetro?',
                        text: "El cronómetro no ha superado el tiempo máximo.",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonText: 'Sí, detenerlo',
                        cancelButtonText: 'No, continuar'
                    }).then((result) => {
                        if (result.isConfirmed) 
                        {
                            stopTimer(codigoGeneracion, stopButtonId); // Pasa el codigoGeneracion al detener
                            Swal.fire('Detenido', 'El cronómetro ha sido detenido.', 'success');
                        }
                    });
                }
            });

            function startTimer() 
            {
                isRunning = true;
                localStorage.setItem(`${storageKey}_isRunning`, 'true');
                lastTimestamp = performance.now();

                interval = setInterval(() => {
                    const currentTimestamp = performance.now();
                    const elapsed = currentTimestamp - lastTimestamp;
                    lastTimestamp = currentTimestamp;

                    milliseconds += elapsed;
                    localStorage.setItem(`${storageKey}_milliseconds`, milliseconds);

                    const angle = (milliseconds / (duration * 1000)) * 360;
                    document.getElementById(progressCircleId).style.background = `conic-gradient(${getColor(milliseconds, redThreshold)} ${angle}deg, #f0f0f0 ${angle}deg)`;

                    updateTimerDisplay(timerTextId, milliseconds);

                }, 50);
            }

            function stopTimer(codigoGeneracion, stopButtonId) 
            {
                clearInterval(interval);
                isRunning = false;
                localStorage.setItem(`${storageKey}_isRunning`, 'false'); // Asegúrate de que el storageKey sea único
                updateTimerDisplay(timerTextId, milliseconds);
                
                console.log(`Cronómetro detenido: ${stopButtonId}, Código: ${codigoGeneracion}`);
                
                // Llama a la función para cambiar el estado
                //changeStatusTimer(codigoGeneracion, stopButtonId);
                
                resetTimer(); // Esto puede ser opcional dependiendo de tu lógica
                // Recargar la página cuando el usuario presione "Aceptar"
                location.reload();
            }

            function resetTimer() 
            {
                milliseconds = 0;
                localStorage.setItem(`${storageKey}_milliseconds`, milliseconds);
                document.getElementById(progressCircleId).style.background = `conic-gradient(#f0f0f0 0deg, #f0f0f0 0deg)`;
                updateTimerDisplay(timerTextId, milliseconds);
            }

            function updateTimerDisplay(timerTextId, milliseconds) 
            {
                const minutes = String(Math.floor(milliseconds / 60000)).padStart(2, '0');
                const seconds = String(Math.floor((milliseconds % 60000) / 1000)).padStart(2, '0');
                const ms = String(Math.floor((milliseconds % 1000) / 10)).padStart(2, '0');
                document.getElementById(timerTextId).innerText = `${minutes}:${seconds}:${ms}`;
            }

            function getColor(milliseconds, redThreshold) 
            {
                if (milliseconds >= redThreshold) 
                {
                    return '#ff0000';
                } 
                else if (milliseconds >= 300000) 
                {
                    return '#ff7300';
                } 
                else 
                {
                    return '#858180';
                }
            }

            $('#confirmarDetener').on('click', function() {
                const motivoDetencion = $('#motivoDetencion').val();
                if (motivoDetencion) {
                    console.log(`Motivo de detención: ${motivoDetencion}`);
                    stopTimer(); // Detiene y ejecuta la lógica correspondiente
                    $('#confirmationModal').modal('hide');
                } else {
                    Swal.fire({
                        title: 'Selecciona un motivo',
                        text: 'Debes seleccionar un motivo de detención antes de continuar.',
                        icon: 'warning',
                        confirmButtonText: 'Ok'
                    });
                }
            });
        }

        function changeStatusTimer(codigoGeneracion, stopButtonId) 
        {
            var predefinedStatusId = 9; // Cambia esto al ID de estado que deseas

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

            // Definir storageKey único para cada cronómetro según el botón de parada
            const storageKey = stopButtonId === 'stopButton1' ? 'timer1' : 'timer2';

            // Guardar el estado actual solo para el cronómetro que se está deteniendo
            saveTimerState(storageKey);

            $.ajax({
                async: true, // Esto asegura que no bloqueará el hilo principal
                type: "POST",
                url: "Autorizacion_Camiones.aspx/ChangeTransactionStatus",
                data: JSON.stringify({ codeGen: codigoGeneracion, predefinedStatusId: predefinedStatusId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) 
                {
                    console.log("Respuesta de la API: ", response.d);
                    // Recargar la página cuando el usuario presione "Aceptar"
                    location.reload();
                },
                error: function(xhr, status, error) 
                {
                    console.error("Error en AJAX:", {
                        status: status,
                        error: error,
                        response: xhr.responseText
                    });
                }
            });
        }

        function saveTimerState(storageKey) 
        {
            let milliseconds = parseInt(localStorage.getItem(`${storageKey}_milliseconds`)) || 0;
            localStorage.setItem(`${storageKey}_milliseconds`, milliseconds);
            localStorage.setItem(`${storageKey}_isRunning`, 'false'); // Solo detén el cronómetro actual
        }

        // Inicialización de cronómetros para ambos botones
        createTimer('progressCircle1', 'timerText1', 'startButton1', 'stopButton1', 'timer1', 900, 900000); // 15 minutos
        createTimer('progressCircle2', 'timerText2', 'startButton2', 'stopButton2', 'timer2', 600, 600000); // 10 minutos

    </script>







<script>
    function confirmAuthorization(linkButton) 
    {
        // Accede a los valores de los atributos personalizados
        const transporter       = linkButton.getAttribute('data-transporter');
        const trailerPlate      = linkButton.getAttribute('data-trailerplate');
        const plate             = linkButton.getAttribute('data-plate');
        const codigoGeneracion  = linkButton.getAttribute('data-codigo-generacion');

        // Construye el mensaje de confirmación en formato de lista
        const message = `
            <p>¿Estás seguro de que este es el camión con el que deseas iniciar el proceso de toma de tiempo?</p>
            <br>
            <ul style="text-align: left; padding-left: 20px;">
                <li><strong>Código Generación:</strong> ${codigoGeneracion}</li>
                <li><strong>Motorista:</strong> ${transporter}</li>
                <li><strong>Placa Remolque:</strong> ${trailerPlate}</li>
                <li><strong>Placa Camión:</strong> ${plate}</li>
            </ul>
        `;

        // Muestra el mensaje de confirmación usando SweetAlert
        Swal.fire({
            title: 'Confirmación',
            html: message, // Cambiamos text a html para interpretar etiquetas HTML
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sí',
            cancelButtonText: 'No',
            customClass: {
                confirmButton: 'swal-wide-button',
                cancelButton: 'swal-wide-button'
            }
        }).then((result) => {
            if (result.isConfirmed) 
            {
                // Mostrar alerta de éxito con SweetAlert2
                Swal.fire({
                    icon: 'success',
                    title: 'Validación exitosa',
                    text: 'El camión ha sido autorizado correctamente.', // Mensaje de éxito
                    confirmButtonText: 'Aceptar'
                }).then(() => {
                    // Llamar a changeStatus después de la validación exitosa
                    changeStatus(codigoGeneracion);
                });
            }
        });

        return false; // Evita que el botón realice su acción predeterminada
    }

    // Función para cambiar el estatus después de la validación exitosa
        function changeStatus(codigoGeneracion) 
        {
            var predefinedStatusId = 8; // Cambia esto al ID de estado que deseas

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
                    
                    // Recargar la página cuando el usuario presione "Aceptar"
                    location.reload();
                },
                error: function(xhr, status, error) 
                {
                    console.error("Error cambiando el estado: ", error);
                }
            });
        }


</script>

</body>
</html>