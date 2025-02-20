<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Autorizacion_Camiones.aspx.cs" Inherits="Basculas_Autorizacion_Camiones" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chequeo de Informacion</title>
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

        /* Aplica borde rojo y fondo suave para campos con la clase 'error-field' */
        input.form-control.error-field,
        textarea.form-control.error-field,
        select.form-control.error-field 
        {
            border: 2px solid red !important; /* Asegúrate de que se aplique incluso si hay otras reglas */
            background-color: #f8d7da !important; /* Fondo suave para resaltar el error */
        }

        /* Fondo oscuro con centrado total */
        #spinner-overlay {
            display: flex;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            align-items: center;
            justify-content: center;
            z-index: 1050;
            overflow: hidden;
        }

        /* Contenedor de los elementos alineados */
        .animation-container {
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 300px;
            height: 300px;
            overflow: hidden;
        }

        /* Contenedor del camión */
        .truck-container {
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            animation: truck-shake 0.2s ease-in-out infinite;
        }

        /* Camión */
        .truck-icon 
        {
            width: 275px; /* Ajusta el tamaño según necesites */
            height: auto;
            position: relative;
            z-index: 1; /* Mantiene la imagen en el fondo */
            margin-top: 20px; /* Ajusta la posición */
        }


        /* Contenedor de ruedas */
        .truck-wheels {
            position: absolute;
            bottom: 80px; /* Ajustar posición */
            left: 58%;
            transform: translateX(-50%);
            display: flex;
            gap: 55px;
            z-index: 2; /* Ruedas sobre el camión */
        }

        /* Nube principal (ya existente) */
        .cloud1 {
            font-size: 75px; /* Aumenta el tamaño */
            color: #ffffff;
            position: absolute;
            bottom: 185px;
            animation: moveLeft 12s linear infinite;
            transform: scaleX(2); /* Aumenta aún más el ancho */
        }

        /* Segunda nube con diferente tamaño, velocidad y dirección */
        .cloud2 {
            font-size: 50px; /* Un poco más pequeña */
            color: #ffffff;
            position: absolute;
            bottom: 220px; /* Más arriba para variar posiciones */
            opacity: 0.8; /* Un poco más transparente */
            animation: moveLeftReverse 12s linear infinite;
        }

        /* Animación de movimiento de la nube de derecha a izquierda */
        @keyframes moveLeft {
            0% { transform: translateX(50px); }  
            100% { transform: translateX(-50px); } 
        }
        /* Movimiento opuesto y más lento para la segunda nube */
        @keyframes moveLeftReverse {
            0% { transform: translateX(-50px); }
            100% { transform: translateX(50px); }
        }
        @keyframes truck-move {
            0% { transform: translateX(-100px); }  /* Inicia fuera de la pantalla */
            50% { transform: translateX(100px); } /* Se mueve hacia la derecha */
            100% { transform: translateX(-100px); } /* Regresa a la posición inicial */
        }
        @keyframes truck-shake {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-2px); } /* Mueve el camión ligeramente hacia arriba */
            100% { transform: translateY(0px); }
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
                    <button class="bg-primary text-white flex items-center px-2 py-1 rounded focus:outline-none">
                        <span>Monitoreo</span>
                        <svg class="ml-1 w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M5.23 7.21a.75.75 0 111.06-1.06L10 9.86l3.71-3.71a.75.75 0 011.06 1.06l-4 4a.75.75 0 01-1.06 0l-4-4z" />
                        </svg>
                    </button>
                    <!-- Dropdown Menu -->
                    <div class="absolute left-0 mt-2 w-48 bg-white border border-gray-200 rounded shadow-lg hidden group-hover:block group-focus-within:block">
                        <div class="block px-4 py-2 bg-primary text-white rounded hover:bg-opacity-80">
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
                        <div class="block px-4 py-2 hover:bg-gray-100 text-gray-700">
                            <a href="Lista_Negra.aspx" style="text-decoration: none;">
                                <i class="fas fa-list-alt mr-2"></i>Lista Negra Motorista
                            </a>
                        </div>
                    </div>
                </div>
                <a href="Tiempos_Azucar.aspx" class="hover:text-orange-800 flex items-center px-2 py-2" style="text-decoration: none;">
                    <i class="fas fa-clock mr-2"></i>Recepción Azúcar
                </a>
            </nav>

            <!-- Logout Button -->
            <a href="login.aspx" class="login-button"  style="text-decoration:none">
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
    <h1>Chequeo de Informacion</h1>
  </section>

    <!-- Main Content -->
    <main class="container mx-auto py-8">
        <!-- Unidad en Espera & Solicitar Unidades -->
        <section>
            <div class="bg-white">
                <div class="bg-white">
                <h2 class="text-lg font-bold mb-1 text-center">TOTAL UNIDADES</h2> <!-- Margen inferior más pequeño -->
                
                <div class="flex justify-center items-center min-h-[25vh]">
                    <div class="grid grid-cols-2 gap-2 mt-[-20px]"> <!-- Agregado margen superior negativo -->
                        <!-- Tarjeta de "Solicitar Plano" -->
                        <div class="text-white text-center rounded-lg" style="background-color: #182A6E; padding: 5px; width: 225px; height: 100px; display: flex; align-items: center; position: relative;">
                            <div class="text-white text-center rounded-lg" style="background-color: #182A6E; padding: 5px; width: 225px; height: 100px; display: flex; align-items: center; position: relative;">
                                <!-- Línea vertical a la izquierda con posición absoluta -->
                                <span style="position: absolute; left: 10px; top: 10px; width: 8px; height: 80px; background-color: #EAE8EC; border-radius:10px;"></span>
                                
                                <!-- Contenedor para el contenido principal -->
                                <div style="flex: 1; text-align: center;">
                                    <span class="text-3xl" style="display: block; margin-bottom: 5px;">Plana</span>
                                    <span class="text-3xl font-bold" style="display: block; margin-top: 5px;">
                                        <asp:Label ID="lblCountP" runat="server" CssClass="text-center font-bold"></asp:Label>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <!-- Tarjeta de "Solicitar Volteo" -->
                        <div class="text-white text-center rounded-lg" style="background-color: #242424; padding: 5px; width: 225px; height: 100px; position: relative;">
                            <!-- Línea vertical -->
                            <span style="position: absolute; left: 10px; top: 10px; width: 8px; height: 80px; background-color: #FF7300; border-radius:10px;"></span>
                            
                            <!-- Contenido principal -->
                            <div class="flex flex-col items-center justify-center h-full">
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
                                style="background-color: white; border-radius: 10px; padding: 5px; display: inline-block; width: 160px; text-align: left;">
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
                            <h2 class="text-xs font-bold text-black mb-1"style="background-color: white; padding: 5px; border-radius: 10px; display: inline-block;">INGENIO CENTRAL AZUCARERO JIBOA</h2>
                            <div class="text-base font-bold">
                                <asp:TextBox ID="txtIngenioQuantity4" runat="server" ReadOnly="true" 
                                    Width="50px" CssClass="text-black text-center"
                                    style="background-color: white; border: none; color: black; border-radius: 5px;" />
                            </div>
                        </div>

                        <!-- Tarjeta 3 -->
                        <div class="card1" style="margin: 2px;">
                            <h2 class="text-xs font-bold text-black mb-1" style="background-color: white; padding: 5px; border-radius: 10px; display: inline-block;">INGENIO CHAPARRASTIQUE</h2>
                            <div class="text-base font-bold">
                                <asp:TextBox ID="txtIngenioQuantity3" runat="server" ReadOnly="true" 
                                    Width="50px" CssClass="text-black text-center"
                                    style="background-color: white; border: none; color: black; border-radius: 5px;" />
                                
                            </div>
                        </div>

                        <!-- Tarjeta 4 -->
                        <div class="card1" style="margin: 2px;">
                            <h2 class="text-xs font-bold text-black mb-1" style="background-color: white; padding: 5px; border-radius: 10px; display: inline-block;">INGENIO <br>EL ANGEL</h2>
                            <div class="text-base font-bold">
                                <asp:TextBox ID="txtIngenioQuantity6" runat="server" ReadOnly="true" 
                                    Width="50px" CssClass="text-black text-center"
                                    style="background-color: white; border: none; color: black; border-radius: 5px;" />
                            </div>
                        </div>

                        <!-- Tarjeta 5 -->
                        <div class="card1" style="margin: 2px;">
                            <h2 class="text-xs font-bold text-black mb-1" style="background-color: white; padding: 5px; border-radius: 10px; display: inline-block;">INGENIO <br>LA CABAÑA</h2>
                            <div class="text-base font-bold">
                                <asp:TextBox ID="txtIngenioQuantity1" runat="server" ReadOnly="true" 
                                    Width="50px" CssClass="text-black text-center"
                                    style="background-color: white; border: none; color: black; border-radius: 5px;" />
                             
                            </div>
                        </div>

                        <!-- Tarjeta 6 -->
                        <div class="card1" style="margin: 2px;">
                            <h2 class="text-xs font-bold text-black mb-1" style="background-color: white; padding: 5px; border-radius: 10px; display: inline-block;">INGENIO LA MAGDALENA</h2>
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
    
        <section class="grid grid-cols-1 md:grid-cols-2 gap-8" style="font-family: 'Gilroy-Bold', sans-serif; margin-bottom: 50px;">
            <!-- Columna izquierda -->
            <div class="w-full h-full bg-white mx-auto" style="max-width: 900px; margin: 0 auto; display: flex; flex-direction: column;">
                <h2 class="text-lg font-bold mb-4 text-center">UNIDADES PLANAS</h2>
                <div class="row g-4">
                <asp:Repeater ID="rptRutas1" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-6 col-md-6 col-sm-12 mb-4">
                            <div class="card border rounded-4 shadow-sm" style="border-color: #ddd; border-radius: 10px; height: 600px; display: flex; flex-direction: column;">
                                <asp:LinkButton CssClass="btn p-0 w-100" ID="lnk_VerRuta" runat="server"
                                    data-toggle="modal" data-target="#rutaModal"
                                    data-codigo-generacion='<%# Eval("codeGen") %>' OnClick="lnk_VerRuta_Click">
                                    <div class="position-relative" style="height: 180px;">
                                        <!-- Imagen responsiva -->
                                        <asp:Image ID="imgShipment" runat="server"
                                            ImageUrl='<%# (Eval("shipmentAttachments") != null && ((IEnumerable<object>)Eval("shipmentAttachments")).Count() > 0)
                                                        ? ((dynamic)Eval("shipmentAttachments"))[0].fileUrl
                                                        : "" %>'
                                            CssClass="img-fluid rounded-top"
                                            style="width: 100%; height: 100%; object-fit: cover; background-color: #f8f9fa;" />

                                        <!-- Badge de tipo de camión, centrado y más abajo -->
                                        <div class="position-absolute bottom-0 start-50 translate-middle-x mb-4" style="left: 50%; transform: translate(-50%, 120%);">
                                            <span class="badge 
                                                <%# Eval("vehicle.truckType").ToString() == "V" ? "bg-success" : 
                                                    Eval("vehicle.truckType").ToString() == "R" ? "bg-dark" : 
                                                    "bg-secondary" %> 
                                                text-white px-3 py-2 rounded-pill">
                                                <%# Eval("vehicle.truckType").ToString() == "V" ? "Volteo" : 
                                                    Eval("vehicle.truckType").ToString() == "R" ? "Plana" : "Plana" %>
                                            </span>
                                        </div>
                                    </div>

                                    <div class="card-body" style="flex-grow: 1; overflow-y: auto;">
                                        <!-- Contenido responsivo -->
                                        <p class="text-start mb-1" style="font-size: 0.9rem;">
                                            <i class="fas fa-calendar-alt text-primary"></i> 
                                            <strong>Fecha Prechequeo:</strong>
                                        </p>
                                        <p class="text-muted mb-2 text-start" style="font-size: 0.85rem;">
                                            <asp:Label ID="lblFechaStatus" runat="server" Text='<%# Eval("dateTimePrecheckeo")  %>' />
                                        </p>

                                        <p class="text-start mb-1" style="font-size: 0.9rem;">
                                            <i class="fas fa-code text-primary"></i> 
                                            <strong>Código Generación:</strong>
                                        </p>
                                        <p class="text-muted mb-2 text-start" style="font-size: 0.85rem;">
                                            <asp:Label ID="lblNombre" runat="server" Text='<%# Eval("codeGen") %>' />
                                        </p>

                                        <hr class="my-3" style="border: 2px solid #ff7300;">

                                        <p class="text-start mb-1" style="font-size: 0.9rem;">
                                            <i class="fas fa-industry text-primary"></i> 
                                            <asp:Label ID="lblIngenio" runat="server" Text='<%# HttpUtility.HtmlEncode(Eval("ingenio.name").ToString().Replace("_", " ")) %>' />
                                        </p>

                                        <p class="text-start mb-1" style="font-size: 0.9rem;">
                                            <i class="fas fa-cogs text-primary"></i> 
                                            <strong>Tipo Operación:</strong>
                                        </p>
                                        <p class="text-muted mb-2 text-start" style="font-size: 0.9rem;">
                                            <asp:Label ID="lbloperacion" runat="server"
                                                Text='<%# Eval("operationType") != null ? 
                                                        (Eval("operationType").ToString() == "C" ? "Carga" : 
                                                        Eval("operationType").ToString() == "D" ? "Recepción" : "No disponible")
                                                        : "No disponible" %>' />
                                        </p>

                                        <p class="text-start mb-1" style="font-size: 0.9rem;">
                                            <i class="fas fa-box text-primary"></i> 
                                            <strong>Producto:</strong>
                                        </p>
                                        <p class="text-muted mb-2 text-start" style="font-size: 0.85rem;">
                                            <asp:Label ID="lblproducto" runat="server"
                                                Text='<%# Eval("nameProduct") != null ? 
                                                        HttpUtility.HtmlEncode(Eval("nameProduct").ToString().Replace("_", " ")) : 
                                                        "N/A" %>' />
                                        </p>

                                        <p class="text-start mb-1" style="font-size: 0.9rem;">
                                            <i class="fas fa-user text-primary"></i> 
                                            <strong>Motorista:</strong>
                                        </p>
                                        <p class="text-muted mb-2 text-start" style="font-size: 0.85rem;">
                                            <asp:Label ID="lbltransporte" runat="server" Text='<%# HttpUtility.HtmlEncode(Eval("driver.name").ToString()) %>' />
                                        </p>
                                    </div>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>


            </div>

            <div class="w-full h-full bg-white mx-auto" style="max-width: 900px; margin: 0 auto; display: flex; flex-direction: column;">
                <h2 class="text-lg font-bold mb-4 text-center">UNIDADES VOLTEO</h2>
                <div class="row g-4">
                    <asp:Repeater ID="rptRutas2" runat="server">
                        <ItemTemplate>
                            <div class="col-lg-6 col-md-6 col-sm-12 mb-4">
                            <div class="card border rounded-4 shadow-sm" style="border-color: #ddd; border-radius: 10px; height: 600px; display: flex; flex-direction: column;">
                                <asp:LinkButton CssClass="btn p-0 w-100" ID="lnk_VerRuta" runat="server"
                                    data-toggle="modal" data-target="#rutaModal"
                                    data-codigo-generacion='<%# Eval("codeGen") %>' OnClick="lnk_VerRuta_Click">
                                    <div class="position-relative" style="height: 180px;">
                                        <!-- Imagen responsiva -->
                                        <asp:Image ID="imgShipment" runat="server"
                                            ImageUrl='<%# (Eval("shipmentAttachments") != null && ((IEnumerable<object>)Eval("shipmentAttachments")).Count() > 0)
                                                        ? ((dynamic)Eval("shipmentAttachments"))[0].fileUrl
                                                        : "" %>'
                                            CssClass="img-fluid rounded-top"
                                            style="width: 100%; height: 100%; object-fit: cover; background-color: #f8f9fa;" />

                                            <!-- Badge de tipo de camión, centrado y más abajo -->
                                            <div class="position-absolute bottom-0 start-50 translate-middle-x mb-4" style="left: 50%; transform: translate(-50%, 120%);">
                                                <span class="badge 
                                                    <%# Eval("vehicle.truckType").ToString() == "V" ? "bg-success" : 
                                                        Eval("vehicle.truckType").ToString() == "R" ? "bg-dark" : 
                                                        "bg-secondary" %> 
                                                    text-white px-3 py-2 rounded-pill">
                                                    <%# Eval("vehicle.truckType").ToString() == "V" ? "Volteo" : 
                                                        Eval("vehicle.truckType").ToString() == "R" ? "Plana" : "Plana" %>
                                                </span>
                                            </div>
                                        </div>

                                        <!-- Contenido de la card con altura fija y sin scroll -->
                                        <div class="card-body" style="height: calc(100% - 180px); padding: 1rem; overflow: hidden; display: flex; flex-direction: column; justify-content: space-between;">
                                            <!-- Contenido responsivo -->
                                            <p class="text-start mb-1" style="font-size: 0.9rem;">
                                                <i class="fas fa-calendar-alt text-primary"></i> 
                                                <strong>Fecha Prechequeo:</strong>
                                            </p>
                                            <p class="text-muted mb-2 text-start" style="font-size: 0.85rem;">
                                                <asp:Label ID="lblFechaStatus" runat="server" Text='<%# Eval("dateTimePrecheckeo")  %>' />
                                            </p>

                                            <p class="text-start mb-1" style="font-size: 0.9rem;">
                                                <i class="fas fa-code text-primary"></i> 
                                                <strong>Código Generación:</strong>
                                            </p>
                                            <p class="text-muted mb-2 text-start" style="font-size: 0.85rem;">
                                                <asp:Label ID="lblNombre" runat="server" Text='<%# Eval("codeGen") %>' />
                                            </p>

                                            <hr class="my-3" style="border: 2px solid #ff7300;">

                                            <p class="text-start mb-1" style="font-size: 0.9rem;">
                                                <i class="fas fa-industry text-primary"></i> 
                                                <asp:Label ID="lblIngenio" runat="server" Text='<%# HttpUtility.HtmlEncode(Eval("ingenio.name").ToString().Replace("_", " ")) %>' />
                                            </p>

                                            <p class="text-start mb-1" style="font-size: 0.9rem;">
                                                <i class="fas fa-cogs text-primary"></i> 
                                                <strong>Tipo Operación:</strong>
                                            </p>
                                            <p class="text-muted mb-2 text-start" style="font-size: 0.9rem;">
                                                <asp:Label ID="lbloperacion" runat="server"
                                                    Text='<%# Eval("operationType") != null ? 
                                                            (Eval("operationType").ToString() == "C" ? "Carga" : 
                                                            Eval("operationType").ToString() == "D" ? "Recepción" : "No disponible")
                                                            : "No disponible" %>' />
                                            </p>

                                            <p class="text-start mb-1" style="font-size: 0.9rem;">
                                                <i class="fas fa-box text-primary"></i> 
                                                <strong>Producto:</strong>
                                            </p>
                                            <p class="text-muted mb-2 text-start" style="font-size: 0.85rem;">
                                                <asp:Label ID="lblproducto" runat="server"
                                                    Text='<%# Eval("nameProduct") != null ? 
                                                            HttpUtility.HtmlEncode(Eval("nameProduct").ToString().Replace("_", " ")) : 
                                                            "N/A" %>' />
                                            </p>

                                            <p class="text-start mb-1" style="font-size: 0.9rem;">
                                                <i class="fas fa-user text-primary"></i> 
                                                <strong>Motorista:</strong>
                                            </p>
                                            <p class="text-muted mb-2 text-start" style="font-size: 0.85rem;">
                                                <asp:Label ID="lbltransporte" runat="server" Text='<%# HttpUtility.HtmlEncode(Eval("driver.name").ToString()) %>' />
                                            </p>
                                        </div>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>





            </div>
        </section>
    </main>

    <!-- Footer -->
    <footer class="flex items-center justify-center py-2 text-sm text-gray-300 font-bold" 
            style="font-family: 'Gilroy-Light', sans-serif; background-color: #242424; color: white; width: 100%; position: fixed; bottom: 0; left: 0;">
        <span>© 2025 Almacenadora del Pacífico S.A. de C.V. - Todos los derechos reservados</span>
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

        <div class="modal fade" id="rutaModal" tabindex="-1" role="dialog" aria-labelledby="rutaModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitulo"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="hidden" class="form-control" id="codigoGeneracionInput" readonly />
                <!-- Agregamos un id al formulario -->
                <form id="formRutaModal">
                    <div class="form-group">
                        <label for="recipient-name" class="col-form-label">Licencia:</label>
                        <input type="text" class="form-control" id="txt_licencia" />
                    </div>
                    <div class="form-group">
                        <label for="message-text" class="col-form-label">Placa Remolque:</label>
                        <input type="text" class="form-control" id="txt_placaremolque" oninput="validarPlacaRemolque()" />
                        <small class="form-text text-muted" id="placaRemolqueHint">Debe comenzar con "RE" seguido de números, sin espacios.</small>
                    </div>
                    <div class="form-group">
                        <label for="message-text" class="col-form-label">Placa Camión:</label>
                        <input type="text" class="form-control" id="txt_placamion" oninput="validarPlacaCamion()" />
                        <small class="form-text text-muted" id="placaCamionHint">Debe comenzar con "C" seguido de números, sin espacios.</small>
                    </div>
                    <div class="form-group">
                        <label for="recipient-name" class="col-form-label">No. Tarjeta:</label>
                        <input type="number" class="form-control" id="txt_tarjeta" oninput="this.value = this.value.slice(0, 4)" />
                    </div>
                </form>
                <asp:Label ID="lblRuta" runat="server" Text=""></asp:Label>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" id="btnReportar">Reportar</button>
                <button type="button" class="btn btn-primary" onclick="validarInformacion()">Confirmar</button>
            </div>
        </div>
    </div>
