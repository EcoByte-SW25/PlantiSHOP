<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="auxs.Hash"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%!
    Connection c;
    Statement s;
    ResultSet r;
    String n, a, u;
%>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        c = DriverManager.getConnection("jdbc:mysql://host/PSHOP", "Lector", "Abcd**12345");
        s = c.createStatement();
        r = s.executeQuery("SELECT N,AP,AM,U FROM Usuarios WHERE CE='"+session.getAttribute("u")+"'");
        r.next();
        n = r.getString(1);
        a = r.getString(2) + " " + r.getString(3);
        u = (new Hash()).descifrar(r.getString(4));
        r.close();
        s.close();
        c.close();
    } catch (Exception e) {
        out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
        out.print("<script>history.back();</script>");
    }
%>
<!DOCTYPE html>
<html lang="es-MX">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfil de Usuario</title>
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
            h1, h2, h3 {
                text-align: center;
                font-family: Agrandir;
            }
            header h2 {
                color: black;
                text-align: left;
                margin-left: 1.5em;
            }
            div {
                display: grid;
                grid-template-columns: 25% 75%;
            }
            article img, article button {
                display: block;
                width: 85%;
                margin-left: auto;
                margin-right: auto;
                border: 1px double maroon;
            }
            article button {
                color: white;
                font-family: Coco Gothic;
                font-size: 2vw;
                font-weight: bold;
                background-color: green;
            }
            article button:hover {
                background-color: greenyellow;
            }
            section {
                text-align: center;
            }
            label {
                display: block;
                margin-top: 2em;
                width: 94%;
                text-align: left;
                font-weight: 600;
                font-family: Coco Gothic;
            }
            input {
                width: 76%;
                border: 2px solid black;
                border-radius: 5px;
                text-align: left;
                font-family: Arial;
            }
            .sm {
                width: 20%;
                background-color: navy;
                color: white;
                font-weight: bold;
                font-family: Agrandir;
                border: 2px solid white;
            }
            .sm:hover {
                background-color: blue;
            }
            #gMap {
                display: block;
                grid: none;
                width: 95%;
                height: 10em;
                border: 1px solid black;
            }
            #i4, fieldset input {
                display: block;
                width: 96%;
            }
            fieldset {
                text-align: center;
                border: 2px double maroon;
            }
            legend {
                color: maroon;
                font-family: Agrandir;
            }
            fieldset p {
                text-align: right;
            }
            fieldset p button {
                padding: 1.5em;
                vertical-align: middle;
                color: white;
                font-weight: 600;
                font-family: Agrandir;
                border: none;
                background-color: blue;
            }
            #dP {
                background-color: red;
            }
            select {
                display: block;
                width: 96%;
                margin-left: auto;
                margin-right: auto;
                border: 2px solid black;
                font-family: Arial;
                color: whitesmoke;
                background-image: linear-gradient(to right, yellow, navy);
            }
            .smf {
                display: block;
                width: 50%;
                margin: 2em auto 0 auto;
                border: none;
                border-radius: 5px;
                color: white;
                background-color: blue;
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
            function toUcsD(i) {
                switch (i) {
                    case 0: {
                        document.getElementById('pwsD').value = "U0";
                        document.getElementById('UD').value = "CAMBIAR";
                        document.getElementById('UD').style.backgroundColor = "blue";
                        document.getElementsByClassName('nc')[0].style.display = "block";
                        document.getElementsByClassName('nc')[1].style.display = "block";
                        document.getElementsByClassName('ncr')[0].style.display = "block";
                        document.getElementsByClassName('ncr')[1].style.display = "block";
                    } break;
                    case 1: {
                        document.getElementById('pwsD').value = "U1";
                        document.getElementById('UD').value = "CAMBIAR";
                        document.getElementById('UD').style.backgroundColor = "blue";
                        document.getElementsByClassName('nc')[0].style.display = "block";
                        document.getElementsByClassName('nc')[1].style.display = "block";
                        document.getElementsByClassName('ncr')[0].style.display = "none";
                        document.getElementsByClassName('ncr')[1].style.display = "none";
                    } break;
                    case 2: {
                        document.getElementById('pwsD').value = "U2";
                        document.getElementById('UD').value = "CAMBIAR";
                        document.getElementById('UD').style.backgroundColor = "blue";
                        document.getElementsByClassName('nc')[0].style.display = "none";
                        document.getElementsByClassName('nc')[1].style.display = "none";
                        document.getElementsByClassName('ncr')[0].style.display = "block";
                        document.getElementsByClassName('ncr')[1].style.display = "block";
                    } break;
                    case 3: {
                        document.getElementById('pwsD').value = "D";
                        document.getElementById('UD').value = "ELIMINAR Perfil";
                        document.getElementById('UD').style.backgroundColor = "red";
                        document.getElementsByClassName('nc')[0].style.display = "none";
                        document.getElementsByClassName('nc')[1].style.display = "none";
                        document.getElementsByClassName('ncr')[0].style.display = "none";
                        document.getElementsByClassName('ncr')[1].style.display = "none";
                    } break;
                }
            }
            let latd, lngd;
            (new google.maps.Geocoder()).geocode({ address: "<%= u %>" }).then(function (r) {
                latd = r.results[0].geometry.location.lat;
                lngd = r.results[0].geometry.location.lng;
            });
            window.initMap = function () {
                (new google.maps.Map(document.getElementById('gMap'), {
                    center: {
                        lat: (latd ?? 19.4326077),
                        lng: (lngd ?? -99.133208)
                    },
                    zoom: 8,
                    mapTypeControl: false
                })).addListener('click', function (ev) {
                    (new google.maps.Geocoder()).geocode({ location: ev.latLng }).then(
                        function (r) {
                            document.getElementById('i4').value = r.results[0].formatted_address;
                        },
                        function (er) {
                            alert('Lo sentimos, se produjo un ERROR:\n'+er);
                        }
                    );
                });
            };
        </script>
    </head>
    <body>
        <header>
            <h2><img src="imgs/logo.png" alt="Logo"/>&nbsp;&nbsp;PlantiSHOP</h2>
            <div>
                <img src="imgs/perfil.jpg" alt="Perfil"/>
                <ul>
                    <li><a href="Jardin.jsp">Tu Jardín</a></li>
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
        <div>
            <article>
                <img src="imgs/perfil.jpg" alt="Perfil"/>
                <h1><%= n %></h1>
                <h1><%= a %></h1>
                <button onclick="location.assign('Jardin.jsp')">Tu Jardín</button>
            </article>
            <section>
                <h2><%= session.getAttribute("u") %></h2>
                <h3><%= u %></h3>
                <hr>
                <form action="Interfaz.jsp" method="post">
                    <input name="x" type="hidden" value="Un">
                    <label for="i1">Nombre(s):</label>
                    <input id="i1" name="n" type="text" pattern="[A-Za-z\s]+" maxlength="25" required><input class="sm" type="submit" value="CAMBIAR">
                </form>
                <form action="Interfaz.jsp" method="post">
                    <input name="x" type="hidden" value="Uap">
                    <label for="i2">Apellido Paterno:</label>
                    <input id="i2" name="ap" type="text" pattern="[A-Za-z\s']+" maxlength="15" required><input class="sm" type="submit" value="CAMBIAR">
                </form>
                <form action="Interfaz.jsp" method="post">
                    <input name="x" type="hidden" value="Uam">
                    <label for="i3">Apellido Materno:</label>
                    <input id="i3" name="am" type="text" pattern="[A-Za-z\s']+" maxlength="15" required><input class="sm" type="submit" value="CAMBIAR">
                </form>
                <form action="Interfaz.jsp" method="post">
                    <input name="x" type="hidden" value="Uu">
                    <label for="i4">Ubicación:</label>
                    <div id="gMap"></div>
                    <input id="i4" name="u" type="text" readonly title="Selecciona en el Mapa la Ubicación de tu Huerto o Jardin ;)" required>
                    <input class="sm" type="submit" value="CAMBIAR">
                </form>
            </section>
        </div>
        <fieldset>
            <legend>Tus Contraseñas:</legend>
            <p><button onclick="toUcsD(1)">Cambiar Contraseña</button><button onclick="toUcsD(2)">Cambiar Contraseña de Respaldo</button><button onclick="toUcsD(0)">Cambiar ambas Contraseñas</button><button id="dP" onclick="toUcsD(3)">ELIMINAR este Perfil</button></p>
            <form action="Interfaz.jsp" method="post">
                <input id="pwsD" name="x" type="hidden" value="U0">
                <label for="i5">Contraseña:</label>
                <input id="i5" name="c1" type="password" minlength="12" maxlength="20" required>
                <label for="i6">Contraseña de Respaldo:</label>
                <input id="i6" name="c2" type="password" minlength="12" maxlength="20" required>
                <label class="nc" for="i7">Nueva Contraseña:</label>
                <input class="nc" id="i7" name="nc1" type="password" pattern="[A-Z]+[a-z]+[+-*/%$._!?]+" minlength="12" maxlength="20" title="Tu Contraseña debe de tener entre 12 y 20 Caracteres, y debe de contener Letras Mayusculas y Minusculas, Numeros y Caracteres Especiales :)">
                <label class="ncr" for="i8">Nueva Contraseña de Respaldo:</label>
                <input class="ncr" id="i8" name="nc2" type="password" pattern="[A-Z]+[a-z]+[+-*/%$._!?]+" minlength="12" maxlength="20" title="Tu Contraseña de Respaldo debe de tener entre 12 y 20 Caracteres, y debe de contener Letras Mayusculas y Minusculas, Numeros y Caracteres Especiales :)">
                <input id="UD" class="smf" type="submit" value="CAMBIAR">
            </form>
        </fieldset>
    </body>
</html>