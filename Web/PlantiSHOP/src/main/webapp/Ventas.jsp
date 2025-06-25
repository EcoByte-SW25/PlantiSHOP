<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%!
    Connection c;
    Statement s;
    ResultSet r;
    String na;
%>
<%
    try {
        if (session.getAttribute("msg") != null) {
            out.print("<script>alert('"+session.getAttribute("msg")+"');</script>");
            session.removeAttribute("msg");
        }
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        c = DriverManager.getConnection("jdbc:mysql://192.168.1.66/PSHOP", "Lector", "Abcd**12345");
        s = c.createStatement();
        r = s.executeQuery("SELECT N,AP,AM FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
        r.next();
        na = r.getString(1) + " " + r.getString(2) + " " + r.getString(3);
    } catch (Exception e) {
        out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
        out.print("<script>history.back();</script>");
    }
%>
<!DOCTYPE html>
<html lang="es-MX">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ventas del Usuario</title>
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
            h1, h2 {
                text-align: center;
                font-family: Agrandir;
            }
            label, input, select, textarea {
                display: block;
                width: 92%;
                margin-left: auto;
                margin-right: auto;
                font-family: Coco Gothic;
            }
            select {
                border: 2px solid black;
                font-weight: bold;
                font-size: 1vw;
                background-image: linear-gradient(to right, orange, yellow, yellowgreen, cyan);
            }
            input, textarea {
                border: 1px solid black;
                font-family: Arial;
            }
            #sm {
                width: 40%;
                background-color: green;
                color: white;
                font-weight: bold;
                font-family: Agrandir;
                border: 2px solid white;
            }
            #sm:hover {
                background-color: greenyellow;
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
            .pD {
                background-color: gold;
            }
            .pH {
                background-color: tomato;
            }
            .pA {
                background-color: turquoise;
            }
            .A {
                background-color: greenyellow;
            }
            .aH {
                background-image: linear-gradient(to right, lime, blanchedalmond);
            }
            .F {
                background-color: #ff9933;
            }
            .H {
                background-color: #cccccc;
            }
            aside img, .d {
                display: block;
                width: 98%;
                margin-left: auto;
                margin-right: auto;
            }
            aside img {
                height: 8em;
            }
            .d {
                color: white;
                border: 1px solid white;
                border-radius: 2px;
                background-color: red;
            }
            p input {
                display: inline;
                width: 5em;
                margin: 0;
                vertical-align: middle;
            }
            .u {
                width: 50%;
                color: white;
                vertical-align: middle;
                border: 1px solid white;
                border-radius: 2px;
                background-color: blue;
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
        <h1>Ventas de <%= na %></h1>
        <hr>
        <form action="UpVentas" method="post" enctype="multipart/form-data">
            <input name="x" type="hidden" value="true">
            <h2>Registro de Producto en el Sistema</h2>
            <label for="i1">Nombre del Producto:</label>
            <input id="i1" name="n" type="text" pattern="[A-Za-z0-9\s]+" maxlength="80" required>
            <label for="i2">Descripción del Producto:</label>
            <textarea id="i2" name="txt" pattern="[A-Za-z0-9\s]+" maxlength="800"></textarea>
            <label for="i3">Tipo de Producto:</label>
            <select id="i3" name="t" required>
                <optgroup label="Plantaciones">
                    <option value="PD" selected>Planta Decorativa</option>
                    <option value="PH">Planta de Huerto</option>
                    <option value="PA">Planta Acuatica</option>
                    <option value="A">Árbol</option>
                    <option value="AH">Alga u Hongo</option>
                </optgroup>
                <option value="F">Fertilizante</option>
                <option value="H">Herramienta</option>
            </select>
            <label for="i4">Precio del Producto:</label>
            <input id="i4" name="p" type="number" min="1" max="5000000" required>
            <label for="i5">Cantidad del Producto:</label>
            <input id="i5" name="c" type="number" min="1" max="1000000" step="1" required>
            <label for="i6">Imagen del Producto:</label>
            <input id="i6" name="i" type="file" accept="image/*" required>
            <input id="sm" type="submit" value="REGISTRAR">
        </form>
        <hr>
        <%
            try {
                r = s.executeQuery("SELECT Img,Id,N,P,D,Cupo FROM Producto WHERE CE='"+session.getAttribute("u")+"' AND T='PD' ORDER BY Pop DESC, Cupo ASC");
                if (r.getFetchSize() > 0) {
                    out.print("<fieldset>");
                        out.print("<legend>Plantas Decorativas</legend>");
                        while (r.next()) {
                            out.print("<div class='pD'>");
                                out.print("<aside>");
                                    out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Planta Decorativa'/>");
                                    out.print("<form action='UpVentas' method='post' enctype='multipart/form-data'>");
                                        out.print("<input name='x' type='hidden' value='false'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<input name='i' type='file' accept='image/*' required><input class='u' type='submit' value='CAMBIAR esta Imagen'>");
                                    out.print("</form>");
                                    out.print("<button class='d' onclick=\"location.assign('Interfaz.jsp?x=D2&t=Producto&id="+r.getLong(2)+"')\">ELIMINAR</button>");
                                out.print("</aside>");
                                out.print("<section>");
                                    out.print("<h1>"+r.getString(3)+"</h1>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Upv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<p>Precio: <input name='p' type='number' min='1' max='5000000' value='"+r.getFloat(4)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Utxtv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<textarea name='txt' pattern='[A-Za-z0-9\\s]+' maxlength='800' value='"+r.getString(5)+"'></textarea>");
                                        out.print("<input class='u' type='submit' value='CAMBIAR esta Descripción'>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Ucv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<p>Cantidad: <input name='c' type='number' min='1' max='1000000' step='1' value='"+r.getInt(6)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                out.print("</section>");
                            out.print("</div>");
                        }
                    out.print("</fieldset>");
                }
                r = s.executeQuery("SELECT Img,Id,N,P,D,Cupo FROM Producto WHERE CE='"+session.getAttribute("u")+"' AND T='PH' ORDER BY Pop DESC, Cupo ASC");
                if (r.getFetchSize() > 0) {
                    out.print("<fieldset>");
                        out.print("<legend>Plantas de Huerto</legend>");
                        while (r.next()) {
                            out.print("<div class='pH'>");
                                out.print("<aside>");
                                    out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Planta de Huerto'/>");
                                    out.print("<form action='UpVentas' method='post' enctype='multipart/form-data'>");
                                        out.print("<input name='x' type='hidden' value='false'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<input name='i' type='file' accept='image/*' required><input class='u' type='submit' value='CAMBIAR esta Imagen'>");
                                    out.print("</form>");
                                    out.print("<button class='d' onclick=\"location.assign('Interfaz.jsp?x=D2&t=Producto&id="+r.getLong(2)+"')\">ELIMINAR</button>");
                                out.print("</aside>");
                                out.print("<section>");
                                    out.print("<h1>"+r.getString(3)+"</h1>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Upv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<p>Precio: <input name='p' type='number' min='1' max='5000000' value='"+r.getFloat(4)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Utxtv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<textarea name='txt' pattern='[A-Za-z0-9\\s]+' maxlength='800' value='"+r.getString(5)+"'></textarea>");
                                        out.print("<input class='u' type='submit' value='CAMBIAR esta Descripción'>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Ucv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<p>Cantidad: <input name='c' type='number' min='1' max='1000000' step='1' value='"+r.getInt(6)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                out.print("</section>");
                            out.print("</div>");
                        }
                    out.print("</fieldset>");
                }
                r = s.executeQuery("SELECT Img,Id,N,P,D,Cupo FROM Producto WHERE CE='"+session.getAttribute("u")+"' AND T='PA' ORDER BY Pop DESC, Cupo ASC");
                if (r.getFetchSize() > 0) {
                    out.print("<fieldset>");
                        out.print("<legend>Plantas Acuaticas</legend>");
                        while (r.next()) {
                            out.print("<div class='pA'>");
                                out.print("<aside>");
                                    out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Planta Acuatica'/>");
                                    out.print("<form action='UpVentas' method='post' enctype='multipart/form-data'>");
                                        out.print("<input name='x' type='hidden' value='false'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<input name='i' type='file' accept='image/*' required><input class='u' type='submit' value='CAMBIAR esta Imagen'>");
                                    out.print("</form>");
                                    out.print("<button class='d' onclick=\"location.assign('Interfaz.jsp?x=D2&t=Producto&id="+r.getLong(2)+"')\">ELIMINAR</button>");
                                out.print("</aside>");
                                out.print("<section>");
                                    out.print("<h1>"+r.getString(3)+"</h1>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Upv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<p>Precio: <input name='p' type='number' min='1' max='5000000' value='"+r.getFloat(4)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Utxtv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<textarea name='txt' pattern='[A-Za-z0-9\\s]+' maxlength='800' value='"+r.getString(5)+"'></textarea>");
                                        out.print("<input class='u' type='submit' value='CAMBIAR esta Descripción'>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Ucv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<p>Cantidad: <input name='c' type='number' min='1' max='1000000' step='1' value='"+r.getInt(6)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                out.print("</section>");
                            out.print("</div>");
                        }
                    out.print("</fieldset>");
                }
                r = s.executeQuery("SELECT Img,Id,N,P,D,Cupo FROM Producto WHERE CE='"+session.getAttribute("u")+"' AND T='A' ORDER BY Pop DESC, Cupo ASC");
                if (r.getFetchSize() > 0) {
                    out.print("<fieldset>");
                        out.print("<legend>Árboles</legend>");
                        while (r.next()) {
                            out.print("<div class='A'>");
                                out.print("<aside>");
                                    out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Árbol'/>");
                                    out.print("<form action='UpVentas' method='post' enctype='multipart/form-data'>");
                                        out.print("<input name='x' type='hidden' value='false'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<input name='i' type='file' accept='image/*' required><input class='u' type='submit' value='CAMBIAR esta Imagen'>");
                                    out.print("</form>");
                                    out.print("<button class='d' onclick=\"location.assign('Interfaz.jsp?x=D2&t=Producto&id="+r.getLong(2)+"')\">ELIMINAR</button>");
                                out.print("</aside>");
                                out.print("<section>");
                                    out.print("<h1>"+r.getString(3)+"</h1>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Upv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<p>Precio: <input name='p' type='number' min='1' max='5000000' value='"+r.getFloat(4)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Utxtv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<textarea name='txt' pattern='[A-Za-z0-9\\s]+' maxlength='800' value='"+r.getString(5)+"'></textarea>");
                                        out.print("<input class='u' type='submit' value='CAMBIAR esta Descripción'>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Ucv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<p>Cantidad: <input name='c' type='number' min='1' max='1000000' step='1' value='"+r.getInt(6)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                out.print("</section>");
                            out.print("</div>");
                        }
                    out.print("</fieldset>");
                }
                r = s.executeQuery("SELECT Img,Id,N,P,D,Cupo FROM Producto WHERE CE='"+session.getAttribute("u")+"' AND T='AH' ORDER BY Pop DESC, Cupo ASC");
                if (r.getFetchSize() > 0) {
                    out.print("<fieldset>");
                        out.print("<legend>Algas y/u Hongos</legend>");
                        while (r.next()) {
                            out.print("<div class='aH'>");
                                out.print("<aside>");
                                    out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Alga / Hongo'/>");
                                    out.print("<form action='UpVentas' method='post' enctype='multipart/form-data'>");
                                        out.print("<input name='x' type='hidden' value='false'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<input name='i' type='file' accept='image/*' required><input class='u' type='submit' value='CAMBIAR esta Imagen'>");
                                    out.print("</form>");
                                    out.print("<button class='d' onclick=\"location.assign('Interfaz.jsp?x=D2&t=Producto&id="+r.getLong(2)+"')\">ELIMINAR</button>");
                                out.print("</aside>");
                                out.print("<section>");
                                    out.print("<h1>"+r.getString(3)+"</h1>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Upv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<p>Precio: <input name='p' type='number' min='1' max='5000000' value='"+r.getFloat(4)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Utxtv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<textarea name='txt' pattern='[A-Za-z0-9\\s]+' maxlength='800' value='"+r.getString(5)+"'></textarea>");
                                        out.print("<input class='u' type='submit' value='CAMBIAR esta Descripción'>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Ucv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<p>Cantidad: <input name='c' type='number' min='1' max='1000000' step='1' value='"+r.getInt(6)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                out.print("</section>");
                            out.print("</div>");
                        }
                    out.print("</fieldset>");
                }
                r = s.executeQuery("SELECT Img,Id,N,P,D,Cupo FROM Producto WHERE CE='"+session.getAttribute("u")+"' AND T='F' ORDER BY Pop DESC, Cupo ASC");
                if (r.getFetchSize() > 0) {
                    out.print("<fieldset>");
                        out.print("<legend>Fertilizantes</legend>");
                        while (r.next()) {
                            out.print("<div class='F'>");
                                out.print("<aside>");
                                    out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Fertilizante'/>");
                                    out.print("<form action='UpVentas' method='post' enctype='multipart/form-data'>");
                                        out.print("<input name='x' type='hidden' value='false'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<input name='i' type='file' accept='image/*' required><input class='u' type='submit' value='CAMBIAR esta Imagen'>");
                                    out.print("</form>");
                                    out.print("<button class='d' onclick=\"location.assign('Interfaz.jsp?x=D2&t=Producto&id="+r.getLong(2)+"')\">ELIMINAR</button>");
                                out.print("</aside>");
                                out.print("<section>");
                                    out.print("<h1>"+r.getString(3)+"</h1>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Upv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<p>Precio: <input name='p' type='number' min='1' max='5000000' value='"+r.getFloat(4)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Utxtv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<textarea name='txt' pattern='[A-Za-z0-9\\s]+' maxlength='800' value='"+r.getString(5)+"'></textarea>");
                                        out.print("<input class='u' type='submit' value='CAMBIAR esta Descripción'>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Ucv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<p>Cantidad: <input name='c' type='number' min='1' max='1000000' step='1' value='"+r.getInt(6)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                out.print("</section>");
                            out.print("</div>");
                        }
                    out.print("</fieldset>");
                }
                r = s.executeQuery("SELECT Img,Id,N,P,D,Cupo FROM Producto WHERE CE='"+session.getAttribute("u")+"' AND T='H' ORDER BY Pop DESC, Cupo ASC");
                if (r.getFetchSize() > 0) {
                    out.print("<fieldset>");
                        out.print("<legend>Herramientas</legend>");
                        while (r.next()) {
                            out.print("<div class='H'>");
                                out.print("<aside>");
                                    out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Herramienta'/>");
                                    out.print("<form action='UpVentas' method='post' enctype='multipart/form-data'>");
                                        out.print("<input name='x' type='hidden' value='false'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<input name='i' type='file' accept='image/*' required><input class='u' type='submit' value='CAMBIAR esta Imagen'>");
                                    out.print("</form>");
                                    out.print("<button class='d' onclick=\"location.assign('Interfaz.jsp?x=D2&t=Producto&id="+r.getLong(2)+"')\">ELIMINAR</button>");
                                out.print("</aside>");
                                out.print("<section>");
                                    out.print("<h1>"+r.getString(3)+"</h1>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Upv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<p>Precio: <input name='p' type='number' min='1' max='5000000' value='"+r.getFloat(4)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Utxtv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<textarea name='txt' pattern='[A-Za-z0-9\\s]+' maxlength='800' value='"+r.getString(5)+"'></textarea>");
                                        out.print("<input class='u' type='submit' value='CAMBIAR esta Descripción'>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Ucv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                        out.print("<p>Cantidad: <input name='c' type='number' min='1' max='1000000' step='1' value='"+r.getInt(6)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                out.print("</section>");
                            out.print("</div>");
                        }
                    out.print("</fieldset>");
                }
                r.close();
                s.close();
                c.close();
            } catch (Exception e) {
                out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                out.print("<script>history.back();</script>");
            }
        %>
    </body>
</html>