</div>

        <div class="modal fade" tabindex="-1" role="dialog" id="modalReportar" aria-labelledby="modalReportarLabel" aria-hidden="true" data-backdrop="static">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Reportar Comentario</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="formReportar">
                            <!-- Campo oculto para almacenar codigoGeneracion -->
                            <input type="hidden" id="codigoGeneracionModal" value="">
                            
                            <div class="form-group">
                                <label for="comentario">Comentario</label>
                                <textarea class="form-control" id="comentario" rows="4" placeholder="Escribe tu comentario aquí..."></textarea>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-primary" onclick="guardarComentario()">Guardar Comentario</button>
                    </div>
                </div>
            </div>
        </div>

    </form>
        <div id="spinner-overlay">
            <div class="animation-container">
                <i class="fa fa-cloud cloud-icon cloud1" aria-hidden="true"></i>
                <i class="fa fa-cloud cloud-icon cloud2" aria-hidden="true"></i>
                <div class="truck-container">
                    <img src="https://raw.githubusercontent.com/MarioPortillo10/Imagenes-ALMAPAC/main/Quickpass.png" alt="Camión" class="truck-icon">
                </div>
            </div>
        </div>


    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <!-- SweetAlert2 (latest version) -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.all.min.js"></script>

    <!-- Custom Scripts -->
    <script src="../src/js/spotlight.bundle.js"></script>

    <script src="https://cdn.tailwindcss.com"></script>

    <script>
        // Función para obtener el valor de una cookie
        function getCookie(nombre) {
            let nombreEQ = nombre + "=";
            let cookies = document.cookie.split(';');
            for (let i = 0; i < cookies.length; i++) {
                let cookie = cookies[i].trim();
                if (cookie.indexOf(nombreEQ) === 0) {
                    return cookie.substring(nombreEQ.length, cookie.length);
                }
            }
            return null;
        }

        // Función que define qué opciones están permitidas según el rol del usuario y usuario específico
        function obtenerOpcionesPorRol(codRol, username) {
            let opcionesGenerales = {
                1: ["Autorizacion_Camiones.aspx", "Autorizacion_ingreso.aspx", "Autorizacion_Porton4.aspx", "Lista_Negra.aspx", "Tiempos_Azucar.aspx"], // Admin
                2: ["Autorizacion_Camiones.aspx", "Autorizacion_ingreso.aspx", "Autorizacion_Porton4.aspx"], // Supervisor
                3: ["Autorizacion_Camiones.aspx", "Autorizacion_ingreso.aspx"], // Pesador
                4: ["Tiempos_Azucar.aspx"], // Operador (por defecto)
                5: ["Autorizacion_Porton4.aspx"]
            };

            let opcionesEspecificasRol4 = {
                "S0001": ["Autorizacion_Camiones.aspx"],
                "S0002": ["Autorizacion_Camiones.aspx"],
                "S0003": ["Autorizacion_ingreso.aspx"],
                "S0004": ["Autorizacion_Porton4.aspx"],
                "S0005": ["Autorizacion_Porton4.aspx"],
                "S0006": ["Autorizacion_Porton4.aspx"]
            };

            // Si el usuario es rol 4 y tiene permisos específicos, retornarlos; de lo contrario, usar los permisos generales del rol
            if (codRol === 4) {
                return opcionesEspecificasRol4[username] || opcionesGenerales[4];
            }

            return opcionesGenerales[codRol] || [];
        }

        // Función para ocultar enlaces del menú según los permisos y redirigir si es necesario
        function filtrarOpcionesMenu() {
            let username = getCookie("username");
            let codRol = parseInt(getCookie("cod_rol"), 10);

            if (!username || isNaN(codRol)) {
                console.error("No se encontraron las cookies de usuario o rol.");
                return;
            }

            let opcionesPermitidas = obtenerOpcionesPorRol(codRol, username);
            console.log("Usuario:", username);
            console.log("Código de Rol:", codRol);
            console.log("Opciones Permitidas:", opcionesPermitidas);

            // Si el usuario solo tiene una opción disponible, redirigirlo automáticamente
            if (opcionesPermitidas.length === 1) {
                let urlDestino = opcionesPermitidas[0];
                if (window.location.pathname !== "/" + urlDestino) {
                    window.location.href = urlDestino; // Redirigir automáticamente
                    return;
                }
            }

            // Ocultar enlaces no permitidos
            document.querySelectorAll("nav a").forEach((enlace) => {
                let href = enlace.getAttribute("href");

                if (!opcionesPermitidas.includes(href)) {
                    enlace.style.display = "none";
                }
            });

            // Ocultar elementos dentro de dropdowns
            document.querySelectorAll(".relative.group .block a").forEach((enlace) => {
                let href = enlace.getAttribute("href");

                if (!opcionesPermitidas.includes(href)) {
                    enlace.parentElement.style.display = "none";
                }
            });
        }

        // Ejecutar la función cuando la página haya cargado
        document.addEventListener("DOMContentLoaded", filtrarOpcionesMenu);
    </script>

    <script>
        document.addEventListener("DOMContentLoaded", function () 
        {
            // Evitar recarga al hacer clic en botones del navbar
            document.querySelectorAll("button").forEach(button => 
            {
                button.addEventListener("click", function (event) 
                {
                    event.preventDefault(); // Evita que el botón recargue la página
                });
            });
        });
    </script>

    <script>
        $("#spinner-overlay").hide();
        $(document).ready(function () 
        {
            $('#rutaModal').on('show.bs.modal', function (event) 
            {
                var button = $(event.relatedTarget); // Botón que abrió el modal
                var codigoGeneracion = button.data('codigo-generacion'); // Extraer la información del atributo data-codigo-generacion
                var modal = $(this);
                
                // Mostrar el código de generación en el input
                modal.find('#codigoGeneracionInput').val(codigoGeneracion);
                
                // Mostrar el código de generación en el título de la modal
                modal.find('.modal-title').text('Validación de Información de ' + codigoGeneracion);
            });
        });


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

        // Validación en tiempo real de la placa remolque
        function validarPlacaRemolque() 
        {
            var placaRemolque = document.getElementById('txt_placaremolque').value;
            var hint = document.getElementById('placaRemolqueHint');
            var regex = /^RE\d+$/;

            if (regex.test(placaRemolque)) 
            {
                hint.style.color = 'green';
                document.getElementById('txt_placaremolque').classList.remove('error-field');
            } 
            else 
            {
                hint.style.color = 'red';
                document.getElementById('txt_placaremolque').classList.add('error-field');
            }
        }

        // Validación en tiempo real de la placa camión
        function validarPlacaCamion() 
        {
            var placaCamion = document.getElementById('txt_placamion').value;
            var hint = document.getElementById('placaCamionHint');
            var regex = /^C\d+$/;

            if (regex.test(placaCamion)) 
            {
                hint.style.color = 'green';
                document.getElementById('txt_placamion').classList.remove('error-field');
            } 
            else 
            {
                hint.style.color = 'red';
                document.getElementById('txt_placamion').classList.add('error-field');
            }
        }

        function validarInformacion() 
        {
            // Obtener los valores de los campos
            var codigoGeneracion = document.getElementById('codigoGeneracionInput').value;
            var licencia         = document.getElementById('txt_licencia').value.trim();
            var placaRemolque    = document.getElementById('txt_placaremolque').value.trim();
            var placaCamion      = document.getElementById('txt_placamion').value.trim();
            var tarjeta = document.getElementById('txt_tarjeta').value.trim();

            // Expresiones regulares para verificar el formato de las placas
            var regexRemolque = /^RE\d+$/; // La placa del remolque debe comenzar con "RE" seguido de números
            var regexCamion = /^C\d+$/;    // La placa del camión debe comenzar con "C" seguido de números

            // Limpiar previamente cualquier clase de error
            resetErrorFields([]);

            // Validación de los campos vacíos
            if (!licencia) 
            {
                document.getElementById('txt_licencia').classList.add('error-field');
            }
            if (!placaRemolque) 
            {
                document.getElementById('txt_placaremolque').classList.add('error-field');
            } 
            else if (!regexRemolque.test(placaRemolque)) 
            {
                // Validar el formato de la placa del remolque
                document.getElementById('txt_placaremolque').classList.add('error-field');
            }
            if (!placaCamion) 
            {
                document.getElementById('txt_placamion').classList.add('error-field');
            } 
            else if (!regexCamion.test(placaCamion)) 
            {
                // Validar el formato de la placa del camión
                document.getElementById('txt_placamion').classList.add('error-field');
            }
            if (!tarjeta) 
            {
                document.getElementById('txt_tarjeta').classList.add('error-field');
            }

            // Si hay algún campo con error, mostramos el mensaje y detenemos la ejecución
            if (document.querySelectorAll('.error-field').length > 0) 
            {
                Swal.fire({
                    icon: 'error',
                    title: 'Campos con error',
                    text: 'Por favor, complete todos los campos correctamente.',
                    confirmButtonText: 'Aceptar'
                });
                return; // Detener la ejecución si algún campo tiene error
            }

            // Si los campos pasan las validaciones, llamamos al servidor para validar los datos
            $.ajax({
                type: "POST",
                url: "Autorizacion_Camiones.aspx/ValidarDatos",
                data: JSON.stringify({
                    codigoGeneracion: codigoGeneracion,
                    licencia: licencia,
                    placaRemolque: placaRemolque,
                    placaCamion: placaCamion
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) 
                {
                    var resultado = response.d;

                    if (resultado.error) 
                    {
                        Swal.fire({
                            icon: 'error',
                            title: 'Errores encontrados',
                            text: 'Por favor revise los campos resaltados.',
                            confirmButtonText: 'Aceptar'
                        });

                        // Limpiar el marcado de error en los campos anteriores
                        resetErrorFields(resultado.camposConError);

                        // Marcar los campos con errores
                        resultado.camposConError.forEach(function (campo) 
                        {
                            switch (campo) 
                            {
                                case "licencia":
                                    document.getElementById('txt_licencia').classList.add('error-field');
                                    break;
                                case "placaRemolque":
                                    document.getElementById('txt_placaremolque').classList.add('error-field');
                                    break;
                                case "placaCamion":
                                    document.getElementById('txt_placamion').classList.add('error-field');
                                    break;
                                case "tarjeta":
                                    document.getElementById('txt_tarjeta').classList.add('error-field');
                                    break;
                            }
                        });
                    } 
                    else 
                    {
                        Swal.fire({
                            icon: 'success',
                            title: 'Validación exitosa',
                            text: resultado.mensaje,
                            confirmButtonText: 'Aceptar',
                            showLoaderOnConfirm: true,
                            preConfirm: () => 
                            {
                                // Llamar a la función asignar tarjeta después de la validación exitosa
                                return asignartarjeta(codigoGeneracion, tarjeta);
                            }
                        }).then(() => 
                        {
                            //console.log("Tarjeta asignada correctamente.");
                        });
                    }
                },
                error: function (error) 
                {
                    console.error("Error en la solicitud:", error);
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Ocurrió un error al validar los datos.',
                        confirmButtonText: 'Aceptar'
                    });
                }
            });
        }

        // Función para limpiar el marcado de error en los campos
        function resetErrorFields(camposConError) 
        {
            var campos = [
                'txt_licencia',
                'txt_placaremolque',
                'txt_placamion',
                'txt_tarjeta'
            ];

            campos.forEach(function (campo) 
            {
                var elemento = document.getElementById(campo);
                if (elemento && !camposConError.includes(campo)) 
                {
                    // Si el campo no está en la lista de campos con error, quitamos la clase 'error-field'
                    elemento.classList.remove('error-field');
                }
            });
        }

        // Función para limpiar campos específicos de la modal
        function limpiarCamposModal() 
        {
            const campos = [
                'txt_licencia',
                'txt_placaremolque',
                'txt_placamion',
                'txt_tarjeta'
            ];

            // Limpiar valores de los campos
            campos.forEach(campoId => 
            {
                const campo = document.getElementById(campoId);
                if (campo) 
                {
                    campo.value = ''; // Limpia el valor del campo
                    campo.classList.remove('error-field'); // Limpia las clases de error si existen
                }
            });

            // Si el formulario tiene campos adicionales que limpiar
            const hiddenField = document.getElementById('codigoGeneracionInput');
            if (hiddenField) 
            {
                hiddenField.value = '';
            }
        }

        // Evento de cierre de la modal
        $('#rutaModal').on('hidden.bs.modal', function () 
        {
            limpiarCamposModal(); // Llama a la función para limpiar los campos
        });
    
        // Funcion para asignar la tarjeta en NAV
        function asignartarjeta(codigoGeneracion, tarjeta) 
        {
            $.ajax({
                type: "POST",
                url: "Autorizacion_Camiones.aspx/AsignarTarjeta",
                data: JSON.stringify({ codigoGeneracion: codigoGeneracion, tarjeta: tarjeta }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) 
                {
                    console.log("Código de estado HTTP:", 200);
                    console.log("Tipo de respuesta:", typeof response);
                    console.log("Respuesta completa de la API:", response);

                    try 
                    {
                        // Extraemos el contenido de `d` si existe
                        let responseData = response.d ? response.d : response;

                        if (typeof responseData === "string") 
                        {
                            // Buscamos la primera llave '{' para extraer el JSON real
                            let jsonStart = responseData.indexOf('{');
                            if (jsonStart !== -1) 
                            {
                                let jsonString = responseData.substring(jsonStart); // Extraemos solo la parte JSON
                                
                                try 
                                {
                                    responseData = JSON.parse(jsonString);
                                } 
                                catch (parseError) 
                                {
                                    console.error("❌ Error al parsear la respuesta:", parseError);
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Error',
                                        text: 'No se pudo interpretar la respuesta de la API.',
                                        confirmButtonText: 'Aceptar'
                                    });
                                    return;
                                }
                            } 
                            else 
                            {
                                console.error("❌ No se encontró JSON válido en la respuesta.");
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error',
                                    text: 'La respuesta de la API no contiene datos válidos.',
                                    confirmButtonText: 'Aceptar'
                                });
                                return;
                            }
                        }

                        console.log("📌 Respuesta después del parseo:", responseData);

                        // Validamos si la respuesta contiene los datos esperados
                        if (responseData.error) 
                        {
                            // Si existe un error en la respuesta, mostrar el mensaje de error
                            console.error("❌ Error en la API:", responseData.message || "Error desconocido");
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: responseData.message || 'Error desconocido',
                                confirmButtonText: 'Aceptar'
                            });
                        } 
                        else if (responseData.id && responseData.codeGen) 
                        {
                            // Validamos que los campos esperados estén presentes para una respuesta exitosa
                            console.log("✅ Respuesta válida con estructura correcta.");
                            Swal.fire({
                                icon: 'success',
                                title: '¡Éxito!',
                                text: 'Tarjeta asignada correctamente.',
                                confirmButtonText: 'Aceptar'
                            }).then(() => 
                            {
                                $("#spinner-overlay").show();
                                changeStatus(codigoGeneracion);
                            });
                        } 
                        else 
                        {
                            // Si no contiene los datos esperados, mostramos un error
                            console.error("❌ Respuesta con estructura incorrecta.");
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'La respuesta de la API no tiene la estructura esperada.',
                                confirmButtonText: 'Aceptar'
                            });
                        }

                    } 
                    catch (error) 
                    {
                        console.error("❌ Error inesperado:", error);
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Ocurrió un problema al procesar la respuesta.',
                            confirmButtonText: 'Aceptar'
                        });
                    }
                },
                error: function (xhr) 
                {
                    console.log("⚠️ Error en la solicitud AJAX");
                    console.log("Código de estado HTTP:", xhr.status);
                    console.log("Respuesta de error:", xhr.responseText);

                    let errorMessage = "Ocurrió un error en la solicitud.";
                    try 
                    {
                        let errorResponse = JSON.parse(xhr.responseText);
                        errorMessage = errorResponse.message || errorMessage;
                    } 
                    catch (e) 
                    {
                        console.error("Error al parsear la respuesta de error:", e);
                    }

                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: errorMessage,
                        confirmButtonText: 'Aceptar'
                    });
                }
            });
        }

        // Función para cambiar el estatus después de la validación exitosa
        function changeStatus(codigoGeneracion) 
        {
            var predefinedStatusId = 3; // Cambia esto al ID de estado que deseas

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
            $("#spinner-overlay").css("display", "flex");

            $.ajax({
                type: "POST",
                url: "Autorizacion_Camiones.aspx/ChangeTransactionStatus",
                data: JSON.stringify({ codeGen: codigoGeneracion, predefinedStatusId: predefinedStatusId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () 
                {
                    $("#spinner-overlay").show(); // 🔹 Mostrar el spinner antes de la petición
                },
                success: function (response) 
                {
                    console.log("Respuesta completa de la API:", response);

                    if (response.d && typeof response.d === "string") 
                    {
                        console.log("Estructura dentro de response.d:", response.d);

                        let detailsHTML = "<p>El estado se actualizó correctamente.</p>";

                        for (const key in response.d) 
                        {
                            if (response.d.hasOwnProperty(key)) 
                            {
                                let value = response.d[key];

                                // Si el valor es un objeto, lo convertimos en un JSON legible
                                if (typeof value === "string" && value !== null) 
                                {
                                    detailsHTML += `<p><strong>${key}:</strong> ${JSON.stringify(value, null, 2)}</p>`;
                                } 
                                else 
                                {
                                    detailsHTML += `<p><strong>${key}:</strong> ${value}</p>`;
                                }
                            }
                        }

                        Swal.fire({
                            icon: 'success',
                            title: '¡Actualización exitosa!',
                            text: 'El estado se actualizó correctamente.',
                            confirmButtonText: 'Aceptar'
                        }).then((result) => 
                        {
                            if (result.isConfirmed) 
                            {
                                location.reload();
                                $("#spinner-overlay").show();
                            }
                        });
                    } 
                    else 
                    {
                        console.error("La respuesta no es un objeto válido:", response.d);
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: typeof response.d === "string" ? response.d : 'Hubo un problema al procesar la solicitud.',
                            confirmButtonText: 'Aceptar'
                        });

                        $("#spinner-overlay").hide(); 
                    }
                },
                complete: function () 
                {
                    $("#spinner-overlay").hide(); // 🔹 Ocultar el spinner después de recibir la respuesta
                },
                error: function(xhr, status, error) 
                {
                    console.error("Error en la solicitud AJAX:", error);
                    try 
                    {
                        let errorResponse = JSON.parse(xhr.responseText);
                        let errorMessage = errorResponse.message || 'Ocurrió un problema al actualizar el estado.';
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: errorMessage,
                            confirmButtonText: 'Aceptar'
                        });
                    } 
                    catch (e) 
                    {
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

        document.getElementById('btnReportar').addEventListener('click', function() 
        {
            // Obtener el valor de codigoGeneracion desde el input
            var codigoGeneracion = document.getElementById('codigoGeneracionInput').value;

            // Asignar el valor al campo oculto en la modal
            document.getElementById('codigoGeneracionModal').value = codigoGeneracion;

            // Ocultar la modal anterior y mostrar la nueva
            $('#rutaModal').modal('hide');
            $('#modalReportar').modal('show');

            // Confirmar en consola
            console.log("Código de generación asignado a la modal:", codigoGeneracion);
        });


        // Al hacer clic en el botón "Cerrar" de modalReportar, cerramos modalReportar y mostramos rutaModal
        document.getElementById('btnCerrarModalReportar').addEventListener('click', function() 
        {
            // Cerrar modalReportar
            $('#modalReportar').modal('hide');
            // Abrir rutaModal
            $('#rutaModal').modal('show');
        });

        function guardarComentario() 
        {
            // Obtener los valores necesarios
            var comentario = document.getElementById('comentario').value.trim();
            var codigoGeneracion = document.getElementById('codigoGeneracionModal').value;

            // Validar si el comentario está vacío
            if (!comentario) 
            {
                Swal.fire({
                    icon: 'warning',
                    title: 'Comentario vacío',
                    text: 'Por favor, ingrese un comentario antes de guardar.',
                    confirmButtonText: 'Aceptar'
                });
                return; // Detener la ejecución
            }

            // Mostrar en consola para confirmar
            console.log("Comentario:", comentario);
            console.log("Código de generación:", codigoGeneracion);

            // Realizar la solicitud AJAX
            $.ajax({
                type: "POST",
                url: "Autorizacion_Camiones.aspx/GuardarComentario",
                data: JSON.stringify({ codigoGeneracion: codigoGeneracion, comentario: comentario }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) 
                {
                    // Analizar el JSON recibido
                    var responseData = response.d; // Asegúrate de adaptar según la estructura de tu backend
                    //console.log("Respuesta del servidor:", responseData);

                    if (responseData && responseData.success) 
                    {
                        Swal.fire({
                            icon: 'success',
                            title: 'Éxito',
                            text: 'El comentario fue procesado correctamente.',
                            confirmButtonText: 'Aceptar'
                        }).then(() => 
                        {
                            $('#modalReportar').modal('hide'); // Ocultar la modal
                            location.reload();
                        });
                    } 
                    else 
                    {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Hubo un problema al procesar el comentario. Inténtalo de nuevo.',
                            confirmButtonText: 'Aceptar'
                        });
                    }
                },
                error: function(error) 
                {
                    console.error("Error en la solicitud:", error);
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Ocurrió un error al guardar el comentario.',
                        confirmButtonText: 'Aceptar'
                    });
                }   
            });
        }
    </script>
</body>
</html>