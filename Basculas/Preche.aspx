<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Prechequeo.aspx.cs" Inherits="Basculas_Prechequeo" %>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
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
        background-color: #f3f3f3;
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
        min-height: 200px;
        margin-top: -120px;
        position: relative;
        top: -80px;
        left: -150px;
    }

    .truck-image 
    {
        max-width: 1000px;
        height: auto;
        max-height: 100%;
        align-self: flex-start;
        margin-top: 0;
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
        padding: 10px; /* Espaciado interno */
        width: 100%; /* Ancho completo */
        border: none; /* Sin borde */
        border-radius: 5px; /* Bordes redondeados */
        text-align: center; /* Texto centrado */
        background-color: #E7E7E7; /* Color de fondo blanco */
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Sombra sutil */
        font-size: 1rem; /* Tamaño de fuente */
        margin-bottom: 10px; /* Espacio inferior */
        color: black;
    }

    /* Estilo adicional para el enfoque */
    .precheck-input:focus 
    {
        outline: none; /* Sin contorno */
        box-shadow: 0 0 5px rgba(255, 92, 0, 0.5); /* Sombra al enfocar */
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
        text-align: center; /* Asegúrate de que el texto esté centrado */
        display: inline-block; /* Para que el botón se comporte como un botón */
    }

    .circle {
        position: absolute;
        border-radius: 50%;
        background-color: rgba(0, 0, 0, 0.05);
        z-index: 1;
    }

    footer {
        background-color: #242424;
        padding: 10px 0;
        text-align: center;
        font-size: 0.8rem;
        color: white;
        position: fixed;
        bottom: 0;
        width: 100%;
    }

    /* Responsive styles */
    @media (max-width: 768px) 
    {
        .main {
            flex-direction: column;
            align-items: center;
            padding: 20px;
        }

        .text-section {
            margin-left: 0;
            text-align: center;
            padding: 0 20px;
        }

        .text-section h2, .text-section h1 {
            font-size: 2.5rem;
            margin-left: 0;
            margin-top: 0;
        }

        .text-section p {
            font-size: 1rem;
        }

        .precheck-box {
            width: 100%;
            max-width: 100%;
        }

        .truck-image-container {
            left: 0;
            top: 0;
            margin-top: 0;
            justify-content: center;
        }

        .truck-image {
            max-width: 90%;
        }
    }

    @media (max-width: 480px) {
        .header {
            padding: 10px 20px;
        }

        .login-button {
            padding: 8px 16px;
            font-size: 0.9rem;
        }

        .text-section h2, .text-section h1 {
            font-size: 2rem;
        }

        .precheck-box {
            padding: 20px;
            font-size: 0.9rem;
        }
    }
</style>



