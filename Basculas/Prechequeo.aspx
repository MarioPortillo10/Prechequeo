<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Prechequeo.aspx.cs" Inherits="Basculas_Prechequeo" %>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prechequeo - Almapac</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
</head>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.2/css/all.css" integrity="sha384-/rXc/GQVaYpyDdyxK+ecHPVYJSN9bmVFBvjA/9eOB+pb3F2w2N6fc5qB9Ew5yIns"  crossorigin="anonymous" />
    <!-- Tipo de letra -->
    <link href="https://fonts.cdnfonts.com/css/gilroy-bold" rel="stylesheet">
   
<style>
    body 
    {
        font-family: 'Poppins', sans-serif;
        background-color: #fff;
        display: flex;
        flex-direction: column;
        margin: 0;
        padding: 0;
        min-height: 100vh;
        overflow: hidden;
    }

    .main 
    {
        display: flex;
        align-items: flex-start;
        justify-content: space-between;
        padding: 40px;
        background-color: white;
        flex: 1;
        overflow: hidden;
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

    .truck-image-container 
    {
        display: flex;
        align-items: flex-start;
        flex: 0 0 auto;
        position: relative;
    }

    .truck-image 
    {
        width: 400px;
        height: 400px;
        border-radius: 50%;
        border: 5px solid white; /* Borde blanco */
        object-fit: cover;
        position: relative;
        z-index: 2; /* Asegura que la imagen esté frente al primer círculo pero detrás del segundo */
        top: 105px;  /* Ajuste fino de la posición */
        left: 50px; /* Ajuste fino de la posición */
    }

    /* Primer círculo gris */
    .truck-image-container::after 
    {
        content: "";
        position: absolute;
        width: 265px;  
        height: 265px;
        background-color: rgba(183, 183, 186, 0.6); 
        border-radius: 50%;
        top: 70px;  
        left: -20px; 
        z-index: 1; /* Asegura que este círculo esté detrás de la imagen */
    }

    /* Segundo círculo gris */
    .truck-image-container::before 
    {
        content: "";
        position: absolute;
        width: 175px; /* Tamaño del segundo círculo */
        height: 175px;
        background-color: rgba(183, 183, 186, 0.6); /* Color gris más transparente */
        border-radius: 50%;
        top: 335px; /* Ajusta la posición */
        left: 295px; /* Ajusta la posición */
        z-index: 3; /* Asegura que el segundo círculo quede frente a la imagen */
    }

    .text-section 
    {
        max-width: 500px;
        margin-left: -300px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        flex: 1;
        margin-top: 70px;
    }

    .text-section h2 
    {
        font-size: 5rem;
        color: #1E3A8A;
        font-weight: 700;
        margin: 0;
        margin-left: 60px;
        margin-bottom: 5px;
        margin-top: -15px;
        font-family: 'Gilroy-Bold', sans-serif;
    }

    .text-section h1 
    {
        font-size: 5rem;
        color: #FF5C00;
        font-weight: 700;
        margin-top: -35px;
        margin-bottom: 0;
        margin-left: 10px;
        font-family: 'Gilroy-Bold', sans-serif;
    }

    .text-section p 
    {
        font-size: 1.5rem;
        color: #6B7280;
        font-weight: 600;
        margin-left: 35px;
        font-family: 'Gilroy-Light', sans-serif;
    }

    .precheck-box 
    {
        margin-top: 10px;
        padding: 40px;
        background-color: #1E3A8A;
        border-radius: 10px;
        color: white;
        width: 100%;
        max-width: 400px;
        text-align: center;
    }

    .precheck-box p 
    {
        color: white;
        margin: 0;
        font-size: 1.2rem;
        margin-bottom: 10px;
        margin-top: -20px;
    }

    .precheck-input 
    {
        padding: 10px;
        width: 100%;
        border: none;
        border-radius: 5px;
        text-align: center;
        background-color: #E7E7E7;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        font-size: 1rem;
        margin-bottom: 10px;
        color: black;
    }

    .precheck-input:focus 
    {
        outline: none;
        box-shadow: 0 0 5px rgba(255, 92, 0, 0.5);
    }

    .precheck-button 
    {
        width: 100%;
        background-color: #FF5C00;
        color: white;
        padding: 10px;
        border-radius: 5px;
        border: none;
        font-weight: bold;
        text-align: center;
        display: inline-block;
    }

    .circle 
    {
        position: absolute;
        border-radius: 50%;
        background-color: rgba(0, 0, 0, 0.05);
        z-index: 1;
    }

    /* Estilo para la modal */
    .custom-modal 
    {
        max-width: 1200px;
        width: 900px;
        margin-top: -50px;
        margin-right: 65px !important;
    }

    .modal-content 
    {
        margin-right: 65px !important;
        background: none;
        border: none;
        width: 1000px;
    }

    .modal-dialog 
    {
        position: absolute;
        top: 5px; /* Distancia desde arriba */
        left: 175px; /* Distancia desde la izquierda */
        margin: 0; /* Elimina márgenes predeterminados */

    }

    /* Contenedor de la imagen dentro del formulario */
    .image-container 
    {
        position: relative;
        width: 100%;
        max-width: 1200px;
        height: 1075px; /* Altura ajustable */
        background-image: url('https://raw.githubusercontent.com/MarioPortillo10/Imagenes-ALMAPAC/refs/heads/main/tickets-_1_-_1_.webp');
        background-size: cover;
        background-repeat: no-repeat;
        background-position: bottom; /* Imagen alineada al bottom */
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: -300px; /* Espaciado entre formulario y imagen */
        margin-right: 100px;
    }

    /* Formulario dentro de la imagen */
    .form-overlay 
    {    
        width: 90%;
        max-width: 800px;
        background: none;
        border-radius: 10px;
        z-index: 7;
    }

    footer 
    {
        background-color: #242424;
        padding: 10px 0;
        text-align: center;
        font-size: 0.8rem;
        color: white;
        position: fixed;
        bottom: 0;
        width: 100%;
    }

    /* Estilo personalizado del cuadro */
    .swal2-container .swal2-popup 
    {
        background-color: #E7E7E7 !important;
        border-radius: 40px !important; /* Bordes menos redondeados */
        padding: 15px 10px; /* Menos espacio interno */
        width: 400px; /* Hacer el cuadro más pequeño */
        box-shadow: 0px 8px 10px rgba(0, 0, 0, 0.1) !important;
    }

    /* Contenedor del icono */
    .swal2-icon-custom 
    {
        position: relative;
        margin: 0 auto 10px;
        width: 45px; /* Icono más pequeño */
        height: 45px; /* Icono más pequeño */
    }

    /* Círculo con borde naranja */
    .swal2-icon-custom::before 
    {
        content: '';
        display: block;
        background-color: #E7E7E7;
        border: 3px solid #FD7304;
        border-radius: 50%;
        width: 45px; /* Ajuste del tamaño */
        height: 45px; /* Ajuste del tamaño */
        position: absolute;
        top: 0;
        left: 0;
    }

    /* La "X" en blanco */
    .swal2-icon-custom .swal2-x-mark 
    {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        display: flex;
        justify-content: center;
        align-items: center;
    }

    /* Las líneas de la "X" */
    .swal2-icon-custom .swal2-x-mark-line 
    {
        background-color: #FD7304;
        height: 4px; /* Líneas más delgadas */
        width: 20px; /* Líneas más cortas */
        position: absolute;
        border-radius: 2px;
    }

    .swal2-icon-custom .swal2-x-mark-line:nth-child(1) 
    {
        transform: rotate(45deg);
    }

    .swal2-icon-custom .swal2-x-mark-line:nth-child(2) 
    {
        transform: rotate(-45deg);
    }

    /* Estilo del título "ERROR" */
    .swal2-title 
    {
        font-size: 24px !important; /* Fuente más pequeña */
        font-weight: bold;
        color: #000000;
        letter-spacing: 25px; /* Menos espaciado entre letras */
        margin-top: -15px !important; /* Ajuste de margen */
        text-align: left;
        padding-left: 50px !important; /* Ajuste del texto */
        line-height: 2.2; /* Menos espacio entre líneas */
        font-family: 'Gilroy-Bold', sans-serif;
    }

    /* Línea divisoria (delgada) */
    .custom-divider 
    {
        width: 75%; /* Reducir tamaño de la línea */
        height: 2px;
        background-color: #182A6E;
        margin: 0 auto 10px; /* Menos espacio */
    }

    /* Estilo del texto de mensaje */
    .swal2-html-container 
    {
        font-size: 19px !important; /* Texto más pequeño */
        color: #000000;
        text-align: center;
        margin: 5px 0 15px;
        line-height: 2.5; /* Menos espacio entre líneas */
        font-family: 'Gilroy-Light', sans-serif;
    }

    /* Estilo del botón "OK" */
    .swal2-styled.swal2-confirm 
    {
        background-color: #ff7300 !important;
        color: white !important;
        border-radius: 20px; /* Botón más pequeño y redondeado */
        padding: 8px 20px; /* Menos padding */
        font-size: 16px !important; /* Texto más pequeño */
        margin-top: 5px; /* Menos espacio superior */
    }

    /* Estilo personalizado para el ancho y alto de la Sweet Alert */
    .custom-alert-wide-container .swal2-popup 
    {
        background-color: #FFFFFF !important;
        border-radius: 15px !important; /* Bordes redondeados */
        padding: 20px 15px; /* Ajusta el espacio interno */
        width: 600px !important; /* Ancho personalizado */
        max-width: 80%; /* Ancho máximo relativo a la ventana */
        box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.2) !important; /* Sombra personalizada */
        overflow: hidden; /* Ocultar contenido que desborde */
    }

    .custom-alert-wide-container .swal2-title 
    {
        font-size: 26px !important; /* Tamaño del título */
        color: #333333; /* Color del texto */
        text-align: center; /* Centrar el texto */
        margin: 0 !important; /* Quitar márgenes externos */
        padding: 0 !important; /* Quitar padding */
        line-height: 1.2 !important; /* Espaciado entre líneas ajustado */
        letter-spacing: normal !important; /* Eliminar separación entre letras */
    }

    .custom-alert-wide-container .swal2-html-container 
    {
        font-size: 16px !important; /* Tamaño del texto del mensaje */
        color: #555555; /* Color del texto */
        line-height: 1.5; /* Espaciado entre líneas */
        text-align: justify; /* Justificar el texto */
    }

    .custom-alert-wide-container .swal2-actions 
    {
        justify-content: center !important; /* Centrar los botones */
        gap: 20px; /* Espaciado moderado entre los botones */
        margin: 20px 0 0 !important; /* Espacio superior para separación del contenido */
    }

    .custom-alert-wide-container .swal2-styled.swal2-confirm 
    {
        background-color: #4CAF50 !important; /* Color del botón Aceptar */
        color: white !important;
        border-radius: 8px; /* Redondeo del botón */
        padding: 10px 15px; /* Ajustar tamaño del botón */
        font-size: 16px !important; /* Tamaño de fuente */
    }

    .custom-alert-wide-container .swal2-styled.swal2-cancel 
    {
        background-color: #F44336 !important; /* Color del botón Cancelar */
        color: white !important;
        border-radius: 8px; /* Redondeo del botón */
        padding: 10px 15px; /* Ajustar tamaño del botón */
        font-size: 16px !important; /* Tamaño de fuente */
    }

    /* Responsive styles */
    @media (max-width: 768px) 
    {
        .main 
        {
            flex-direction: column;
            align-items: center;
            padding: 20px;
        }

        .text-section 
        {
            margin-left: 0;
            text-align: center;
            padding: 0 20px;
        }

        .text-section h2, .text-section h1 
        {
            font-size: 2.5rem;
            margin-left: 0;
            margin-top: 0;
        }

        .text-section p 
        {
            font-size: 1rem;
        }

        .precheck-box 
        {
            width: 100%;
            max-width: 100%;
        }

        .truck-image-container 
        {
            left: 0;
            top: 0;
            margin-top: 0;
            justify-content: center;
        }

        .truck-image 
        {
            max-width: 90%;
        }
    }

    @media (max-width: 480px) 
    {
        .header 
        {
            padding: 10px 20px;
        }

        .login-button 
        {
            padding: 8px 16px;
            font-size: 0.9rem;
        }

        .text-section h2, .text-section h1 
        {
            font-size: 2rem;
        }

        .precheck-box 
        {
            padding: 20px;
            font-size: 0.9rem;
        }
    }
