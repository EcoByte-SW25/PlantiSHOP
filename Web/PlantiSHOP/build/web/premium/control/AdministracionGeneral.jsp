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
    } catch (Exception e) {
        out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
        out.print("<script>history.back();</script>");
    }
%>
<!DOCTYPE html>
<html lang="es-MX">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EcoByte</title>
        <link rel="icon" type="image/x-icon" href="../../imgs/logo.png">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                background-image: url(../../imgs/fondo.png);
                background-repeat: no-repeat;
                background-size: cover;
                background-attachment: fixed;
                background-position: center center;
            }
            h1, a {
                text-align: center;
            }
            table {
                width: 99.8%;
                margin-left: auto;
                margin-right: auto;
                overflow-x: auto;
                border: 1px solid black;
                background-color: #33ff33;
            }
            caption {
                color: #ff3333;
            }
            th, td {
                margin: 0;
                border: 1px solid black;
            }
            img {
                display: block;
                width: 99.5%;
                margin: 0 auto 0 auto;
            }
            button {
                border: none;
                color: white;
                font-weight: bold;
                vertical-align: middle;
            }
            .d {
                background-color: red;
            }
            .u {
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
        <h1>Administración General de PlantiSHOP</h1>
        <a href="../../index.html">SALIR</a>
        <hr>
        <table>
            <caption>Usuario</caption>
            <tr>
                <th colspan="2">Correo Electronico</th>
                <th>Contraseña</th>
                <th>Contraseña de Respaldo</th>
                <th>Nombre(s)</th>
                <th>Apellido Paterno</th>
                <th>Apellido Materno</th>
                <th>Ubicación</th>
                <th>Codigo de Verificación</th>
                <th>Intentos para las Contraseñas</th>
                <th>Fin del Veto para las Contraseñas</th>
                <th>Intentos para el CV</th>
                <th>Fin del Veto para el CV</th>
                <th>Premium</th>
                <th>Fin de la Suscripción Premium</th>
                <th>Nuevos Ingresos</th>
            </tr>
            <%
                try {
                    r = s.executeQuery("SELECT * FROM Usuario");
                    while (r.next()) {
                        out.print("<tr><td><button class='u' onclick=\"location.assign('Admin.jsp?ud=true&w=true&x=true&id="+r.getString(1)+"')\">MODIFICAR</button><button class='d' onclick=\"location.assign('Admin.jsp?ud=false&t=Usuario&i=CE&id="+r.getString(1)+"&sn=true')\">ELIMINAR</button></td><td>"+r.getString(1)+"</td><td>"+r.getString(2)+"</td><td>"+r.getString(3)+"</td><td>"+r.getString(4)+"</td><td>"+r.getString(5)+"</td><td>"+r.getString(6)+"</td><td>"+r.getString(7)+"</td><td>"+r.getString(8)+"</td><td>"+r.getString(9)+"</td><td>"+r.getString(10)+"</td><td>"+r.getString(11)+"</td><td>"+r.getString(12)+"</td><td>"+r.getString(13)+"</td><td>"+r.getString(14)+"</td><td>"+r.getString(15)+"</td></tr>");
                    }
                } catch (Exception e) {
                    out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                    out.print("<script>history.back();</script>");
                }
            %>
        </table>
        <table>
            <caption>Jardin</caption>
            <tr>
                <th colspan="2">ID</th>
                <th>Usuario</th>
                <th>Nombre de la Plantación</th>
                <th>Tipo de Plantación</th>
                <th>Consideraciones</th>
                <th>Porcentaje de Luz</th>
                <th>Nivel de Prioridad</th>
            </tr>
            <%
                try {
                    r = s.executeQuery("SELECT * FROM Jardin");
                    while (r.next()) {
                        out.print("<tr><td><button class='d' onclick=\"location.assign('Admin.jsp?ud=false&t=Jardin&i=Id&id="+r.getString(1)+"&sn=false')\">ELIMINAR</button></td><td>"+r.getString(1)+"</td><td>"+r.getString(2)+"</td><td>"+r.getString(3)+"</td><td>"+r.getString(4)+"</td><td>"+r.getString(5)+"</td><td>"+r.getString(6)+"</td><td>"+r.getString(7)+"</td></tr>");
                    }
                } catch (Exception e) {
                    out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                    out.print("<script>history.back();</script>");
                }
            %>
        </table>
        <table>
            <caption>Producto</caption>
            <tr>
                <th colspan="2">ID</th>
                <th>Usuario</th>
                <th>Nombre del Producto</th>
                <th>Descripción</th>
                <th>Tipo de Producto</th>
                <th>Precio</th>
                <th>Imagen</th>
                <th>Popularidad del Producto</th>
                <th>Cantidad del Producto</th>
            </tr>
            <%
                try {
                    r = s.executeQuery("SELECT * FROM Producto");
                    while (r.next()) {
                        out.print("<tr><td><button class='u' onclick=\"location.assign('Admin.jsp?ud=true&w=true&x=false&id="+r.getString(1)+"')\">MODIFICAR</button><button class='d' onclick=\"location.assign('Admin.jsp?ud=false&t=Producto&i=Id&id="+r.getString(1)+"&sn=false')\">ELIMINAR</button></td><td>"+r.getString(1)+"</td><td>"+r.getString(2)+"</td><td>"+r.getString(3)+"</td><td>"+r.getString(4)+"</td><td>"+r.getString(5)+"</td><td>"+r.getString(6)+"</td><td><img src='../../imgs/prods/"+r.getString(7)+"' alt='"+r.getString(7)+"'/></td><td>"+r.getString(8)+"</td><td>"+r.getString(9)+"</td></tr>");
                    }
                } catch (Exception e) {
                    out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                    out.print("<script>history.back();</script>");
                }
            %>
        </table>
        <table>
            <caption>Compra</caption>
            <tr>
                <th colspan="2">ID</th>
                <th>Vendedor</th>
                <th>Comprador</th>
                <th>Producto</th>
                <th>Descripción del Producto</th>
                <th>Precio Individual del Producto</th>
                <th>Imagen del Producto</th>
                <th>Fase</th>
                <th>No. de Lotes del Producto</th>
                <th>Precio Total</th>
                <th>Lugar de la Compra</th>
                <th>Fecha y Hora de la Compra</th>
                <th>Estado de la Negociación</th>
            </tr>
            <%
                try {
                    r = s.executeQuery("SELECT * FROM Compra");
                    while (r.next()) {
                        out.print("<tr><td><button class='d' onclick=\"location.assign('Admin.jsp?ud=false&t=Compra&i=Id&id="+r.getString(1)+"&sn=false')\">ELIMINAR</button></td><td>"+r.getString(1)+"</td><td>"+r.getString(2)+"</td><td>"+r.getString(3)+"</td><td>"+r.getString(4)+"</td><td>"+r.getString(5)+"</td><td>"+r.getString(6)+"</td><td><img src='../../imgs/prods/"+r.getString(7)+"' alt='"+r.getString(7)+"'/></td><td>"+r.getString(8)+"</td><td>"+r.getString(9)+"</td><td>"+r.getString(10)+"</td><td>"+r.getString(11)+"</td><td>"+r.getString(12)+"</td><td>"+r.getString(13)+"</td></tr>");
                    }
                } catch (Exception e) {
                    out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                    out.print("<script>history.back();</script>");
                }
            %>
        </table>
        <table>
            <caption>Notificación</caption>
            <tr>
                <th colspan="2">ID</th>
                <th>Vendedor</th>
                <th>Comprador</th>
                <th>A. Paterno del Comprador</th>
                <th>A. Materno del Comprador</th>
                <th>Tipo de Notificación</th>
                <th>Producto</th>
                <th>No. de Lotes del Producto</th>
                <th>Precio Total</th>
                <th>Fecha y Hora de la Compra</th>
                <th>Lugar de la Compra</th>
            </tr>
            <%
                try {
                    r = s.executeQuery("SELECT * FROM Notificacion");
                    while (r.next()) {
                        out.print("<tr><td><button class='d' onclick=\"location.assign('Admin.jsp?ud=false&t=Notificacion&i=Id&id="+r.getString(1)+"&sn=false')\">ELIMINAR</button></td><td>"+r.getString(1)+"</td><td>"+r.getString(2)+"</td><td>"+r.getString(3)+"</td><td>"+r.getString(4)+"</td><td>"+r.getString(5)+"</td><td>"+r.getString(6)+"</td><td>"+r.getString(7)+"</td><td>"+r.getString(8)+"</td><td>"+r.getString(9)+"</td><td>"+r.getString(10)+"</td><td>"+r.getString(11)+"</td></tr>");
                    }
                } catch (Exception e) {
                    out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                    out.print("<script>history.back();</script>");
                }
            %>
        </table>
        <table>
            <caption>Administración</caption>
            <tr>
                <th>Tabla SQL</th>
                <th>Evento</th>
                <th>Usuario SQL</th>
                <th>Usuario de PlantiSHOP</th>
                <th>Fecha y Hora</th>
            </tr>
            <%
                try {
                    r = s.executeQuery("SELECT * FROM Administracion");
                    while (r.next()) {
                        out.print("<tr><td>"+r.getString(1)+"</td><td>"+r.getString(2)+"</td><td>"+r.getString(3)+"</td><td>"+r.getString(4)+"</td><td>"+r.getString(5)+"</td></tr>");
                    }
                    r.close();
                    s.close();
                    c.close();
                } catch (Exception e) {
                    out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                    out.print("<script>history.back();</script>");
                }
            %>
        </table>
    </body>
</html>