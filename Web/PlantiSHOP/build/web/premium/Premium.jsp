<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%!
    Connection c;
    Statement s;
    ResultSet r;
%>
<!DOCTYPE html>
<html lang="es-MX">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Premium</title>
        <link rel="icon" type="image/x-icon" href="../imgs/logo.png">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                background-image: url(../imgs/fondo4.png);
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
            h1, h2 {
                text-align: center;
                font-family: Agrandir;
            }
            header h2 {
                color: black;
                text-align: left;
                margin-left: 1.5em;
            }
            h3, p {
                text-align: center;
                font-family: Coco Gothic;
            }
            button {
                display: block;
                width: 80%;
                margin-left: auto;
                margin-right: auto;
                padding: 2.5em;
                border: none;
                border-radius: 8px;
                font-size: 2vw;
                font-weight: 800;
                font-family: Coco Gothic;
            }
            #iA {
                background-color: cyan;
            }
            #iA:hover {
                color: white;
                background-color: blue;
            }
            #aD {
                background-color: orange;
            }
            #aD:hover {
                color: white;
                background-color: orangered;
            }
            form {
                width: 95%;
                margin-left: auto;
                margin-right: auto;
                padding: 2em;
                background-color: #cccccc;
                border-radius: 10px;
            }
            label {
                display: block;
                margin-top: 2em;
                width: 94%;
                margin-left: auto;
                margin-right: auto;
                font-weight: 600;
                font-family: Coco Gothic;
            }
            #i1, #i2, #i3, select {
                display: block;
                width: 96%;
                margin-left: auto;
                margin-right: auto;
                border: 2px solid black;
                border-radius: 5px;
                font-family: Arial;
            }
            select {
                border-radius: 0;
                background-color: greenyellow;
            }
            #sm {
                width: 40%;
                background-color: black;
                color: white;
                font-weight: bold;
                font-family: Agrandir;
                border: 2px double white;
            }
            #sm:hover {
                color: black;
                background-color: white;
                border-color: black;
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
            function sM(bol) {
                if (bol) {
                    document.getElementById('sm').disabled = false;
                } else {
                    document.getElementById('sm').disabled = true;
                }
            }
        </script>
    </head>
    <body>
        <header>
            <h2><img src="imgs/logo.png" alt="Logo"/>&nbsp;&nbsp;PlantiSHOP</h2>
            <div id="Gral">
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
        </nav>
        <h1>PREMIUM</h1>
        <p>¡Pon a tu Disposición una Programación Especial de PlantiSHOP; y ten Acceso a nuestro ChatBot "Basil.IA", tu nuevo Asistente Personal de Jardineria, y a un Analista Estadistico-Predictivo de tus Actividades Comerciales en la Aplicación y del Mercado Botanico de PlantiSHOP!</p>
        <hr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
                c = DriverManager.getConnection("jdbc:mysql://host/PSHOP", "Lector", "Abcd**12345");
                s = c.createStatement();
                r = s.executeQuery("SELECT P,FfS,N,AP,AM FROM Usuarios WHERE CE='"+session.getAttribute("u")+"'");
                r.next();
                if (r.getBoolean(1)) {
                    out.print("<button id='iA' onclick=\"location.assign('ChatBot.jsp')\">Basil.IA</button>");
                    out.print("<button id='aD' onclick=\"location.assign('Analisis.jsp')\">Tus Finanzas y el Mercado</button>");
                    out.print("<br>");
                    out.print("<h2>Tu Suscripción termina el "+r.getDate(2).toLocalDate().format(DateTimeFormatter.ofPattern("E, d / MMM / uuuu")).toUpperCase()+"</h2>");
                    if (LocalDate.now().until(r.getDate(2).toLocalDate(), ChronoUnit.DAYS) <= 8L) {
                        out.print("<h3>¡Faltan "+LocalDate.now().until(r.getDate(2).toLocalDate(), ChronoUnit.DAYS)+" días para que termine tu Suscripción!</h3>");
                    }
                } else {
                    out.print("<form action='UpSuscripciones' method='post'>");
                        out.print("<h2>¡Suscribete a PlantiSHOP!</h2>");
                        out.print("<p>"+session.getAttribute("u")+"</p>");
                        out.print("<label for='i1'>Clave Bancaria Estandarizada (CLABE) de tu Cuenta Bancaria:</label>");
                        out.print("<input id='i1' name='CLABE' type='password' pattern='[0-9]{18}' maxlength='18' required>");
                        out.print("<label for='i2'>Número de tu Tarjeta Bancaria:</label>");
                        out.print("<input id='i2' name='nTG' type='password' pattern='[0-9]{16}' maxlength='16' required>");
                        out.print("<label for='i3'>Número de Teléfono asociado a la Cuenta:</label>");
                        out.print("<input id='i3' name='tf' type='tel' maxlength='10' required>");
                        out.print("<label for='i4'>Plan de Suscripción:</label>");
                        out.print("<select id='i4' required>");
                            out.print("<option value='1' selected>Mensual (30 días).- $</option>");
                            out.print("<option value='3'>Trimestral (3 meses).- $</option>");
                            out.print("<option value='6'>Semestral (6 meses).- $</option>");
                            out.print("<option value='12'>Anual (365 días).- $</option>");
                        out.print("</select>");
                        out.print("<p><input name='SI' type='checkbox' onclick='sM(this.checked)' value='Yo, "+r.getString(3)+" "+r.getString(4)+" "+r.getString(5)+" ("+session.getAttribute("u")+"), Acepto y Confirmo esta Transferencia Bancaria a EcoByte, realizada el día "+LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/uuuu"))+", para el uso del Apartado PREMIUM de PlantiSHOP' required> Yo, "+r.getString(3)+" "+r.getString(4)+" "+r.getString(5)+" ("+session.getAttribute("u")+"), Acepto y Confirmo esta Transferencia Bancaria a EcoByte, realizada el día "+LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/uuuu"))+", para el uso del Apartado PREMIUM de PlantiSHOP</p>");
                        out.print("<input id='sm' type='submit' value='SUSCRIBIRSE' disabled='true'>");
                    out.print("</form>");
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