<body>
<form id="form1" runat="server">
    <!-- Header -->
    <header class="header" style="background: linear-gradient(to right, #ffffff, #eaeaea);">
        <div class="logo">
            <img src="https://github.com/MarioPortillo10/Imagenes-ALMAPAC/blob/main/Imagenes/almapac.png?raw=true" alt="Almapac Logo">
        </div>
        <a href="login.aspx" class="login-button">
            <i class="fas fa-user"></i> Iniciar Sesión
        </a>
    </header>

    <!-- Main Section -->
    <main class="main">
        <!-- Truck Image -->
        <div class="truck-image-container">
            <img src="https://raw.githubusercontent.com/MarioPortillo10/Imagenes-ALMAPAC/main/Imagenes/imagen%20camionero.png" alt="Truck Image" class="truck-image">
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
                        <asp:TextBox ID="txtTransaccion" CssClass="precheck-input" runat="server" placeholder="Número de prechequeo" required="required" />

                        <asp:HiddenField ID="dataFound" runat="server" Value="false" />
                        <br><br>
                        
                        <input type="hidden" id="hfTransaccion" runat="server" />
                        <asp:UpdatePanel ID="UpdatePanelBuscar" runat="server">
                            <ContentTemplate>
                                <asp:LinkButton ID="lnkBuscar" CssClass="precheck-button" OnClick="lnkBuscar_Click" runat="server" Text="Verificar" OnClientClick="checkInput(); return true;" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </main>
    <div class="modal fade bd-example-modal-lg" id="editModal" tabindex="-1" role="dialog"
                aria-labelledby="editModalLabel" aria-hidden="true" data-backdrop="static">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div id="carouselForms" class="carousel slide" data-bs-interval="false">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Validacion de Prechequeo</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeModal();">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                            <ContentTemplate>
                                                <form>
                                                    <div class="form-group">
                                                        <label for="txt_ingenio">Ingenio</label>
                                                        <asp:TextBox ID="txt_ingenio" CssClass="form-control"
                                                            runat="server" Enabled="false"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for=" txt_producto">Producto</label>
                                                        <asp:TextBox ID="txt_producto" CssClass="form-control"
                                                            runat="server" Enabled="false"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="txt_transporte">Transporte</label>
                                                        <asp:TextBox ID="txt_transporte" CssClass="form-control"
                                                            runat="server" Enabled="false"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="txt_motorista">Motorista</label>
                                                        <asp:TextBox ID="txt_motorista" CssClass="form-control"
                                                            runat="server" Enabled="false"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="txt_licencia">Licencia</label>
                                                        <asp:TextBox ID="txt_licencia" CssClass="form-control"
                                                            runat="server" Enabled="false"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="txt_placaCamion">Placa Camion</label>
                                                        <asp:TextBox ID="txt_placaCamion" CssClass="form-control"
                                                            runat="server" Enabled="false"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="txt_placaRemolque">Placa Remolque</label>
                                                        <asp:TextBox ID="txt_placaRemolque" CssClass="form-control"
                                                            runat="server" Enabled="false"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="txt_tipoUnidad">Tipo Unidad</label>
                                                        <asp:TextBox ID="txt_tipoUnidad" CssClass="form-control"
                                                            runat="server" Enabled="false"></asp:TextBox>
                                                    </div>
                                                </form>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-primary" id="nextBtn">Siguiente</button>
                                    </div>
                                </div>

                                <div class="carousel-item">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Captura de Fotografia</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeModal()">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <form>
                                            <div class="form-group">
                                                <label for="exampleFormControlFile1">Fotografia</label>
                                            </div>
                                            <div class="form-group">
                                                <video id="camera" width="320" height="240"></video>
                                                <canvas id="canvas" width="320" height="240"></canvas>
                                            </div>
                                            <div class="form-group">
                                                <button type="button" id="takePhoto" class="btn btn-dark">
                                                    <i class="fa fa-camera" aria-hidden="true"></i> Capturar
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" id="backBtn">Volver</button>
                                        <button type="button" class="btn btn-primary" id="confirmBtn" onclick="changeStatus()">Confirmar</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

    <!-- Footer -->
    <footer>
        © 2024 Almacenes del Pacífico - Todos los derechos reservados
    </footer>
