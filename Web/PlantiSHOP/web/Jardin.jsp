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
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        c = DriverManager.getConnection("jdbc:mysql://host/PSHOP", "Lector", "Abcd**12345");
        s = c.createStatement();
        r = s.executeQuery("SELECT N,AP,AM FROM Usuarios WHERE CE='"+session.getAttribute("u")+"'");
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
        <title>Jardin Personal</title>
        <link rel="icon" type="image/x-icon" href="imgs/logo.png">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                background-image: url(imgs/fondo2.jpg);
                background-repeat: no-repeat;
                background-size: cover;
                background-attachment: fixed;
                background-position: center center;
            }
            h1, h2 {
                text-align: center;
                font-family: Agrandir;
            }
            #rtrn:link, #rtrn:active, #rtrn:visited {
                color: blue;
                font-weight: bold;
                text-align: center;
                font-family: Coco Gothic;
            }
            #rtrn:hover {
                color: white;
                background-color: blue;
                text-decoration: none;
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
        <h1>Jardin Virtual Personal de <%= na %></h1>
        <a id="rtrn" href="Perfil.jsp">Regresar al Perfil</a>
        <hr>
        <form action="Interfaz.jsp" method="post">
            <input name="x" type="hidden" value="Cj">
            <h2>Registro de Nuevas Plantaciones</h2>
            <label for="i1">Nombre:</label>
            <input id="i1" name="n" type="text" pattern="[A-Za-z0-9\s']+" maxlength="25" required>
            <label for="i2">Tipo:</label>
            <select id="i2" name="t" required>
                <option value="PD" selected>Planta Decorativa</option>
                <option value="PH">Planta de Huerto</option>
                <option value="PA">Planta Acuatica</option>
                <option value="A">Árbol</option>
                <option value="AH">Alga u Hongo</option>
            </select>
            <label for="i3">Consideraciones:</label>
            <textarea id="i3" name="txt" pattern="[A-Za-z0-9\s]+" maxlength="250"></textarea>
            <label for="i4">Porcentaje de Luz:</label>
            <input id="i4" name="l" type="number" min="0" max="100" required>
            <label for="i5">Nivel de Prioridad:</label>
            <input id="i5" name="p" type="number" min="1" max="10" step="1" required>
            <input id="sm" type="submit" value="REGISTRAR">
        </form>
        <hr>
        <%
            try {
                r = s.executeQuery("SELECT Id,N,C,L,P FROM Jardines WHERE CE='"+session.getAttribute("u")+"' AND T='PD' ORDER BY P DESC");
                if (r.getFetchSize() > 0) {
                    out.print("<fieldset>");
                        out.print("<legend>Tus Plantas Decorativas</legend>");
                        while (r.next()) {
                            out.print("<div class='pD'>");
                                out.print("<aside>");
                                    out.print("<img src='imgs/PD.png' alt='Planta Decorativa'/>");
                                    out.print("<button class='d' onclick=\"location.assign('Interfaz.jsp?x=D2&t=Jardin&id="+r.getLong(1)+"')\">ELIMINAR</button>");
                                out.print("</aside>");
                                out.print("<section>");
                                    out.print("<h1>"+r.getString(2)+"</h1>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Utxtj'><input name='id' type='hidden' value='"+r.getLong(1)+"'>");
                                        out.print("<textarea name='txt' pattern='[A-Za-z0-9\\s]+' maxlength='200' value='"+r.getString(3)+"'></textarea>");
                                        out.print("<input class='u' type='submit' value='CAMBIAR esta Consideración'>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Ulj'><input name='id' type='hidden' value='"+r.getLong(1)+"'>");
                                        out.print("<p>Porcentaje de Luz: <input name='l' type='number' min='0' max='100' value='"+r.getByte(4)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Upj'><input name='id' type='hidden' value='"+r.getLong(1)+"'>");
                                        out.print("<p>Nivel de Prioridad: <input name='p' type='number' min='1' max='10' step='1' value='"+r.getByte(5)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                out.print("</section>");
                            out.print("</div>");
                        }
                    out.print("</fieldset>");
                }
                r = s.executeQuery("SELECT Id,N,C,L,P FROM Jardines WHERE CE='"+session.getAttribute("u")+"' AND T='PH' ORDER BY P DESC");
                if (r.getFetchSize() > 0) {
                    out.print("<fieldset>");
                        out.print("<legend>Tus Plantas de Huerto</legend>");
                        while (r.next()) {
                            out.print("<div class='pH'>");
                                out.print("<aside>");
                                    out.print("<img src='imgs/PH.png' alt='Planta de Huerto'/>");
                                    out.print("<button class='d' onclick=\"location.assign('Interfaz.jsp?x=D2&t=Jardin&id="+r.getLong(1)+"')\">ELIMINAR</button>");
                                out.print("</aside>");
                                out.print("<section>");
                                    out.print("<h1>"+r.getString(2)+"</h1>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Utxtj'><input name='id' type='hidden' value='"+r.getLong(1)+"'>");
                                        out.print("<textarea name='txt' pattern='[A-Za-z0-9\\s]+' maxlength='200' value='"+r.getString(3)+"'></textarea>");
                                        out.print("<input class='u' type='submit' value='CAMBIAR esta Consideración'>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Ulj'><input name='id' type='hidden' value='"+r.getLong(1)+"'>");
                                        out.print("<p>Porcentaje de Luz: <input name='l' type='number' min='0' max='100' value='"+r.getByte(4)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Upj'><input name='id' type='hidden' value='"+r.getLong(1)+"'>");
                                        out.print("<p>Nivel de Prioridad: <input name='p' type='number' min='1' max='10' step='1' value='"+r.getByte(5)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                out.print("</section>");
                            out.print("</div>");
                        }
                    out.print("</fieldset>");
                }
                r = s.executeQuery("SELECT Id,N,C,L,P FROM Jardines WHERE CE='"+session.getAttribute("u")+"' AND T='PA' ORDER BY P DESC");
                if (r.getFetchSize() > 0) {
                    out.print("<fieldset>");
                        out.print("<legend>Tus Plantas Acuaticas</legend>");
                        while (r.next()) {
                            out.print("<div class='pA'>");
                                out.print("<aside>");
                                    out.print("<img src='imgs/PA.png' alt='Planta Acuatica'/>");
                                    out.print("<button class='d' onclick=\"location.assign('Interfaz.jsp?x=D2&t=Jardin&id="+r.getLong(1)+"')\">ELIMINAR</button>");
                                out.print("</aside>");
                                out.print("<section>");
                                    out.print("<h1>"+r.getString(2)+"</h1>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Utxtj'><input name='id' type='hidden' value='"+r.getLong(1)+"'>");
                                        out.print("<textarea name='txt' pattern='[A-Za-z0-9\\s]+' maxlength='200' value='"+r.getString(3)+"'></textarea>");
                                        out.print("<input class='u' type='submit' value='CAMBIAR esta Consideración'>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Ulj'><input name='id' type='hidden' value='"+r.getLong(1)+"'>");
                                        out.print("<p>Porcentaje de Luz: <input name='l' type='number' min='0' max='100' value='"+r.getByte(4)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Upj'><input name='id' type='hidden' value='"+r.getLong(1)+"'>");
                                        out.print("<p>Nivel de Prioridad: <input name='p' type='number' min='1' max='10' step='1' value='"+r.getByte(5)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                out.print("</section>");
                            out.print("</div>");
                        }
                    out.print("</fieldset>");
                }
                r = s.executeQuery("SELECT Id,N,C,L,P FROM Jardines WHERE CE='"+session.getAttribute("u")+"' AND T='A' ORDER BY P DESC");
                if (r.getFetchSize() > 0) {
                    out.print("<fieldset>");
                        out.print("<legend>Tus Árboles</legend>");
                        while (r.next()) {
                            out.print("<div class='A'>");
                                out.print("<aside>");
                                    out.print("<img src='imgs/A.png' alt='Árbol'/>");
                                    out.print("<button class='d' onclick=\"location.assign('Interfaz.jsp?x=D2&t=Jardin&id="+r.getLong(1)+"')\">ELIMINAR</button>");
                                out.print("</aside>");
                                out.print("<section>");
                                    out.print("<h1>"+r.getString(2)+"</h1>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Utxtj'><input name='id' type='hidden' value='"+r.getLong(1)+"'>");
                                        out.print("<textarea name='txt' pattern='[A-Za-z0-9\\s]+' maxlength='200' value='"+r.getString(3)+"'></textarea>");
                                        out.print("<input class='u' type='submit' value='CAMBIAR esta Consideración'>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Ulj'><input name='id' type='hidden' value='"+r.getLong(1)+"'>");
                                        out.print("<p>Porcentaje de Luz: <input name='l' type='number' min='0' max='100' value='"+r.getByte(4)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Upj'><input name='id' type='hidden' value='"+r.getLong(1)+"'>");
                                        out.print("<p>Nivel de Prioridad: <input name='p' type='number' min='1' max='10' step='1' value='"+r.getByte(5)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                out.print("</section>");
                            out.print("</div>");
                        }
                    out.print("</fieldset>");
                }
                r = s.executeQuery("SELECT Id,N,C,L,P FROM Jardines WHERE CE='"+session.getAttribute("u")+"' AND T='AH' ORDER BY P DESC");
                if (r.getFetchSize() > 0) {
                    out.print("<fieldset>");
                        out.print("<legend>Tus Algas y/u Hongos</legend>");
                        while (r.next()) {
                            out.print("<div class='aH'>");
                                out.print("<aside>");
                                    out.print("<img src='imgs/AH.png' alt='Alga / Hongo'/>");
                                    out.print("<button class='d' onclick=\"location.assign('Interfaz.jsp?x=D2&t=Jardin&id="+r.getLong(1)+"')\">ELIMINAR</button>");
                                out.print("</aside>");
                                out.print("<section>");
                                    out.print("<h1>"+r.getString(2)+"</h1>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Utxtj'><input name='id' type='hidden' value='"+r.getLong(1)+"'>");
                                        out.print("<textarea name='txt' pattern='[A-Za-z0-9\\s]+' maxlength='200' value='"+r.getString(3)+"'></textarea>");
                                        out.print("<input class='u' type='submit' value='CAMBIAR esta Consideración'>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Ulj'><input name='id' type='hidden' value='"+r.getLong(1)+"'>");
                                        out.print("<p>Porcentaje de Luz: <input name='l' type='number' min='0' max='100' value='"+r.getByte(4)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
                                    out.print("</form>");
                                    out.print("<form action='Interfaz.jsp' method='post'>");
                                        out.print("<input name='x' type='hidden' value='Upj'><input name='id' type='hidden' value='"+r.getLong(1)+"'>");
                                        out.print("<p>Nivel de Prioridad: <input name='p' type='number' min='1' max='10' step='1' value='"+r.getByte(5)+"' required><input class='u' type='submit' value='CAMBIAR'></p>");
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