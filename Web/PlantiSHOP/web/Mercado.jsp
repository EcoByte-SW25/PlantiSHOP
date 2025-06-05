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
            h1, p {
                text-align: center;
                font-family: Agrandir;
            }
            h2, h3, section p {
                text-align: left;
                font-family: Coco Gothic;
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
        <h1>Mercado</h1>
        <hr>
        <fieldset id="PD">
            <legend>Plantas Decorativas</legend>
            <%
                try {
                    r = s.executeQuery("SELECT Productos.Img,Productos.Id,Productos.N,Productos.P,Productos.D,Usuarios.N,Usuarios.AP,Usuarios.AM FROM Productos INNER JOIN Usuarios ON Productos.CE=Usuarios.CE WHERE Productos.T='PD' ORDER BY Productos.Pop DESC");
                    if (r.getFetchSize() > 0) {
                        while (r.next()) {
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
                    if (r.getFetchSize() > 0) {
                        while (r.next()) {
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
                    if (r.getFetchSize() > 0) {
                        while (r.next()) {
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
                    if (r.getFetchSize() > 0) {
                        while (r.next()) {
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
                    if (r.getFetchSize() > 0) {
                        while (r.next()) {
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
                    if (r.getFetchSize() > 0) {
                        while (r.next()) {
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
                    if (r.getFetchSize() > 0) {
                        while (r.next()) {
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
                    r.close();
                    s.close();
                    c.close();
                } catch (Exception e) {
                    out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                    out.print("<script>history.back();</script>");
                }
            %>
        </fieldset>
    </body>
</html>