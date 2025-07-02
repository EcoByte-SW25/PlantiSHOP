<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.File"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%!
    Connection c;
    Statement s;
    ResultSet r;
%>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        c = DriverManager.getConnection("jdbc:mysql://localhost/PSHOP", "root", "n0m3l0");
        s = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
    } catch (Exception e) {
        out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
        out.print("<script>history.back();</script>");
    }
%>
<!DOCTYPE html>
<html lang="es-MX">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>O</title>
        <link rel="icon" type="image/x-icon" href="../../imgs/logo.png">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-image: url(../../imgs/fondo4.png);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 20px;
                box-sizing: border-box;
            }
            .success-container {
                background: white;
                border-radius: 20px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                padding: 40px;
                max-width: 800px;
                width: 100%;
                transform: translateY(0);
                animation: slideUp 0.6s ease-out;
                border: 1px solid #e9ecef;
            }
            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .success-content {
                display: flex;
                align-items: center;
                gap: 30px;
            }
            .success-title {
                color: #495057;
                font-weight: 600;
                font-size: 2.5rem;
                margin: 0;
                white-space: nowrap;
                line-height: 1.2;
            }
            .success-image {
                max-width: 200px;
                height: auto;
                border-radius: 15px;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
                transition: transform 0.3s ease;
            }
            .success-image:hover {
                transform: scale(1.05);
            }
            .success-container::before {
                content: '';
                position: absolute;
                top: -1px;
                left: -1px;
                right: -1px;
                bottom: -1px;
                background: linear-gradient(135deg, #6c757d, #adb5bd);
                border-radius: 21px;
                z-index: -1;
                opacity: 0.3;
            }
            .success-container {
                position: relative;
            }
            @media (max-width: 768px) {
                .success-content {
                    flex-direction: column;
                    text-align: center;
                    gap: 20px;
                }
                .success-title {
                    font-size: 1.8rem;
                    white-space: normal;
                }
                .success-image {
                    max-width: 150px;
                }
                .success-container {
                    padding: 30px 20px;
                    max-width: 90%;
                }
            }
            @media (max-width: 480px) {
                .success-title {
                    font-size: 1.5rem;
                    white-space: normal;
                }
            }
            .success-container::after {
                content: '';
                position: absolute;
                top: 20px;
                right: 20px;
                width: 80px;
                height: 80px;
                background: radial-gradient(circle, rgba(108, 117, 125, 0.1) 0%, transparent 70%);
                border-radius: 50%;
                z-index: -1;
            }
            form * {
                color: orangered;
                font-weight: bold;
                text-align: center;
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
        <%
            try {
                if (Boolean.parseBoolean(request.getParameter("ud"))) {
                    if (Boolean.parseBoolean(request.getParameter("w"))) {
                        if (Boolean.parseBoolean(request.getParameter("x"))) {
                            r = s.executeQuery("SELECT N,AP,AM,I1,FhN1,I2,FhN2,P,FfS FROM Usuario WHERE CE='"+request.getParameter("id")+"'");
                            r.next();
                            out.print("<form action='Admin.jsp' method='post'>");
                                out.print("<h1>Usuario ("+request.getParameter("id")+")</h1>");
                                out.print("<input name='ud' type='hidden' value='true'>");
                                out.print("<input name='w' type='hidden' value='false'>");
                                out.print("<input name='x' type='hidden' value='true'>");
                                out.print("<input name='ce' type='hidden' value='"+request.getParameter("id")+"'>");
                                out.print("<label for='i1'>Nombre(s):</label>");
                                out.print("<input id='i1' name='n' type='text' pattern='[A-Za-z\\s]+' maxlength='25' value='"+r.getString(1)+"' required>");
                                out.print("<label for='i2'>Apellido Paterno:</label>");
                                out.print("<input id='i2' name='ap' type='text' pattern=\"[A-Za-z\\s']+\" maxlength='15' value='"+r.getString(2)+"' required>");
                                out.print("<label for='i3'>Apellido Materno:</label>");
                                out.print("<input id='i3' name='am' type='text' pattern=\"[A-Za-z\\s']+\" maxlength='15' value='"+r.getString(3)+"' required>");
                                out.print("<label for='i4'>Intentos para las Contraseñas:</label>");
                                out.print("<input id='i4' name='ii1' type='number' min='0' max='5' step='1' value='"+r.getByte(4)+"' required>");
                                out.print("<label for='i5'>Fin del Veto para las Contraseñas:</label>");
                                out.print("<input id='i5' name='v1' type='datetime-local' value='"+((r.getTimestamp(5) == null) ? 0 : r.getTimestamp(5).toLocalDateTime().format(DateTimeFormatter.ofPattern("uuuu-MM-ddTHH:mm")))+"' required>");
                                out.print("<label for='i6'>Intentos para el CV:</label>");
                                out.print("<input id='i6' name='ii2' type='number' min='0' max='2' step='1' value='"+r.getByte(6)+"' required>");
                                out.print("<label for='i7'>Fin del Veto para el CV:</label>");
                                out.print("<input id='i7' name='v2' type='datetime-local' value='"+((r.getTimestamp(7) == null) ? 0 : r.getTimestamp(7).toLocalDateTime().format(DateTimeFormatter.ofPattern("uuuu-MM-ddTHH:mm")))+"' required>");
                                out.print("<label for='i8'>Premium:</label>");
                                out.print("<select id='i8' name='p' required>");
                                    out.print("<option value='true' "+(r.getBoolean(8) ? "selected" : "")+">Con ACCESO</option>");
                                    out.print("<option value='false' "+(r.getBoolean(8) ? "" : "selected")+">Sin ACCESO</option>");
                                out.print("</select>");
                                out.print("<label for='i9'>Fin de la Suscripción Premium:</label>");
                                out.print("<input id='i9' name='fp' type='date' value='"+r.getString(9)+"' required>");
                                out.print("<p><input id='rs' type='reset' value='RESETEAR'><input id='sm' type='submit' value='CAMBIAR'></p>");
                            out.print("</form>");
                        } else {
                            r = s.executeQuery("SELECT N,D,T,P FROM Producto WHERE Id="+request.getParameter("id"));
                            r.next();
                            out.print("<form action='Admin.jsp' method='post'>");
                                out.print("<h1>Producto ("+request.getParameter("id")+")</h1>");
                                out.print("<input name='ud' type='hidden' value='true'>");
                                out.print("<input name='w' type='hidden' value='false'>");
                                out.print("<input name='x' type='hidden' value='false'>");
                                out.print("<input name='id' type='hidden' value='"+request.getParameter("id")+"'>");
                                out.print("<label for='i1'>Nombre del Producto:</label>");
                                out.print("<input id='i1' name='n' type='text' pattern='[A-Za-z0-9\\s]+' maxlength='80' value='"+r.getString(1)+"' required>");
                                out.print("<label for='i2'>Descripción del Producto:</label>");
                                out.print("<input id='i2' name='d' type='text' pattern=\"[A-Za-z0-9\\s']+\" maxlength='800' value='"+r.getString(2)+"' required>");
                                out.print("<label for='i3'>Tipo de Producto:</label>");
                                out.print("<select id='i3' name='t' required>");
                                    out.print("<optgroup label='Plantaciones'>");
                                        out.print("<option value='PD' "+(r.getString(3).equals("PD") ? "selected" : "")+">Planta Decorativa</option>");
                                        out.print("<option value='PH' "+(r.getString(3).equals("PH") ? "selected" : "")+">Planta de Huerto</option>");
                                        out.print("<option value='PA' "+(r.getString(3).equals("PA") ? "selected" : "")+">Planta Acuatica</option>");
                                        out.print("<option value='A' "+(r.getString(3).equals("A") ? "selected" : "")+">Árbol</option>");
                                        out.print("<option value='AH' "+(r.getString(3).equals("AH") ? "selected" : "")+">Alga u Hongo</option>");
                                    out.print("</optgroup>");
                                    out.print("<option value='F' "+(r.getString(3).equals("F") ? "selected" : "")+">Fertilizante</option>");
                                    out.print("<option value='H' "+(r.getString(3).equals("H") ? "selected" : "")+">Herramienta</option>");
                                out.print("</select>");
                                out.print("<label for='i4'>Precio del Producto:</label>");
                                out.print("<input id='i4' name='p' type='number' min='1' max='5000000' value='"+r.getFloat(4)+"' required>");
                                out.print("<p><input id='rs' type='reset' value='RESETEAR'><input id='sm' type='submit' value='CAMBIAR'></p>");
                            out.print("</form>");
                        }
                        r.close();
                    } else {
                        if (Boolean.parseBoolean(request.getParameter("x"))) {
                            s.executeUpdate("UPDATE Usuario SET N='"+request.getParameter("n")+"',AP='"+request.getParameter("ap")+"',AM='"+request.getParameter("am")+"',I1="+request.getParameter("ii1")+",FhN1='"+request.getParameter("v1")+"',I2="+request.getParameter("ii2")+",FhN2='"+request.getParameter("v2")+"',P="+request.getParameter("p")+",FfS='"+request.getParameter("fp")+"' WHERE CE='"+request.getParameter("ce")+"'");
                        } else {
                            s.executeUpdate("UPDATE Producto SET N='"+request.getParameter("n")+"',D='"+request.getParameter("d")+"',T='"+request.getParameter("t")+"',P="+request.getParameter("p")+" WHERE Id="+request.getParameter("id"));
                        }
                        s.execute("COMMIT");
                        out.print("<div class='success-container'>");
                            out.print("<div class='success-content'>");
                                out.print("<h1 class='success-title'>Registro modificado EXITOSAMENTE</h1>");
                                out.print("<img src='../../imgs/usql.png' alt='U' class='success-image'/>");
                            out.print("</div>");
                        out.print("</div>");
                        out.print("<script>setTimeout(function () { location.assign('AdministracionGeneral.jsp'); }, 5000);</script>");
                    }
                } else {
                    if (request.getParameter("t").equals("Usuario")) {
                        r = s.executeQuery("SELECT Img FROM Producto WHERE CE='"+session.getAttribute("u")+"'");
                        while (r.next()) {
                            (new File("imgs\\prods\\"+r.getString(1))).delete();
                        }
                        r.close();
                        r = null;
                    }
                    s.executeUpdate("DELETE FROM "+request.getParameter("t")+" WHERE "+request.getParameter("i")+"="+(Boolean.parseBoolean(request.getParameter("sn")) ? "'"+request.getParameter("id")+"'" : request.getParameter("id")));
                    s.execute("COMMIT");
                    if (request.getParameter("t").equals("Producto")) {
                        r = s.executeQuery("SELECT Img FROM Producto WHERE Id="+request.getParameter("id"));
                        r.next();
                        (new File("imgs\\prods\\"+r.getString(1))).delete();
                        r.close();
                        out.print("<div class='success-container'>");
                            out.print("<div class='success-content'>");
                                out.print("<h1 class='success-title'>Registro eliminado EXITOSAMENTE</h1>");
                                out.print("<img src='../../imgs/dsql.png' alt='D' class='success-image'/>");
                            out.print("</div>");
                        out.print("</div>");
                        out.print("<script>setTimeout(function () { history.back(); }, 5000);</script>");
                    }
                }
                s.close();
                c.close();
            } catch (Exception e) {
                out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                out.print("<script>history.back();</script>");
            }
        %>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    </body>
</html>