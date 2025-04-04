﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Basculas_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Imágenes Escaneadas</title>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.2/css/all.css" integrity="sha384-/rXc/GQVaYpyDdyxK+ecHPVYJSN9bmVFBvjA/9eOB+pb3F2w2N6fc5qB9Ew5yIns" crossorigin="anonymous" />

    <script src="../src/js/jquery-3.4.1.min.js"> </script>
    <%--    <script src="../src/js/spotlight.min.js"></script>--%>
    <script src="../src/js/spotlight.bundle.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    <script>

        var rotation = 0;

        jQuery.fn.rotate = function (degrees) 
        {
            $(this).css({
                '-webkit-transform': 'rotate(' + degrees + 'deg)',
                '-moz-transform': 'rotate(' + degrees + 'deg)',
                '-ms-transform': 'rotate(' + degrees + 'deg)',
                'transform': 'rotate(' + degrees + 'deg)'
            });
        };


        $('#spotlight').click(function () 
        {
            alert("Demo Rotation");
            //rotation += 45;
            //$('.rotate').rotate(rotation);
        });

        function openModal(cod_actividad, ntarjeta, cod_preTrans) 
        {
            //alert(codigo);
            // jQuery.noConflict();
            //$('#actividadModal').modal('show');

            //var slt = document.getElementById('ddlActividadEdt'); txt_codigoPreTransaccion
            document.getElementById("ddlActividadEdt").selectedIndex = cod_actividad;
            document.getElementById("txt_tarjetaEdit").value = ntarjeta;
            document.getElementById("txt_codigoPreTransaccion").value = cod_preTrans;
        }



        //Confirma si el cliente quiere eliminar el item.  getConfirmationDetele
        function getConfirmation() 
        {
            var retVal = confirm("¿Desea autorizar este ingreso?");
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


        function getConfirmationDetele() 
        {
            //Swal.fire({
            //    title: '¿Estás seguro?',
            //    text: "¡Este cambio no podrá ser revertido!",
            //    icon: 'warning',
            //    showCancelButton: true,
            //    confirmButtonColor: '#3085d6',
            //    cancelButtonColor: '#d33',
            //    confirmButtonText: 'Sí, bórralo!'
            //}).then((result) => {
            //    if (result.value) {
            //        Swal.fire(
            //            'Eliminado!',
            //            'El registro ha sido eliminado.',
            //            'success'
            //        )
            //    }
            //})



            var retVal = confirm("¿Desea Actualizar este registro?\n Este cambio no podra ser revertido");
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


        //Confirma si el cliente quiere eliminar el item.  getConfirmationDetele
        function getConfirmation_update() 
        {
            var retVal = confirm("¿Desea actualizar este registro?");
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
    <script type="text/javascript">
        var resultAsJson
        var myVar = setInterval(myTimer, 500);
        var y;
        var x = 0;
        var w = 0;
        var x1 = -1;
        var x2 = -1;
        var w1 = -1;
        var w2 = -1;

        function myTimer() 
        {
            var d = new Date();
            //ejecutamos la funcion
            get_count();
            get_count2();

            if ((x1 == -1 & x2 == -1) || (w1 == -1 & w2 == -1)) 
            {
                x1 = x;
                x2 = x;
                w1 = w;
                w2 = w;
            }
            else if ((x2 != -1) & (w2 != -1)) 
            {
                x2 = x;
                w2 = w;

                if ((x2 != x1) || (w2 != w1)) 
                {
                    x1 = x;
                    w1 = w;
                    __doPostBack('<%=UpdatePanel1.ClientID%>', '');
                    __doPostBack('<%=UpdatePanel1.ClientID%>', '');
                    document.getElementById("nft_1").innerHTML = x;
                }
            }

            document.getElementById("demo").innerHTML = 'Hora: ' + d.toLocaleTimeString();
            //$('#lblResultado').text('Número = ' + x + '--'+x1+'--'+x2); nft_1
        }

        function pos() 
        {
            __doPostBack('<%=UpdatePanel1.ClientID%>', '');
        }



        function geta() 
        {
            var resul = resultAsJson;
            alert(resul);
        }


        function get_count() 
        {
            $.ajax({
                type: "POST",                                              // tipo de request que estamos generando
                url: 'default.aspx/GetCount',                              // URL al que vamos a hacer el pedido
                data: null,                                                // data es un arreglo JSON que contiene los parámetros que 
                
                // van a ser recibidos por la función del servidor
                contentType: "application/json; charset=utf-8",            // tipo de contenido
                dataType: "json",                                          // formato de transmición de datos
                //async: true,                                             // si es asincrónico o no
                success: function (resultado) 
                {                                                          // función que va a ejecutar si el pedido fue exitoso
                    //var num = resultado.d;
                    //$('#lblResultado').text('Número = ' + num);
                    x = resultado.d;;

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) 
                {                                                           // función que va a ejecutar si hubo algún tipo de error en el pedido
                    var error = eval("(" + XMLHttpRequest.responseText + ")");
                    aler(error.Message);
                }
            });
        }


        function get_count2() 
        {
            $.ajax({
                type: "POST",                                              // tipo de request que estamos generando
                url: 'default.aspx/pendientes_autorizacion2',              // URL al que vamos a hacer el pedido
                data: null,                                                // data es un arreglo JSON que contiene los parámetros que 
                // van a ser recibidos por la función del servidor
                contentType: "application/json; charset=utf-8",            // tipo de contenido
                dataType: "json",                                          // formato de transmición de datos
                //async: true,                                             // si es asincrónico o no
                success: function (resultado) 
                {                            // función que va a ejecutar si el pedido fue exitoso
                    //var num = resultado.d;
                    //$('#lblResultado').text('Número = ' + num);
                    w = resultado.d;;
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) 
                { // función que va a ejecutar si hubo algún tipo de error en el pedido
                    var error = eval("(" + XMLHttpRequest.responseText + ")");
                    aler(error.Message);
                }
            });
        }
    </script>


    <style>
        .Content12 
        {
            -webkit-border-radius: 10px 10px 10px 10px;
            border-radius: 10px 10px 10px 10px;
            background: #fff;
            /*padding: 30px;*/
            width: 100%;
            /*max-width: 450px;*/
            position: relative;
            /*padding: 0px;*/
            -webkit-box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
            box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
            /*text-align: center;*/
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
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
                        <li class="nav-item active">
                            <a class="nav-link bg-primary text-white" href="Default.aspx">
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
                        <li class="nav-item">
                            <a class="nav-link" href="Autorizacion_Camiones.aspx">
                                 <i class="fa fa-truck" aria-hidden="true"></i>&nbsp;Chequeo de Informacion
                            </a>
                        </li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Monitoreo</a>
                            <div class="dropdown-menu">
                                <span id="nft_1" class="badge badge-danger" style="position: absolute; top: -5px; left: 12px;"></span>
                                <a class="dropdown-item" href="Autorizacion_Camiones.aspx">
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

        <div class="container-fluid" id="conten">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sql_estados" ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>" runat="server" SelectCommand="SELECT * FROM [LEVERANS_PreTransaccionesEstados] ORDER BY Pk_PreTransEstados ASC"></asp:SqlDataSource>
            <asp:SqlDataSource ID="Sql_basculas" ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>" runat="server" SelectCommand="SELECT * FROM [LEVERANS_Basculas] where N_Bascula <= 6 ORDER BY [N_Bascula] ASC"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sql_actividades" ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>" runat="server" SelectCommand="SELECT PkActividad,Descripcion  FROM [dbo].[LEVERANS_Actividades] ORDER BY PkActividad"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sql_documetos" runat="server" ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sql_usuarios" SelectCommand="SELECT PK_Usuario,Usuario FROM [dbo].[LEVERANS_UsuariosBascula]" runat="server" ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>"></asp:SqlDataSource>

            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <%--  --%>
                    <div class="row ml-4">
                        <h3>Documentos Escaneados</h3>
                        <p class="h3 ml-3" id="demo"></p>
                    </div>

                    <div class="row ml-3 sticky-top" style="border: solid 0px;">
                        <div class="col-9 mt-2 mb-2">
                            <div class="input-group mb-3" style="border: solid 0px;">
                                <div class="input-group-prepend">
                                    <span class="input-group-text secondary"># de Transacción</span>
                                </div>
                                <asp:TextBox ID="txtTransaccion" autocomplete="off" CssClass="form-control col-2" runat="server"></asp:TextBox>
                                <asp:DropDownList ID="ddl_Estado" CssClass="form-control" runat="server" DataSourceID="sql_estados" DataValueField="Pk_PreTransEstados" DataTextField="Descripcion" AppendDataBoundItems="true">
                                    <asp:ListItem Value="0">Todos</asp:ListItem>
                                </asp:DropDownList>

                                <asp:DropDownList ID="ddl_Actividades2" CssClass="form-control" DataSourceID="sql_actividades" DataTextField="Descripcion" DataValueField="PkActividad" runat="server" AppendDataBoundItems="true">
                                    <asp:ListItem Value="0"> Seleccione una actividad</asp:ListItem>
                                </asp:DropDownList>

                                <asp:DropDownList ID="ddl_basculas" CssClass="form-control" runat="server" DataSourceID="Sql_basculas" DataValueField="N_Bascula" DataTextField="Descripcion" AppendDataBoundItems="true">
                                    <asp:ListItem Value="0">-Selecciones Báscula-</asp:ListItem>
                                </asp:DropDownList>

                                <div class="input-group-append">
                                    <asp:LinkButton ID="lnkBuscar" CssClass="btn btn-info" OnClick="lnkBuscar_Click" OnClientClick="return ShowCurrentTime()" runat="server"><i class="fas fa-search"></i> Buscar</asp:LinkButton>
                                    <asp:LinkButton ID="LnkRefresh" CssClass="btn btn-secondary" runat="server"><i class="fas fa-sync"></i></asp:LinkButton>
                                    <asp:LinkButton ID="Lnk_newTransaccon" Visible="false" CssClass="btn btn-success" runat="server" data-toggle="modal" data-target="#nuevaPretransaccionModal"><i class="far fa-file-alt">Nueva</i></asp:LinkButton>
                                  
                                    <%-- <asp:LinkButton ID="LinkButton2" CssClass="btn btn-outline-secondary" OnClick="LinkSalir1_Click" runat="server">Salir</asp:LinkButton>--%>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script type="text/javascript">
                        $(document).on("click", '.ocultar', function () 
                        {
                            console.log("world");
                            $(this).hide();
                        });
                    </script>

                    <div class="row" style="border: solid 0px">
                        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1" OnPagePropertiesChanging="lvwPrincipal_PagePropertiesChanging" OnItemDataBound="ListView1_ItemDataBound">
                            <ItemTemplate>
                                <div class="col-lg-4 col-md-6 col-sm-12 " style="border: solid 0px">
                                    <div class="mb-4 Content12" style="border: solid 0px">
                                        <asp:Label ID="lblCodT" Visible="false" runat="server" Text='<%# Eval("PK_PreTransaccion") %>'></asp:Label>
                                        <div class="row">

                                            <div class="col-4">
                                                <div class="row ml-3 mt-3">
                                                    <asp:Repeater ID="rpt_galeria" runat="server">
                                                        <ItemTemplate>
                                                            <div class="col-6" style="border: solid 0px">
                                                                <asp:HyperLink ID="HyperLink5" CssClass="spotlight" data-title='<%# "codTransaccion :" +DataBinder.Eval(Container.DataItem,"codTransaccion")%>' NavigateUrl='<%# "http://sv-svr-almapp02:2050/" + DataBinder.Eval(Container.DataItem,"Documento")%>' runat="server">
                                                                    <asp:Image class="img-fluid rounded mt-4 mb-3 mb-md-0" Width="100%" ID="Image1" runat="server" ImageUrl='<%# "http://sv-svr-almapp02:2050/" + DataBinder.Eval(Container.DataItem,"Documento_thumbnail")%>' />
                                                                </asp:HyperLink>
                                                                <asp:LinkButton ID="lnk_rotar" OnClick="lnk_rotar_Click" CommandArgument='<%# Eval("Documento")+ ";" + Eval("Documento_thumbnail")%>' runat="server"><i class="fas fa-sync-alt"></i></asp:LinkButton>
                                                            </div>
                                                        </ItemTemplate>

                                                    </asp:Repeater>
                                                </div>
                                            </div>

                                            <div class="col-8">
                                                <br />
                                                <h5>

                                                    <asp:Label ID="lbl_cod_estado" Visible="false" runat="server" Text='<%# Eval("cod_estado") %>'></asp:Label>
                                                    <asp:Label ID="lblAlerta" runat="server" ForeColor='<%# System.Drawing.ColorTranslator.FromHtml(Eval("Color").ToString()) %>' CssClass="alerta"><i class="fa fa-circle"></i></asp:Label>&nbsp;<asp:Label ID="Label1" ForeColor="Blue" CssClass="h5" runat="server" Text='<%# Eval("estado") %>'></asp:Label></h5>

                                                <h5>Código:
                                                    <asp:Label ID="lblCodigo" runat="server" Text='<%# Eval("PK_PreTransaccion") %>'></asp:Label>
                                                </h5>

                                                <h5>
                                                    Transacción:                                                
                                                    <asp:Label ID="lblNombre" CssClass="h5" runat="server" Text='<%# Eval("codTransaccion") %>'></asp:Label>
                                                </h5>
                                                <h5>
                                                    Tarjeta:
                                                    <asp:Label ID="lblTarjeta" runat="server" Text='<%# Eval("ntarjeta") %>'></asp:Label>
                                                </h5>
                                                <h5>
                                                    Placa:
                                                    <asp:Label ID="lblPlaca" runat="server" Text='<%# Eval("placa") %>'></asp:Label>
                                                </h5>
                                                <h5>
                                                    Actividad:
                                                    <asp:Label ID="lblActividad" CssClass="h6" runat="server" Text='<%# Eval("desc_actividad") %>'></asp:Label>
                                                </h5>
                                                <p class="h5">
                                                    N° Báscula:
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("nbascula") %>'></asp:Label>
                                                </p>
                                                <p class="h5">
                                                    Fecha Creación:
                                                    <asp:Label ID="lblFecha" runat="server" Text='<%# Eval("FechaHora") %>'></asp:Label>
                                                </p>
                                                <p class="h5">
                                                    Fecha Autorizado:
                                                    <asp:Label ID="lblFechaAutorizado" runat="server" Text='<%# Eval("fechaautorizado") %>' ></asp:Label>
                                                </p>
                                                <br />
                                                <asp:LinkButton ID="lnk_autorizar" CssClass="btn btn-danger mb-3" OnClientClick="return getConfirmation();" OnClick="lnk_autorizar_Click" CommandArgument='<%# Eval("PK_PreTransaccion")+ ";" + Eval("codTransaccion")%>' runat="server"> <i class="fas fa-clipboard-check"></i>&nbsp;Autorizar</asp:LinkButton>
                                                <asp:LinkButton ID="lnk_autorizar2" CssClass="btn btn-warning mb-3" OnClientClick="return getConfirmation();" OnClick="lnk_autorizar2_Click" CommandArgument='<%# Eval("PK_PreTransaccion")+ ";" + Eval("codTransaccion")%>' runat="server"> <i class="fas fa-clipboard-check"></i>&nbsp;Autorizar 2</asp:LinkButton>
                                                <asp:LinkButton ID="lnk_crearTransaccion" Visible="false" OnClick="lnk_crearTransaccion_Click" CommandArgument='<%# Eval("PK_PreTransaccion")%>' runat="server" CssClass="btn ocultar btn-primary mb-3">Crear</asp:LinkButton>
                                                <asp:LinkButton ID="lnk_delete" Visible="false" runat="server" CssClass="btn btn-danger mb-3" OnClientClick="return getConfirmationDetele();" OnClick="lnk_delete_Click" CommandArgument='<%# Eval("PK_PreTransaccion")%>'><i class="fas fa-trash-alt"></i>&nbsp;Finalizar</asp:LinkButton>
                                                <asp:LinkButton ID="lnk_update_pret" Visible="false" runat="server" CssClass="btn btn-info mb-3" OnClientClick="return getConfirmation_update();" OnClick="lnk_update_pret_Click" CommandArgument='<%# Eval("PK_PreTransaccion")%>' ><i class="fas fa-angle-double-right"></i>&nbsp;Omitir</asp:LinkButton>
                                                <%--<button type="button" class="btn btn-primary mb-3" id="btn_edi" runat="server" onclick="openModal('<%# Eval("cod_actividad")%>',<%# Eval("ntarjeta")%>,<%# Eval("PK_PreTransaccion")%>)" data-toggle="modal" data-target="#modal_editActividad" ><i class="fas fa-road"></i>Editar</button>--%>
                                                <button type="button" class="btn btn-primary mb-3" id="btn_edi" name="btn_edit" runat="server" visible="false" onclick='<%# "openModal(" +Eval("cod_actividad")+","+Eval("ntarjeta")+","+Eval("PK_PreTransaccion") + " );" %>' data-toggle="modal" data-target="#modal_editActividad"><i class="fas fa-road"></i>Editar2</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>

                            <EmptyDataTemplate>
                                <div>
                                    <h4>No se encontraron resultados!!!!</h4>
                                </div>
                            </EmptyDataTemplate>
                        </asp:ListView>
                    </div>

                    <div class="row" style="border: solid 0px; position: fixed; bottom: 0; left: 0; right: 0;">
                        <div class="col-lg-12 h3" style="text-align: center">
                            <asp:DataPager runat="server" ID="dtpPrincipal" PagedControlID="ListView1" PageSize="12">
                                <Fields>
                                    <asp:NextPreviousPagerField ShowFirstPageButton="True" ShowNextPageButton="false" ShowPreviousPageButton="true" NextPageText="&lt;i class='fas fa-angle-right'&gt;&lt;/i&gt;" PreviousPageText="&lt;i class='fas fa-angle-left'&gt;&lt;/i&gt;" FirstPageText="&lt;i class='fas fa-angle-double-left'&gt;&lt;/i&gt;" LastPageText="&lt;i class='fas fa-angle-double-right'&gt;&lt;/i&gt;" />
                                    <asp:NumericPagerField />
                                    <asp:NextPreviousPagerField ShowLastPageButton="True" ShowNextPageButton="true" ShowPreviousPageButton="false" FirstPageText="&lt;i class='fas fa-angle-double-left'&gt;&lt;/i&gt;" LastPageText="&lt;i class='fas fa-angle-double-right'&gt;&lt;/i&gt;" NextPageText="&lt;i class='fas fa-angle-right'&gt;&lt;/i&gt;" PreviousPageText="&lt;i class='fas fa-angle-left'&gt;&lt;/i&gt;" />
                                </Fields>
                            </asp:DataPager>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>

            <!-- Modal para crear una nueva Pretransaccion -->
            <div class="modal fade" id="nuevaPretransaccionModal" tabindex="-1" role="dialog" aria-labelledby="nuevaPretransaccionTitle" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="nuevaPretransaccionLongTitle">Create</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group col-12">
                                <asp:TextBox ID="txtTarjeta" CssClass="form-control" TextMode="Number" placeholder="N° Tarjeta" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="req_txtTarjeta" runat="server" ControlToValidate="txtTarjeta" CssClass="reqGeneral" ErrorMessage="*" Display="Dynamic" ValidationGroup="save" InitialValue=""><i class="fa fa-times-circle" aria-hidden="true"></i></asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group col-12">
                                <asp:DropDownList ID="ddl_actividades" CssClass="form-control" DataSourceID="sql_actividades" DataTextField="Descripcion" DataValueField="PkActividad" runat="server" AppendDataBoundItems="true">
                                    <asp:ListItem Value="0"> Seleccione una Actividad</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="reqddl_actividades" runat="server" ControlToValidate="ddl_actividades" CssClass="reqGeneral" ErrorMessage="*" Display="Dynamic" ValidationGroup="save" InitialValue="0"><i class="fa fa-times-circle" aria-hidden="true"></i></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <asp:LinkButton ID="btn_save" runat="server" OnClick="btn_save_Click" CausesValidation="True" CssClass="btn btn-primary" ValidationGroup="save"><i class="fa fa-floppy-o"></i> Crear </asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal -->
            <div class="modal fade" id="modal_editActividad" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Modal Edit</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="form-group col-12">

                                <input type="text" id="txt_codigoPreTransaccion" style="display: none" runat="server" />
                                <label for="exampleInputEmail1">N° Tarjeta</label>
                                <asp:TextBox ID="txt_tarjetaEdit" CssClass="form-control" TextMode="Number" placeholder="N° Tarjeta" runat="server" autocomplete="off"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_tarjetaEdit" CssClass="reqGeneral" ErrorMessage="*" Display="Dynamic" ValidationGroup="edit2" InitialValue=""><i class="fa fa-times-circle" aria-hidden="true"></i></asp:RequiredFieldValidator>
                            </div>


                            <div class="form-group col-12">
                                <label for="exampleInputEmail1">Actividad</label>
                                <asp:DropDownList ID="ddlActividadEdt" CssClass="form-control" DataSourceID="sql_actividades" DataTextField="Descripcion" DataValueField="PkActividad" runat="server" AppendDataBoundItems="true">
                                    <asp:ListItem Value="0"> seleccione una actividad</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlActividadEdt" CssClass="reqGeneral" ErrorMessage="*" Display="Dynamic" ValidationGroup="edit2" InitialValue="0"><i class="fa fa-times-circle" aria-hidden="true"></i></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                            <asp:LinkButton ID="lnk_editPreTransaccion" OnClick="lnk_editPreTransaccion_Click" runat="server" CausesValidation="True" CssClass="btn btn-primary" ValidationGroup="edit2"><i class="fa fa-floppy-o"></i> Guardar </asp:LinkButton>
                        </div>
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

                            <asp:LinkButton ID="lnk_restablecer" runat="server" OnClick="lnk_restablecer_Click" CausesValidation="True" CssClass="btn btn-primary" ValidationGroup="reset"><i class="fa fa-floppy-o"></i> Guardar </asp:LinkButton>

                        </div>
                    </div>
                </div>
            </div>





        </div>
    </form>

    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript" src="../scripts/jquery.blockUI.js"></script>
    <script type="text/javascript">
        $(function () 
        {
            BlockUI("conten");
            $.blockUI.defaults.css = {};
        });
        function BlockUI(elementID) 
        {
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_beginRequest(function () 
            {
                $("#" + elementID).block({
                    message: '<div align = "center">' + '<img src="../images/009.gif"/></div>',
                    css: {},
                    overlayCSS: { backgroundColor: '#F8F9F9', opacity: 0.8, border: '0px solid #63B2EB' }
                });
            });
            prm.add_endRequest(function () 
            {
                $("#" + elementID).unblock();
            });
        };
    </script>



    <script src="https://cdn.jsdelivr.net/picturefill/2.3.1/picturefill.min.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lightgallery.js/master/dist/js/lightgallery.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-pager.js/master/dist/lg-pager.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-autoplay.js/master/dist/lg-autoplay.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-fullscreen.js/master/dist/lg-fullscreen.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-zoom.js/master/dist/lg-zoom.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-hash.js/master/dist/lg-hash.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-share.js/master/dist/lg-share.js"></script>
    <script>
        lightGallery(document.getElementById('lightgallery'));
    </script>
</body>
</html>
