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
                <div class="relative group hover:bg-gray-100 p-2 rounded">
                    <button class="hover:text-orange-600 px-2 py-1 flex items-center focus:outline-none">
                        <span>Monitoreo</span>
                        <svg class="ml-1 w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M5.23 7.21a.75.75 0 111.06-1.06L10 9.86l3.71-3.71a.75.75 0 011.06 1.06l-4 4a.75.75 0 01-1.06 0l-4-4z" />
                        </svg>
                    </button>
                    <!-- Dropdown Menu -->
                    <div class="absolute left-0 mt-2 w-48 bg-white border border-gray-200 rounded shadow-lg hidden group-hover:block group-focus-within:block">
                        <div class="block px-4 py-2 hover:bg-gray-100 text-gray-700">
                            <a href="Autorizacion_Camiones.aspx" style="text-decora tion: none;">
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
                        <div class="block px-4 py-2 hover:bg-gray-100 text-gray-700">
                            <a href="Lista_Negra.aspx" style="text-decoration: none;">
                                <i class="fas fa-list-alt mr-2"></i>Lista Negra Motorista
                            </a>
                        </div>
                    </div>
                </div>
                <a href="Tiempos_Azucar.aspx" class="bg-primary text-white flex items-center px-2 py-2 rounded focus:outline-none" style="text-decoration: none;">
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
                    <div class="text-white text-center rounded-lg" style="background-color: #182A6E; padding: 5px; height: 130px; max-width: 300px; position: relative;">
                        <!-- Línea vertical fija al lado izquierdo de la tarjeta -->
                        <div style="position: absolute; top: 8px; left: 10px; width: 10px; height: 90%; background-color: #EAE8EC; border-radius: 5px;"></div>
                        
                        <div class="flex flex-col items-center">
                            <!-- Texto en la parte superior -->
                            <span class="text-3xl mb-1">Plana</span>

                            <!-- Etiqueta ASP.NET -->
                            <span class="text-5xl mt-1 font-bold">
                                <asp:Label ID="lblTotalRegistros" runat="server" CssClass="text-center font-bold mb-4"></asp:Label>
                            </span>
                        </div>
                    </div>

                    <!-- Volteo -->
                    <div class="text-white text-center rounded-lg" style="background-color:#242424; padding: 8px; max-height: 135px; max-width: 350px; position: relative;">
                        
                        <!-- Línea vertical fija al lado izquierdo de la tarjeta -->
                        <div style="position: absolute; top: 8px; left: 10px; width: 10px; height: 90%; background-color: #FF5733; border-radius: 5px;"></div>
                        
                        <div class="flex flex-col items-center">
                            <!-- Texto en la parte superior -->
                            <span class="text-3xl mb-1">Volteo</span>
                            <div class="text-5xl mt-1 font-bold">
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
                    <div class="text-white text-center rounded-lg" style="background-color: #182A6E; padding: 5px; height: 130px; max-width: 300px; position: relative;">
                        <!-- Línea vertical fija al lado izquierdo de la tarjeta -->
                        <div style="position: absolute; top: 8px; left: 10px; width: 10px; height: 90%; background-color: #EAE8EC; border-radius: 5px;"></div>    
                        
                        <div class="flex flex-col items-center">
                            <!-- Texto en la parte superior -->
                            <span class="text-3xl mb-1">Plana</span>

                            <!-- Contador en la parte inferior con los botones -->
                            <div class="flex items-center space-x mt-1">
                                <button id="decreaseButtonPlano" class="bg-gray-700 text-white px-2 py-1 rounded-md" type="button">-</button>
                                <input id="numberInputPlano" type="text" value="0" data-type="plano" style="width: 50px; text-align: center; margin: 0 5px; border-radius: 5px; padding: 5px; font-size: 19px; transition: border-color 0.3s; color: black;" 
                                    onfocus="this.style.borderColor='#C9E9D2';" 
                                    onblur="this.style.borderColor='#4472C4';" readonly />
                                <button id="increaseButtonPlano" class="bg-gray-700 text-white px-2 py-1 rounded-md" type="button">+</button>
                            </div>
                        </div>

                        <!-- Botón Solicitar -->
                        <button id="solicitarp" class="button-orange mt-2 py-1 px-3 rounded-md text-xs font-semibold" type="button" style="font-size: 18px;">Solicitar</button>
                    </div>

                    <!-- Solicitar Volteo -->
                    <div class="text-white text-center rounded-lg" style="background-color:#242424; padding: 8px; max-height: 135px; max-width: 350px; position: relative;">
                        
                        <!-- Línea vertical fija al lado izquierdo de la tarjeta -->
                        <div style="position: absolute; top: 8px; left: 10px; width: 10px; height: 90%; background-color: #FF5733; border-radius: 5px;"></div>
                        <div class="flex flex-col items-center">
                            <!-- Texto en la parte superior -->
                            <span class="text-3xl mb-1">Volteo</span>

                            <!-- Contador en la parte inferior con los botones -->
                            <div class="flex items-center space-x mt-1">
                                <button id="decreaseButtonVolteo" class="bg-gray-700 text-white px-2 py-1 rounded-md" type="button">-</button>
                                <input id="numberInputVolteo" type="text" value="0" data-type="plano" style="width: 50px; text-align: center; margin: 0 5px; border-radius: 5px; padding: 5px; font-size: 19px; transition: border-color 0.3s; color: black;" 
                                    onfocus="this.style.borderColor='#4472C4';" onblur="this.style.borderColor='#C9E9D2';" />
                                <button id="increaseButtonVolteo" class="bg-gray-700 text-white px-2 py-1 rounded-md" type="button">+</button>
                            </div>
                        </div>

                        <!-- Botón Solicitar -->
                        <button  id="solicitarv" class="button-orange mt-2 py-1 px-3 rounded-md text-xs font-semibold" type="button" style="font-size: 18px;">Solicitar</button>
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
                                        <button id="startButton1" type="button" class="bg-green-500 text-white px-3 py-1 rounded-md" onclick="mostrarModal(event, this)" 
                                            data-requires-sweeping='<%# Eval("requiresSweeping") %>'>Iniciar</button>
                                        <button id="stopButton1" type="button" class="bg-red-500 text-white px-3 py-1 rounded-md ml-2" 
                                            onclick="console.log('Detener Cronómetro 1'); stopTimer('stopButton1')" data-codigo-generacion='<%# HttpUtility.HtmlEncode(Eval("codeGen").ToString()) %>'>Detener</button>
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
                                <strong>Transacción:</strong>
                                <asp:Label ID="lblTransaccion" runat="server" Text='<%# Eval("idNavRecord") != null ? Convert.ToString(Eval("idNavRecord")) : "Sin Datos" %>' />
                            </p>
                            
                            <p>
                                <strong>Ingenio:</strong> 
                                <asp:Label ID="lblIngenio" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("ingenio.name").ToString().Replace("_", " ")) %>' /></asp:Label>
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


                <asp:Repeater ID="rptRutas" runat="server">
                    <ItemTemplate>
                        <h2 id="titulo" class="text-lg font-bold mb-4 text-center" runat="server" Visible='<%# Eval("IsFirst") %>'>UNIDAD PLANA EN COLA</h2>
                            <div class="bg-blue-600 text-white p-2 rounded-lg mb-2"  style="font-family: 'Gilroy-Light', sans-serif;">
                                <asp:LinkButton CssClass="btn" ID="lnk_VerRuta" runat="server" 
                                            data-transporter='<%# HttpUtility.HtmlEncode(Eval("driver.name").ToString()) %>' 
                                            data-trailerplate='<%# HttpUtility.HtmlEncode(Eval("vehicle.trailerPlate").ToString()) %>' 
                                            data-plate='<%# HttpUtility.HtmlEncode(Eval("vehicle.plate").ToString()) %>' 
                                            data-codigo-generacion='<%# HttpUtility.HtmlEncode(Eval("codeGen").ToString()) %>' OnClientClick="return confirmAuthorization(this);" CausesValidation="false">
                                        
                                    <asp:Label ID="lblCodT" Visible="false" runat="server" Text='<%# Eval("id") %>'></asp:Label>

                                    <ul class="space-y text-sm" style="color: white; text-align: left;">
                                        <li>
                                            <strong>Transacción:</strong>
                                            <asp:Label ID="lblTransaccion" runat="server" Text='<%# Eval("idNavRecord") != null ? Convert.ToString(Eval("idNavRecord")) : "Sin Datos" %>' />
                                        </li>
                                        <li>
                                            <strong>Ingenio:</strong> 
                                            <asp:Label ID="lblIngenio" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("ingenio.name").ToString().Replace("_", " ")) %>' /></asp:Label>
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
                                            <asp:Label ID="lblHoraIngreso" runat="server" CssClass="no-bold" Text='<%# Eval("dateTimePrecheckeo") != null ? Convert.ToDateTime(Eval("dateTimePrecheckeo")).ToString("yyyy-MM-dd HH:mm:ss") : "No hay datos" %>'></asp:Label>
                                        </li>
                                    </ul>
                                </asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            
            <!-- Unidades de Volteo -->
            <div class="w-3/4 mx-auto bg-white"> 
            <asp:Repeater ID="rptRutas3" runat="server">
                <ItemTemplate>
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
                                    <button id="startButton2" type="button" class="bg-green-500 text-white px-3 py-1 rounded-md" onclick="mostrarModal(event, this)" 
                                        data-requires-sweeping='<%# Eval("requiresSweeping") %>'>Iniciar</button>
                                    <button id="stopButton2" type="button" class="bg-red-500 text-white px-3 py-1 rounded-md ml-2" 
                                        onclick="console.log('Detener Cronómetro 2'); stopTimer('stopButton2')" data-codigo-generacion='<%# HttpUtility.HtmlEncode(Eval("codeGen").ToString()) %>'>Detener</button>
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
                                <strong>Transacción:</strong>
                                <asp:Label ID="lblTransaccion" runat="server" Text='<%# Eval("idNavRecord") != null ? Convert.ToString(Eval("idNavRecord")) : "Sin Datos" %>' />
                            </p>
                                
                            <p>
                                <strong>Ingenio:</strong> 
                                <asp:Label ID="lblIngenio" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("ingenio.name").ToString().Replace("_", " ")) %>' /></asp:Label>
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
                                <asp:Label ID="lblHoraIngreso" runat="server" CssClass="no-bold" Text='<%# Eval("dateTimePrecheckeo") != null ? Convert.ToDateTime(Eval("dateTimePrecheckeo")).ToString("yyyy-MM-dd HH:mm:ss") : "No hay datos" %>'></asp:Label>
                            </p>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <!-- Entry 2 -->    
                <asp:Repeater ID="rptRutas2" runat="server">
                    <ItemTemplate>
                        <h2 id="titulo" class="text-lg font-bold mb-4 text-center" runat="server" Visible='<%# Eval("IsFirst") %>'>UNIDAD VOLTEO EN COLA</h2>
                            <div class="bg-gray-600 text-white p-2 rounded-lg mb-2"  style="font-family: 'Gilroy-Light', sans-serif;">
                                <asp:LinkButton CssClass="btn" ID="lnk_VerRuta" runat="server" 
                                            data-transporter='<%# HttpUtility.HtmlEncode(Eval("driver.name").ToString()) %>' 
                                            data-trailerplate='<%# HttpUtility.HtmlEncode(Eval("vehicle.trailerPlate").ToString()) %>' 
                                            data-plate='<%# HttpUtility.HtmlEncode(Eval("vehicle.plate").ToString()) %>' 
                                            data-codigo-generacion='<%# HttpUtility.HtmlEncode(Eval("codeGen").ToString()) %>' OnClientClick="return confirmAuthorization(this);" CausesValidation="false">
                                        
                                    <asp:Label ID="lblCodT" Visible="false" runat="server" Text='<%# Eval("id") %>'></asp:Label>

                                    <ul class="space-y text-sm" style="color: white; text-align: left;">
                                        <li>
                                            <strong>Transacción:</strong>
                                            <asp:Label ID="lblTransaccion" runat="server" Text='<%# Eval("idNavRecord") != null ? Convert.ToString(Eval("idNavRecord")) : "Sin Datos" %>' />
                                        </li>
                                        <li>
                                            <strong>Ingenio:</strong> 
                                            <asp:Label ID="lblIngenio" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("ingenio.name").ToString().Replace("_", " ")) %>' /></asp:Label>
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
                                            <asp:Label ID="lblHoraIngreso" runat="server" CssClass="no-bold" Text='<%# Eval("dateTimePrecheckeo") != null ? Convert.ToDateTime(Eval("dateTimePrecheckeo")).ToString("yyyy-MM-dd HH:mm:ss") : "No hay datos" %>'></asp:Label>
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
    <footer class="flex items-center justify-center py-2 text-sm text-gray-300 font-bold" 
            style="font-family: 'Gilroy-Light', sans-serif; background-color: #242424; color: white; width: 100%; position: fixed; bottom: 0; left: 0;">
        <span>© 2024 Almacenadora del Pacífico S.A. de C.V. - Todos los derechos reservados</span>
    </footer>

    <!-- Modal para seleccionar tipo de barrido -->
    <div id="barridoModal" class="modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" style="display: none;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Seleccionar Tipo de Barrido</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>Seleccione el tipo de barrido:</p>
                    <select id="tipoBarrido" class="form-control">
                        <option value="N">Sencillo</option>
                        <option value="S">Doble</option>
                    </select>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" id="confirmBarrido">Confirmar</button>
                </div>
            </div>
        </div>
    </div>


    <!-- Modal -->
    <div id="confirmationModal" class="modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" style="display: none;">
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
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" id="cancelStopButton">Cancelar</button>
                    <button type="button" class="btn btn-primary" id="confirmStopButton">Detener Cronómetro</button>
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

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Evitar recarga al hacer clic en botones del navbar
            document.querySelectorAll("button").forEach(button => {
                button.addEventListener("click", function (event) {
                    event.preventDefault(); // Evita que el botón recargue la página
                });
            });
        });
    </script>

    <!-- JavaScript for Mobile Menu Toggle -->
    <script>
        document.getElementById('menu-toggle').addEventListener('click', function() 
        {
            const mobileMenu = document.getElementById('mobile-menu');
            mobileMenu.classList.toggle('hidden');
        });
    </script>

    <script>
        document.addEventListener('DOMContentLoaded', function() 
        {
            // Configuración de botones y contadores para Volteo
            const decreaseButtonVolteo = document.getElementById('decreaseButtonVolteo');
            const increaseButtonVolteo = document.getElementById('increaseButtonVolteo');
            const numberInputVolteo    = document.getElementById('numberInputVolteo');
            const solicitarVolteo      = document.getElementById('solicitarv');
        
            // Configuración de botones y contadores para Plano
            const decreaseButtonPlano = document.getElementById('decreaseButtonPlano');
            const increaseButtonPlano = document.getElementById('increaseButtonPlano');
            const numberInputPlano    = document.getElementById('numberInputPlano');
            const solicitarPlano      = document.getElementById('solicitarp');

            // Función para obtener el valor como número entero
            function getValue(input) 
            {
                let value = parseInt(input.value);
                return isNaN(value) ? 0 : value; // Si no es un número, regresa 0
            }

            // Validación para asegurarse de que la suma no pase de 4
            function validateTotal() 
            {
                let volteoValue = getValue(numberInputVolteo);
                let planoValue = getValue(numberInputPlano);
                return (volteoValue + planoValue) <= 3;
            }

            // Decrementar Volteo
            decreaseButtonVolteo.addEventListener('click', function() 
            {
                let currentValue = getValue(numberInputVolteo);
                if (currentValue > 0) // Evitar valores negativos
                { 
                    numberInputVolteo.value = currentValue - 1;
                }
            });

            // Incrementar Volteo
            increaseButtonVolteo.addEventListener('click', function() 
            {
                let currentValue = getValue(numberInputVolteo);
                numberInputVolteo.value = currentValue + 1;
            });

            // Decrementar Plano
            decreaseButtonPlano.addEventListener('click', function() 
            {
                let currentValue = getValue(numberInputPlano);
                if (currentValue > 0) // Evitar valores negativos
                { 
                    numberInputPlano.value = currentValue - 1;
                }
            });

            // Incrementar Plano
            increaseButtonPlano.addEventListener('click', function() 
            {
                let currentValue = getValue(numberInputPlano);
                numberInputPlano.value = currentValue + 1;
            });

            // Validación al solicitar Volteo
            solicitarVolteo.addEventListener('click', function() 
            {
                let currentValue = getValue(numberInputVolteo);
                var Tipo_Unidad = 'V';

                // Establecer el valor de numberInputVolteo a 0
                numberInputVolteo.value = 0;
                SolicitarUnidad(Tipo_Unidad, currentValue);
            });

            // Validación al solicitar Plano
            solicitarPlano.addEventListener('click', function() 
            {
                let currentValue = getValue(numberInputPlano);
                var Tipo_Unidad = 'R';

                // Establecer el valor de numberInputPlano a 0
                numberInputPlano.value = 0;
                SolicitarUnidad(Tipo_Unidad, currentValue);
            });
        });

        function SolicitarUnidad(Tipo_Unidad, currentValue) 
        {
            if (Tipo_Unidad === "V") 
            {
                nuevaVariable = "Volteo";
            } 
            else if (Tipo_Unidad === "R") 
            {
                nuevaVariable = "Plana";
            }

            $.ajax({
                async: true,
                type: "POST",
                url: "Tiempos_Azucar.aspx/SolicitarUnidad",
                data: JSON.stringify({ Tipo_Unidad: Tipo_Unidad, currentValue: currentValue }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) 
                {
                    // Verificar si la respuesta es un mensaje de éxito en formato de texto
                    if (typeof response.d === "string" && response.d.includes("Status: waiting_to_send")) 
                    {
                        // Extraer detalles del mensaje (opcional)
                        const status = response.d.split(",")[0]; // "Status: waiting_to_send"
                        const entryTime = response.d.split(",")[1].trim(); // "EntryTime: 04/02/2025 21:40:16"

                        // Mostrar SweetAlert de éxito con los detalles
                        Swal.fire({
                            icon: 'success',
                            title: '¡Solicitud Enviada!',
                            html: `
                                <p>La solicitud se ha procesado correctamente.</p>
                                <p><strong> Has solicitado ${currentValue} camiones del tipo ${nuevaVariable}.</strong></p>
                            `,
                            confirmButtonText: 'Aceptar',
                            confirmButtonColor: '#28a745',
                        });
                    }
                    // Verificar si la respuesta es un objeto JSON con éxito
                    else if (response.d && response.d.success) 
                    {
                        // Mostrar SweetAlert de éxito con mensaje personalizado
                        Swal.fire({
                            icon: 'success',
                            title: '¡Solicitud Enviada!',
                            text: `Has solicitado ${currentValue} camiones del tipo ${nuevaVariable}.`,
                            confirmButtonText: 'Aceptar',
                            confirmButtonColor: '#28a745',
                        });
                    }
                    // Si la respuesta no es exitosa o no tiene el formato esperado
                    else 
                    {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: response.d || 'Hubo un problema al procesar la solicitud.',
                            confirmButtonText: 'Aceptar',
                            confirmButtonColor: '#dc3545',
                        });
                    }
                },
                error: function(xhr, status, error) 
                {
                    console.log("Error en la solicitud: ", error);

                    // Mostrar SweetAlert de error en caso de fallo en la solicitud AJAX
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Hubo un problema con la solicitud. Verifica tu conexión e intenta nuevamente.',
                        confirmButtonText: 'Aceptar',
                        confirmButtonColor: '#dc3545',
                    });
                }
            });
        }
    </script>

    <script>
        let intervals = { timer1: null, timer2: null }; // Objeto para almacenar los intervalos de cada cronómetro
        let isRunning = { timer1: false, timer2: false }; // Estado de ejecución de cada cronómetro
        let lastTimestamps = { timer1: null, timer2: null }; // Tiempos de inicio de cada cronómetro

        window.onload = function () 
        {
            for (const key in intervals) 
            {
                const isRunningStored = localStorage.getItem(`${key}_isRunning`) === 'true';
                const storedMilliseconds = parseInt(localStorage.getItem(`${key}_milliseconds`)) || 0;

                if (isRunningStored) 
                {
                    console.log(`Restaurando ${key}, tiempo acumulado: ${storedMilliseconds}ms`);
                    lastTimestamps[key] = performance.now();
                    restoreTimer(key, storedMilliseconds);
                } 
                else 
                {
                    console.log(`${key} no estaba en ejecución.`);
                    updateTimerDisplay(key === 'timer1' ? 'timerText1' : 'timerText2', storedMilliseconds);
                }
            }
        };

        // Función para manejar la modal y la lógica de barrido
        function mostrarModal(event, button) 
        {
            const requiresSweeping = button.getAttribute('data-requires-sweeping'); // Obtener el valor de requiresSweeping desde el atributo de datos
            const isSweepingRequired = requiresSweeping === 'S'; // evalúa si requiresSweeping es igual a "S", asignando true si lo es y false en caso contrario
            const codigoGeneracion = button.getAttribute('data-codigo-generacion'); //Obtener el valor del codigo de generacion

            let storageKey;
            if (button.id === 'startButton1') 
            {
                storageKey = 'timer1'; // Si el id es 'startButton1', asigna 'timer1'
            } 
            else if (button.id === 'startButton2') 
            {
                storageKey = 'timer2'; // Si el id es 'startButton2', asigna 'timer2'
            } 
            else 
            {
                console.error('Botón desconocido: ' + button.id); // Para otros casos, se muestra un error
            }

            // Mostrar la modal de barrido
            $('#barridoModal').modal('show');

            // Al hacer clic en el botón de confirmar barrido
            document.getElementById('confirmBarrido').onclick = function () 
            {
                const tipoSeleccionado = document.getElementById('tipoBarrido').value;
                console.log('Valor de tipoSeleccionado:', tipoSeleccionado);
                console.log('requiresSweeping:', requiresSweeping);
                console.log('storageKey:', storageKey);

                // Verificar discrepancias entre el tipo de barrido requerido y el seleccionado
                if ((requiresSweeping === 'S' && tipoSeleccionado === 'N') || (requiresSweeping === 'N' && tipoSeleccionado === 'S')) 
                {
                    // Discrepancia detectada
                    Swal.fire({
                        title: '¿Estás seguro?',
                        text: 'El tipo de barrido seleccionado no coincide con el requerido. ¿Deseas continuar?',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonText: 'Sí',
                        cancelButtonText: 'No'
                    }).then((result) => 
                    {
                        if (result.isConfirmed) 
                        {
                            // Mostrar modal de comentario y cerrar la modal de barrido
                            $('#barridoModal').modal('hide');
                            showCommentModal(codigoGeneracion, isSweepingRequired, (comentario) => 
                            {
                                console.log('Iniciando cronómetro tras comentario...');
                                //sweepinglog(codigoGeneracion, isSweepingRequired, comentario); // Registrar el barrido con el comentario
                                startTimer(storageKey); // Llamar al inicio del cronómetro
                            });
                        }
                    });
                } 
                else 
                {
                    // Si no hay discrepancias, se procede directamente con el cronómetro
                    console.log(`Tipo de barrido seleccionado: ${tipoSeleccionado}`);
                    $('#barridoModal').modal('hide'); // Cerrar modal de barrido
                    console.log('Iniciando cronómetro directamente...');
                    //sweepinglog(codigoGeneracion, isSweepingRequired, '');
                    startTimer(storageKey); // Llamar al inicio del cronómetro
                }
            };
        }

        // Función para mostrar el modal de comentario
        function showCommentModal(codigoGeneracion, isSweepingRequired, callback) 
        {
            Swal.fire({
                title: 'Ingrese su comentario',
                input: 'textarea',
                inputPlaceholder: 'Escribe tu comentario aquí...',
                showCancelButton: true,
                confirmButtonText: 'Enviar',
                cancelButtonText: 'Cancelar',
                allowOutsideClick: false,
                focusConfirm: false,
                didOpen: (modal) => 
                {
                    console.log("Modal abierto correctamente");
                    const textarea = modal.querySelector('textarea');
                    if (textarea) 
                    {
                        textarea.removeAttribute('readonly'); // Asegurarse de que no sea readonly
                        textarea.focus();
                        console.log("Textarea listo para escribir");
                    }
                }
            }).then((result) => 
            {
                if (result.isConfirmed) 
                {
                    console.log('Comentario enviado:', result.value);
                    console.log('Código Generación:', codigoGeneracion);
                    console.log('Requiere Barrido:', isSweepingRequired);
                    if (callback) callback(); // Ejecutar el callback al confirmar
                } 
                else 
                {
                    // Si cancela, reabrir la modal de barrido
                    $('#barridoModal').modal('show');
                }
            });
        }

        function sweepinglog(codeGen, requiresSweeping, observation)
        {
            //alert(codeGen + " - " + requiresSweeping + " - " + observation);
            $.ajax({
                type: "POST",
                url: "Tiempos_Azucar.aspx/sweepinglog",
                data: JSON.stringify({ codeGen: codeGen, requiresSweeping: requiresSweeping, observation: observation }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) 
                {
                    console.log("Respuesta de la API: ", response.d);     
                },
                error: function(xhr, status, error) 
                {
                    console.error("Error cambiando el estado: ", error);
                }
            });
        }

        function startTimer(storageKey) 
        {
            if (!storageKey || isRunning[storageKey]) return;

            const duration = storageKey === 'timer1' ? 15 * 60 * 1000 : 10 * 60 * 1000;
            const progressCircleId = storageKey === 'timer1' ? 'progressCircle1' : 'progressCircle2';
            const timerTextId = storageKey === 'timer1' ? 'timerText1' : 'timerText2';

            let milliseconds = parseInt(localStorage.getItem(`${storageKey}_milliseconds`)) || 0;
            const wasRunning = localStorage.getItem(`${storageKey}_isRunning`) === 'true';

            if (wasRunning) 
            {
                const lastSavedTimestamp = parseInt(localStorage.getItem(`${storageKey}_lastTimestamp`)) || 0;
                if (lastSavedTimestamp) 
                {
                    const now = performance.now();
                    milliseconds += now - lastSavedTimestamp;
                }
            }

            isRunning[storageKey] = true;
            lastTimestamps[storageKey] = performance.now();
            localStorage.setItem(`${storageKey}_isRunning`, 'true');

            intervals[storageKey] = setInterval(() => 
            {
                const currentTimestamp = performance.now();
                const elapsed = currentTimestamp - lastTimestamps[storageKey];
                lastTimestamps[storageKey] = currentTimestamp;

                milliseconds += elapsed;
                localStorage.setItem(`${storageKey}_milliseconds`, milliseconds);
                localStorage.setItem(`${storageKey}_lastTimestamp`, performance.now());

                const angle = (milliseconds / duration) * 360;
                const progressCircleElement = document.getElementById(progressCircleId);
                if (progressCircleElement) 
                {
                    progressCircleElement.style.background = `conic-gradient(${getColor(milliseconds, duration, storageKey)} ${angle}deg, #f0f0f0 ${angle}deg)`;
                }

                updateTimerDisplay(timerTextId, milliseconds);

                // Eliminar o comentar este bloque para que el cronómetro no se detenga automáticamente
                // if (milliseconds >= duration) 
                // {
                //     clearInterval(intervals[storageKey]);
                //     isRunning[storageKey] = false;
                //     localStorage.setItem(`${storageKey}_isRunning`, 'false');
                // }
            }, 50);
        }

        function stopTimer(stopButtonId) 
        {
            const codigoGeneracion = document.getElementById(stopButtonId).getAttribute('data-codigo-generacion');
            const storageKey = stopButtonId === 'stopButton1' ? 'timer1' : 'timer2';
            const progressCircleId = storageKey === 'timer1' ? 'progressCircle1' : 'progressCircle2';
            const timerTextId = storageKey === 'timer1' ? 'timerText1' : 'timerText2';
            const threshold = storageKey === 'timer1' ? 15 * 60 * 1000 : 10 * 60 * 1000; // 15 min para timer1 y 10 min para timer2
            const milliseconds = parseInt(localStorage.getItem(`${storageKey}_milliseconds`)) || 0;
            const tiempoTranscurrido = formatTime(milliseconds); // Formatear el tiempo transcurrido

            console.log(`Código de generación: ${codigoGeneracion}`);
            console.log(`Tiempo transcurrido: ${tiempoTranscurrido}`);

            if (!isRunning[storageKey]) {
                console.log("El cronómetro ya está detenido.");
                return; // No hacer nada si el cronómetro ya está detenido
            }

            // Mostrar la modal si se supera el umbral de tiempo
            if (milliseconds > threshold) {
                const confirmationModal = document.getElementById("confirmationModal");
                confirmationModal.style.display = "block"; // Mostrar modal

                document.getElementById("confirmStopButton").onclick = function () {
                    const motivoDetencion = document.getElementById("motivoDetencion").value || ''; // Comentario opcional
                    console.log('Motivo seleccionado:', motivoDetencion);

                    // Detener el cronómetro y limpiar la UI
                    clearInterval(intervals[storageKey]);
                    isRunning[storageKey] = false;
                    localStorage.setItem(`${storageKey}_isRunning`, 'false');
                    localStorage.setItem(`${storageKey}_milliseconds`, 0);
                    document.getElementById(progressCircleId).style.background = `conic-gradient(#f0f0f0 0deg, #f0f0f0 0deg)`;
                    updateTimerDisplay(timerTextId, 0);

                    // Llamar a la función TiempoAzucar
                    TiempoAzucar(codigoGeneracion, tiempoTranscurrido, motivoDetencion);

                    confirmationModal.style.display = "none"; // Ocultar modal
                };

                document.getElementById("cancelStopButton").onclick = function () {
                    confirmationModal.style.display = "none"; // Cerrar modal sin detener el cronómetro
                };

                return; // Salir de la función para no detener automáticamente el cronómetro
            }

            // Si no se supera el umbral, detener normalmente
            clearInterval(intervals[storageKey]);
            isRunning[storageKey] = false;
            localStorage.setItem(`${storageKey}_isRunning`, 'false');
            localStorage.setItem(`${storageKey}_milliseconds`, 0);
            document.getElementById(progressCircleId).style.background = `conic-gradient(#f0f0f0 0deg, #f0f0f0 0deg)`;
            updateTimerDisplay(timerTextId, 0);

            // Llamar a la función TiempoAzucar con un comentario vacío
            TiempoAzucar(codigoGeneracion, tiempoTranscurrido, '');
        }

        function restoreTimer(storageKey, initialMilliseconds) 
        {
            const duration = storageKey === 'timer1' ? 15 * 60 * 1000 : 10 * 60 * 1000;
            const progressCircleId = storageKey === 'timer1' ? 'progressCircle1' : 'progressCircle2';
            const timerTextId = storageKey === 'timer1' ? 'timerText1' : 'timerText2';

            let milliseconds = initialMilliseconds;

            isRunning[storageKey] = true;

            intervals[storageKey] = setInterval(() => 
            {
                const currentTimestamp = performance.now();
                const elapsed = currentTimestamp - lastTimestamps[storageKey];
                lastTimestamps[storageKey] = currentTimestamp;
                milliseconds += elapsed;
                localStorage.setItem(`${storageKey}_milliseconds`, milliseconds);

                const angle = (milliseconds / duration) * 360;
                const progressCircleElement = document.getElementById(progressCircleId);

                if (progressCircleElement) 
                {
                    progressCircleElement.style.background = `conic-gradient(${getColor(milliseconds, duration, storageKey)} ${angle}deg, #f0f0f0 ${angle}deg)`;
                }

                updateTimerDisplay(timerTextId, milliseconds);

                // Eliminar la condición de detención del cronómetro
                // Ya no hay necesidad de detener el cronómetro si ha alcanzado el tiempo máximo
            }, 50);
        }

        function updateTimerDisplay(timerTextId, milliseconds) 
        {
            const timeString = formatTime(milliseconds);
            const timerTextElement = document.getElementById(timerTextId);
            if (timerTextElement) 
            {
                timerTextElement.textContent = timeString;
            } 
            else 
            {
                console.error(`Elemento con ID "${timerTextId}" no encontrado.`);
            }
        }

        function formatTime(milliseconds) 
        {
            const minutes = Math.floor(milliseconds / 60000);
            const seconds = Math.floor((milliseconds % 60000) / 1000);
            const millis = Math.floor((milliseconds % 1000) / 10); // Milisegundos
            return `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}:${millis.toString().padStart(2, '0')}`;
        }

        function getColor(milliseconds, maxMilliseconds, storageKey) 
        {
            let warningTime; // Tiempo límite para cambiar a color rojo
            if (storageKey === 'timer1') 
            {
                warningTime = 15 * 60 * 1000; // 15 minutos en milisegundos
            } 
            else if (storageKey === 'timer2') 
            {
                warningTime = 10 * 60 * 1000; // 10 minutos en milisegundos
            } 
            else 
            {
                console.error("StorageKey desconocido");
                return "#ffbf00"; // Color inicial por defecto
            }

            // Calcula el progreso del tiempo
            const ratio = milliseconds / maxMilliseconds;

            if (milliseconds < warningTime / 2) 
            {
                // Primera mitad del tiempo
                return "#ffbf00"; // Amarillo
            } 
            else if (milliseconds < warningTime) 
            {
                // Segunda mitad del tiempo
                return "#ff7300"; // Naranja
            } 
            else 
            {
                // Tiempo excedido o alcanzado
                return "#ff0000"; // Rojo
            }
        }

        // Función para cambiar el estatus después de la validación exitosa
        function changeStatusAzucar(codigoGeneracion) 
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

           $.ajax({
                type: "POST",
                url: "Autorizacion_Camiones.aspx/ChangeTransactionStatus",
                data: JSON.stringify({ codeGen: codigoGeneracion, predefinedStatusId: predefinedStatusId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) {
                    console.log("Respuesta completa de la API:", response);
                    
                    if (response.d && typeof response.d === "string") {
                        console.log("Estructura dentro de response.d:", response.d);

                        let detailsHTML = "<p>El estado se actualizó correctamente.</p>";

                        for (const key in response.d) {
                            if (response.d.hasOwnProperty(key)) {
                                let value = response.d[key];

                                // Si el valor es un objeto, lo convertimos en un JSON legible
                                if (typeof value === "string" && value !== null) {
                                    detailsHTML += `<p><strong>${key}:</strong> ${JSON.stringify(value, null, 2)}</p>`;
                                } else {
                                    detailsHTML += `<p><strong>${key}:</strong> ${value}</p>`;
                                }
                            }
                        }

                        Swal.fire({
                            icon: 'success',
                            title: '¡Actualización exitosa!',
                            text: 'El estado se actualizó correctamente.',
                            confirmButtonText: 'Aceptar'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                location.reload();
                            }
                        });

                    } else {
                        console.error("La respuesta no es un objeto válido:", response.d);
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: typeof response.d === "string" ? response.d : 'Hubo un problema al procesar la solicitud.',
                            confirmButtonText: 'Aceptar'
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error en la solicitud AJAX:", error);
                    try {
                        let errorResponse = JSON.parse(xhr.responseText);
                        let errorMessage = errorResponse.message || 'Ocurrió un problema al actualizar el estado.';
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: errorMessage,
                            confirmButtonText: 'Aceptar'
                        });
                    } catch (e) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Hubo un problema al realizar la solicitud.',
                            confirmButtonText: 'Aceptar'
                        });
                    }
                }
            });
        }

        function TiempoAzucar(codigoGeneracion, tiempo, comentario)
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
                url: "Tiempos_Azucar.aspx/TiempoAzucar",
                data: JSON.stringify({ codigoGeneracion: codigoGeneracion, tiempo: tiempo, comentario: comentario}),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) 
                {
                    console.log("Respuesta de la API: ", response.d);     

                    // Funcion para cambiar estatus de la Transacción
                    changeStatusAzucar(codigoGeneracion);
                },
                error: function(xhr, status, error) 
                {
                    console.error("Error cambiando el estado: ", error);
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
                customClass: 
                {
                    confirmButton: 'swal-wide-button',
                    cancelButton: 'swal-wide-button'
                }
            }).then((result) => 
            {
                if (result.isConfirmed) 
                {
                    // Llamar a changeStatus después de la validación exitosa
                    changeStatus(codigoGeneracion);
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
                success: function(response) {
                    console.log("Respuesta completa de la API:", response);
                    
                    if (response.d && typeof response.d === "string") {
                        console.log("Estructura dentro de response.d:", response.d);

                        let detailsHTML = "<p>El estado se actualizó correctamente.</p>";

                        for (const key in response.d) {
                            if (response.d.hasOwnProperty(key)) {
                                let value = response.d[key];

                                // Si el valor es un objeto, lo convertimos en un JSON legible
                                if (typeof value === "string" && value !== null) {
                                    detailsHTML += `<p><strong>${key}:</strong> ${JSON.stringify(value, null, 2)}</p>`;
                                } else {
                                    detailsHTML += `<p><strong>${key}:</strong> ${value}</p>`;
                                }
                            }
                        }

                        Swal.fire({
                            icon: 'success',
                            title: '¡Actualización exitosa!',
                            text: 'El estado se actualizó correctamente.',
                            confirmButtonText: 'Aceptar'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                location.reload();
                            }
                        });

                    } else {
                        console.error("La respuesta no es un objeto válido:", response.d);
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: typeof response.d === "string" ? response.d : 'Hubo un problema al procesar la solicitud.',
                            confirmButtonText: 'Aceptar'
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error en la solicitud AJAX:", error);
                    try {
                        let errorResponse = JSON.parse(xhr.responseText);
                        let errorMessage = errorResponse.message || 'Ocurrió un problema al actualizar el estado.';
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: errorMessage,
                            confirmButtonText: 'Aceptar'
                        });
                    } catch (e) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Hubo un problema al realizar la solicitud.',
                            confirmButtonText: 'Aceptar'
                        });
                    }
                }
            });
        }
    </script>
</body>
</html>