</style>


<body>
<form id="frm_Login" runat="server">
    <!-- Header -->
    <header class="header" style="background: linear-gradient(to right, #ffffff, #eaeaea);">
        <div class="logo">
            <img src="https://github.com/MarioPortillo10/Imagenes-ALMAPAC/blob/main/Imagenes/almapac.png?raw=true" alt="Almapac Logo">
        </div>
        <a href="login.aspx" class="login-button" style="text-decoration:none">
            <i class="fas fa-user"></i> Iniciar Sesión
        </a>
    </header>

    <!-- Main Section -->
    <main class="main">
        <!-- Truck Image -->
        <div class="truck-image-container">
            <img src="https://raw.githubusercontent.com/MarioPortillo10/Imagenes-ALMAPAC/refs/heads/main/DSC_0013-2-_2_.webp" alt="Truck Image" class="truck-image">
        </div>

        <!-- Text Section -->
        <div class="text-section">
            <p>Recuerda Siempre <strong>Realizar</strong></p>
            <h2>TU PRE</h2>
            <h1>CHEQUEO</h1>

            <!-- Precheck Form -->
            <div class="precheck-box">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <p>Prechequeo</p>
                        <asp:TextBox ID="txtTransaccion" CssClass="precheck-input" runat="server"
                                    placeholder="Número de prechequeo" required="required" />

                        <asp:HiddenField ID="dataFound" runat="server" Value="false" />
                        <br><br>

                        <input type="hidden" id="hfTransaccion" runat="server" />
                        <asp:UpdatePanel ID="UpdatePanelBuscar" runat="server">
                            <ContentTemplate>
                                <asp:LinkButton ID="lnkBuscar" CssClass="precheck-button" OnClick="lnkBuscar_Click"
                                                runat="server" Text="Verificar" OnClientClick="checkInput(); return true;"
                                                style="text-decoration:none" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </main>
    <!-- Modal de Validación -->
    <div class="modal fade bd-example-modal-lg" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <!-- Carousel for swipe effect -->
                <div id="carouselForms" class="carousel slide" data-bs-interval="false">
                    <div class="carousel-inner">
                        <!-- Primer Formulario Ticket -->
                        <div class="carousel-item active">
                            <div class="modal-header" style="background-color: transparent; border: none; display: flex; align-items: center;">
                                <div style="flex-grow: 1; text-align: center; margin-right: 350px;">
                                    <h5 class="modal-title" id="editPass2" style="font-size: 28px; font-weight: bold; margin-top: 10px;">VIAJE DISPONIBLE PRECHEQUEO</h5>
                                </div>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <div class="modal-body">
                                <asp:UpdatePanel ID="UpdatePanelModal1" runat="server">
                                    <ContentTemplate>
                                        <div class="image-container">
                                            <div class="form-overlay" style="display: flex; justify-content: flex-start; align-items: center; padding: 0; margin-left: 425px; margin-top: -215px; width: 100%; transform: translateX(-350px);">
                                                <div class="form-group" style="flex: 0 0 150px; text-align: left; margin-right: 0; padding: 0;">
                                                    <label for="txt_ingenio" style="font-size: 20px; display: block; margin-top: -5px;">
                                                        <strong>ORIGEN:</strong>
                                                    </label>
                                                    <h2 style="font-size: 16px; margin: 0;">
                                                        <asp:Literal ID="txt_ingenio" runat="server" Mode="PassThrough" />
                                                    </h2>
                                                </div>

                                                <!-- Tipo -->
                                                <div class="form-group1" style="flex: 0 0 auto; text-align: left; margin-left: 30px; padding: 0; display: flex; flex-direction: column; align-items: flex-start;">
                                                    <label for="tipoUnidad" style="font-size: 20px; display: block; margin-bottom: 10px;">
                                                        <strong>TIPO:</strong>
                                                    </label>
                                                
                                                    <!-- Contenedor de imágenes y checkboxes en fila -->
                                                    <div id="tipoUnidad" style="display: flex; flex-direction: row; align-items: center; gap: 15px;">
                                                        <!-- Imagen de camión ícono (PLANA) -->
                                                        <div id="imgPlanaContainer" runat="server" style="display: none;">
                                                            <img src="https://github.com/MarioPortillo10/Imagenes-ALMAPAC/blob/main/Imagenes/camion%20icono.png?raw=true" 
                                                                alt="Camión Ícono" 
                                                                style="width: 45px; height: auto; margin-top: -75px; margin-left: 60px; filter: sepia(1) saturate(5) hue-rotate(200deg);">
                                                        </div>
                                                        <!-- Imagen de camión de volteo -->
                                                        <div id="imgVolteoContainer" runat="server" style="display: none;">
                                                            <img src="https://github.com/MarioPortillo10/Imagenes-ALMAPAC/blob/main/Imagenes/camion%20de%20volteo.png?raw=true" 
                                                                alt="Camión de Volteo" 
                                                                style="width: 40px; height: 20px; transform: scaleX(-1); margin-top: -65px; margin-left: 65px;">
                                                        </div>

                                                        <!-- Contenedor de checkboxes -->
                                                        <div style="display: flex; flex-direction: column; align-items: flex-start; margin-left: -125px;">
                                                            <!-- Checkbox para PLANA -->
                                                            <div class="form-check" style="margin-bottom: 5px;">
                                                                <input type="checkbox" id="chkPlana" runat="server" class="form-check-input" disabled 
                                                                    style="font-size: 16px; margin-left: -15px;"/>
                                                                <label for="chkPlana" class="form-check-label" style="font-size: 16px; margin-left: 5px;">PLANA</label>
                                                            </div>
                                                            <!-- Checkbox para VOLTEO -->
                                                            <div class="form-check">
                                                                <input type="checkbox" id="chkVolteo" runat="server" class="form-check-input" disabled 
                                                                    style="font-size: 16px; margin-left: -15px;"/>
                                                                <label for="chkVolteo" class="form-check-label" style="font-size: 16px; margin-left: 5px; margin-bottom: 5px;">VOLTEO</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Destino -->
                                                <div class="form-group" style="flex: 1.3; text-align: left; margin-left: 100px; padding: 0; margin-top: -15px; width: 100%; max-width: none;">
                                                    <label for="txt_ingenio" style="font-size: 20px; display: block; margin-bottom: 5px;">
                                                        <strong>DESTINO:</strong>
                                                    </label>
                                                    <img src="https://github.com/MarioPortillo10/Imagenes-ALMAPAC/blob/main/Imagenes/almapac.png?raw=true" 
                                                        style="height: 30px; width: 135px; max-width: none;">
                                                </div>
                                            </div>

                                            <div class="container fecha-prechequeo-container" style="position: fixed; top: 325px; left: 50px; z-index: 1000;">
                                                <div class="form-row" style="align-items: flex-start; margin-right: 50px;">
                                                    <!-- Fecha -->
                                                    <div class="form-group fecha-prechequeo" style="flex: 0.4; margin-right: 25px;">
                                                        <label for="txtFecha" style="font-size: 14px; margin-bottom: 5px; margin-top: 18px; margin-left: 35px; display: block; width: 160px;">
                                                            <strong>FECHA PRECHEQUEO:</strong>
                                                        </label>
                                                        <p style="font-size: 14px; margin: 0; margin-top: -5px; margin-left: 35px;">
                                                            <asp:Literal ID="txtFecha" runat="server" Mode="PassThrough" />
                                                        </p>
                                                    </div>
                                                    <!-- Transportista -->
                                                    <div class="form-group transporte" style="flex: 0 0 300px; margin-top: 15px;">
                                                        <label for="txt_transporte" style="font-size: 14px; margin-bottom: 5px; margin-left: -55px;">
                                                            <strong>EMPRESA DE TRANSPORTE:</strong>
                                                        </label>
                                                        <p style="font-size: 14px; margin: 0; margin-top: -5px; flex: 1; width: 300px; margin-left: -55px;">
                                                            <asp:Literal ID="txt_transporte" runat="server" Mode="PassThrough" />
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>

                                    <!-- Fila para Hora, Placa Camión y Placa Remolque -->
                                    <div class="container" style="position: relative;">
                                        <div class="form-row-container" style="position: absolute; top: 100px; right: 460px; display: flex; justify-content: flex-start; margin-bottom: 15px;">
                                            <!-- Hora -->
                                            <div class="form-group" style="flex: 0.4; margin-top: -2px; margin-left: 90px;"> <!-- Reducido el margen derecho -->
                                                <label for="txtHora" style="font-size: 14px; margin-bottom: 0px; width: 150px;">
                                                    <strong>HORA PRECHEQUEO:</strong>
                                                </label>
                                                <div style="width: 120px; font-size: 14px"> <!-- Ajusta el ancho según lo necesites -->
                                                    <asp:Literal ID="txtHora" runat="server" Mode="PassThrough" />
                                                </div>
                                            </div>

                                            <!-- Cabezal -->
                                            <div class="form-group" style="flex: 2; margin-left: 25px;"> <!-- Reducido el margen derecho -->
                                                <label for="txt_placaCamion" style="font-size: 14px; margin-bottom: 0px; display: block;">
                                                    <strong>CABEZAL:</strong>
                                                </label>
                                                <p style="font-size: 14px; width: 20px; margin: 0;">
                                                    <asp:Literal ID="txt_placaCamion" runat="server" Mode="PassThrough" />
                                                </p>
                                            </div>

                                            <!-- Remolque -->
                                            <div class="form-group" style="flex: 1; margin-left: 105px;"> <!-- Sin margen derecho para acercar más -->
                                                <label for="txt_placaRemolque" style="font-size: 14px; margin-bottom: 0px; display: block;">
                                                    <strong>REMOLQUE:</strong>
                                                </label>
                                                <p style="font-size: 14px; width: 80px; margin: 0;">
                                                    <asp:Literal ID="txt_placaRemolque" runat="server" Mode="PassThrough" />
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div> 
                            </div>    
                        </ContentTemplate>
                    </asp:UpdatePanel>   
                    <div class="modal-footer" style="border: none; box-shadow: none; position: relative; top: -735px; left: 320px; display: flex; flex-direction: column; align-items: center; background-color: transparent;">
                        <div style="display: flex; align-items: center; margin-bottom: 70px; margin-left: 25px;">
                            <img src="https://github.com/MarioPortillo10/Imagenes-ALMAPAC/blob/main/Imagenes/camion%20icono.png?raw=true" alt="Camión Ícono" style="width: 55px; height: auto; filter: brightness(0) invert(1); margin-right: 15px;">
                            <h5 style="font-size: 28px; font-weight: bold; color: white; margin-right: 10px;">PRECHEQUEO</h5>
                        </div>

                        <!-- Texto "CONTINUAR" -->
                        <p style="font-size: 36px; font-weight: bold; color: white; margin-bottom: -10px; margin-left: 44px;">CONTINUAR</p>

                        <!-- Texto "PRECHEQUEO" en la parte inferior -->
                        <p style="font-size: 38px; color: white; margin-bottom: 75px; margin-left: 47px;">PRECHEQUEO</p>

                        <!-- Botón -->
                        <button type="button" class="btn btn-primary" id="nextBtn">REALIZÓ PRECHEQUEO</button>
                    </div>
                </div>
            

                <!-- Segundo Formulario (Captura de Fotografía) -->
                <div class="carousel-item" style="max-width: 500px; margin: 0 auto; overflow: hidden;">
                    <!-- Modal Header -->
                    <div class="modal-header" style="background-color: transparent !important; flex-shrink: 0; display: flex; justify-content: center; align-items: center; padding: 0.5rem; border: none; border-radius: 8px 8px 0 0; width: 100%; height: 40px; position: relative;">
                        <h5 class="modal-title" style="margin: 0; font-size: 1.2rem; font-weight: bold; color: #2c3e50; text-align: center;">
                            <span style="position: absolute; top: 10%; left: 50%; transform: translateX(-50%); z-index: 1055; padding: 0.3rem 0.8rem; background-color: #002073; color: #fff; border-radius: 20px; font-size: 1rem; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); text-align: center;">
                                Captura de Fotografía
                            </span>
                        </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeModal()" style="position: absolute; right: 10px; top: 10px; background: none; border: none; font-size: 1.3rem; color: #7f8c8d; cursor: pointer; transition: color 0.3s;">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body" style="background-color: #f9f9f9; border-radius: 30px; flex-grow: 1; width: 100%; margin: auto; display: flex; flex-direction: column; justify-content: flex-start; padding: 0.5rem; transform: translateY(-5%);">    
                        <div class="p-4">
                            <div class="flex justify-center mb-4">
                                <div class="w-280 h-210 overflow-hidden border-2 border-gray-300" style="width: 280px; height: 210px;">
                                    <video id="camera" width="280" height="210"></video>
                                    <canvas id="canvas" width="280" height="210"></canvas>
                                    <img id="capturedPhoto" src="" alt="Captured Photo" style="width: 100%; height: 100%; display: none;" />
                                </div>
                            </div>

                            <!-- License and Motorista Section -->
                            <asp:UpdatePanel ID="UpdatePanelModal2" runat="server">
                                <ContentTemplate>
                                    <div style="display: flex; justify-content: center; align-items: center; width: 100%; text-align: center; margin-top: -1rem; margin-bottom: 1rem;">
                                        <!-- License and Motorista Section -->
                                        <asp:Literal ID="txt_licencia" runat="server" Mode="PassThrough" />
                                        <br />
                                        <asp:Literal ID="txt_motorista" runat="server" Mode="PassThrough" />
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                                    <div class="flex justify-center mt-2" style="position: relative; display: flex; align-items: center; justify-content: center;">
                                        <span style="position: absolute; left: 0; right: auto; height: 2.5px; width: 33%; background-color: #00166E; top: 50%; transform: translateY(-45%);"></span>
                                        <button type="button" id="takePhoto" class="px-3 py-1.5 bg-orange-500 text-white font-bold rounded shadow hover:bg-orange-600">
                                            <img src="https://raw.githubusercontent.com/MarioPortillo10/Imagenes-ALMAPAC/deca1fc768771fa51f12c44c2102f294c43a15c4/Imagenes/photo-camera-svgrepo-com.svg" alt="Camera Icon" style="width: 1.2em; height: 1.2em; filter: invert(1); display: inline-block; vertical-align: middle;" aria-hidden="true" /> Capturar
                                        </button>
                                        <span style="position: absolute; right: 0; left: auto; height: 2.5px; width: 33%; background-color: #00166E; top: 50%; transform: translateY(-50%); border: 2px;"></span>
                                    </div>

                                    <!-- Contenedor para botones alineados a la derecha -->
                                    <div class="flex justify-end mt-6" style="display: flex; justify-content: flex-end; gap: 1rem; padding-right: 1rem; margin-top: 2rem;">
                                        <button type="button" class="btn" id="backBtn" style="width: 25%; height: 2rem; background-color: #888281; color: white; border-radius: 15px; font-size: 0.9rem;">
                                            <strong> <i class="fa fa-arrow-left" aria-hidden="true"></i> Volver</strong>
                                        </button>
                                        <button type="button" class="btn" id="changeStatusButton" onclick="changeStatus()" style="width: 25%; height: 2rem; background-color: #002174; color: white; border-radius: 15px; font-size: 0.9rem;">
                                            <strong>Continuar</strong>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        © 2025 Almacenadora del Pacífico S.A. de C.V. - Todos los derechos reservados
    </footer>
