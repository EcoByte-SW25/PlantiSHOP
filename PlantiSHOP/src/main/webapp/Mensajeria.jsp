<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="auxs.Llavero"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%!
    Connection c;
    Statement s;
    ResultSet r;
    long i;
    String na, u;
%>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        c = DriverManager.getConnection("jdbc:mysql://localhost/PSHOP", "root", "n0m3l0");
        s = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        r = s.executeQuery("SELECT N,AP,AM,U FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
        r.next();
        na = r.getString(1) + " " + r.getString(2) + " " + r.getString(3);
        u = r.getString(4);
        r.close();
        r = null;
    } catch (Exception e) {
        out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
        out.print("<script>history.back();</script>");
    }
%>
<!DOCTYPE html>
<html lang="es-MX">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mensajeria Comercial</title>
        <link rel="icon" type="image/x-icon" href="imgs/logo.png">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body { background-color: #f0f0f0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
            .product-card { background: white; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); margin-bottom: 20px; }
            .product-img { width: 100%; height: 200px; object-fit: cover; border-radius: 15px 15px 0 0; }
            .status-pending { border-left: 5px solid #ffc107; }
            .status-accepted { border-left: 5px solid #28a745; }
            .status-waiting { border-left: 5px solid #17a2b8; }
            .map-container { height: 300px; border-radius: 10px; }
            .btn-custom-green { background-color: #28a745; border-color: #28a745; }
            .btn-custom-blue { background-color: #007bff; border-color: #007bff; }
            .btn-custom-red { background-color: #dc3545; border-color: #dc3545; }
        </style>
        <script src="https://maps.googleapis.com/maps/api/js?key=<%= Llavero.getApiGoogleMaps() %>&callback=initMap&v=weekly" defer></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                window.location.hash = "no-back-button";
                window.location.hash = "Again-No-back-button";
                window.onhashchange = function () {
                    window.location.hash = "";
                };
            });
            window.initMap = function () {
                let latd, lngd;
                (new google.maps.Geocoder()).geocode({ address: "<%= u %>" }).then(function (r) {
                    latd = r.results[0].geometry.location.lat;
                    lngd = r.results[0].geometry.location.lng;
                });
                <%
                    try {
                        r = s.executeQuery("SELECT Compra.X FROM Compra INNER JOIN Usuario ON Compra.V=Usuario.CE WHERE Compra.C='"+session.getAttribute("u")+"' ORDER BY Compra.X DESC, Compra.Fh ASC");
                        i = 1L;
                        while (r.next()) {
                            if (r.getByte(1) == 1) {
                                out.print("(new google.maps.Map(document.getElementById('gMap'"+i+"), { center: { lat: (latd ?? 19.4326077), lng: (lngd ?? -99.133208) }, zoom: 8, mapTypeControl: false })).addListener('click', function (ev) { (new google.maps.Geocoder()).geocode({ location: ev.latLng }).then(function (r) { document.getElementById('m'"+i+").value = r.results[0].formatted_address; }, function (er) { alert('Lo sentimos, se produjo un ERROR:\n'+er); }); });");
                            }
                            i = i + 1L;
                        }
                        r.close();
                        r = null;
                    } catch (Exception e) {
                        out.print("alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');");
                        out.print("history.back();");
                    }
                %>
            };
        </script>
    </head>
    <body>
        <%@include file="imgs/navbar.jsp"%>
        
        <div class="container mt-4">
            <h1 class="text-center mb-4"><i class="bi bi-bag-check"></i> Pedidos de <%= na %></h1>
            <%
                try {
                    r = s.executeQuery("SELECT Compra.ImgP,Compra.NP,Compra.PP,Compra.DP,Usuario.N,Usuario.AP,Usuario.AM,Compra.X,Compra.BMsg,Compra.Id,Compra.LP FROM Compra INNER JOIN Usuario ON Compra.V=Usuario.CE WHERE Compra.C='"+session.getAttribute("u")+"' ORDER BY Compra.X DESC, Compra.Fh ASC");
                    if (r.next()) {
                        i = 1L;
                        String minFH = LocalDateTime.now().plusDays(1L).format(DateTimeFormatter.ofPattern("uuuu-MM-ddTHH:mm"));
                        r.beforeFirst();
                        while (r.next()) {
                            String statusClass = "";
                            switch (r.getByte(8)) {
                                case 1: { statusClass = "status-pending"; } break;
                                case 2: { statusClass = "status-waiting"; } break;
                                case 3: { statusClass = "status-accepted"; } break;
                            }
                            out.print("<div class='product-card "+statusClass+"'>");
                                out.print("<div class='row g-0'>");
                                    out.print("<div class='col-md-3'>");
                                        out.print("<img src='imgs/prods/"+r.getString(1)+"' class='product-img' alt='Producto'/>");
                                    out.print("</div>");
                                    out.print("<div class='col-md-9'>");
                                        out.print("<div class='card-body'>");
                                            out.print("<h3 class='card-title'>"+r.getString(2)+"</h3>");
                                            out.print("<h4 class='text-success'>$ "+r.getFloat(3)+" <small class='text-muted'>(c / LOTE)</small></h4>");
                                            out.print("<p class='card-text'>"+r.getString(4)+"</p>");
                                            out.print("<p class='text-muted'><i class='bi bi-person-circle'></i> Vendedor: "+r.getString(5)+" "+r.getString(6)+" "+r.getString(7)+"</p>");
                                            switch (r.getByte(8)) {
                                                case 1: {
                                                    if (r.getBoolean(9)) { out.print("<div class='alert alert-warning'><i class='bi bi-exclamation-triangle'></i> El Vendedor ha Rechazado tu Solicitud... inténtalo de NUEVO...</div>"); }
                                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                                        out.print("<input name='x' type='hidden' value='B1'>");
                                                        out.print("<div class='row'>");
                                                            out.print("<div class='col-md-6'>");
                                                                out.print("<div class='mb-3'>");
                                                                    out.print("<label class='form-label'>Número de Lotes:</label><input name='n' type='number' min='1' max='"+((r.getByte(11) == 0) ? 100 : r.getByte(11))+"' step='1' onchange=\"document.getElementById('t"+i+"').value = Number.parseFloat(this.value) * "+r.getFloat(3)+"\" class='form-control' value='1' required>");
                                                                out.print("</div>");
                                                                out.print("<div class='mb-3'>");
                                                                    out.print("<label class='form-label'>Precio Total:</label><input id='t"+i+"' name='pt' type='number' min='1' max='500000000' class='form-control' readonly value='"+r.getFloat(3)+"' required>");
                                                                out.print("</div>");
                                                                out.print("<div class='mb-3'>");
                                                                    out.print("<label class='form-label'>Lugar de la Compra:</label><input id='m"+i+"' name='u' type='text' class='form-control' readonly value='"+u+"' required>");
                                                                out.print("</div>");
                                                                out.print("<div class='mb-3'>");
                                                                    out.print("<label class='form-label'>Fecha y Hora:</label><input name='fh' type='datetime-local' class='form-control' min='"+minFH+"' required>");
                                                                out.print("</div>");
                                                                out.print("<button type='submit' class='btn btn-custom-green text-white'><i class='bi bi-send'></i> COMUNICAR AL VENDEDOR</button>");
                                                            out.print("</div>");
                                                            out.print("<div class='col-md-6'>");
                                                                out.print("<div id='gMap"+i+"' class='map-container'></div>");
                                                            out.print("</div>");
                                                        out.print("</div>");
                                                    out.print("</form>");
                                                } break;
                                                case 2: {
                                                    out.print("<div class='alert alert-info'><i class='bi bi-hourglass-split'></i> Esperando a que el Vendedor analice tu Solicitud...</div>");
                                                } break;
                                                case 3: {
                                                    out.print("<div class='alert alert-success'><i class='bi bi-check-circle'></i> ¡El Vendedor ha Aceptado tu Solicitud!</div>");
                                                    out.print("<div class='d-flex gap-2'>");
                                                        out.print("<button class='btn btn-custom-blue text-white' onclick=\"location.assign('Interfaz.jsp?x=B3&sn=true&id="+r.getLong(10)+"')\"><i class='bi bi-check'></i> FINALIZAR LA SOLICITUD</button><button class='btn btn-custom-red text-white' onclick=\"location.assign('Interfaz.jsp?x=B3&sn=false&id="+r.getLong(10)+"')\"><i class='bi bi-x'></i> CANCELAR EL PEDIDO</button>");
                                                    out.print("</div>");
                                                } break;
                                            }
                                        out.print("</div>");
                                    out.print("</div>");
                                out.print("</div>");
                            out.print("</div>");
                            i = i + 1L;
                        }
                    } else {
                        out.print("<div class='alert alert-info text-center'><i class='bi bi-info-circle'></i> Sin Pedidos de Compra registrados en tu Cuenta Personal...</div>");
                    }
                    r.close();
                    r = null;
                } catch (Exception e) {
                    out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                    out.print("<script>history.back();</script>");
                }
            %>
            <hr class="my-5">
            <h1 class="text-center mb-4" id="tV"><i class="bi bi-currency-dollar"></i> Ofertas de Venta</h1>
            <%
                try {
                    r = s.executeQuery("SELECT Compra.ImgP,Compra.NP,Compra.PP,Compra.DP,Usuario.N,Usuario.AP,Usuario.AM,Compra.X,Compra.LP,Compra.TP,Compra.Fh,Compra.U,Compra.Id FROM Compra INNER JOIN Usuario ON Compra.C=Usuario.CE WHERE Compra.V='"+session.getAttribute("u")+"' AND Compra.X>1 AND Compra.X<4 ORDER BY Compra.X, Compra.Fh");
                    if (r.next()) {
                        r.beforeFirst();
                        while (r.next()) {
                            out.print("<div class='product-card'>");
                                out.print("<div class='row g-0'>");
                                    out.print("<div class='col-md-3'>");
                                        out.print("<img src='imgs/prods/"+r.getString(1)+"' class='product-img' alt='Producto'/>");
                                    out.print("</div>");
                                    out.print("<div class='col-md-9'>");
                                        out.print("<div class='card-body'>");
                                            out.print("<h3 class='card-title'>"+r.getString(2)+"</h3>");
                                            out.print("<h4 class='text-success'>$ "+r.getFloat(3)+" <small class='text-muted'>(c / LOTE)</small></h4>");
                                            out.print("<p class='card-text'>"+r.getString(4)+"</p>");
                                            out.print("<p class='text-muted'><i class='bi bi-person-circle'></i> Comprador: "+r.getString(5)+" "+r.getString(6)+" "+r.getString(7)+"</p>");
                                            if (r.getByte(8) == 2) {
                                                out.print("<div class='row mb-3'>");
                                                    out.print("<div class='col-md-6'>");
                                                        out.print("<p><strong>Lotes:</strong> "+r.getByte(9)+"</p>");
                                                        out.print("<p><strong>Total:</strong> $"+r.getFloat(10)+"</p>");
                                                    out.print("</div>");
                                                    out.print("<div class='col-md-6'>");
                                                        out.print("<p><strong>Fecha y Hora:</strong> "+r.getTimestamp(11).toLocalDateTime().format(DateTimeFormatter.ofPattern("d / MMM / uuuu -- h:mm a")).toUpperCase()+"</p>");
                                                        out.print("<p><strong>Lugar:</strong> "+r.getString(12)+"</p>");
                                                    out.print("</div>");
                                                out.print("</div>");
                                                out.print("<div class='d-flex gap-2'>");
                                                    out.print("<button class='btn btn-custom-green text-white' onclick=\"location.assign('Interfaz.jsp?x=B2&sn=true&id="+r.getLong(13)+"')\"><i class='bi bi-check'></i> ACEPTAR LA SOLICITUD</button><button class='btn btn-custom-blue text-white' onclick=\"location.assign('Interfaz.jsp?x=B2&sn=false&id="+r.getLong(13)+"')\"><i class='bi bi-x'></i> RECHAZAR LA SOLICITUD</button>");
                                                out.print("</div>");
                                            } else {
                                                out.print("<div class='alert alert-info'><i class='bi bi-hourglass-split'></i> Esperando a que el Comprador analice tu Respuesta...</div>");
                                            }
                                        out.print("</div>");
                                    out.print("</div>");
                                out.print("</div>");
                            out.print("</div>");
                        }
                    } else {
                        out.print("<div class='alert alert-info text-center'><i class='bi bi-info-circle'></i> Sin Ofertas de Venta para TI...</div>");
                    }
                    r.close();
                    r = null;
                    r = s.executeQuery("SELECT * FROM Notificacion WHERE V='"+session.getAttribute("u")+"'");
                    File f;
                    FileWriter w;
                    while (r.next()) {
                        out.print("<script>alert('"+r.getString(3)+" "+r.getString(4)+" "+r.getString(5)+" ha "+(r.getBoolean(6) ? "ACEPTADO" : "CANCELADO")+" este Pedido: "+r.getString(7)+"');</script>");
                        if (r.getBoolean(6)) {
                            f = new File("D:\\V"+r.getLong(1)+".txt");
                            f.createNewFile();
                            w = new FileWriter(f);
                            w.write("Registro Comercial\n\nProducto: "+r.getString(7)+"\nVendedor: "+na+"\nComprador: "+r.getString(3)+" "+r.getString(4)+" "+r.getString(5)+"\nNo. de Lotes: "+r.getByte(8)+"\nCosto: $"+r.getFloat(9)+"\nFecha y Hora: "+r.getTimestamp(10).toLocalDateTime().format(DateTimeFormatter.ofPattern("d / MMM / uuuu -- h:mm a")).toUpperCase()+"\nUbicacion: "+r.getString(11));
                            w.close();
                            w = null;
                        }
                    }
                    if (r.first()) {
                        s.executeUpdate("DELETE FROM Notificacion WHERE V='"+session.getAttribute("u")+"'");
                        s.execute("COMMIT");
                    }
                    r.close();
                    s.close();
                    c.close();
                } catch (Exception e) {
                    out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                    out.print("<script>history.back();</script>");
                }
            %>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>