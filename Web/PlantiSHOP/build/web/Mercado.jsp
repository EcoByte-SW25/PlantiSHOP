<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%!
    Connection c;
    Statement s;
    ResultSet r;
    boolean k;
%>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        c = DriverManager.getConnection("jdbc:mysql://host/PSHOP", "Lector", "Abcd**12345");
        s = c.createStatement();
    } catch (Exception e) {
        out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
        out.print("<script>history.back();</script>");
    }
%>
<!DOCTYPE html>
<html lang="es-MX">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mercado</title>
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
            h2, h3, section p {
                text-align: left;
                font-family: Coco Gothic;
            }
            header h2 {
                color: black;
                text-align: left;
                margin-left: 1.5em;
            }
            fieldset {
                border: 2px double maroon;
            }
            legend {
                color: maroon;
                font-family: Agrandir;
            }
            div {
                display: grid;
                grid-template-columns: 20% 80%;
                border: 1px solid black;
            }
            #PD div {
                background-color: gold;
            }
            #PH div {
                background-color: tomato;
            }
            #PA div {
                background-color: turquoise;
            }
            #A div {
                background-color: greenyellow;
            }
            #AH div {
                background-image: linear-gradient(to right, lime, blanchedalmond);
            }
            #F div {
                background-color: #ff9933;
            }
            #H div {
                background-color: #cccccc;
            }
            aside img, .buy {
                display: block;
                width: 98%;
                margin-left: auto;
                margin-right: auto;
            }
            aside img {
                height: 8em;
            }
            .buy {
                border: 1px solid black;
                border-radius: 2px;
                font-weight: bold;
                background-color: #00ff00;
            }
        </style>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                window.location.hash = "no-back-button";
                window.location.hash = "Again-No-back-button";
                window.onhashchange = function () {
                    window.location.hash = "no-back-button";
                };
            });
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
            <a href="Mensajeria.jsp">Tus Compras</a>
            <a href="FAQ.html">FAQ</a>
            <a href="premium/Premium.jsp">Apartado PREMIUM</a>
        </nav>
        <h1>Mercado</h1>
        <hr>
        <fieldset id="PD">
            <legend>Plantas Decorativas</legend>
            <%
                try {
                    r = s.executeQuery("SELECT Productos.Img,Productos.Id,Productos.N,Productos.P,Productos.D,Usuarios.N,Usuarios.AP,Usuarios.AM FROM Productos INNER JOIN Usuarios ON Productos.CE=Usuarios.CE WHERE Productos.T='PD' ORDER BY Productos.Pop DESC");
                    if (r.next()) {
                        k = true;
                        while (r.next()) {
                            if (k) {
                                r.first();
                                k = false;
                            }
                            out.print("<div>");
                                out.print("<aside>");
                                    out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Planta Decorativa'/>");
                                    out.print("<button class='buy' onclick=\"location.assign('Interfaz.jsp?x=B&id="+r.getLong(2)+"')\">COMPRAR</button>");
                                out.print("</aside>");
                                out.print("<section>");
                                    out.print("<h1>"+r.getString(3)+"</h1>");
                                    out.print("<h2>$ "+r.getFloat(4)+"</h2>");
                                    out.print("<p>"+r.getString(5)+"</p>");
                                    out.print("<br>");
                                    out.print("<h3>Vendedor: "+r.getString(6)+" "+r.getString(7)+" "+r.getString(8)+"</h3>");
                                out.print("</section>");
                            out.print("</div>");
                        }
                    } else {
                        out.print("<p>Lo sentimos... NO hay Ofertas en este apartado!</p>");
                    }
                } catch (Exception e) {
                    out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                    out.print("<script>history.back();</script>");
                }
            %>
        </fieldset>
        <fieldset id="PH">
            <legend>Plantas de Huerto</legend>
            <%
                try {
                    r = s.executeQuery("SELECT Productos.Img,Productos.Id,Productos.N,Productos.P,Productos.D,Usuarios.N,Usuarios.AP,Usuarios.AM FROM Productos INNER JOIN Usuarios ON Productos.CE=Usuarios.CE WHERE Productos.T='PH' ORDER BY Productos.Pop DESC");
                    if (r.next()) {
                        k = true;
                        while (r.next()) {
                            if (k) {
                                r.first();
                                k = false;
                            }
                            out.print("<div>");
                                out.print("<aside>");
                                    out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Planta de Huerto'/>");
                                    out.print("<button class='buy' onclick=\"location.assign('Interfaz.jsp?x=B&id="+r.getLong(2)+"')\">COMPRAR</button>");
                                out.print("</aside>");
                                out.print("<section>");
                                    out.print("<h1>"+r.getString(3)+"</h1>");
                                    out.print("<h2>$ "+r.getFloat(4)+"</h2>");
                                    out.print("<p>"+r.getString(5)+"</p>");
                                    out.print("<br>");
                                    out.print("<h3>Vendedor: "+r.getString(6)+" "+r.getString(7)+" "+r.getString(8)+"</h3>");
                                out.print("</section>");
                            out.print("</div>");
                        }
                    } else {
                        out.print("<p>Lo sentimos... NO hay Ofertas en este apartado!</p>");
                    }
                } catch (Exception e) {
                    out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                    out.print("<script>history.back();</script>");
                }
            %>
        </fieldset>
        <fieldset id="PA">
            <legend>Plantas Acuaticas</legend>
            <%
                try {
                    r = s.executeQuery("SELECT Productos.Img,Productos.Id,Productos.N,Productos.P,Productos.D,Usuarios.N,Usuarios.AP,Usuarios.AM FROM Productos INNER JOIN Usuarios ON Productos.CE=Usuarios.CE WHERE Productos.T='PA' ORDER BY Productos.Pop DESC");
                    if (r.next()) {
                        k = true;
                        while (r.next()) {
                            if (k) {
                                r.first();
                                k = false;
                            }
                            out.print("<div>");
                                out.print("<aside>");
                                    out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Planta Acuatica'/>");
                                    out.print("<button class='buy' onclick=\"location.assign('Interfaz.jsp?x=B&id="+r.getLong(2)+"')\">COMPRAR</button>");
                                out.print("</aside>");
                                out.print("<section>");
                                    out.print("<h1>"+r.getString(3)+"</h1>");
                                    out.print("<h2>$ "+r.getFloat(4)+"</h2>");
                                    out.print("<p>"+r.getString(5)+"</p>");
                                    out.print("<br>");
                                    out.print("<h3>Vendedor: "+r.getString(6)+" "+r.getString(7)+" "+r.getString(8)+"</h3>");
                                out.print("</section>");
                            out.print("</div>");
                        }
                    } else {
                        out.print("<p>Lo sentimos... NO hay Ofertas en este apartado!</p>");
                    }
                } catch (Exception e) {
                    out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                    out.print("<script>history.back();</script>");
                }
            %>
        </fieldset>
        <fieldset id="A">
            <legend>Árboles</legend>
            <%
                try {
                    r = s.executeQuery("SELECT Productos.Img,Productos.Id,Productos.N,Productos.P,Productos.D,Usuarios.N,Usuarios.AP,Usuarios.AM FROM Productos INNER JOIN Usuarios ON Productos.CE=Usuarios.CE WHERE Productos.T='A' ORDER BY Productos.Pop DESC");
                    if (r.next()) {
                        k = true;
                        while (r.next()) {
                            if (k) {
                                r.first();
                                k = false;
                            }
                            out.print("<div>");
                                out.print("<aside>");
                                    out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Árbol'/>");
                                    out.print("<button class='buy' onclick=\"location.assign('Interfaz.jsp?x=B&id="+r.getLong(2)+"')\">COMPRAR</button>");
                                out.print("</aside>");
                                out.print("<section>");
                                    out.print("<h1>"+r.getString(3)+"</h1>");
                                    out.print("<h2>$ "+r.getFloat(4)+"</h2>");
                                    out.print("<p>"+r.getString(5)+"</p>");
                                    out.print("<br>");
                                    out.print("<h3>Vendedor: "+r.getString(6)+" "+r.getString(7)+" "+r.getString(8)+"</h3>");
                                out.print("</section>");
                            out.print("</div>");
                        }
                    } else {
                        out.print("<p>Lo sentimos... NO hay Ofertas en este apartado!</p>");
                    }
                } catch (Exception e) {
                    out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                    out.print("<script>history.back();</script>");
                }
            %>
        </fieldset>
        <fieldset id="AH">
            <legend>Algas y Hongos</legend>
            <%
                try {
                    r = s.executeQuery("SELECT Productos.Img,Productos.Id,Productos.N,Productos.P,Productos.D,Usuarios.N,Usuarios.AP,Usuarios.AM FROM Productos INNER JOIN Usuarios ON Productos.CE=Usuarios.CE WHERE Productos.T='AH' ORDER BY Productos.Pop DESC");
                    if (r.next()) {
                        k = true;
                        while (r.next()) {
                            if (k) {
                                r.first();
                                k = false;
                            }
                            out.print("<div>");
                                out.print("<aside>");
                                    out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Alga / Hongo'/>");
                                    out.print("<button class='buy' onclick=\"location.assign('Interfaz.jsp?x=B&id="+r.getLong(2)+"')\">COMPRAR</button>");
                                out.print("</aside>");
                                out.print("<section>");
                                    out.print("<h1>"+r.getString(3)+"</h1>");
                                    out.print("<h2>$ "+r.getFloat(4)+"</h2>");
                                    out.print("<p>"+r.getString(5)+"</p>");
                                    out.print("<br>");
                                    out.print("<h3>Vendedor: "+r.getString(6)+" "+r.getString(7)+" "+r.getString(8)+"</h3>");
                                out.print("</section>");
                            out.print("</div>");
                        }
                    } else {
                        out.print("<p>Lo sentimos... NO hay Ofertas en este apartado!</p>");
                    }
                } catch (Exception e) {
                    out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                    out.print("<script>history.back();</script>");
                }
            %>
        </fieldset>
        <fieldset id="F">
            <legend>Fertilizantes</legend>
            <%
                try {
                    r = s.executeQuery("SELECT Productos.Img,Productos.Id,Productos.N,Productos.P,Productos.D,Usuarios.N,Usuarios.AP,Usuarios.AM FROM Productos INNER JOIN Usuarios ON Productos.CE=Usuarios.CE WHERE Productos.T='F' ORDER BY Productos.Pop DESC");
                    if (r.next()) {
                        k = true;
                        while (r.next()) {
                            if (k) {
                                r.first();
                                k = false;
                            }
                            out.print("<div>");
                                out.print("<aside>");
                                    out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Fertilizante'/>");
                                    out.print("<button class='buy' onclick=\"location.assign('Interfaz.jsp?x=B&id="+r.getLong(2)+"')\">COMPRAR</button>");
                                out.print("</aside>");
                                out.print("<section>");
                                    out.print("<h1>"+r.getString(3)+"</h1>");
                                    out.print("<h2>$ "+r.getFloat(4)+"</h2>");
                                    out.print("<p>"+r.getString(5)+"</p>");
                                    out.print("<br>");
                                    out.print("<h3>Vendedor: "+r.getString(6)+" "+r.getString(7)+" "+r.getString(8)+"</h3>");
                                out.print("</section>");
                            out.print("</div>");
                        }
                    } else {
                        out.print("<p>Lo sentimos... NO hay Ofertas en este apartado!</p>");
                    }
                } catch (Exception e) {
                    out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                    out.print("<script>history.back();</script>");
                }
            %>
        </fieldset>
        <fieldset id="H">
            <legend>Herramientas</legend>
            <%
                try {
                    r = s.executeQuery("SELECT Productos.Img,Productos.Id,Productos.N,Productos.P,Productos.D,Usuarios.N,Usuarios.AP,Usuarios.AM FROM Productos INNER JOIN Usuarios ON Productos.CE=Usuarios.CE WHERE Productos.T='H' ORDER BY Productos.Pop DESC");
                    if (r.next()) {
                        k = true;
                        while (r.next()) {
                            if (k) {
                                r.first();
                                k = false;
                            }
                            out.print("<div>");
                                out.print("<aside>");
                                    out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Herramienta'/>");
                                    out.print("<button class='buy' onclick=\"location.assign('Interfaz.jsp?x=B&id="+r.getLong(2)+"')\">COMPRAR</button>");
                                out.print("</aside>");
                                out.print("<section>");
                                    out.print("<h1>"+r.getString(3)+"</h1>");
                                    out.print("<h2>$ "+r.getFloat(4)+"</h2>");
                                    out.print("<p>"+r.getString(5)+"</p>");
                                    out.print("<br>");
                                    out.print("<h3>Vendedor: "+r.getString(6)+" "+r.getString(7)+" "+r.getString(8)+"</h3>");
                                out.print("</section>");
                            out.print("</div>");
                        }
                    } else {
                        out.print("<p>Lo sentimos... NO hay Ofertas en este apartado!</p>");
                    }
                } catch (Exception e) {
                    out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                    out.print("<script>history.back();</script>");
                }
            %>
        </fieldset>
    </body>
</html>
<%
    r.close();
    s.close();
    c.close();
%>