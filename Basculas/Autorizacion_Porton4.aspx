<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Autorizacion_Porton4.aspx.cs" Inherits="Basculas_Autorizacion_Porton4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Autorizacion Porton 4</title>

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
                    <img src="https://static.wixstatic.com/media/c0de4d_46396c047a20462d8e426910f7f8630f~mv2.png/v1/fill/w_309,h_59,al_c,lg_1,q_85,enc_auto/1-ALMAPAC%20final2-768x143%201.png" style="height: 40px; width: auto;">
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

                        <li class="nav-item">
                            <a class="nav-link" href="Prechequeo.aspx">
                                <i class="fas fa-qrcode"></i>&nbsp;Prechequeo
                            </a>
                        </li>

                        <li class="nav-item dropdown active" style="position: relative">
                            <span id="nft_1" class="badge badge-danger" style="position: absolute; top: -5px; left: 12px;"></span>
                            <a class="nav-link dropdown-toggle  bg-primary text-white" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Monitoreo</a>
                            <div class="dropdown-menu">
                               
                                <a class="dropdown-item" href="Autorizacion_Camiones.aspx">
                                    <i class="fa fa-truck" aria-hidden="true"></i>&nbsp;Chequeo de Informacion
                                </a>

                                <a class="dropdown-item" href="Autorizacion_ingreso.aspx">
                                    <i class="fas fa-unlock"></i>&nbsp;Autorizacion Ingreso
                                </a>

                                <span id="nft_1" class="badge badge-danger" style="position: absolute; top: -5px; left: 12px;"></span>
                                <a class="dropdown-item bg-primary text-white" href="Autorizacion_Porton4.aspx">
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
            <h2>Validacion de Marchamos</h2>
        </div>

       <br>
        <div class="col-lg-12">
            <div class="row justify-content-center" style="margin: 20px;">
                <input type="text" id="searchInput" onkeyup="filterCards()" placeholder="Buscar transacciones..." class="form-control mb-3" style="border-radius: 15px; height: 45px; width:  1500px;">
            </div>

            <div class="row justify-content-center" style="margin: 20px;">
                <asp:Repeater ID="rptRutas" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-4 col-md-4 col-sm-16 mb-4">
                            <div class="card" style="height: 400px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);">
                                <div class="card-body d-flex flex-column">
                                    <%-- Viñeta Dinámica --%>
                                    <span style="padding: 8px 15px; border-radius: 12px; display: inline-block; font-size: 18px;" 
                                        class='<%# Eval("vehicle.truckType").ToString() == "V" ? "badge badge-success" : 
                                                Eval("vehicle.truckType").ToString() == "P" ? "badge badge-dark" : 
                                                "badge badge-dark" %>'>
                                        <%# Eval("vehicle.truckType").ToString() == "V" ? "Volteo" : 
                                            Eval("vehicle.truckType").ToString() == "P" ? "Rastra" : 
                                            "Plano" %>
                                    </span>
                                    <asp:LinkButton CssClass="btn" ID="lnk_VerRuta" runat="server" data-toggle="modal" data-target="#rutaModal" data-codigo-generacion='<%# Eval("codeGen") %>'>
                                        <asp:Label ID="lblCodT" Visible="false" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                                        <h5 class="card-text text-left">
                                            <strong>Fecha Prechequeo:</strong>
                                            <asp:Label ID="lblFechaStatus" runat="server" CssClass="no-bold" Text='<%# Eval("statuses[1].createdAt") != null ? Convert.ToDateTime(Eval("statuses[1].createdAt")).ToString("dd/MM/yyyy") : "No disponible" %>'></asp:Label>
                                        </h5>
      
                                        <h5 class="card-text text-left">
                                            <strong>Hora Prechequeo:</strong>
                                            <asp:Label ID="lblHoraStatus" runat="server"  CssClass="no-bold" Text='<%# Eval("statuses[1].createdAt") != null ? Convert.ToDateTime(Eval("statuses[1].createdAt")).ToString("HH:mm:ss") : "No disponible" %>'></asp:Label>
                                        </h5>

                                        <h5 class="card-title text-left">
                                            <strong>Codigo generacion:</strong>
                                            <asp:Label ID="lblNombre" runat="server" CssClass="no-bold" Text='<%# Eval("codeGen") %>'></asp:Label>
                                        </h5>

                                        <h5 class="card-text text-left">
                                            <strong>Ingenio:</strong>
                                            <asp:Label ID="lblIngenio" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("ingenio.user.username").ToString()) %>'></asp:Label>
                                        </h5>

                                        <h5 class="card-text text-left">
                                            <strong>Tipo Operacion:</strong>
                                            <asp:Label ID="lbloperacion" runat="server" CssClass="no-bold"  Text='<%# Eval("operationType") != null ? (Eval("operationType").ToString() == "C" ? "Carga" : Eval("operationType").ToString() == "D" ? "Descarga" : "No disponible") : "No disponible" %>'></asp:Label>
                                        </h5>

                                        <h5 class="card-text text-left">
                                            <strong>Producto:</strong>
                                            <asp:Label ID="lblproducto" runat="server" CssClass="no-bold" Text='<%# Eval("nameProduct") != null ? HttpUtility.HtmlEncode(Eval("nameProduct").ToString().Replace("_", " ")) : "N/A" %>'></asp:Label>    
                                        </h5>

                                        <h5 class="card-text text-left">
                                            <strong>Cantidad:</strong>
                                            <asp:Label ID="lblcantidad" runat="server" CssClass="no-bold" Text='<%# Eval("productQuantityKg") != null ? HttpUtility.HtmlEncode(Eval("productQuantityKg").ToString().Replace("_", " ")) : "N/A" %>'> </asp:Label>    
                                        </h5>
                                        
                                        <h5 class="card-text text-left">
                                            <strong>Transportista:</strong> 
                                            <asp:Label ID="lbltransporte" runat="server" CssClass="no-bold" Text='<%# HttpUtility.HtmlEncode(Eval("driver.name").ToString()) %>'></asp:Label>
                                        </h5>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
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
