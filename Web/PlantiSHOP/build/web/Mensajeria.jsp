<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="auxs.Hash"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%!
    Connection c;
    Statement s;
    ResultSet r;
    Hash h;
    File f;
    FileWriter w;
    boolean k;
    long i;
    String na, u, minFH;
%>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        c = DriverManager.getConnection("jdbc:mysql://host/PSHOP", "Crud", "PlantiSHOP-+CrUd*/https:02468.!?");
        s = c.createStatement();
        r = s.executeQuery("SELECT N,AP,AM,U FROM Usuarios WHERE CE='"+session.getAttribute("u")+"'");
        r.next();
        na = r.getString(1) + " " + r.getString(2) + " " + r.getString(3);
        h = new Hash();
        u = h.descifrar(r.getString(4));
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
        <style>
            body {
                background-image: url(imgs/fondo3.png);
                background-repeat: no-repeat;
                background-size: cover;
                background-attachment: fixed;
                background-position: center center;
            }
            header, nav {
                margin: 0;
            }
            header {
                background-color: #cccccc;
                display: grid;
                grid-template-columns: 90% 10%;
            }
            img {
                width: 2em;
                height: 2em;
                vertical-align: middle;
            }
            #Gral {
                position: relative;
            }
            #Gral img {
                width: 95%;
                height: 5em;
                margin: 0.5em auto 0 auto;
            }
            ul {
                display: none;
                position: absolute;
                list-style-type: none;
                padding: 0;
                background-color: #009900;
            }
            #Gral:hover ul {
                display: block;
            }
            li a:link, li a:active, li a:visited {
                display: block;
                color: white;
                padding: 1.2em;
                border: 1px solid white;
                font-weight: bold;
                text-decoration: none;
                font-family: Coco Gothic;
            }
            nav {
                padding: 0;
                overflow: hidden;
                background-color: green;
            }
            nav a:link, nav a:active, nav a:visited {
                float: left;
                color: white;
                padding: 1.5em;
                font-weight: bold;
                text-decoration: none;
                font-family: Coco Gothic;
            }
            li a:hover, nav a:hover {
                color: black;
                background-color: greenyellow;
            }
            h1, p {
                text-align: center;
                font-family: Agrandir;
            }
            .cU article p {
                font-family: Coco Gothic;
            }
            h2, h3, section p, .vU article p {
                text-align: left;
                font-family: Coco Gothic;
            }
            header h2 {
                color: black;
                text-align: left;
                margin-left: 1.5em;
            }
            .pc, article h2 {
                text-align: center;
            }
            .cU, .vU {
                display: grid;
                grid-template-columns: 20% 80%;
                border: 1px solid black;
            }
            .cU {
                background-color: chartreuse;
            }
            .vU {
                background-color: gold;
            }
            aside img {
                display: block;
                width: 98%;
                height: 8em;
                margin-left: auto;
                margin-right: auto;
            }
            article {
                grid-column: 1 / span 2;
            }
            form {
                display: grid;
                grid-template-columns: 34% 32% 34%;
            }
            form h2 {
                grid-column: 1 / span 3;
            }
            input {
                width: 95%;
                border: 1px solid black;
                font-family: Arial;
                vertical-align: middle;
            }
            button {
                color: white;
                font-weight: 800;
                border: none;
                border-radius: 5px;
                font-family: Agrandir;
                vertical-align: middle;
            }
            .sm1 {
                font-family: Agrandir;
                background-color: #00cc00;
            }
            .sm2 {
                background-color: navy;
            }
            .sm3 {
                background-color: #cc0000;
            }
        </style>
        <script src="https://maps.googleapis.com/maps/api/js?key=&callback=initMap&v=weekly" defer></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                window.location.hash = "no-back-button";
                window.location.hash = "Again-No-back-button";
                window.onhashchange = function () {
                    window.location.hash = "no-back-button";
                };
            });
            let latd, lngd;
            (new google.maps.Geocoder()).geocode({ address: "<%= u %>" }).then(function (r) {
                latd = r.results[0].geometry.location.lat;
                lngd = r.results[0].geometry.location.lng;
            });
            function initMap(n) {
                (new google.maps.Map(document.getElementById('gMap'+n), {
                    center: {
                        lat: (latd ?? 19.4326077),
                        lng: (lngd ?? -99.133208)
                    },
                    zoom: 8,
                    mapTypeControl: false
                })).addListener('click', function (ev) {
                    (new google.maps.Geocoder()).geocode({ location: ev.latLng }).then(
                        function (r) {
                            document.getElementById('m'+n).value = r.results[0].formatted_address;
                        },
                        function (er) {
                            alert('Lo sentimos, se produjo un ERROR:\n'+er);
                        }
                    );
                });
            }
        </script>
    </head>
    <body>
        <header>
            <h2><img src="imgs/logo.png" alt="Logo"/>&nbsp;&nbsp;PlantiSHOP</h2>
            <div>
                <img src="imgs/perfil.jpg" alt="Perfil"/>
                <ul>
                    <li><a href="Perfil.jsp">Tu Perfil</a></li>
                    <li><a href="Interfaz.jsp?x=E">Cerrar Sesión</a></li>
                </ul>
            </div>
        </header>
        <nav>
            <a href="Mercado.jsp#PD">Plantas Decorativas</a>
            <a href="Mercado.jsp#PH">Plantas de Huerto</a>
            <a href="Mercado.jsp#PA">Plantas Acuaticas</a>
            <a href="Mercado.jsp#A">Árboles</a>
            <a href="Mercado.jsp#AH">Algas y Hongos</a>
            <a href="Mercado.jsp#F">Fertilizantes</a>
            <a href="Mercado.jsp#H">Herramientas</a>
            <a href="Ventas.jsp">Tus Ventas</a>
            <a href="FAQ.html">FAQ</a>
            <a href="premium/Premium.jsp">Apartado PREMIUM</a>
        </nav>
        <h1>Pedidos de <%= na %></h1>
        <%
            try {
                r = s.executeQuery("SELECT Compras.ImgP,Compras.NP,Compras.PP,Compras.DP,Usuarios.N,Usuarios.AP,Usuarios.AM,Compras.X,Compras.BMsg,Compras.Id FROM Compras INNER JOIN Usuarios ON Compras.V=Usuarios.CE WHERE Compras.C='"+session.getAttribute("u")+"' ORDER BY Compras.X DESC, Compras.Fh ASC");
                if (r.next()) {
                    k = true;
                    i = 1L;
                    minFH = LocalDateTime.now().plusDays(1L).format(DateTimeFormatter.ofPattern("uuuu-MM-ddTHH:mm"));
                    while (r.next()) {
                        if (k) {
                            r.first();
                            k = false;
                        }
                        out.print("<div class='cU'>");
                            out.print("<aside>");
                                out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Producto'/>");
                            out.print("</aside>");
                            out.print("<section>");
                                out.print("<h1>"+r.getString(2)+"</h1>");
                                out.print("<h2>$ "+r.getFloat(3)+" (c / LOTE)</h2>");
                                out.print("<p>"+r.getString(4)+"</p>");
                                out.print("<br>");
                                out.print("<h3>Vendedor: "+r.getString(5)+" "+r.getString(6)+" "+r.getString(7)+"</h3>");
                            out.print("</section>");
                            out.print("<article>");
                                switch (r.getByte(8)) {
                                    case 1: {
                                        if (r.getBoolean(9)) { out.print("<h1>El Vendedor ha Rechazado tu Solicitud... intentalo de NUEVO...</h1>"); }
                                        out.print("<form action='Interfaz.jsp' method='post'>");
                                            out.print("<h2>Datos del Pedido</h2>");
                                            out.print("<div>");
                                                out.print("<input name='x' type='hidden' value='B1'>");
                                                out.print("<p>Número de Lotes a Comprar: <input name='n' type='number' min='1' max='100' step='1' onchange=\"document.getElementById('t"+i+"').value = Number.parseFloat(this.value) * "+r.getFloat(3)+"\" value='1' required></p>");
                                                out.print("<p>Precio Total: <input id='t"+i+"' name='pt' type='number' min='1' max='500000000' readonly value='"+r.getFloat(3)+"' required></p>");
                                            out.print("</div>");
                                            out.print("<div id='gMap"+i+"' onload='initMap("+i+")'></div>");
                                            out.print("<div>");
                                                out.print("<p>Lugar de la Compra: <input id='m"+i+"' name='u' type='text' readonly value='"+u+"' required></p>");
                                                out.print("<p>Fecha y Hora de la Compra: <input name='fh' type='datetime-local' min='"+minFH+"' required></p>");
                                                out.print("<p><input class='sm1' type='submit' value='COMUNICAR AL VENDEDOR'></p>");
                                            out.print("</div>");
                                        out.print("</form>");
                                    } break;
                                    case 2: {
                                        out.print("<h1>Esperando a que el Vendedor analice tu Solicitud...</h1>");
                                    } break;
                                    case 3: {
                                        out.print("<h1>¡El Vendedor ha Aceptado tu Solicitud!</h1>");
                                        out.print("<p><button class='sm2' onclick=\"location.assign('Interfaz.jsp?x=B3&sn=true&id="+r.getLong(10)+"')\">FINALIZAR LA SOLICITUD</button><button class='sm3' onclick=\"location.assign('Interfaz.jsp?x=B3&sn=false&id="+r.getLong(10)+"')\">CANCELAR EL PEDIDO</button></p>");
                                    } break;
                                }
                            out.print("</article>");
                        out.print("</div>");
                        i = i + 1L;
                    }
                } else {
                    out.print("<p>Sin Pedidos de Compra registrados en tu Cuenta Personal...</p>");
                }
            } catch (Exception e) {
                out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                out.print("<script>history.back();</script>");
            }
        %>
        <hr>
        <h1 id="tV">Ofertas de Venta</h1>
        <%
            try {
                r = s.executeQuery("SELECT Compras.ImgP,Compras.NP,Compras.PP,Compras.DP,Usuarios.N,Usuarios.AP,Usuarios.AM,Compras.X,Compras.LP,Compras.TP,Compras.Fh,Compras.U,Compras.Id FROM Compras INNER JOIN Usuarios ON Compras.C=Usuarios.CE WHERE Compras.V='"+session.getAttribute("u")+"' ORDER BY Compras.X, Compras.Fh");
                if (r.next()) {
                    k = true;
                    while (r.next() && r.getByte(8) != 1) {
                        if (k) {
                            r.first();
                            if (r.getByte(8) == 1) { continue; }
                            k = false;
                        }
                        out.print("<div class='vU'>");
                            out.print("<aside>");
                                out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Producto'/>");
                            out.print("</aside>");
                            out.print("<section>");
                                out.print("<h1>"+r.getString(2)+"</h1>");
                                out.print("<h2>$ "+r.getFloat(3)+" (c / LOTE)</h2>");
                                out.print("<p>"+r.getString(4)+"</p>");
                                out.print("<br>");
                                out.print("<h3>Comprador: "+r.getString(5)+" "+r.getString(6)+" "+r.getString(7)+"</h3>");
                            out.print("</section>");
                            out.print("<article>");
                                if (r.getByte(8) == 2) {
                                    out.print("<p>Número de Lotes a Comprar: "+r.getByte(9)+"</p>");
                                    out.print("<p>Precio Total: $"+r.getFloat(10)+"</p>");
                                    out.print("<p>Fecha y Hora de la Compra: "+r.getTimestamp(11).toLocalDateTime().format(DateTimeFormatter.ofPattern("d / MMM / uuuu -- h:mm a")).toUpperCase()+"</p>");
                                    out.print("<p>Lugar de la Compra: "+r.getString(12)+"</p>");
                                    out.print("<p class='pc'><button class='sm1' onclick=\"location.assign('Interfaz.jsp?x=B2&sn=true&id="+r.getLong(13)+"')\">ACEPTAR LA SOLICITUD</button><button class='sm2' onclick=\"location.assign('Interfaz.jsp?x=B2&sn=false&id="+r.getLong(13)+"')\">RECHAZAR LA SOLICITUD</button></p>");
                                } else {
                                    out.print("<h1>Esperando a que el Comprador analice tu Respuesta...</h1>");
                                }
                            out.print("</article>");
                        out.print("</div>");
                    }
                } else {
                    out.print("<p>Sin Ofertas de Venta para TI...</p>");
                }
                r = s.executeQuery("SELECT * FROM Notificaciones WHERE V='"+session.getAttribute("u")+"'");
                while (r.next()) {
                    out.print("<script>alert('"+r.getString(3)+" "+r.getString(4)+" "+r.getString(5)+" ha "+(r.getBoolean(6) ? "ACEPTADO" : "CANCELADO")+" este Pedido: "+r.getString(7)+"');</script>");
                    if (r.getBoolean(6)) {
                        f = new File("D:\\V"+r.getLong(1)+".txt");
                        f.createNewFile();
                        w = new FileWriter(f);
                        w.write("Registro Comercial\n\nProducto: "+r.getString(7)+"\nVendedor: "+na+"\nComprador: "+r.getString(3)+" "+r.getString(4)+" "+r.getString(5)+"\nNo. de Lotes: "+r.getByte(8)+"\nCosto: $"+r.getFloat(9)+"\nFecha y Hora: "+r.getTimestamp(10).toLocalDateTime().format(DateTimeFormatter.ofPattern("d / MMM / uuuu -- h:mm a")).toUpperCase()+"\nUbicacion: "+h.descifrar(r.getString(11)));
                        w.close();
                        w = null;
                    }
                }
                if (r.first()) {
                    s.executeUpdate("DELETE FROM Notificacion WHERE V='"+session.getAttribute("u")+"'");
                    s.execute("COMMIT");
                }
            } catch (Exception e) {
                out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                out.print("<script>history.back();</script>");
            }
        %>
    </body>
</html>
<%
    r.close();
    s.close();
    c.close();
%>