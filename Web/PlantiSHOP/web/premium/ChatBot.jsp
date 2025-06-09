<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%!
    Connection c;
    Statement s;
    ResultSet r;
%>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        c = DriverManager.getConnection("jdbc:mysql://192.168.1.66/PSHOP", "Lector", "Abcd**12345");
        s = c.createStatement();
        r = s.executeQuery("SELECT P FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
        r.next();
        if (!r.getBoolean(1)) {
            out.print("<script>alert('Lo sentimos, NO eres un Usuario PREMIUM... por lo que NO puedes hacer uso de este APARTADO...');</script>");
            out.print("<script>location.assign('../index.html');</script>");
        }
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
        <title>IA</title>
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
            p {
                text-align: center;
                font-weight: bold;
                font-size: 0.8vw;
                font-family: Arial;
            }
            #RA {
                text-align: right;
            }
            img, textarea, input {
                display: block;
                margin-left: auto;
                margin-right: auto;
            }
            img {
                width: 40%;
                border: 1px solid blue;
            }
            button {
                padding: 2em;
                border: none;
                border-radius: 5px;
                font-size: 1vw;
                font-weight: 600;
                font-family: Coco Gothic;
            }
            #r {
                background-color: gold;
            }
            #r:hover {
                color: white;
                background-color: goldenrod;
            }
            #aD {
                background-color: orange;
            }
            #aD:hover {
                color: white;
                background-color: orangered;
            }
            textarea {
                width: 90%;
            }
            input {
                width: 50%;
                background-color: black;
                color: white;
                font-weight: bold;
                font-family: Agrandir;
                border: 2px solid white;
            }
            input:hover {
                color: black;
                background-color: white;
                border-color: black;
            }
            #fP, #fP:hover {
                width: 95%;
                background-color: yellowgreen;
                color: goldenrod;
                border: none;
                font-family: Coco Gothic;
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
        <p id="RA"><button id="r" onclick="location.assign('Premium.jsp')">REGRESAR</button><button id="aD" onclick="location.assign('Analisis.jsp')">IR AL ANALISTA</button></p>
        <img src="../imgs/ia.jpg" alt="Basil.IA"/>
        <%
            if (session.getAttribute("rIA") == null) {
                out.print("<p>¡Hola! Soy Basil.IA, tu Asistente Personal de Jardineria... Dime ¿En que te puedo Ayudar?</p>");
            } else {
                out.print("<p id='txt'></p>");
                out.print("<script>");
                    out.print("try {");
                        out.print("let json = JSON.parse('"+session.getAttribute("rIA")+"');");
                    if ((Boolean) session.getAttribute("k")) {
                        out.print("document.getElementById('txt').innerHTML = json.choices[0].message.content;");
                    } else {
                        out.print("let aux = '';");
                        out.print("for (let i = 0; i < Math.min(3, json.results.length); i++) { aux += 'Nombre Cientifico de la Plantación: <b>' + json.results[i].species.scientificNameWithoutAuthor + '</b> (' + (json.results[i].score * 100) + '% de CERTEZA)<br>'; }");
                        out.print("document.getElementById('txt').innerHTML = aux;");
                    }
                    out.print("} catch (e) {");
                        out.print("document.getElementById('txt').innerHTML = 'Lo lamento, ha ocurrido un ERROR... intentalo de NUEVO...';");
                    out.print("}");
                out.print("</script>");
                session.removeAttribute("k");
                session.removeAttribute("rIA");
            }
        %>
        <form action="BasilIA" method="post">
            <input name="x" type="hidden" value="true">
            <textarea name="req" required></textarea>
            <input type="submit" value="ENVIAR">
        </form>
        <br>
        <form action="BasilIA" method="post" enctype="multipart/form-data">
            <input name="x" type="hidden" value="false">
            <input id="fP" name="img" type="file" accept="image/jpeg" required>
            <input type="submit" value="BUSCAR Plantación">
        </form>
    </body>
</html>