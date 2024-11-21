<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Tiempos_Azucar.aspx.cs" Inherits="Basculas_Tiempos_azucar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recepcion Azucar</title>
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
        <a href="#" class="hover:text-orange-600 px-2 py-1 flex items-center">
            <span>Monitoreo</span>
            <svg class="ml-1 w-4 h-4" fill="currentColor" viewBox="0 0 20 20"><path d="M5.23 7.21a.75.75 0 111.06-1.06L10 9.86l3.71-3.71a.75.75 0 011.06 1.06l-4 4a.75.75 0 01-1.06 0l-4-4z"/></svg>
        </a>
        <!-- Dropdown Menu -->
        <div class="absolute left-0 mt-2 w-48 bg-white border border-gray-200 rounded shadow-lg group-hover:block hidden">
            <a href="Autorizacion_Camiones.aspx" class="block px-4 py-2 hover:bg-gray-100 text-gray-700">
                <i class="fa fa-truck mr-2"></i>Chequeo de Informacion
            </a>
            <a href="Autorizacion_ingreso.aspx" class="block px-4 py-2 hover:bg-gray-100 text-gray-700">
                <i class="fas fa-unlock mr-2"></i>Autorizacion Ingreso
            </a>
            <a href="Autorizacion_Porton4.aspx" class="block px-4 py-2 bg-primary text-white">
                <i class="fas fa-check-square mr-2"></i>Autorizacion Porton 4
            </a>
            <a href="Lista_Negra.aspx" class="block px-4 py-2 hover:bg-gray-100 text-gray-700">
                <i class="fas fa-list-alt mr-2"></i>Lista Negra Motorista
            </a>
        </div>
    </div>
    <a href="Tiempos_Azucar.aspx" class="bg-primary text-white flex items-center px-2 py-1 rounded">
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
    <h1>RECEPCIÓN DE AZÚCAR</h1>
  </section>

    <!-- Main Content -->
    <main class="container mx-auto py-8">
        <!-- Unidad en Espera & Solicitar Unidades -->
        <section class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-8" style="font-family: 'Gilroy-Bold', sans-serif;">
            <div class="bg-white">
                <h2 class="text-lg font-bold mb-4 text-center">UNIDAD EN ESPERA</h2>
                <div class="grid grid-cols-2 gap-4">
            
                    <!-- Plano -->
                    <div class="text-white text-center p-4 rounded-lg flex items-center justify-center" style="background-color:#182A6E;">
                        
                        <div class="flex flex-col items-center">
                            <div class="text-3xl mb-1">Plano</div>
                            <div class="text-2xl mt-2 font-bold">
                                <asp:Label ID="lblTotalRegistros" runat="server" CssClass="text-center font-bold mb-4"></asp:Label>
                            </div>
                        </div>
                    </div>

                    <!-- Volteo -->
                    <div class="bg-gray-800 text-white text-center p-4 rounded-lg flex items-center justify-center" style="background-color:#242424;">
                        
                        <div class="text-center">
                            <div class="text-3xl mb-1">Volteo</div>
                            <div class="text-2xl mt-2 font-bold">
                                <asp:Label ID="lblTotalRegistrosV" runat="server" CssClass="text-center font-bold mb-4"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="bg-white">
                <h2 class="text-lg font-bold mb-4 text-center">SOLICITAR UNIDADES</h2>
                <div class="grid grid-cols-2 gap-4">
          
                    <!-- Tarjeta de "Solicitar Plano" con altura reducida -->
                    <div class="text-white text-center rounded-lg" style="background-color: #182A6E; padding: 5px; max-height: 140px; max-width: 400px;">
                        <div class="flex flex-col items-center">
                            <!-- Texto en la parte superior -->
                            <span class="text-3xl mb-1">Plano</span>

                            <!-- Contador en la parte inferior con los botones -->
                            <div class="flex items-center space-x mt-1">
                                <button id="decreaseButtonVolteo" class="bg-gray-700 text-white px-2 py-1 rounded-md" type="button">-</button>
                                <input id="numberInputVolteo" type="number" value="0" data-type="volteo" style="width: 60px; text-align: center; margin: 0 5px; border: 2px solid #4472C4; border-radius: 5px; padding: 5px; font-size: 16px; transition: border-color 0.3s; color: black;" 
                                    onfocus="this.style.borderColor='#C9E9D2';" 
                                    onblur="this.style.borderColor='#4472C4';" />
                                <button id="increaseButtonVolteo" class="bg-gray-700 text-white px-2 py-1 rounded-md" type="button">+</button>
                            </div>
                        </div>

                        <!-- Botón Solicitar -->
                        <button id="solicitarv" class="button-orange mt-2 py-1 px-3 rounded-md text-xs font-semibold" type="button">Solicitar</button>
                    </div>

                    <!-- Solicitar Volteo -->
                    <div class="text-white text-center rounded-lg" style="background-color:#242424; padding: 8px; max-height: 135px; max-width: 350px;">
                        <div class="flex flex-col items-center">
                            <!-- Texto en la parte superior -->
                            <span class="text-3xl mb-1">Volteo</span>

                            <!-- Contador en la parte inferior con los botones -->
                            <div class="flex items-center space-x mt-1">
                                <button id="decreaseButtonPlano" class="bg-gray-700 text-white px-2 py-1 rounded-md" type="button">-</button>
                                <input id="numberInputPlano" type="number" value="0" data-type="plano" 
                                    style="width: 60px; text-align: center; margin: 0 5px; border: 2px solid #C9E9D2; border-radius: 5px; padding: 5px; font-size: 16px; transition: border-color 0.3s; color: black;" 
                                    onfocus="this.style.borderColor='#4472C4';" onblur="this.style.borderColor='#C9E9D2';" />
                                <button id="increaseButtonPlano" class="bg-gray-700 text-white px-2 py-1 rounded-md" type="button">+</button>
                            </div>
                        </div>

                        <!-- Botón Solicitar -->
                        <button  id="solicitarp" class="button-orange mt-2 py-1 px-3 rounded-md text-xs font-semibold" type="button">Solicitar</button>
                    </div>
                </div>
            </div>
            </div>
            </div>
        </section>

    <!-- Unidades Planas & Unidades de Volteo -->
    <section class="grid grid-cols-1 md:grid-cols-2 gap-8" style="font-family: 'Gilroy-Bold', sans-serif;">
        <div class="w-3/4 mx-auto bg-white"> 
            <asp:Repeater ID="rptRutas1" runat="server">
                <ItemTemplate>
                     <!-- Unidades Planas -->
                    <h2 class="text-lg font-bold mb-4 text-center">UNIDADES PLANAS</h2>
                    <div class="space-y-2">
                        <div class="flex justify-between items-center text-white p-2 rounded-lg" style="background-color: #182A6E; background-image: linear-gradient(90deg, rgba(255,255,255,0.1) 1px, transparent 1px), linear-gradient(rgba(255,255,255,0.1) 1px, transparent 1px); background-size: 20px 20px;">
                            <div class="w-1/4 flex flex-col items-center">
                                <div id="progressCircle1" style="width: 95px; height: 95px; border-radius: 50%; background: #f0f0f0; position: relative;">
                                    <div id="timerText1" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 18px; color: black;">00:00:00</div>
                                </div>
                            </div>
                            
                            <div class="mt-2 flex flex-col items-center">
                                <div class="flex justify-center">
                                    <button id="startButton1" type="button" class="bg-green-500 text-white px-3 py-1 rounded-md">Iniciar</button>
                                    <button id="stopButton1" type="button" class="bg-red-500 text-white px-3 py-1 rounded-md ml-2" data-codigo-generacion='<%# HttpUtility.HtmlEncode(Eval("codeGen").ToString()) %>'>Detener</button>
                                </div>
                                
                                <!-- Texto condicional con recuadro -->
                                <span class="text-blue-500 font-bold mt-2" 
                                    runat="server" 
                                    Visible='<%# Eval("requiresSweeping").ToString() == "S" %>'
                                    style="display: inline-block; padding: 8px 12px; margin-top: 8px; border: 2px solid #0067c2; border-radius: 8px; background-color: #0067c2; color: #f0f0f0;">
                                    Se Requiere Barrido
                                </span>
                            </div>

                        </div>
                    </div>
                    <!-- Info 1 -->
                    <div class="bg-white p-2 rounded-md  text-sm mb-4" style="font-family: 'Gilroy-Light', sans-serif;">
                        <p>
                            <strong>Transaccion:</strong>
                        </p>
                        
                        <p>
                            <strong>Ingenio:</strong> 
                            <asp:Label ID="lblIngenio" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("ingenio.user.username").ToString()) %>'></asp:Label>
                        </p>

                        <p>
                            <strong>Motorista:</strong>
                            <asp:Label ID="lblMotorista" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("driver.name").ToString()) %>'></asp:Label>
                        </p>

                        <p>
                            <strong>Placa Remolque:</strong>
                            <asp:Label ID="lblPlacaR" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("vehicle.trailerPlate").ToString()) %>'></asp:Label>
                        </p>

                        <p>
                            <strong>Placa Camión:</strong> 
                            <asp:Label ID="lblPlacaC" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("vehicle.plate").ToString()) %>'></asp:Label>
                        </p>

                        <p>
                            <strong>Hora de Ingreso:</strong> 
                            <asp:Label ID="lblHoraIngreso" runat="server" CssClass="no-bold" Text='<%# Eval("TimeForId2") %>'></asp:Label>
                        </p>

                    </div>
            </ItemTemplate>
        </asp:Repeater>

        <!-- Entry 2 -->    
        <asp:Repeater ID="rptRutas" runat="server">
            <ItemTemplate>
                <!-- Unidades Planas -->
                <h2 class="text-lg font-bold mb-4 text-center">UNIDAD PLANA EN COLA</h2>
                <div class="bg-blue-600 text-white p-2 rounded-lg mb-4" style="font-family: 'Gilroy-Light', sans-serif;">
                    <asp:LinkButton CssClass="btn" ID="lnk_VerRuta" runat="server" 
                                    data-transporter='<%# HttpUtility.HtmlEncode(Eval("driver.name").ToString()) %>' 
                                    data-trailerplate='<%# HttpUtility.HtmlEncode(Eval("vehicle.trailerPlate").ToString()) %>' 
                                    data-plate='<%# HttpUtility.HtmlEncode(Eval("vehicle.plate").ToString()) %>' 
                                    data-codigo-generacion='<%# HttpUtility.HtmlEncode(Eval("codeGen").ToString()) %>' OnClientClick="return confirmAuthorization(this);" CausesValidation="false">
                                    
                        <asp:Label ID="lblCodT" Visible="false" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                        <ul class="space-y text-sm" style="color: white; text-align: left;">
                            <li>
                                <strong>Transaccion:</strong>
                            </li>
                            <li>
                                <strong>Ingenio:</strong> 
                                <asp:Label ID="lblIngenio" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("ingenio.user.username").ToString()) %>'></asp:Label>
                            </li>
                            <li>
                                <strong>Motorista:</strong> 
                                <asp:Label ID="lblMotorista" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("driver.name").ToString()) %>'></asp:Label>
                            </li>
                            
                            <li>
                                <strong>Placa Remolque:</strong>
                                <asp:Label ID="lblPlacaR" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("vehicle.trailerPlate").ToString()) %>'></asp:Label>
                            </li>
                            <li>
                                <strong>Placa Camión:</strong> 
                                <asp:Label ID="lblPlacaC" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("vehicle.plate").ToString()) %>'></asp:Label>
                            </li>
                            <li>
                                <strong>Hora de Ingreso:</strong> 
                                <asp:Label ID="lblHoraIngreso" runat="server" CssClass="no-bold" Text='<%# Eval("TimeForId2") %>'></asp:Label>
                            </li>
                        </ul>
                    </asp:LinkButton>
                </div>
            </ItemTemplate>
        </asp:Repeater>
         </div>   
        

        <!-- Unidades de Volteo -->
            <asp:Repeater ID="rptRutas3" runat="server">
                <ItemTemplate>
                <div class="w-3/4 mx-auto bg-white"> 
            <h2 class="text-lg font-bold mb-4 text-center">UNIDADES DE VOLTEO</h2>
                <div class="space-y-2">
                    <div class="flex justify-between items-center text-white p-2 rounded-lg" style="background-color: #242424; background-image: linear-gradient(90deg, rgba(255,255,255,0.1) 1px, transparent 1px), linear-gradient(rgba(255,255,255,0.1) 1px, transparent 1px); background-size: 20px 20px;">
                        <div class="w-1/4 flex flex-col items-center">
                            <div id="progressCircle2" style="width: 95px; height: 95px; border-radius: 50%; background: #f0f0f0; position: relative;">
                                <div id="timerText2" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 18px; color: black;">00:00:00</div>
                            </div>
                        </div>
                        
                        <div class="mt-2 flex flex-col items-center">
                            <div class="flex justify-center">
                                <button id="startButton2" type="button" class="bg-green-500 text-white px-3 py-1 rounded-md">Iniciar</button>
                                <button id="stopButton2" type="button" class="bg-red-500 text-white px-3 py-1 rounded-md ml-2" data-codigo-generacion='<%# HttpUtility.HtmlEncode(Eval("codeGen").ToString()) %>'>Detener</button>
                            </div>
                            <!-- Texto condicional con recuadro -->
                            <span class="text-gray-500 font-bold mt-2" 
                                  runat="server" Visible='<%# Eval("requiresSweeping").ToString() == "S" %>'
                                  style="display: inline-block; padding: 8px 12px; margin-top: 8px; border: 2px solid #343435; border-radius: 8px; background-color: #343435; color: #f0f0f0;">
                                  Se Requiere Barrido
                            </span>
                        </div>
                    </div>
                </div>
                    <!-- Info 1 -->
                    <div class="bg-white p-2 rounded-md text-sm mb-4" style="font-family: 'Gilroy-Light', sans-serif;">
                        <p>
                            <strong>Transaccion:</strong>
                        </p>
                        
                        <p>
                            <strong>Ingenio:</strong> 
                            <asp:Label ID="lblIngenio" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("ingenio.user.username").ToString()) %>'></asp:Label>
                        </p>

                        <p>
                            <strong>Motorista:</strong>
                            <asp:Label ID="lblMotorista" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("driver.name").ToString()) %>'></asp:Label>
                        </p>

                        <p>
                            <strong>Placa Remolque:</strong>
                            <asp:Label ID="lblPlacaR" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("vehicle.trailerPlate").ToString()) %>'></asp:Label>
                        </p>

                        <p>
                            <strong>Placa Camión:</strong> 
                            <asp:Label ID="lblPlacaC" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("vehicle.plate").ToString()) %>'></asp:Label>
                        </p>

                        <p>
                            <strong>Hora de Ingreso:</strong> 
                            <asp:Label ID="lblHoraIngreso" runat="server" CssClass="no-bold" Text='<%# Eval("TimeForId2") %>'></asp:Label>
                        </p>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <!-- Entry 2 -->    
            <asp:Repeater ID="rptRutas2" runat="server">
                <ItemTemplate>
                     <h2 class="text-lg font-bold mb-4 text-center">UNIDAD VOLTEO EN COLA</h2>
                    <div class="bg-gray-600 text-white p-2 rounded-lg mb-2"  style="font-family: 'Gilroy-Light', sans-serif;">
                        <asp:LinkButton CssClass="btn" ID="lnk_VerRuta" runat="server" 
                                    data-transporter='<%# HttpUtility.HtmlEncode(Eval("driver.name").ToString()) %>' 
                                    data-trailerplate='<%# HttpUtility.HtmlEncode(Eval("vehicle.trailerPlate").ToString()) %>' 
                                    data-plate='<%# HttpUtility.HtmlEncode(Eval("vehicle.plate").ToString()) %>' 
                                    data-codigo-generacion='<%# HttpUtility.HtmlEncode(Eval("codeGen").ToString()) %>' OnClientClick="return confirmAuthorization(this);" CausesValidation="false">
                                    
                                    <asp:Label ID="lblCodT" Visible="false" runat="server" Text='<%# Eval("id") %>'></asp:Label>

                            <ul class="space-y text-sm" style="color: white; text-align: left;">
                                <li>
                                    <strong>Transaccion:</strong>
                                </li>
                                <li>
                                    <strong>Ingenio:</strong> 
                                    <asp:Label ID="lblIngenio" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("ingenio.user.username").ToString()) %>'></asp:Label>
                                </li>
                                <li>
                                    <strong>Motorista:</strong> 
                                    <asp:Label ID="lblMotorista" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("driver.name").ToString()) %>'></asp:Label>
                                </li>
                                
                                <li>
                                    <strong>Placa Remolque:</strong>
                                    <asp:Label ID="lblPlacaR" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("vehicle.trailerPlate").ToString()) %>'></asp:Label>
                                </li>
                                <li>
                                    <strong>Placa Camión:</strong> 
                                    <asp:Label ID="lblPlacaC" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("vehicle.plate").ToString()) %>'></asp:Label>
                                </li>
                                <li>
                                    <strong>Hora de Ingreso:</strong> 
                                    <asp:Label ID="lblHoraIngreso" runat="server" CssClass="no-bold" Text='<%# Eval("TimeForId2") %>'></asp:Label>
                                </li>
                            </ul>
                        </asp:LinkButton>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
      </div>
    </section>
  </main>

  <!-- Footer -->
  <footer class="text-center py-4 text-sm text-gray-600" 
          style="font-family: 'Gilroy-Light', sans-serif; background-color: #242424; color: white; width: 100%;">
    © 2024 Almacenadora del Pacífico
  </footer>

