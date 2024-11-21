<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Autorizacion_Camiones.aspx.cs" Inherits="Basculas_Autorizacion_Camiones" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Autorizacion de Camiones</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.2/css/all.css" integrity="sha384-/rXc/GQVaYpyDdyxK+ecHPVYJSN9bmVFBvjA/9eOB+pb3F2w2N6fc5qB9Ew5yIns" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.6/dist/jquery.fancybox.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" />

    <style>
        .no-bold 
        {
            font-weight: normal;
        }
        
    </style>

  
    <script>
        //Confirma si el cliente quiere eliminar el item.
        function getConfirmation() 
        {
            var retVal = confirm("¿Desea eliminar esta fila?");
            if (retVal == true) 
            {
                //alert("User wants to continue!");
                return true;
            } 
            else 
            {
                //alert("User does not want to continue!");
                return false;
            }
        }
    </script>
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

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <a class="navbar-brand" href="#">
                    <img src="https://github.com/MarioPortillo10/Imagenes-ALMAPAC/blob/main/Imagenes/almapac.png?raw=true" style="height: 40px; width: auto;">
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse"
                    data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="Default.aspx">
                                <i class="far fa-file-alt"></i>&nbsp;Pre-Transacciones
                            </a>
                        </li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Rutas</a>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="Rutas_Transacciones.aspx">
                                    <i class="fas fa-road"></i>&nbsp;Rutas Transacciones
                                </a>
                                <a class="dropdown-item" href="Rutas_Actividades.aspx">
                                    <i class="fas fa-road"></i>&nbsp;Rutas Actividades
                                </a>
                            </div>
                        </li>

                        <li class="nav-item dropdown active" style="position: relative">
                            <span id="nft_1" class="badge badge-danger" style="position: absolute; top: -5px; left: 12px;"></span>
                            <a class="nav-link dropdown-toggle  bg-primary text-white" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Monitoreo</a>
                            <div class="dropdown-menu">
                                <span id="nft_1" class="badge badge-danger" style="position: absolute; top: -5px; left: 12px;"></span>
                                <a class="dropdown-item  bg-primary text-white" href="Autorizacion_Camiones.aspx">
                                    <i class="fa fa-truck" aria-hidden="true"></i>&nbsp;Chequeo de Informacion
                                </a>

                                <a class="dropdown-item" href="Autorizacion_ingreso.aspx">
                                    <i class="fas fa-unlock"></i>&nbsp;Autorizacion Ingreso
                                </a>

                                <a class="dropdown-item" href="Autorizacion_Porton4.aspx">
                                    <i class="fas fa-check-square"></i>&nbsp;Autorizacion Porton 4
                                </a>

                                <a class="dropdown-item" href="Lista_Negra.aspx">
                                    <i class="fas fa-list-alt"></i>&nbsp;Lista Negra Motorista
                                </a>
                            </div>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="Tiempos_Azucar.aspx">
                                <i class="fas fa-clock"></i>&nbsp;Recepcion Azucar
                            </a>
                        </li>
                    </ul>

                    <div class="my-2 my-lg-0">
                        <asp:LinkButton ID="lnk_perfil" OnClick="lnk_perfil_Click" CssClass="btn btn-outline-success my-2 my-sm-0" runat="server"> Perfil</asp:LinkButton>

                        <asp:LinkButton ID="lnk_salir" OnClick="LinkSalir1_Click"
                            CssClass="btn btn-outline-info my-2 my-sm-0" runat="server">
                            <i class="fas fa-power-off">&nbsp Salir </i>&nbsp<i class="far fa-user"></i>
                        </asp:LinkButton>
                    </div>
                </div>
            </nav>

        <div class="row ml-4">
            <h2>Chequeo de Informacion</h2>
        </div>

       <br>

        <div class="col-lg-12">
            <div class="row justify-content-center" style="margin: 20px;">
                <input type="text" id="searchInput" onkeyup="filterCards()" placeholder="Buscar transacciones..." class="form-control mb-3" style="border-radius: 15px; height: 45px; width:  1500px; border-color: black;">
            </div>
            <div class="container my-5">
    <!-- Contenedor de tarjetas -->
    <div class="row d-flex flex-wrap justify-content-center">
        <asp:Repeater ID="rptRutas" runat="server">
            <ItemTemplate>
                <div class="col-lg-4 col-md-6 col-sm-12 mb-4 card-container">
                    <div class="card border rounded-4" style="height: 750px; border-color: #ddd;">
                        <asp:LinkButton CssClass="btn" 
                            ID="lnk_VerRuta" 
                            runat="server" 
                            data-toggle="modal" 
                            data-target="#rutaModal" 
                            data-codigo-generacion='<%# Eval("codeGen") %>' 
                            OnClick="lnk_VerRuta_Click">
                            
                            <!-- Imagen superior adaptada al recuadro con object-fit: contain -->
                            <asp:Image ID="imgShipment" runat="server" 
                                ImageUrl='<%# (Eval("shipmentAttachments") != null && ((IEnumerable<object>)Eval("shipmentAttachments")).Count() > 0) 
                                            ? ((dynamic)Eval("shipmentAttachments"))[0].fileUrl 
                                            : "" %>' 
                                CssClass="img-fluid rounded-top" 
                                style="width: 100%; height: 250px; object-fit: contain; background-color: #f8f9fa;" />
                            
                            <div class="card-body p-4" style="height: 350px;">
                                <!-- Badge de tipo de camión -->
                                <div class="d-flex justify-content-start align-items-center mb-3">
                                    <span class="badge 
                                        <%# Eval("vehicle.truckType").ToString() == "V" ? "bg-success" : 
                                            Eval("vehicle.truckType").ToString() == "R" ? "bg-dark" : 
                                            "bg-secondary" %> 
                                        text-white px-3 py-2 rounded-pill">
                                        <%# Eval("vehicle.truckType").ToString() == "V" ? "Volteo" : 
                                            Eval("vehicle.truckType").ToString() == "R" ? "Plana" : "Plano" %>
                                    </span>
                                </div>

                                <!-- Información distribuida en columnas -->
                                <div class="row">
                                    <!-- Columna izquierda -->
                                    <div class="col-lg-6 col-md-6">
                                        <p><i class="fas fa-calendar-alt text-primary"></i> <strong>Fecha Prechequeo:</strong></p>
                                        <p class="text-muted mb-1">
                                            <asp:Label ID="lblFechaStatus" runat="server" 
                                                Text='<%# Eval("statuses[1].createdAt") != null 
                                                        ? Convert.ToDateTime(Eval("statuses[1].createdAt")).ToString("dd/MM/yyyy") 
                                                        : "No disponible" %>' />
                                        </p>

                                        <p><i class="fas fa-clock text-primary"></i> <strong>Hora Prechequeo:</strong></p>
                                        <p class="text-muted mb-1">
                                            <asp:Label ID="lblHoraStatus" runat="server" 
                                                Text='<%# Eval("statuses[1].createdAt") != null 
                                                        ? Convert.ToDateTime(Eval("statuses[1].createdAt")).ToString("HH:mm:ss") 
                                                        : "No disponible" %>' />
                                        </p>

                                        <p><i class="fas fa-code text-primary"></i> <strong>Código Generación:</strong></p>
                                        <p class="text-muted mb-1">
                                            <asp:Label ID="lblNombre" runat="server" 
                                                Text='<%# Eval("codeGen") %>' />
                                        </p>
                                    </div>

                                    <!-- Columna derecha -->
                                    <div class="col-lg-6 col-md-6">
                                        <p><i class="fas fa-industry text-primary"></i> <strong>Ingenio:</strong></p>
                                        <p class="text-muted mb-1">
                                            <asp:Label ID="lblIngenio" runat="server" 
                                                Text='<%# HttpUtility.HtmlEncode(Eval("ingenio.user.username").ToString()) %>' />
                                        </p>

                                        <p><i class="fas fa-cogs text-primary"></i> <strong>Tipo Operación:</strong></p>
                                        <p class="text-muted mb-1">
                                            <asp:Label ID="lbloperacion" runat="server" 
                                                Text='<%# Eval("operationType") != null ? 
                                                        (Eval("operationType").ToString() == "C" ? "Carga" : 
                                                        Eval("operationType").ToString() == "D" ? "Descarga" : "No disponible") 
                                                        : "No disponible" %>' />
                                        </p>

                                        <p><i class="fas fa-box text-primary"></i> <strong>Producto:</strong></p>
                                        <p class="text-muted mb-1">
                                            <asp:Label ID="lblproducto" runat="server" 
                                                Text='<%# Eval("nameProduct") != null ? 
                                                        HttpUtility.HtmlEncode(Eval("nameProduct").ToString().Replace("_", " ")) : 
                                                        "N/A" %>' />
                                        </p>
                                        
                                        <p><i class="fas fa-user text-primary"></i> <strong>Motorista:</strong></p>
                                        <p class="text-muted mb-1">
                                            <asp:Label ID="lbltransporte" runat="server" 
                                                Text='<%# HttpUtility.HtmlEncode(Eval("driver.name").ToString()) %>' />
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </asp:LinkButton>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    


