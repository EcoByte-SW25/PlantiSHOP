<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="auxs.Cortes"%>
<%@page import="auxs.Epistula"%>
<%@page import="auxs.Hash"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.time.LocalDateTime"%>
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
        <title>O</title>
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
            div {
                background-color: whitesmoke;
                width: 60%;
                height: 20em;
                margin: 15em auto 0 auto;
                border: 2px double black;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            h1, h3 {
                text-align: center;
                font-family: Agrandir;
            }
            h1 {
                font-size: 2.5vw;
            }
            h3 {
                font-size: 1vw;
                color: red;
            }
            img {
                display: block;
                width: 45%;
                margin: 2.5em auto 0 auto;
            }
            form {
                background-color: #cccccc;
                width: 75%;
                padding: 5em;
                margin: 18em auto 0 auto;
                border: 2px double black;
            }
            #in {
                display: block;
                width: 80%;
                margin-left: auto;
                margin-right: auto;
                border: 2px solid black;
                border-radius: 5px;
                text-align: center;
                font-family: Arial;
            }
            #sm {
                width: 40%;
                margin-top: 2em;
                background-color: navy;
                color: white;
                font-weight: bold;
                font-family: Agrandir;
                border: 2px double white;
            }
            #sm:hover {
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
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
                c = DriverManager.getConnection("jdbc:mysql://192.168.1.66/PSHOP", "Crud", "PlantiSHOP-+CrUd*/https:02468.!?");
                s = c.createStatement();
                switch (request.getParameter("x")) {
                    case "C": {
                        r = s.executeQuery("SELECT CE FROM Usuario WHERE CE='"+request.getParameter("ce")+"'");
                        if (r.next()) {
                            out.print("<div>");
                                out.print("<h1>Registro INVALIDO</h1>");
                                out.print("<img src='err.png' alt='E'/>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { history.back(); }, 5000);</script>");
                        } else {
                            Epistula e = new Epistula();
                            e.eMail(request.getParameter("ce"), "Nuevo REGISTRO", "¡Bienvenido a PlantiSHOP!");
                            Hash h = new Hash();
                            s.executeUpdate("INSERT INTO Usuario(CE,C1,C2,N,AP,AM,U) VALUES ('"+request.getParameter("ce")+"','"+h.cifrar(request.getParameter("c1"))+"','"+h.cifrar(request.getParameter("c2"))+"','"+request.getParameter("n")+"','"+request.getParameter("ap")+"','"+request.getParameter("am")+"','"+h.cifrar(request.getParameter("u"))+"')");
                            out.print("<div>");
                                out.print("<h1>Usuario correctamente REGISTRADO</h1>");
                                out.print("<img src='csql.png' alt='C'/>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { location.assign('Sesion.html'); }, 5000);</script>");
                        }
                        r.close();
                    } break;
                    case "Cj": {
                        r = s.executeQuery("SELECT Id FROM Jardin WHERE CE='"+session.getAttribute("u")+"' AND N='"+request.getParameter("n")+"'");
                        if (r.next()) {
                            out.print("<div>");
                                out.print("<h1>Registro INVALIDO</h1>");
                                out.print("<img src='err.png' alt='E'/>");
                            out.print("</div>");
                        } else {
                            s.executeUpdate("INSERT INTO Jardin(CE,N,T,C,P) VALUES ('"+session.getAttribute("u")+"','"+request.getParameter("n")+"','"+request.getParameter("t")+"','"+request.getParameter("txt")+"',"+request.getParameter("l")+","+request.getParameter("p")+")");
                            out.print("<div>");
                                out.print("<h1>Elemento correctamente REGISTRADO</h1>");
                                out.print("<img src='csql.png' alt='C'/>");
                            out.print("</div>");
                        }
                        out.print("<script>setTimeout(function () { history.back(); }, 5000);</script>");
                        r.close();
                    } break;
                    case "R": {
                        r = s.executeQuery("SELECT FhN1,FhN2,I1,I2,C1,C2,FfS FROM Usuario WHERE CE='"+request.getParameter("ce")+"'");
                        if (r.next()) {
                            if (r.getTimestamp(1) != null) { if (r.getTimestamp(1).toLocalDateTime().isBefore(LocalDateTime.now())) { s.executeUpdate("UPDATE Usuario SET I1=5,FhN1=NULL WHERE CE='"+request.getParameter("ce")+"'"); } }
                            if (r.getTimestamp(2) != null) { if (r.getTimestamp(2).toLocalDateTime().isBefore(LocalDateTime.now())) { s.executeUpdate("UPDATE Usuario SET I2=2,FhN2=NULL WHERE CE='"+request.getParameter("ce")+"'"); } }
                            if (r.getDate(7) != null) { if (r.getDate(7).toLocalDate().isBefore(LocalDateTime.now().toLocalDate())) { s.executeUpdate("UPDATE Usuario SET P=FALSE,FfS=NULL WHERE CE='"+request.getParameter("ce")+"'"); } }
                        }
                        if (r.first() && r.getByte(3) > 0 && r.getByte(4) > 0 && r.getFetchSize() == 1) {
                            Hash h = new Hash();
                            if (request.getParameter("c1").equals(h.descifrar(r.getString(5))) && request.getParameter("c2").equals(h.descifrar(r.getString(6)))) {
                                Cortes v = new Cortes();
                                String cV = v.cV();
                                s.executeUpdate("UPDATE Usuario SET CV='"+cV+"' WHERE CE='"+request.getParameter("ce")+"'");
                                Epistula e = new Epistula();
                                e.eMail(request.getParameter("ce"), "Código de Verificación", cV);
                                out.print("<form action='Interfaz.jsp' method='post'>");
                                    out.print("<input name='x' type='hidden' value='R2'>");
                                    out.print("<input name='ce' type='hidden' value='"+request.getParameter("ce")+"'>");
                                    out.print("<h1>Para Acceder, ingresa el Codigo de Verificación de 10 Digitos que enviamos a tu Correo Electronico:</h1>");
                                    out.print("<input id='in' name='cv' type='text' pattern='[0-9A-Z]{10}' maxlength='10' required>");
                                    out.print("<input id='sm' type='submit' value='ACCEDER'>");
                                out.print("</form>");
                            } else {
                                if (r.getByte(3) == 1) { s.executeUpdate("UPDATE Usuario SET FhN1='"+LocalDateTime.now().plusDays(1L).format(DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss"))+"' WHERE CE='"+request.getParameter("ce")+"'"); }
                                s.executeUpdate("UPDATE Usuario SET I1="+(r.getByte(3) - 1)+" WHERE CE='"+request.getParameter("ce")+"'");
                                out.print("<div>");
                                    out.print("<h1>Contraseña(s) INCORRECTA(S)</h1>");
                                    out.print("<h3>Intentos RESTANTES: "+(r.getByte(3) - 1)+"</h3>");
                                    out.print("<img src='err.png' alt='E'/>");
                                out.print("</div>");
                                out.print("<script>setTimeout(function () { history.back(); }, 5000);</script>");
                            }
                        } else {
                            out.print("<div>");
                                out.print("<h1>Usuario INVALIDO</h1>");
                                out.print("<img src='err.png' alt='E'/>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { history.back(); }, 5000);</script>");
                        }
                        r.close();
                    } break;
                    case "R2": {
                        r = s.executeQuery("SELECT CV,I2 FROM Usuario WHERE CE='"+request.getParameter("ce")+"'");
                        r.next();
                        if (request.getParameter("cv").equals(r.getString(1))) {
                            if (!request.getParameter("ce").equals("") && !request.getParameter("ce").equals("") && !request.getParameter("ce").equals("") && !request.getParameter("ce").equals("")) { session.setAttribute("u", request.getParameter("ce")); }
                            s.executeUpdate("UPDATE Usuario SET CV=NULL,I1=5,FhN1=NULL,I2=2,FhN2=NULL WHERE CE='"+request.getParameter("ce")+"'");
                            out.print("<div>");
                                out.print("<h1>¡Bienvenido a PlantiSHOP!</h1>");
                                out.print("<img src='rsql.png' alt='R'/>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { location.assign('"+((!request.getParameter("ce").equals("") && !request.getParameter("ce").equals("") && !request.getParameter("ce").equals("") && !request.getParameter("ce").equals("")) ? "Principal.html" : "premium/control/AdministracionGeneral.jsp")+"'); }, 5000);</script>");
                        } else {
                            if (r.getByte(2) == 1) { s.executeUpdate("UPDATE Usuario SET FhN2='"+LocalDateTime.now().plusDays(2L).format(DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss"))+"' WHERE CE='"+request.getParameter("ce")+"'"); }
                            s.executeUpdate("UPDATE Usuario SET CV=NULL,I2="+(r.getByte(2) - 1)+" WHERE CE='"+request.getParameter("ce")+"'");
                            out.print("<div>");
                                out.print("<h1>Verificación INCORRECTA</h1>");
                                out.print("<h3>Intentos RESTANTES: "+(r.getByte(2) - 1)+"</h3>");
                                out.print("<img src='err.png' alt='E'/>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { location.assign('Sesion.html'); }, 5000);</script>");
                        }
                        r.close();
                    } break;
                    case "M": {
                        Epistula e = new Epistula();
                        e.eMail("ecobyte.sw@gmail.com", ((String) session.getAttribute("u")), request.getParameter("em"));
                        out.print("<div>");
                            out.print("<h1>Mensaje correctamente ENVIADO</h1>");
                            out.print("<img src='csql.png' alt='OK'/>");
                        out.print("</div>");
                        out.print("<script>setTimeout(function () { history.back(); }, 5000);</script>");
                    } break;
                    case "U0": {
                        r = s.executeQuery("SELECT C1,C2 FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
                        r.next();
                        Hash h = new Hash();
                        if (request.getParameter("c1").equals(h.descifrar(r.getString(1))) && request.getParameter("c2").equals(h.descifrar(r.getString(2)))) {
                            s.executeUpdate("UPDATE Usuario SET C1='"+h.cifrar(request.getParameter("nc1"))+"',C2='"+h.cifrar(request.getParameter("nc2"))+"' WHERE CE='"+session.getAttribute("u")+"'");
                            out.print("<div>");
                                out.print("<h1>Usuario correctamente ACTUALIZADO</h1>");
                                out.print("<img src='usql.png' alt='U'/>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { location.assign('Sesion.html'); }, 5000);</script>");
                        } else {
                            out.print("<div>");
                                out.print("<h1>Actualización DENEGADA</h1>");
                                out.print("<img src='err.png' alt='E'/>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { history.back(); }, 5000);</script>");
                        }
                        r.close();
                    } break;
                    case "U1": {
                        r = s.executeQuery("SELECT C1,C2 FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
                        r.next();
                        Hash h = new Hash();
                        if (request.getParameter("c1").equals(h.descifrar(r.getString(1))) && request.getParameter("c2").equals(h.descifrar(r.getString(2)))) {
                            s.executeUpdate("UPDATE Usuario SET C1='"+h.cifrar(request.getParameter("nc1"))+"' WHERE CE='"+session.getAttribute("u")+"'");
                            out.print("<div>");
                                out.print("<h1>Usuario correctamente ACTUALIZADO</h1>");
                                out.print("<img src='usql.png' alt='U'/>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { location.assign('Sesion.html'); }, 5000);</script>");
                        } else {
                            out.print("<div>");
                                out.print("<h1>Actualización DENEGADA</h1>");
                                out.print("<img src='err.png' alt='E'/>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { history.back(); }, 5000);</script>");
                        }
                        r.close();
                    } break;
                    case "U2": {
                        r = s.executeQuery("SELECT C1,C2 FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
                        r.next();
                        Hash h = new Hash();
                        if (request.getParameter("c1").equals(h.descifrar(r.getString(1))) && request.getParameter("c2").equals(h.descifrar(r.getString(2)))) {
                            s.executeUpdate("UPDATE Usuario SET C2='"+h.cifrar(request.getParameter("nc2"))+"' WHERE CE='"+session.getAttribute("u")+"'");
                            out.print("<div>");
                                out.print("<h1>Usuario correctamente ACTUALIZADO</h1>");
                                out.print("<img src='usql.png' alt='U'/>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { location.assign('Sesion.html'); }, 5000);</script>");
                        } else {
                            out.print("<div>");
                                out.print("<h1>Actualización DENEGADA</h1>");
                                out.print("<img src='err.png' alt='E'/>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { history.back(); }, 5000);</script>");
                        }
                        r.close();
                    } break;
                    case "D": {
                        r = s.executeQuery("SELECT C1,C2 FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
                        r.next();
                        Hash h = new Hash();
                        if (request.getParameter("c1").equals(h.descifrar(r.getString(1))) && request.getParameter("c2").equals(h.descifrar(r.getString(2)))) {
                            s.executeUpdate("DELETE FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
                            session.removeAttribute("u");
                            out.print("<div>");
                                out.print("<h1>Usuario correctamente ELIMINADO</h1>");
                                out.print("<img src='dsql.png' alt='D'/>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { location.assign('index.html'); }, 5000);</script>");
                        } else {
                            out.print("<div>");
                                out.print("<h1>Eliminación DENEGADA</h1>");
                                out.print("<img src='err.png' alt='E'/>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { history.back(); }, 5000);</script>");
                        }
                        r.close();
                    } break;
                    case "Un": {
                        s.executeUpdate("UPDATE Usuario SET N='"+request.getParameter("n")+"' WHERE CE='"+session.getAttribute("u")+"'");
                        out.print("<script>history.back();</script>");
                    } break;
                    case "Uap": {
                        s.executeUpdate("UPDATE Usuario SET AP='"+request.getParameter("ap")+"' WHERE CE='"+session.getAttribute("u")+"'");
                        out.print("<script>history.back();</script>");
                    } break;
                    case "Uam": {
                        s.executeUpdate("UPDATE Usuario SET AM='"+request.getParameter("am")+"' WHERE CE='"+session.getAttribute("u")+"'");
                        out.print("<script>history.back();</script>");
                    } break;
                    case "Uu": {
                        Hash h = new Hash();
                        s.executeUpdate("UPDATE Usuario SET U='"+h.cifrar(request.getParameter("u"))+"' WHERE CE='"+session.getAttribute("u")+"'");
                        out.print("<script>history.back();</script>");
                    } break;
                    case "Utxtj": {
                        s.executeUpdate("UPDATE Jardin SET C='"+request.getParameter("txt")+"' WHERE Id="+request.getParameter("id"));
                        out.print("<script>history.back();</script>");
                    } break;
                    case "Ulj": {
                        s.executeUpdate("UPDATE Jardin SET L="+request.getParameter("l")+" WHERE Id="+request.getParameter("id"));
                        out.print("<script>history.back();</script>");
                    } break;
                    case "Upj": {
                        s.executeUpdate("UPDATE Jardin SET P="+request.getParameter("p")+" WHERE Id="+request.getParameter("id"));
                        out.print("<script>history.back();</script>");
                    } break;
                    case "Upv": {
                        s.executeUpdate("UPDATE Producto SET P="+request.getParameter("p")+" WHERE Id="+request.getParameter("id"));
                        out.print("<script>history.back();</script>");
                    } break;
                    case "Ucv": {
                        s.executeUpdate("UPDATE Producto SET Cupo="+request.getParameter("c")+" WHERE Id="+request.getParameter("id"));
                        out.print("<script>history.back();</script>");
                    } break;
                    case "Utxtv": {
                        s.executeUpdate("UPDATE Producto SET D='"+request.getParameter("txt")+"' WHERE Id="+request.getParameter("id"));
                        out.print("<script>history.back();</script>");
                    } break;
                    case "D2": {
                        s.executeUpdate("DELETE FROM "+request.getParameter("t")+" WHERE Id="+request.getParameter("id"));
                        if (request.getParameter("t").equals("Producto")) {
                            r = s.executeQuery("SELECT Img FROM Producto WHERE Id="+request.getParameter("id"));
                            r.next();
                            (new File("imgs\\prods\\"+r.getString(1))).delete();
                            r.close();
                        }
                        out.print("<script>history.back();</script>");
                    } break;
                    case "B": {
                        r = s.executeQuery("SELECT CE,N,D,P,Img,Cupo FROM Producto WHERE Id="+request.getParameter("id"));
                        r.next();
                        s.executeUpdate("INSERT INTO Compra(V,C,NP,DP,PP,ImgP,X,LP) VALUES ('"+r.getString(1)+"','"+session.getAttribute("u")+"','"+r.getString(2)+"','"+r.getString(3)+"',"+r.getFloat(4)+",'"+r.getString(5)+"',1,"+((r.getInt(6) < 100) ? r.getInt(6) : 0)+")");
                        out.print("<div>");
                            out.print("<h1>Compra REALIZADA</h1>");
                            out.print("<img src='csql.png' alt='C'/>");
                        out.print("</div>");
                        out.print("<script>setTimeout(function () { history.back(); }, 5000);</script>");
                        r.close();
                    } break;
                    case "B1": {
                        Hash h = new Hash();
                        s.executeUpdate("UPDATE Compra SET X=2,LP="+request.getParameter("n")+",TP="+request.getParameter("pt")+",U='"+h.cifrar(request.getParameter("u"))+"',Fh='"+LocalDateTime.parse(request.getParameter("fh"), DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss"))+"' WHERE Id="+request.getParameter("id"));
                        out.print("<div>");
                            out.print("<h1>Notificación ENVIADA</h1>");
                            out.print("<img src='usql.png' alt='U'/>");
                        out.print("</div>");
                        out.print("<script>setTimeout(function () { history.back(); }, 5000);</script>");
                    } break;
                    case "B2": {
                        if (Boolean.parseBoolean(request.getParameter("sn"))) {
                            s.executeUpdate("UPDATE Compra SET X=3,BMsg=FALSE WHERE Id="+request.getParameter("id"));
                            out.print("<div>");
                                out.print("<h1>Oferta ACEPTADA</h1>");
                                out.print("<img src='usql.png' alt='U'/>");
                            out.print("</div>");
                        } else {
                            s.executeUpdate("UPDATE Compra SET X=1,LP=0,TP=0.00,U=NULL,Fh=NULL,BMsg=TRUE WHERE Id="+request.getParameter("id"));
                            out.print("<div>");
                                out.print("<h1>Oferta RECHAZADA</h1>");
                                out.print("<img src='bnot.png' alt='NB'/>");
                            out.print("</div>");
                        }
                        out.print("<script>setTimeout(function () { location.assign('Mensajeria.jsp#tV'); }, 5000);</script>");
                    } break;
                    case "B3": {
                        r = s.executeQuery("SELECT N,AP,AM FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
                        r.next();
                        String[] $c = {r.getString(1), r.getString(2), r.getString(3)};
                        r = s.executeQuery("SELECT Producto.Pop,Producto.Id,Usuario.CE,Usuario.N,Usuario.AP,Usuario.AM,Compra.NP,Compra.LP,Compra.TP,Compra.Fh,Compra.U,Producto.Cupo FROM Producto (INNER JOIN Usuario ON Producto.CE=Usuario.CE (INNER JOIN Compra ON Usuario.CE=Compra.V)) WHERE Compra.C='"+session.getAttribute("u")+"' AND Compra.Id="+request.getParameter("id"));
                        r.next();
                        if (Boolean.parseBoolean(request.getParameter("sn"))) {
                            s.executeUpdate("UPDATE Compra SET X=4,DP=NULL,PP=0.00,LP=0,U=NULL,BMsg=NULL WHERE Id="+request.getParameter("id"));
                            s.executeUpdate("UPDATE Producto SET Pop="+(r.getLong(1) + 1L)+",Cupo="+(r.getInt(12) - r.getByte(8))+" WHERE Id="+r.getLong(2));
                            Hash h = new Hash();
                            s.executeUpdate("INSERT INTO Notificacion(V,C,APC,AMC,N,P,LP,TP,Fh,U) VALUES ('"+r.getString(3)+"','"+$c[0]+"','"+$c[1]+"','"+$c[2]+"',TRUE,'"+r.getString(7)+"',"+r.getByte(8)+","+r.getFloat(9)+",'"+r.getString(10)+"','"+h.cifrar(r.getString(11))+"')");
                            File f = new File("D:\\C"+request.getParameter("id")+".txt");
                            f.createNewFile();
                            FileWriter w = new FileWriter(f);
                            w.write("Registro Comercial\n\nProducto: "+r.getString(7)+"\nVendedor: "+r.getString(4)+" "+r.getString(5)+" "+r.getString(6)+"\nComprador: "+$c[0]+" "+$c[1]+" "+$c[2]+"\nNo. de Lotes: "+r.getByte(8)+"\nCosto: $"+r.getFloat(9)+"\nFecha y Hora: "+r.getTimestamp(10).toLocalDateTime().format(DateTimeFormatter.ofPattern("d / MMM / uuuu -- h:mm a")).toUpperCase()+"\nUbicacion: "+h.descifrar(r.getString(11)));
                            w.close();
                            out.print("<div>");
                                out.print("<h1>Compra FINALIZADA</h1>");
                                out.print("<img src='byes.png' alt='YB'/>");
                            out.print("</div>");
                        } else {
                            s.executeUpdate("INSERT INTO Notificacion(V,C,APC,AMC,N,P) VALUES ('"+r.getString(3)+"','"+$c[0]+"','"+$c[1]+"','"+$c[2]+"',FALSE,'"+r.getString(7)+"')");
                            s.executeUpdate("DELETE FROM Compra WHERE Id="+request.getParameter("id"));
                            out.print("<div>");
                                out.print("<h1>Compra CANCELADA</h1>");
                                out.print("<img src='dsql.png' alt='D'/>");
                            out.print("</div>");
                        }
                        out.print("<script>setTimeout(function () { history.back(); }, 5000);</script>");
                        r.close();
                    } break;
                    case "E": {
                        session.removeAttribute("u");
                        out.print("<script>location.assign('index.html');</script>");
                    } break;
                }
                s.execute("COMMIT");
                s.close();
                c.close();
            } catch (Exception e) {
                out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO');</script>");
                out.print("<script>history.back();</script>");
            }
        %>
    </body>
</html>