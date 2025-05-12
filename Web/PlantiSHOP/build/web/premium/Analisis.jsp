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
        c = DriverManager.getConnection("jdbc:mysql://host/PSHOP", "Lector", "Abcd**12345");
        s = c.createStatement();
        r = s.executeQuery("SELECT P FROM Usuarios WHERE CE='"+session.getAttribute("u")+"'");
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
        <title>Analisis de Datos del Usuario</title>
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
                
            }
            #RiA {
                text-align: right;
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
            #iA {
                background-color: cyan;
            }
            #iA:hover {
                color: white;
                background-color: navy;
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
        <p id="RiA"><button id="r" onclick="location.assign('Premium.jsp')">REGRESAR</button><button id="iA" onclick="location.assign('ChatBot.jsp')">Basil.IA</button></p>
        
    </body>
</html>