</div>


        </div>
            
        <!-- Modal RESTABLECER CONTRASEÑA -->
            <div class="modal fade" id="editPass" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editPass2">Cambiar contraseña</h5>
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
                        
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal de Validación -->
            <div class="modal fade" id="rutaModal" tabindex="-1" role="dialog" aria-labelledby="rutaModalLabel" aria-hidden="true" data-backdrop="static">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">


                                    <div class="modal-header">
                                        <h5 class="modal-title" id="rutaModalLabel">Validación de Información</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <input type="hidden" class="form-control" id="codigoGeneracionInput" readonly />
                                        <form>
                                            <div class="form-group">
                                                <label for="recipient-name" class="col-form-label">Licencia:</label>
                                                <input type="text" class="form-control" id="txt_licencia" />
                                            </div>
                                            <div class="form-group">
                                                <label for="message-text" class="col-form-label">Placa Remolque:</label>
                                                <input type="text" class="form-control" id="txt_placaremolque" />
                                            </div>
                                            <div class="form-group">
                                                <label for="message-text" class="col-form-label">Placa Camion:</label>
                                                <input type="text" class="form-control" id="txt_placamion" />
                                            </div>
                                            <div class="form-group">
                                                <label for="recipient-name" class="col-form-label">No. Tarjeta:</label>
                                                <input type="text" class="form-control" id="txt_tarjeta" />
                                            </div>
                                        </form>
                                        <asp:Label ID="lblRuta" runat="server" Text=""></asp:Label>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-primary" onclick="validarInformacion()">Confirmar</button>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </asp:SqlDataSource>

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
        // Inicializar el carrusel y otros elementos cuando el DOM esté listo
        document.addEventListener('DOMContentLoaded', function () {
            // Inicializar el carrusel
            var carouselElement = document.getElementById('carouselRuta');
            var carousel = new bootstrap.Carousel(carouselElement, {
                interval: false // Asegúrate de que el intervalo esté desactivado
            });

            // Mover al siguiente formulario
            document.getElementById('nextBtnRuta').addEventListener('click', function () {
                carousel.next(); // Mueve al siguiente formulario (slide)
            });

            // Volver al formulario anterior
            document.getElementById('backBtnRuta').addEventListener('click', function () {
                carousel.prev(); // Mueve al formulario anterior (slide)
            });

            // Restablecer el carrusel al primer slide al cerrar la modal
            $('#rutaModal').on('hidden.bs.modal', function () {
                carousel.to(0); // Mueve el carrusel al primer slide
            });
        });
        $(document).ready(function () 
        {
            $('#rutaModal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget); // Botón que abrió el modal
                var codigoGeneracion = button.data('codigo-generacion'); // Extraer la información del atributo data-codigo-generacion
                var modal = $(this);
                modal.find('#codigoGeneracionInput').val(codigoGeneracion); // Mostrar el código de generación en el input
            });
        });

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




        function validarInformacion() 
        {
            var codigoGeneracion = document.getElementById('codigoGeneracionInput').value;
            var licencia = document.getElementById('txt_licencia').value;
            var placaRemolque = document.getElementById('txt_placaremolque').value;
            var placaCamion = document.getElementById('txt_placamion').value;

            $.ajax({
                type: "POST",
                url: "Autorizacion_Camiones.aspx/ValidarDatos",
                data: JSON.stringify({ codigoGeneracion: codigoGeneracion, licencia: licencia, placaRemolque: placaRemolque, placaCamion: placaCamion }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) 
                {
                    var resultado = response.d; 
                    if (resultado.includes("Validación exitosa")) 
                    {
                        Swal.fire({
                            icon: 'success',
                            title: 'Validación exitosa',
                            text: resultado,
                            confirmButtonText: 'Aceptar'
                        }).then(() => {
                            // Llamar a la función changeStatus después de la validación exitosa
                            changeStatus(codigoGeneracion);
                        });
                    } 
                    else 
                    {
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
                        text: 'Ocurrió un error al validar los datos.',
                        confirmButtonText: 'Aceptar'
                    });
                }
            });
        }

        // Función para cambiar el estatus después de la validación exitosa
        function changeStatus(codigoGeneracion) 
        {
            var predefinedStatusId = 3; // Cambia esto al ID de estado que deseas

            if (!codigoGeneracion || codigoGeneracion.trim() === '') {
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
