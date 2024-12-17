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
                        <div class="block px-4 py-2 bg-primary text-white rounded hover:bg-opacity-80">
                            <a href="Autorizacion_ingreso.aspx" style="text-decoration: none;">
                                <i class="fas fa-unlock mr-2"></i>Autorización Ingreso
                            </a>
                        </div>
                        <div class="block px-4 py-2 hover:bg-gray-100 text-gray-700">
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
                    <div class="text-white text-center rounded-lg" style="background-color: #182A6E; padding: 5px; max-height: 140px; max-width: 400px; position: relative;">
                        <!-- Línea vertical fija al lado izquierdo de la tarjeta -->
                        <div style="position: absolute; top: 8px; left: 10px; width: 10px; height: 85%; background-color: #EAE8EC; border-radius: 5px; "></div>

                        <div class="flex flex-col items-center">
                            <!-- Texto en la parte superior -->
                            <span class="text-3xl mb-1">Plano</span>

                            <span class="text-3xl mt-1 font-bold">
                                <asp:Label ID="lblP" runat="server" CssClass="text-center font-bold mb-2"></asp:Label>
                            </span>
                        </div>
                    </div>

                    <!-- Volteo -->
                    <div class="text-white text-center rounded-lg" style="background-color:#242424; padding: 8px; max-height: 135px; max-width: 350px; position: relative;">
                        <!-- Línea vertical fija al lado izquierdo de la tarjeta -->
                        <div style="position: absolute; top: 8px; left: 10px; width: 10px; height: 85%; background-color: #FF5733; border-radius: 5px;"></div>

                        <div class="flex flex-col items-center">
                            <!-- Texto en la parte superior -->
                            <span class="text-3xl mb-1">Volteo</span>

                            <span class="text-3xl mt-1 font-bold">
                                <asp:Label ID="lblV" runat="server" CssClass="text-center font-bold mb-4"></asp:Label>
                            </span>
                        </div>
                    </div>

                </div>
            </div>

            <div class="bg-white">
                <h2 class="text-lg font-bold mb-4 text-center">TOTAL UNIDADES</h2>
                <div class="grid grid-cols-2 gap-4">
        
                    <!-- Tarjeta de "Solicitar Plano" con altura reducida -->
                    <div class="text-white text-center rounded-lg" style="background-color: #182A6E; padding: 5px; max-height: 140px; max-width: 300px; position: relative;">
                        <!-- Línea vertical fija al lado izquierdo de la tarjeta -->
                        <div style="position: absolute; top: 8px; left: 10px; width: 10px; height: 85%; background-color: #EAE8EC; border-radius: 5px; "></div>
                        
                        <div class="flex flex-col items-center">
                            <!-- Texto en la parte superior -->
                            <span class="text-3xl mb-1">Plano</span>

                            <!-- Etiqueta ASP.NET -->
                            <span class="text-3xl mt-1 font-bold">
                                <asp:Label ID="lblCountP" runat="server" CssClass="text-center font-bold mb-4"></asp:Label>
                            </span>
                        </div>
                    </div>


                    <!-- Solicitar Volteo -->
                    <div class="text-white text-center rounded-lg" style="background-color:#242424; padding: 8px; max-height: 135px; max-width: 350px; position: relative;">
                        
                        <!-- Línea vertical fija al lado izquierdo de la tarjeta -->
                        <div style="position: absolute; top: 8px; left: 10px; width: 10px; height: 85%; background-color: #FF5733; border-radius: 5px;"></div>
                        
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
                <h2 class="text-lg font-bold mb-2 text-center">TOTAL INGENIOS</h2>
                <div style="background-color: #d1d5db; padding: 5px;">
                    <div class="flex flex-row justify-center items-center flex-wrap">

                        <!-- Tarjeta 1 -->
                        <div class="card1" style="margin: 20px;">
                            <h2 class="text-xs font-bold text-black mb-1" 
                                style="background-color: white; border-radius: 10px; padding: 7px; display: inline-block; width: 160px; text-align: left;">
                                COMPAÑÍA AZUCARERA <center> SALVADOREÑA</center>
                            </h2>
                            <div class="text-base font-bold">
                                <asp:TextBox ID="txtIngenioQuantity2" runat="server" ReadOnly="true" 
                                    Width="50px" CssClass="text-black text-center"
                                    style="background-color: white; border: none; color: black; border-radius: 5px;" />
                            </div>
                        </div>

                        <!-- Tarjeta 2 -->
                        <div class="card1" style="margin: 2px;">
                            <h2 class="text-xs font-bold text-black mb-1"style="background-color: white; padding: 7px; border-radius: 10px; display: inline-block;">INGENIO CENTRAL AZUCARERO JIBOA</h2>
                            <div class="text-base font-bold">
                                <asp:TextBox ID="txtIngenioQuantity4" runat="server" ReadOnly="true" 
                                    Width="50px" CssClass="text-black text-center"
                                    style="background-color: white; border: none; color: black; border-radius: 5px;" />
                            </div>
                        </div>

                        <!-- Tarjeta 3 -->
                        <div class="card1" style="margin: 2px;">
                            <h2 class="text-xs font-bold text-black mb-1" style="background-color: white; padding: 7px; border-radius: 10px; display: inline-block;">INGENIO CHAPARRASTIQUE</h2>
                            <div class="text-base font-bold">
                                <asp:TextBox ID="txtIngenioQuantity3" runat="server" ReadOnly="true" 
                                    Width="50px" CssClass="text-black text-center"
                                    style="background-color: white; border: none; color: black; border-radius: 5px;" />
                                
                            </div>
                        </div>

                        <!-- Tarjeta 4 -->
                        <div class="card1" style="margin: 2px;">
                            <h2 class="text-xs font-bold text-black mb-1" style="background-color: white; padding: 7px; border-radius: 10px; display: inline-block;">INGENIO <br>EL ANGEL</h2>
                            <div class="text-base font-bold">
                                <asp:TextBox ID="txtIngenioQuantity6" runat="server" ReadOnly="true" 
                                    Width="50px" CssClass="text-black text-center"
                                    style="background-color: white; border: none; color: black; border-radius: 5px;" />
                            </div>
                        </div>

                        <!-- Tarjeta 5 -->
                        <div class="card1" style="margin: 2px;">
                            <h2 class="text-xs font-bold text-black mb-1" style="background-color: white; padding: 7px; border-radius: 10px; display: inline-block;">INGENIO <br>LA CABAÑA</h2>
                            <div class="text-base font-bold">
                                <asp:TextBox ID="txtIngenioQuantity1" runat="server" ReadOnly="true" 
                                    Width="50px" CssClass="text-black text-center"
                                    style="background-color: white; border: none; color: black; border-radius: 5px;" />
                             
                            </div>
                        </div>

                        <!-- Tarjeta 6 -->
                        <div class="card1" style="margin: 2px;">
                            <h2 class="text-xs font-bold text-black mb-1" style="background-color: white; padding: 7px; border-radius: 10px; display: inline-block;">INGENIO LA MAGDALENA</h2>
                            <div class="text-base font-bold">
                                <asp:TextBox ID="txtIngenioQuantity5" runat="server" ReadOnly="true" 
                                    Width="50px" CssClass="text-black text-center"
                                    style="background-color: white; border: 1px; color: black; border-radius: 5px;" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <div class="row ml-3" style="border: solid 0px;">
            <div class="col mt-2 mb-2">
                <input type="text" id="searchInput" onkeyup="filterCards()" placeholder="Busca aqui la transaccion..." class="form-control mb-3" style="border-radius: 15px; background-color: #f8f9f9; border: 1px solid #000000;">
            </div>
        </div>

        <section class="grid grid-cols-1 md:grid-cols-2 gap-8" style="font-family: 'Gilroy-Bold', sans-serif;">
            <div class="w-11/12 mx-auto bg-white" style="max-width: 900px; margin: 0 auto;">
                <h2 class="text-lg font-bold mb-4 text-center">UNIDADES PLANAS</h2>
                <div class="row g-4">
                    <asp:Repeater ID="rptRutas1" runat="server">
                        <ItemTemplate>
                            <div class="col-lg-6 col-md-6 col-sm-12 mb-4">
                                <div class="card border rounded-4" style="border-color: #ddd; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); width: 100%; max-width: 450px; height: 400px;">
                                    <asp:LinkButton CssClass="btn" ID="lnk_VerRuta" runat="server" 
                                    data-transporter='<%# HttpUtility.HtmlEncode(Eval("driver.name").ToString()) %>' 
                                    data-trailerplate='<%# HttpUtility.HtmlEncode(Eval("vehicle.trailerPlate").ToString()) %>' 
                                    data-plate='<%# HttpUtility.HtmlEncode(Eval("vehicle.plate").ToString()) %>' 
                                    data-codigo-generacion='<%# HttpUtility.HtmlEncode(Eval("codeGen").ToString()) %>' OnClientClick="return confirmAuthorization(this);" CausesValidation="false">
                                        <div style="position: relative;">
                                            <!-- Badge de tipo de camión, centrado y más abajo -->  
                                            <div class="position-absolute bottom-0 start-50 translate-middle-x mb-4" style="left: 0; transform: translate(0%, 200%);">
                                                <span class="badge text-white py-2" 
                                                    style="padding-left: 90px; padding-right: 90px; border-radius: 10px; font-size: 18px; 
                                                        background-color: <%# Eval("vehicle.truckType").ToString() == "V" ? "#2D2D2B" : 
                                                                            Eval("vehicle.truckType").ToString() == "R" ? "#004382" : 
                                                                            "#004382" %>;">
                                                        <%# Eval("vehicle.truckType").ToString() == "V" ? "Volteo" : 
                                                            Eval("vehicle.truckType").ToString() == "R" ? "Plana" : "Plano" %>
                                                </span>
                                            </div>
                                        </div>

                                        <div class="card-body p-8" style="transform: translate( -10px, 20px );">
                                            <!-- Información de la tarjeta con texto más pequeño -->
                                            <p class="text-start" style="font-size: 0.9rem;"><i class="fas fa-calendar-alt text-primary"></i> <strong>Fecha Prechequeo:</strong></p>
                                            <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                                <asp:Label ID="lblFechaStatus" runat="server" Text='<%# Eval("dateTimePrecheckeo")  %>' />
                                            </p>

                                            <p class="text-start" style="font-size: 0.9rem;"><i class="fas fa-code text-primary"></i> <strong>Código Generación:</strong></p>
                                            <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                                <asp:Label ID="lblNombre" runat="server"
                                                    Text='<%# Eval("codeGen") %>' />
                                            </p>

                                            <!-- Línea divisoria con grosor y color especificados -->
                                            <hr style="border: 2px solid #ff7300; margin: 10px 0;" />

                                            <!-- Información adicional de la tarjeta -->
                                            <p class="text-start" style="font-size: 0.9rem;"><i class="fas fa-industry text-primary"></i> 
                                                <asp:Label ID="lblIngenio" runat="server"
                                                    Text='<%# HttpUtility.HtmlEncode(Eval("ingenio.name").ToString().Replace("_", " ")) %>' />
                                            </p>
                                            <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;"> </p>

                                            <p class="text-start" style="font-size: 0.9rem;"><i class="fas fa-user text-primary"></i> <strong>Motorista:</strong></p>
                                            <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                                <asp:Label ID="lbltransporte" runat="server"
                                                    Text='<%# HttpUtility.HtmlEncode(Eval("driver.name").ToString()) %>' />
                                            </p>
                                            
                                            <p class="text-start" style="font-size: 0.9rem;"><i class="fas fa-truck text-primary"></i> <strong>Placa Remolque:</strong></p>
                                            <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                                 <asp:Label ID="lblplacaremolque" runat="server"
                                                    Text='<%# HttpUtility.HtmlEncode(Eval("vehicle.trailerPlate").ToString()) %>' />
                                            </p>
                                            
                                        </div>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <div class="w-11/12 mx-auto bg-white" style="max-width: 900px; margin: 0 auto;">
                <h2 class="text-lg font-bold mb-4 text-center">UNIDADES VOLTEO</h2>
                <div class="row g-4">
                    <asp:Repeater ID="rptRutas2" runat="server">
                        <ItemTemplate>
                            <div class="col-lg-6 col-md-6 col-sm-12 mb-4">
                                <div class="card border rounded-4" style="border-color: #ddd; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); width: 100%; max-width: 450px; height: 400px;">
                                    <asp:LinkButton CssClass="btn" ID="lnk_VerRuta" runat="server" 
                                    data-transporter='<%# HttpUtility.HtmlEncode(Eval("driver.name").ToString()) %>' 
                                    data-trailerplate='<%# HttpUtility.HtmlEncode(Eval("vehicle.trailerPlate").ToString()) %>' 
                                    data-plate='<%# HttpUtility.HtmlEncode(Eval("vehicle.plate").ToString()) %>' 
                                    data-codigo-generacion='<%# HttpUtility.HtmlEncode(Eval("codeGen").ToString()) %>' OnClientClick="return confirmAuthorization(this);" CausesValidation="false">
                                        <div style="position: relative;">
                                            <!-- Badge de tipo de camión, centrado y más abajo -->  
                                            <div class="position-absolute bottom-0 start-50 translate-middle-x mb-4" style="left: 0; transform: translate(0%, 200%);">
                                                <span class="badge text-white py-2" 
                                                    style="padding-left: 90px; padding-right: 90px; border-radius: 10px; font-size: 18px; 
                                                        background-color: <%# Eval("vehicle.truckType").ToString() == "V" ? "#2D2D2B" : 
                                                                            Eval("vehicle.truckType").ToString() == "R" ? "#004382" : 
                                                                            "#2D2D2B" %>;">
                                                <%# Eval("vehicle.truckType").ToString() == "V" ? "Volteo" : 
                                                    Eval("vehicle.truckType").ToString() == "R" ? "Plana" : "Plano" %>
                                                </span>
                                            </div>
                                        </div>

                                        <div class="card-body p-8" style="transform: translate( -10px, 20px );">
                                            <!-- Información de la tarjeta con texto más pequeño -->
                                            <p class="text-start" style="font-size: 0.9rem;"><i class="fas fa-calendar-alt text-primary"></i> <strong>Fecha Prechequeo:</strong></p>
                                            <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                                <asp:Label ID="lblFechaStatus" runat="server" Text='<%# Eval("dateTimePrecheckeo")  %>' />
                                            </p>

                                            
                                            <p class="text-start" style="font-size: 0.9rem;"><i class="fas fa-code text-primary"></i> <strong>Código Generación:</strong></p>
                                            <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                                <asp:Label ID="lblNombre" runat="server"
                                                    Text='<%# Eval("codeGen") %>' />
                                            </p>

                                            <!-- Línea divisoria con grosor y color especificados -->
                                            <hr style="border: 2px solid #ff7300; margin: 10px 0;" />

                                            <!-- Información adicional de la tarjeta -->
                                            <p class="text-start" style="font-size: 0.9rem;"><i class="fas fa-industry text-primary"></i> 
                                                <asp:Label ID="lblIngenio" runat="server"
                                                    Text='<%# HttpUtility.HtmlEncode(Eval("ingenio.name").ToString().Replace("_", " ")) %>' />
                                            </p>
                                            <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;"> </p>

                                            <p class="text-start" style="font-size: 0.9rem;"><i class="fas fa-user text-primary"></i> <strong>Motorista:</strong></p>
                                            <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                                <asp:Label ID="lbltransporte" runat="server"
                                                    Text='<%# HttpUtility.HtmlEncode(Eval("driver.name").ToString()) %>' />
                                            </p>

                                            <p class="text-start" style="font-size: 0.9rem;"><i class="fas fa-truck text-primary"></i> <strong>Placa Remolque:</strong></p>
                                            <p class="text-muted mb-1 text-start" style="font-size: 0.85rem;">
                                                 <asp:Label ID="lblplacaremolque" runat="server"
                                                    Text='<%# HttpUtility.HtmlEncode(Eval("vehicle.trailerPlate").ToString()) %>' />
                                            </p>
                                        </div>
                                    </asp:LinkButton>
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
            <p>¿Estás seguro de autorizar al camión con el siguiente detalle para entrar a planta?</p>
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
            customClass: 
            {
                confirmButton: 'swal-wide-button',
                cancelButton: 'swal-wide-button'
            }
        }).then((result) => 
        {
            if (result.isConfirmed) 
            {
               
                changeStatus(codigoGeneracion);
            }
        });

        return false; // Evita que el botón realice su acción predeterminada
    }

    // Función para cambiar el estatus después de la validación exitosa
    function changeStatus(codigoGeneracion) 
    {
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
            url: "Autorizacion_ingreso.aspx/ChangeTransactionStatus",
            data: JSON.stringify({ codeGen: codigoGeneracion}),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) 
            {
                // Verificar la respuesta en la consola para depuración
                console.log("Respuesta de la API:", response.d);  // Esto debería contener el mensaje que la API devuelve.

                // Mostrar una alerta de éxito usando SweetAlert
                Swal.fire({
                    title: '¡Operación exitosa!',
                    text: "El Ingreso a sido autorizado", // Mostrar el mensaje de la API
                    icon: 'success',
                    confirmButtonText: 'Aceptar'
                }).then((result) => {
                    if (result.isConfirmed) 
                    {
                        // Recargar la página cuando el usuario presione "Aceptar"
                        location.reload();
                    }
                });
            },
            error: function(xhr, status, error) 
            {
                // Verificar el error en la consola para depuración
                console.error("Error al cambiar el estado:", error);

                // Mostrar una alerta de error usando SweetAlert
                Swal.fire({
                    title: 'Error',
                    text: 'Hubo un problema al cambiar el estado: ' + error,
                    icon: 'error',
                    confirmButtonText: 'Aceptar'
                });
            }
        });
    }
</script>

</body>
</html>