<!-- Modal -->
<div id="confirmationModal" class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">¿Deseas detener el cronómetro?</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Por favor selecciona una opción para explicar el motivo del retraso:</p>
                <select id="motivoDetencion" class="form-control">
                    <option value="sin_observaciones">Sin observaciones.</option>
                    <option value="corte_energia">Corte de energía eléctrica.</option>
                    <option value="azucar_terrones">Azúcar con terrones</option>
                    <option value="falla_bascula">Falla en Báscula</option>
                    <option value="falta_personal_supervisor">Falta personal supervisor AAES</option>
                    <option value="falla_volcador">Falla en el volcador</option>
                    <option value="limpieza_sistema_recepcion">Limpieza del sistema de recepción</option>
                    <option value="limpieza_fosa_banda_65_66">Limpieza de fosa banda #65 y #66 (PLANA)</option>
                    <option value="limpieza_fosa_banda_67">Limpieza de fosa banda #67 (VOLTEO)</option>
                    <option value="movimiento_carro_banda">Movimiento de carro en banda.</option>
                    <option value="colocando_laminas">Colocando láminas en banda.</option>
                    <option value="lluvia">Lluvia</option>
                    <option value="falta_personal_barredores">Falta personal de barredores</option>
                    <option value="falta_personal_seguridad">Falta personal de seguridad.</option>
                    <option value="fallo_unidad_recepcion">Falló unidad en recepción.</option>
                    <option value="levante_rebalse">Levante de rebalse.</option>
                    <option value="fallo_unidad_bascula">Fallo de unidad en báscula</option>
                    <option value="falla_puerta_4">Falla de unidad en puerta #4</option>
                    <option value="falla_sistema_plumas_porton_4">Falla en sistema plumas de portón #4</option>
                    <option value="limpieza_ductos_carro_banda">Limpieza de ductos de carro en banda.</option>
                    <option value="falla_sistema_electrico_bandas">Falla en sistema eléctrico de bandas</option>
                    <option value="rebalse">Rebalse</option>
                    <option value="obstruccion_tolva">Obstrucción en tolva.</option>
                    <option value="falla_mecanica_unidad">Falla mecánica de unidad.</option>
                    <option value="azucar_pegada">Azúcar pegada</option>
                    <option value="falla_sistemas_bandas">Falla en sistemas de bandas</option>
                    <option value="cambio_turno">Cambio de turno.</option>
                    <option value="falta_relevo_operador">Falta de relevo de operador de sistema.</option>
                    <option value="tiempo_comida">Tiempo de comida.</option>
                    <option value="revisando_ruta_recepcion">Revisando ruta de recepción.</option>
                    <option value="fallo_unidad_puerta_5">Falló unidad en puerta #5</option>
                    <option value="falla_mecanica_unidad_2">Falla mecánica de unidad.</option>
                    <option value="falla_sistema_toma_tiempo">Falla en sistema de toma de tiempo.</option>
                    <option value="fuga_aceite">Fuga de Aceite.</option>
                    <option value="fuga_combustible">Fuga de combustible</option>
                    <option value="fuga_agua">Fuga de agua.</option>
                    <option value="fallo_sistema_volcador">Fallo en sistema de volcador</option>
                    <option value="lluvia_durante_recepcion">Lluvia durante recepción.</option>
                    <option value="falla_sistema_toma_tiempo_recepcion">Falla en sistema de toma de tiempo (recepción)</option>
                    <option value="demora_operario_bascula">Demora por operario de báscula</option>
                    <option value="reunion_operativa_almapac">Reunión Operativa ALMAPAC.</option>
                    <option value="falta_unidades">Falta de unidades</option>
                    <option value="motorista_sin_pre_chequeo">Motorista sin Pre-chequeo</option>
                    <option value="azucar_pegada_terrones">Azúcar pegada y con terrones</option>
                    <option value="flujo_restringido_tolva_banda_66">Flujo restringido en abertura de tolva de banda #66 [01]</option>
                    <option value="flujo_restringido_banda_67">Flujo restringido en banda #67 [01]</option>
                </select>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-primary" id="confirmarDetener">Detener Cronómetro</button>
            </div>
        </div>
    </div>