</form>

   <!-- Scripts necesarios de Bootstrap y jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<!-- SweetAlert2 (latest version) -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.all.min.js"></script>

<!-- Custom Scripts -->
<script src="../src/js/spotlight.bundle.js"></script>

<!-- LightGallery and Plugins -->
<script src="https://cdn.rawgit.com/sachinchoolur/lightgallery.js/master/dist/js/lightgallery.js"></script>
<script src="https://cdn.rawgit.com/sachinchoolur/lg-pager.js/master/dist/lg-pager.js"></script>
<script src="https://cdn.rawgit.com/sachinchoolur/lg-autoplay.js/master/dist/lg-autoplay.js"></script>
<script src="https://cdn.rawgit.com/sachinchoolur/lg-fullscreen.js/master/dist/lg-fullscreen.js"></script>
<script src="https://cdn.rawgit.com/sachinchoolur/lg-zoom.js/master/dist/lg-zoom.js"></script>
<script src="https://cdn.rawgit.com/sachinchoolur/lg-hash.js/master/dist/lg-hash.js"></script>
<script src="https://cdn.rawgit.com/sachinchoolur/lg-share.js/master/dist/lg-share.js"></script>

<script>
    $(document).ready(function () {
        // Detectar cuando se cambia el valor del input
        $('#<%= txtTransaccion.ClientID %>').on('input', function () {
            var valor = $(this).val();
            // Reemplazar ' por -
            valor = valor.replace(/'/g, '-');
            // Establecer el nuevo valor en el input
            $(this).val(valor);
        });
    });

    document.addEventListener('DOMContentLoaded', function () {
        const inputTransaccion = document.querySelector('.precheck-input');
        const verifyButton = document.getElementById('<%= lnkBuscar.ClientID %>');

        // Asegurar que el input tenga el foco al cargar la página
        inputTransaccion.focus();

        // Detectar pérdida de enfoque del input y activar el botón Verificar si el input no está vacío
        inputTransaccion.addEventListener('blur', function () {
            if (inputTransaccion.value.trim() !== '') {
                console.log('Input perdió el foco. Disparando verificación.');
                verifyButton.click();
            } else {
                console.log('Input vacío, no se ejecuta verificación.');
            }
        });

        // Volver a dar foco al input cuando pierda el foco
        document.getElementById('editModal').addEventListener('hidden.bs.modal', function () {
            setTimeout(() => inputTransaccion.focus(), 0); // Evitar conflicto con otros eventos
        });
    });

    document.addEventListener('DOMContentLoaded', function () 
    {
        var carouselElement = document.getElementById('carouselForms');
        var carousel = new bootstrap.Carousel(carouselElement, {
            interval: false
        });

        const video = document.getElementById('camera');
        const canvas = document.getElementById('canvas');
        const capturedPhoto = document.getElementById('capturedPhoto');
        const takePhotoButton = document.getElementById('takePhoto');
        let stream;

        // Configurar acceso a la cámara
        function startCamera() 
        {
            navigator.mediaDevices.getUserMedia({ video: true, audio: false })
            .then(cameraStream => 
            {
                stream = cameraStream;
                video.srcObject = stream;
                video.play();
            })
            .catch(error => 
            {
                console.error('Error al acceder a la cámara:', error);
            });
        }

        function stopCamera() 
        {
            if (stream) 
            {
                stream.getTracks().forEach(track => track.stop());
                video.srcObject = null;
                stream = null;
                console.log('Cámara detenida y liberada');
            }
        }

        // Configurar la funcionalidad de captura de foto
        takePhotoButton.addEventListener('click', (event) => 
        {
            const ctx = canvas.getContext('2d');
            ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
            event.preventDefault();

            const photo = canvas.toDataURL('image/jpeg');
            if (photo === 'data:,') 
            {
                Swal.fire({
                    title: 'Error',
                    text: 'Por favor, capture una foto antes de cambiar el estado.',
                    icon: 'error',
                    confirmButtonColor: '#3085d6',
                    confirmButtonText: 'Aceptar'
                });
                return;
            }

            capturedPhoto.src = photo;
            capturedPhoto.style.display = 'block';
            canvas.style.display = 'none';
            video.style.display = 'none';
        });

        // Resetear el estado de la cámara y limpiar foto
        function resetCameraState() 
        {
            console.log('Resetting camera state');
            stopCamera(); // Detener la cámara completamente
            capturedPhoto.style.display = 'none';
            capturedPhoto.src = '';
            canvas.style.display = 'none';
            video.style.display = 'block';

            // Volver a iniciar la cámara si la modal está abierta
            startCamera();
        }

        // Aplicar el reseteo al abrir la modal
        $('#editModal').on('show.bs.modal', function () 
        {
            console.log('Modal is being shown');
            resetCameraState();
        });

        // Detener la cámara al cerrar la modal
        $('#editModal').on('hidden.bs.modal', function () 
        {
            console.log('Modal is being hidden');
            stopCamera();
        });

        // Resetear la cámara y la foto al cambiar de slide en el carrusel
        carouselElement.addEventListener('slid.bs.carousel', function () 
        {
            console.log('Slide changed');
            resetCameraState();
        });

        document.getElementById('nextBtn').addEventListener('click', function () 
        {
            console.log('Next button clicked');
            Swal.fire({
                title: 'Aviso Importante',
                html: `
                    <div style="white-space: pre-line; margin-top: -20px">
                        Asegúrese de revisar cuidadosamente todos los detalles antes de continuar, ya que cualquier discrepancia o error en la información puede resultar en demoras o rechazos en el proceso.

                        Al hacer clic en Aceptar, usted autoriza y valida que los datos ingresados son correctos y completos.

                        En caso de error, seleccione “Cancelar” y comuníquese con el ingenio para actualizar la información con ALMAPAC.
                    </div>
                `,
                icon: 'warning',
                showCancelButton: true,
                cancelButtonText: 'Cancelar',
                confirmButtonText: 'Aceptar',
                customClass: 
                {
                    popup: 'custom-alert-wide-container',
                    confirmButton: 'btn btn-success',
                    cancelButton: 'btn btn-danger'
                },
                buttonsStyling: false
            }).then((result) => 
            {
                if (result.isConfirmed) 
                {
                    console.log('Confirm button pressed');
                    // Reiniciar la cámara después de presionar el botón de confirmación
                    resetCameraState();
                    carousel.next();
                } 
                else if (result.isDismissed) 
                {
                    console.log('Cancel button pressed');
                    // Recargar la página cuando se presione "Cancelar"
                    location.reload();
                }
            });
        });

        document.getElementById('backBtn').addEventListener('click', function () 
        {
            console.log('Back button clicked');
            carousel.prev();
        });

        document.querySelectorAll('[data-bs-dismiss="modal"]').forEach(function (element) 
        {
            element.addEventListener('click', function () {
                console.log('Modal dismiss button clicked');
                var modal = bootstrap.Modal.getInstance(document.getElementById('editModal'));
                modal.hide();
            });
        });
    });

    // Detectar cuando se presiona la tecla Esc
    document.addEventListener('keydown', function(event) 
    {
        if (event.key === 'Escape') 
        {
            // Cerrar el modal (si está abierto)
            $('#editModal').modal('hide');

            // Recargar la página
            location.reload();
        }
    });

    // Detectar el cierre del modal (cuando se cierra de otra manera, por ejemplo, con el botón de cerrar)
    $('#editModal').on('hidden.bs.modal', function () 
    {
        // Recargar la página cuando se cierra el modal
        location.reload();
    });


    // Función para cambiar el estado
    function changeStatus() 
    {
        const txtTransaccion = document.getElementById('txtTransaccion').value.trim();
        const canvas = document.getElementById('canvas');
        const context = canvas.getContext('2d');
        const photo = canvas.toDataURL('image/jpeg'); // Obtén la imagen como base64

        // Verificar si el código de transacción está vacío
        if (txtTransaccion === '') 
        {
            Swal.fire({
                title: 'Error',
                text: 'Por favor, Ingrese un Código de Generación',
                icon: 'error',
                confirmButtonColor: '#3085d6',
                confirmButtonText: 'Aceptar'
            });
            return false;
        }

        // Verificar si la foto ha sido tomada
        const isCanvasEmpty = !context.getImageData(0, 0, canvas.width, canvas.height).data.some(channel => channel !== 0);

        if (isCanvasEmpty) 
        {
            Swal.fire({
                title: 'Error',
                text: 'Por favor, capture una foto antes de cambiar el estado.',
                icon: 'error',
                confirmButtonColor: '#3085d6',
                confirmButtonText: 'Aceptar'
            });
            return false; // No permite continuar si no hay foto
        }

        const predefinedStatusId = 2; // Cambia esto al ID de estado que deseas

        // Realizar el cambio de estado primero
        $.ajax({
            type: "POST",
            url: "Prechequeo.aspx/ChangeTransactionStatus",
            data: JSON.stringify({
                codeGen: txtTransaccion,
                predefinedStatusId: predefinedStatusId,
                imageData: photo
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) 
            {
                const message = response.d;

                if (message === "Error: No se puede cambiar el estado sin haber subido una foto.") 
                {
                    Swal.fire({
                        title: 'Advertencia',
                        text: message,
                        icon: 'warning',
                        confirmButtonColor: '#3085d6',
                        confirmButtonText: 'Aceptar'
                    });
                } 
                else if (message === "Cambio de estatus realizado con éxito") 
                {
                    $.ajax({
                        url: 'Prechequeo.aspx/UploadPhoto',
                        type: 'POST',
                        contentType: 'application/json; charset=utf-8',
                        data: JSON.stringify({ 
                            imageData: photo, 
                            codeGen: txtTransaccion 
                        }),
                        success: function (response) {
                            if (response.d === 'success') {
                                Swal.fire({
                                    title: 'Éxito',
                                    text: 'Prechequeo realizado, por favor presente sus documentos en ventanilla para ser validados',
                                    icon: 'success',
                                    confirmButtonColor: '#3085d6',
                                    confirmButtonText: 'Aceptar'
                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        location.reload();
                                    }
                                });
                            } else {
                                Swal.fire('Error', response.d || 'No se pudo subir la imagen al servidor', 'error');
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('Error al subir la imagen:', error);
                            let serverResponse = xhr.responseText ? JSON.parse(xhr.responseText) : { message: 'No se recibió respuesta del servidor.' };
                            let errorMessage = serverResponse.message || 'No se pudo conectar con el servidor para subir la imagen';
                            Swal.fire('Error', errorMessage, 'error');
                        }
                    });

                } 
                else 
                {
                    Swal.fire({
                        title: 'Error',
                        text: message || 'Hubo un problema al realizar el cambio de estatus.',
                        icon: 'error',
                        confirmButtonColor: '#3085d6',
                        confirmButtonText: 'Aceptar'
                    });
                }
            },
            error: function(xhr, status, error) 
            {
                console.error("Error cambiando el estado: ", error);
                let serverResponse = xhr.responseText ? JSON.parse(xhr.responseText) : { message: 'No se recibió respuesta del servidor.' };
                let errorMessage = serverResponse.message || 'Hubo un error al cambiar el estado.';
                Swal.fire('Error', errorMessage, 'error');
            }
        });

        return false; // Prevenir cualquier comportamiento por defecto
    }

    function closeModal()
    {
        // Recarga la página cuando el usuario presione Cerrar
        location.reload();
    }

    function checkInput() 
    {
        var txtTransaccion = document.getElementById('txtTransaccion').value.trim();
            
        if (txtTransaccion === '') 
        {
            // Mostrar la alerta al cargar la página
            Swal.fire({
                html: `
                    <div class="swal2-icon-custom">
                        <div class="swal2-x-mark">
                            <div class="swal2-x-mark-line"></div>
                            <div class="swal2-x-mark-line"></div>
                        </div>
                    </div>
                    <div class="swal2-title">ERROR</div>
                    <div class="custom-divider"></div>
                    El código de generación ingresado no existe.
                `,
                confirmButtonText: 'OK',
                customClass: {
                    popup: 'swal2-popup',
                    confirmButton: 'swal2-styled swal2-confirm'
                },
                showConfirmButton: true
            }).then((result) => 
            {
                // Verificar si se hizo clic en "OK" para limpiar el campo
                if (result.isConfirmed) 
                {
                    // Limpiar el valor del input
                    document.getElementById('txtTransaccion').value = ''; // Asegúrate de que el ID sea correcto
                }
            }).catch((error) => 
            {
                console.error('Error en SweetAlert2:', error);
            });

            return false;
        }

        var dataFound = document.getElementById('dataFound').value;

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () 
        {
            if (dataFound === 'true') 
            { 
                $('#editModal').modal('show');
            }
        });
        
        return true;
    }
</script>
</body>
</html>