</form>

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

    <!-- Código para mostrar el modal -->

        <script>
              
            // Inicializar el carrusel y otros elementos cuando el DOM esté listo
            document.addEventListener('DOMContentLoaded', function () {
                // Inicializar el carrusel
                var carouselElement = document.getElementById('carouselForms');
                var carousel = new bootstrap.Carousel(carouselElement, {
                    interval: false // Asegúrate de que el intervalo esté desactivado
                });

                // Mover al siguiente formulario
                document.getElementById('nextBtn').addEventListener('click', function () {
                    carousel.next(); // Mueve al siguiente formulario (slide)
                });

                // Volver al formulario anterior
                document.getElementById('backBtn').addEventListener('click', function () {
                    carousel.prev(); // Mueve al formulario anterior (slide)
                });

                // Restablecer el carrusel al primer slide al cerrar la modal
                $('#editModal').on('hidden.bs.modal', function () {
                    carousel.to(0); // Mueve el carrusel al primer slide
                });
                
                // Cerrar la modal al hacer clic en el botón de cierre
                document.querySelectorAll('[data-bs-dismiss="modal"]').forEach(function (element) {
                    element.addEventListener('click', function () {
                        var modal = bootstrap.Modal.getInstance(document.getElementById('editModal'));
                        modal.hide();
                    });
                });

                // Inicializar lightGallery
                lightGallery(document.getElementById('lightgallery'));

                // Obtener elementos de video y canvas
                const video = document.getElementById('camera');
                const canvas = document.getElementById('canvas');
                const takePhotoButton = document.getElementById('takePhoto');

                // Configurar acceso a la cámara
                navigator.mediaDevices.getUserMedia({ video: true, audio: false })
                    .then(stream => {
                        // Establecer la fuente del video en la transmisión de la cámara
                        video.srcObject = stream;
                        video.play();

                        // Tomar una foto cuando el usuario haga clic en el botón
                        takePhotoButton.addEventListener('click', () => {
                            // Dibujar el fotograma del video en el canvas
                            canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);
                            event.preventDefault();
                            // Obtener la foto como una cadena codificada en base64
                            const photo = canvas.toDataURL('image/jpeg');
                            var codeGen = document.getElementById('txtTransaccion').value.trim();
                            console.log("este es code gen: ", codeGen);

                            // Enviar la imagen al servidor con AJAX
                            fetch('Prechequeo.aspx/UploadPhoto', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                                body: JSON.stringify({ imageData: photo, codeGen: codeGen })
                            })
                                .then(response => response.json())
                                .then(result => 
                                {
                                    // Mostrar SweetAlert basado en la respuesta
                                    console.log("este es el result", result);
                                    if (result.d === 'success') 
                                    {
                                        //Swal.fire('Éxito', 'Imagen enviada correctamente', 'success');
                                    } 
                                    else 
                                    {
                                        //Swal.fire('Error', 'Hubo un problema al enviar la imagen', 'error');
                                    }
                                })
                                .catch(error => {
                                    console.error('Error al enviar la imagen:', error);
                                    Swal.fire('Error', 'No se pudo conectar con el servidor', 'error');
                                });
                        });
                    })
                    .catch(error => {
                        console.error('Error accessing camera:', error);
                    });
            });

            document.addEventListener("DOMContentLoaded", function () 
            {
                const txtTransaccion = document.getElementById("<%= txtTransaccion.ClientID %>");

                // Colocar el cursor en el `input` al cargar la página
                txtTransaccion.focus();

                // Mantener el cursor en el `input` después de cada ingreso
                txtTransaccion.addEventListener("blur", function () {
                    txtTransaccion.focus();
                });

                // Detectar el evento `Enter` y llamar a la función `checkInput()`
                txtTransaccion.addEventListener("keypress", function (event) {
                    if (event.key === "Enter") {
                        event.preventDefault(); // Evitar la recarga de página o submit por defecto
                        checkInput(); // Llamar a la función `checkInput()`
                    }
                });
            });

        function checkInput() 
        {
            var txtTransaccion = document.getElementById('txtTransaccion').value.trim();
            
            if (txtTransaccion === '') 
            {
                Swal.fire({
                    title: 'Error',
                    text: 'Por favor, ingrese un Código de Generación',
                    icon: 'error',
                    confirmButtonColor: '#3085d6',
                    confirmButtonText: 'Aceptar'
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

        function changeStatus() 
        {
            var txtTransaccion = document.getElementById('txtTransaccion').value.trim();

            if (txtTransaccion === '') 
            {
                Swal.fire({
                    title: 'Error',
                    text: 'Por favor, Ingrese un Codigo de Generacion',
                    icon: 'error',
                    confirmButtonColor: '#3085d6',
                    confirmButtonText: 'Aceptar'
                });
                return false;
            } 
            else 
            {
                var predefinedStatusId = 2; // Cambia esto al ID de estado que deseas

                $.ajax({
                    type: "POST",
                    url: "Prechequeo.aspx/ChangeTransactionStatus",
                    data: JSON.stringify({ codeGen: txtTransaccion, predefinedStatusId: predefinedStatusId }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(response) 
                    {
                        var message = response.d;

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
                            Swal.fire({
                                title: 'Confirmado',
                                text: 'Prechequeo realizado con exito.',
                                icon: 'success',
                                confirmButtonColor: '#3085d6',
                                confirmButtonText: 'Aceptar'
                            }).then((result) => {
                                if (result.isConfirmed) 
                                {
                                    location.reload();
                                }
                            });
                        } 
                        else 
                        {
                            Swal.fire({
                                title: 'Error',
                                text: 'Hubo un problema al realizar el cambio de estatus.',
                                icon: 'error',
                                confirmButtonColor: '#3085d6',
                                confirmButtonText: 'Aceptar'
                            });
                        }
                    },
                    error: function(xhr, status, error) 
                    {
                        console.error("Error cambiando el estado: ", error);
                        Swal.fire({
                            title: 'Error',
                            text: 'Hubo un error al cambiar el estado.',
                            icon: 'error',
                            confirmButtonColor: '#3085d6',
                            confirmButtonText: 'Aceptar'
                        });
                    }
                });

                return false;
            }
        }

            function closeModal()
            {
                // Recarga la página cuando el usuario presione Cerrar
                location.reload();
            }
        </script>


    </body>

    </html>