</div>



       
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

    <!-- Custom Scripts -->
    <script src="../src/js/spotlight.bundle.js"></script>

    <!-- SweetAlert2 (latest version) -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.all.min.js"></script>

    <script src="https://cdn.tailwindcss.com"></script>


    <!-- JavaScript for Mobile Menu Toggle -->
    <script>
        document.getElementById('menu-toggle').addEventListener('click', function() {
            const mobileMenu = document.getElementById('mobile-menu');
            mobileMenu.classList.toggle('hidden');
        });
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
    function createTimer(progressCircleId, timerTextId, startButtonId, stopButtonId, storageKey, duration, redThreshold) {
        let interval;
        let isRunning = false;
        let milliseconds = localStorage.getItem(`${storageKey}_milliseconds`) ? parseInt(localStorage.getItem(`${storageKey}_milliseconds`)) : 0;
        let lastTimestamp = performance.now();

        if (localStorage.getItem(`${storageKey}_lastUpdated`) && Date.now() - parseInt(localStorage.getItem(`${storageKey}_lastUpdated`)) > 3600000) {
            localStorage.removeItem(`${storageKey}_milliseconds`);
        }
        localStorage.setItem(`${storageKey}_lastUpdated`, Date.now().toString());

        updateTimerDisplay(timerTextId, milliseconds);

        // Verifica si el cronómetro está en ejecución y lo arranca si es necesario
        if (localStorage.getItem(`${storageKey}_isRunning`) === 'true') {
            startTimer();
        }

        window.addEventListener('storage', function(event) {
            if (event.key === `${storageKey}_milliseconds`) {
                const updatedTime = parseInt(event.newValue);
                updateTimerDisplay(timerTextId, updatedTime);
            }
        });

        // Botón de inicio
        document.getElementById(startButtonId).addEventListener('click', function(event) {
            event.preventDefault();
            if (!isRunning) {
                startTimer();
            }
        });

        // Botón de detención
        document.getElementById(stopButtonId).addEventListener('click', function(event) {
            event.preventDefault();
            console.log(`Botón de detención presionado: ${stopButtonId}`);
            const codigoGeneracion = this.getAttribute("data-codigo-generacion");
            console.log(`Código de generación: ${codigoGeneracion}`);

            if (!isRunning) {
                Swal.fire({
                    title: 'Acción no permitida',
                    text: 'El cronómetro no está en ejecución.',
                    icon: 'warning',
                    confirmButtonText: 'Ok'
                }).then((result) => {
                    if (result.isConfirmed) {
                        stopTimer(codigoGeneracion, stopButtonId); // Pasa el codigoGeneracion al detener
                        Swal.fire('Detenido', 'El cronómetro ha sido detenido.', 'success');
                    }
                });
                return;
            }

            // Lógica de detención si el cronómetro ha alcanzado el tiempo máximo
            if (milliseconds >= duration * 1000) {
                $('#confirmationModal').modal('show');  // Mostrar la modal
            } else {
                Swal.fire({
                    title: '¿Estás seguro de detener el cronómetro?',
                    text: "El cronómetro no ha superado el tiempo máximo.",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: 'Sí, detenerlo',
                    cancelButtonText: 'No, continuar'
                }).then((result) => {
                    if (result.isConfirmed) {
                        stopTimer(codigoGeneracion, stopButtonId); // Pasa el codigoGeneracion al detener
                        Swal.fire('Detenido', 'El cronómetro ha sido detenido.', 'success');
                    }
                });
            }
        });

        function startTimer() {
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
            updateTimerDisplay(timerTextId, milliseconds, stopButtonId);

            console.log(`Cronómetro detenido: ${stopButtonId}, Código: ${codigoGeneracion}`);

            // Llama a la función para cambiar el estado
            changeStatusTimer(codigoGeneracion, stopButtonId);

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

        function updateTimerDisplay(timerTextId, milliseconds, stopButtonId) 
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
            if (motivoDetencion) 
            {
                console.log(`Motivo de detención: ${motivoDetencion}`);
                stopTimer(); // Detiene y ejecuta la lógica correspondiente
                $('#confirmationModal').modal('hide');
            } 
            else 
            {
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
            async: true,
            type: "POST",
            url: "Autorizacion_Camiones.aspx/ChangeTransactionStatus",
            data: JSON.stringify({ codeGen: codigoGeneracion, predefinedStatusId: predefinedStatusId }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) 
            {
                console.log("Respuesta de la API: ", response.d);
                // Llamamos a updateStatusDisplay para actualizar la UI después de cambiar el estado
                updateStatusDisplay();
                // Recargar la página cuando el usuario presione "Aceptar"
                //location.reload();

            },
            error: function(xhr, status, error) 
            {
                console.error("Error en AJAX:", { status: status, error: error, response: xhr.responseText });
            }
        });
    }

    function saveTimerState(storageKey) 
    {
        let milliseconds = parseInt(localStorage.getItem(`${storageKey}_milliseconds`)) || 0;
        localStorage.setItem(`${storageKey}_milliseconds`, milliseconds);
        localStorage.setItem(`${storageKey}_isRunning`, 'false'); // Solo detén el cronómetro actual
    }

    function updateStatusDisplay() 
    {
        // Aquí actualizas el botón del cronómetro 1
        var stopButton1 = document.getElementById('stopButton1');
        stopButton1.textContent = "Iniciar";  // Cambia el texto a "Iniciar"
        stopButton1.style.backgroundColor = "green";  // Cambia el color de fondo del botón a verde

        // Si tienes otro cronómetro (como Cronómetro 2)
        var stopButton2 = document.getElementById('stopButton2');
        stopButton2.textContent = "Detener";  // Cambia el texto a "Detener"
        stopButton2.style.backgroundColor = "red";  // Cambia el color de fondo del botón a rojo

        // Puedes agregar más lógica aquí para actualizar otras partes de la interfaz de usuario
        // como los temporizadores visuales o los mensajes de estado.
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