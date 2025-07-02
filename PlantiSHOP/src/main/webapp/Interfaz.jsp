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
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-image: url(imgs/fondo2.jpg);
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
            .success-text {
                flex: 1;
            }
            .success-title {
                color: #495057;
                font-weight: 600;
                font-size: 2.5rem;
                margin: 0;
                white-space: nowrap;
                line-height: 1.2;
            }
            .success-subtitle {
                color: #6c757d;
                font-weight: 500;
                font-size: 1.4rem;
                margin: 15px 0 0 0;
                white-space: nowrap;
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
                .success-subtitle {
                    font-size: 1.2rem;
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
                .success-subtitle {
                    font-size: 1.1rem;
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
            .verification-container {
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .verification-card {
                max-width: 600px;
                width: 100%;
                padding: 3rem;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }
            .verification-title {
                font-size: 1.5rem;
                font-weight: 600;
                margin-bottom: 2rem;
                text-align: center;
                line-height: 1.4;
            }
            .code-input {
                font-size: 1.2rem;
                padding: 1rem;
                border: none;
                border-radius: 10px;
                text-align: center;
                letter-spacing: 0.2em;
                font-weight: 500;
                margin-bottom: 2rem;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
            }
            .code-input:focus {
                outline: none;
                box-shadow: 0 8px 25px rgba(255, 255, 255, 0.2);
                transform: translateY(-2px);
            }
            .submit-btn {
                font-size: 1.1rem;
                font-weight: 600;
                padding: 1rem 2rem;
                border: none;
                border-radius: 10px;
                background: linear-gradient(45deg, #ff6b6b, #ee5a24);
                color: white;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            }
            .submit-btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
                background: linear-gradient(45deg, #ee5a24, #ff6b6b);
            }
            .submit-btn:active {
                transform: translateY(-1px);
            }
            @media (max-width: 768px) {
                .verification-card {
                    padding: 2rem;
                    margin: 1rem;
                }
                .verification-title {
                    font-size: 1.3rem;
                }
                .code-input {
                    font-size: 1rem;
                }
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
                c = DriverManager.getConnection("jdbc:mysql://localhost/PSHOP", "root", "n0m3l0");
                s = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                switch (request.getParameter("x")) {
                    case "C": {
                        r = s.executeQuery("SELECT CE FROM Usuario WHERE CE='"+request.getParameter("ce")+"'");
                        if (r.next()) {
                            out.print("<div class='success-container'>");
                                out.print("<div class='success-content'>");
                                    out.print("<h1 class='success-title'>Registro INVALIDO</h1>");
                                    out.print("<img src='imgs/err.png' alt='E' class='success-image'/>");
                                out.print("</div>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { location.assign('Registro.jsp'); }, 5000);</script>");
                        } else {
                            Epistula e = new Epistula();
                            e.eMail(request.getParameter("ce"), "Nuevo REGISTRO", "¡Bienvenido a PlantiSHOP!");
                            Hash h = new Hash();
                            s.executeUpdate("INSERT INTO Usuario(CE,C1,C2,N,AP,AM,U) VALUES ('"+request.getParameter("ce")+"','"+h.hashSHA256(request.getParameter("c1"))+"','"+h.hashSHA256(request.getParameter("c2"))+"','"+request.getParameter("n")+"','"+request.getParameter("ap")+"','"+request.getParameter("am")+"','"+request.getParameter("u")+"')");
                            out.print("<div class='success-container'>");
                                out.print("<div class='success-content'>");
                                    out.print("<h1 class='success-title'>Usuario correctamente REGISTRADO</h1>");
                                    out.print("<img src='imgs/csql.png' alt='C' class='success-image'/>");
                                out.print("</div>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { location.assign('Sesion.html'); }, 5000);</script>");
                            s.execute("COMMIT");
                        }
                        r.close();
                    } break;
                    case "Cj": {
                        r = s.executeQuery("SELECT Id FROM Jardin WHERE CE='"+session.getAttribute("u")+"' AND N='"+request.getParameter("n")+"'");
                        if (r.next()) {
                            out.print("<div class='success-container'>");
                                out.print("<div class='success-content'>");
                                    out.print("<h1 class='success-title'>Registro INVALIDO</h1>");
                                    out.print("<img src='imgs/err.png' alt='E' class='success-image'/>");
                                out.print("</div>");
                            out.print("</div>");
                        } else {
                            s.executeUpdate("INSERT INTO Jardin(CE,N,T,C,L,P) VALUES ('"+session.getAttribute("u")+"','"+request.getParameter("n")+"','"+request.getParameter("t")+"',"+((request.getParameter("txt") == null) ? "NULL" : "'"+request.getParameter("txt")+"'")+","+request.getParameter("l")+","+request.getParameter("p")+")");
                            out.print("<div class='success-container'>");
                                out.print("<div class='success-content'>");
                                    out.print("<h1 class='success-title'>Elemento correctamente REGISTRADO</h1>");
                                    out.print("<img src='imgs/csql.png' alt='C' class='success-image'/>");
                                out.print("</div>");
                            out.print("</div>");
                            s.execute("COMMIT");
                        }
                        out.print("<script>setTimeout(function () { location.assign('Jardin.jsp'); }, 5000);</script>");
                        r.close();
                    } break;
                    case "R": {
                        r = s.executeQuery("SELECT FhN1,FhN2,I1,I2,C1,C2,FfS FROM Usuario WHERE CE='"+request.getParameter("ce")+"'");
                        if (r.next() && !r.next()) {
                            r.first();
                            if (r.getTimestamp(1) != null) { if (r.getTimestamp(1).toLocalDateTime().isBefore(LocalDateTime.now())) { s.executeUpdate("UPDATE Usuario SET I1=5,FhN1=NULL WHERE CE='"+request.getParameter("ce")+"'"); } }
                            if (r.getTimestamp(2) != null) { if (r.getTimestamp(2).toLocalDateTime().isBefore(LocalDateTime.now())) { s.executeUpdate("UPDATE Usuario SET I2=2,FhN2=NULL WHERE CE='"+request.getParameter("ce")+"'"); } }
                            if (r.getDate(7) != null) { if (r.getDate(7).toLocalDate().isBefore(LocalDateTime.now().toLocalDate())) { s.executeUpdate("UPDATE Usuario SET P=FALSE,FfS=NULL WHERE CE='"+request.getParameter("ce")+"'"); } }
                            if (r.getByte(3) > 0 && r.getByte(4) > 0) {
                                Hash h = new Hash();
                                if (r.getString(5).equals(h.hashSHA256(request.getParameter("c1"))) && r.getString(6).equals(h.hashSHA256(request.getParameter("c2")))) {
                                    Cortes v = new Cortes();
                                    String cV = v.cV();
                                    s.executeUpdate("UPDATE Usuario SET CV='"+cV+"' WHERE CE='"+request.getParameter("ce")+"'");
                                    Epistula e = new Epistula();
                                    e.eMail(request.getParameter("ce"), "Código de Verificación", cV);
                                    out.print("<div class='container-fluid verification-container'>");
                                        out.print("<div class='verification-card'>");
                                            out.print("<form action='Interfaz.jsp' method='post' class='text-center'>");
                                                out.print("<input name='x' type='hidden' value='R2'>");
                                                out.print("<input name='ce' type='hidden' value='"+request.getParameter("ce")+"'>");
                                                out.print("<h1 class='verification-title'>Para Acceder, ingresa el Codigo de Verificación de 10 Digitos que enviamos a tu Correo Electronico:</h1>");
                                                out.print("<div class='mb-4'><input name='cv' class='form-control code-input' type='text' pattern='[0-9+.*/A-Z]{10}' maxlength='10' placeholder='----------' required></div>");
                                                out.print("<div class='d-grid'><input type='submit' value='ACCEDER' class='btn submit-btn'></div>");
                                            out.print("</form>");
                                        out.print("</div>");
                                    out.print("</div>");
                                } else {
                                    if (r.getByte(3) == 1) { s.executeUpdate("UPDATE Usuario SET FhN1='"+LocalDateTime.now().plusDays(1L).format(DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss"))+"' WHERE CE='"+request.getParameter("ce")+"'"); }
                                    byte menos = ((byte) (r.getByte(3) - 1));
                                    s.executeUpdate("UPDATE Usuario SET I1="+menos+" WHERE CE='"+request.getParameter("ce")+"'");
                                    out.print("<div class='success-container'>");
                                        out.print("<div class='success-content'>");
                                            out.print("<div class='success-text'>");
                                                out.print("<h1 class='success-title'>Contraseña(s) INCORRECTA(S)</h1>");
                                                out.print("<h3 class='success-subtitle'>Intentos RESTANTES: "+menos+"</h3>");
                                            out.print("</div>");
                                            out.print("<img src='imgs/err.png' alt='E' class='success-image'/>");
                                        out.print("</div>");
                                    out.print("</div>");
                                    out.print("<script>setTimeout(function () { location.assign('Sesion.html'); }, 5000);</script>");
                                }
                                s.execute("COMMIT");
                            } else {
                                out.print("<div class='success-container'>");
                                    out.print("<div class='success-content'>");
                                        out.print("<h1 class='success-title'>Usuario INVALIDO</h1>");
                                        out.print("<img src='imgs/err.png' alt='E' class='success-image'/>");
                                    out.print("</div>");
                                out.print("</div>");
                                out.print("<script>setTimeout(function () { location.assign('Sesion.html'); }, 5000);</script>");
                            }
                        } else {
                            out.print("<div class='success-container'>");
                                out.print("<div class='success-content'>");
                                    out.print("<h1 class='success-title'>Usuario No REGISTRADO</h1>");
                                    out.print("<img src='imgs/err.png' alt='E' class='success-image'/>");
                                out.print("</div>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { location.assign('Sesion.html'); }, 5000);</script>");
                        }
                        r.close();
                    } break;
                    case "R2": {
                        r = s.executeQuery("SELECT CV,I2 FROM Usuario WHERE CE='"+request.getParameter("ce")+"'");
                        r.next();
                        if (request.getParameter("cv").equals(r.getString(1))) {
                            session.setAttribute("u", request.getParameter("ce"));
                            s.executeUpdate("UPDATE Usuario SET CV=NULL,I1=5,FhN1=NULL,I2=2,FhN2=NULL WHERE CE='"+request.getParameter("ce")+"'");
                            out.print("<div class='success-container'>");
                                out.print("<div class='success-content'>");
                                    out.print("<h1 class='success-title'>¡Bienvenido a PlantiSHOP!</h1>");
                                    out.print("<img src='imgs/rsql.png' alt='R' class='success-image'/>");
                                out.print("</div>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { location.assign('"+((!request.getParameter("ce").equals("alonmc237@gmail.com") && !request.getParameter("ce").equals("fernandomarlon2007.1976@gmail.com") && !request.getParameter("ce").equals("juanpagon16@gmail.com") && !request.getParameter("ce").equals("agarciagael93@gmail.com")) ? "Perfil.jsp" : "premium/control/AdministracionGeneral.jsp")+"'); }, 5000);</script>");
                        } else {
                            if (r.getByte(2) == 1) { s.executeUpdate("UPDATE Usuario SET FhN2='"+LocalDateTime.now().plusDays(2L).format(DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss"))+"' WHERE CE='"+request.getParameter("ce")+"'"); }
                            byte menos = ((byte) (r.getByte(2) - 1));
                            s.executeUpdate("UPDATE Usuario SET CV=NULL,I2="+menos+" WHERE CE='"+request.getParameter("ce")+"'");
                            out.print("<div class='success-container'>");
                                out.print("<div class='success-content'>");
                                    out.print("<div class='success-text'>");
                                        out.print("<h1 class='success-title'>Verificación INCORRECTA</h1>");
                                        out.print("<h3 class='success-subtitle'>Intentos RESTANTES: "+menos+"</h3>");
                                    out.print("</div>");
                                    out.print("<img src='imgs/err.png' alt='E' class='success-image'/>");
                                out.print("</div>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { location.assign('Sesion.html'); }, 5000);</script>");
                        }
                        r.close();
                        s.execute("COMMIT");
                    } break;
                    case "M": {
                        Epistula e = new Epistula();
                        e.eMail("ecobyte.sw@gmail.com", ((String) session.getAttribute("u")), request.getParameter("em"));
                        out.print("<div class='success-container'>");
                            out.print("<div class='success-content'>");
                                out.print("<h1 class='success-title'>Mensaje correctamente ENVIADO</h1>");
                                out.print("<img src='imgs/csql.png' alt='OK' class='success-image'/>");
                            out.print("</div>");
                        out.print("</div>");
                        out.print("<script>setTimeout(function () { location.assign('FAQ.html'); }, 5000);</script>");
                    } break;
                    case "U0": {
                        r = s.executeQuery("SELECT C1,C2 FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
                        r.next();
                        Hash h = new Hash();
                        if (r.getString(1).equals(h.hashSHA256(request.getParameter("c1"))) && r.getString(2).equals(h.hashSHA256(request.getParameter("c2")))) {
                            s.executeUpdate("UPDATE Usuario SET C1='"+h.hashSHA256(request.getParameter("nc1"))+"',C2='"+h.hashSHA256(request.getParameter("nc2"))+"' WHERE CE='"+session.getAttribute("u")+"'");
                            session.removeAttribute("u");
                            out.print("<div class='success-container'>");
                                out.print("<div class='success-content'>");
                                    out.print("<h1 class='success-title'>Usuario correctamente ACTUALIZADO</h1>");
                                    out.print("<img src='imgs/usql.png' alt='U' class='success-image'/>");
                                out.print("</div>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { location.assign('Sesion.html'); }, 5000);</script>");
                            s.execute("COMMIT");
                        } else {
                            out.print("<div class='success-container'>");
                                out.print("<div class='success-content'>");
                                    out.print("<h1 class='success-title'>Actualización DENEGADA</h1>");
                                    out.print("<img src='imgs/err.png' alt='E' class='success-image'/>");
                                out.print("</div>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { location.assign('Perfil.jsp'); }, 5000);</script>");
                        }
                        r.close();
                    } break;
                    case "U1": {
                        r = s.executeQuery("SELECT C1,C2 FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
                        r.next();
                        Hash h = new Hash();
                        if (r.getString(1).equals(h.hashSHA256(request.getParameter("c1"))) && r.getString(2).equals(h.hashSHA256(request.getParameter("c2")))) {
                            s.executeUpdate("UPDATE Usuario SET C1='"+h.hashSHA256(request.getParameter("nc1"))+"' WHERE CE='"+session.getAttribute("u")+"'");
                            session.removeAttribute("u");
                            out.print("<div class='success-container'>");
                                out.print("<div class='success-content'>");
                                    out.print("<h1 class='success-title'>Usuario correctamente ACTUALIZADO</h1>");
                                    out.print("<img src='imgs/usql.png' alt='U' class='success-image'/>");
                                out.print("</div>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { location.assign('Sesion.html'); }, 5000);</script>");
                            s.execute("COMMIT");
                        } else {
                            out.print("<div class='success-container'>");
                                out.print("<div class='success-content'>");
                                    out.print("<h1 class='success-title'>Actualización DENEGADA</h1>");
                                    out.print("<img src='imgs/err.png' alt='E' class='success-image'/>");
                                out.print("</div>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { location.assign('Perfil.jsp'); }, 5000);</script>");
                        }
                        r.close();
                    } break;
                    case "U2": {
                        r = s.executeQuery("SELECT C1,C2 FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
                        r.next();
                        Hash h = new Hash();
                        if (r.getString(1).equals(h.hashSHA256(request.getParameter("c1"))) && r.getString(2).equals(h.hashSHA256(request.getParameter("c2")))) {
                            s.executeUpdate("UPDATE Usuario SET C2='"+h.hashSHA256(request.getParameter("nc2"))+"' WHERE CE='"+session.getAttribute("u")+"'");
                            session.removeAttribute("u");
                            out.print("<div class='success-container'>");
                                out.print("<div class='success-content'>");
                                    out.print("<h1 class='success-title'>Usuario correctamente ACTUALIZADO</h1>");
                                    out.print("<img src='imgs/usql.png' alt='U' class='success-image'/>");
                                out.print("</div>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { location.assign('Sesion.html'); }, 5000);</script>");
                            s.execute("COMMIT");
                        } else {
                            out.print("<div class='success-container'>");
                                out.print("<div class='success-content'>");
                                    out.print("<h1 class='success-title'>Actualización DENEGADA</h1>");
                                    out.print("<img src='imgs/err.png' alt='E' class='success-image'/>");
                                out.print("</div>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { location.assign('Perfil.jsp'); }, 5000);</script>");
                        }
                        r.close();
                    } break;
                    case "D": {
                        r = s.executeQuery("SELECT C1,C2 FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
                        r.next();
                        Hash h = new Hash();
                        if (r.getString(1).equals(h.hashSHA256(request.getParameter("c1"))) && r.getString(2).equals(h.hashSHA256(request.getParameter("c2")))) {
                            r.close();
                            r = null;
                            r = s.executeQuery("SELECT Img FROM Producto WHERE CE='"+session.getAttribute("u")+"'");
                            while (r.next()) {
                                (new File("C:\\Users\\Marlon\\PlantiSHOP\\src\\main\\webapp\\imgs\\prods\\"+r.getString(1))).delete();
                            }
                            r.close();
                            s.executeUpdate("DELETE FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
                            session.removeAttribute("u");
                            out.print("<div class='success-container'>");
                                out.print("<div class='success-content'>");
                                    out.print("<h1 class='success-title'>Usuario correctamente ELIMINADO</h1>");
                                    out.print("<img src='imgs/dsql.png' alt='D' class='success-image'/>");
                                out.print("</div>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { location.assign('index.html'); }, 5000);</script>");
                            s.execute("COMMIT");
                        } else {
                            r.close();
                            out.print("<div class='success-container'>");
                                out.print("<div class='success-content'>");
                                    out.print("<h1 class='success-title'>Eliminación DENEGADA</h1>");
                                    out.print("<img src='imgs/err.png' alt='E' class='success-image'/>");
                                out.print("</div>");
                            out.print("</div>");
                            out.print("<script>setTimeout(function () { location.assign('Perfil.jsp'); }, 5000);</script>");
                        }
                    } break;
                    case "Un": {
                        s.executeUpdate("UPDATE Usuario SET N='"+request.getParameter("n")+"' WHERE CE='"+session.getAttribute("u")+"'");
                        out.print("<script>location.assign('Perfil.jsp');</script>");
                        s.execute("COMMIT");
                    } break;
                    case "Uap": {
                        s.executeUpdate("UPDATE Usuario SET AP='"+request.getParameter("ap")+"' WHERE CE='"+session.getAttribute("u")+"'");
                        out.print("<script>location.assign('Perfil.jsp');</script>");
                        s.execute("COMMIT");
                    } break;
                    case "Uam": {
                        s.executeUpdate("UPDATE Usuario SET AM='"+request.getParameter("am")+"' WHERE CE='"+session.getAttribute("u")+"'");
                        out.print("<script>location.assign('Perfil.jsp');</script>");
                        s.execute("COMMIT");
                    } break;
                    case "Uu": {
                        s.executeUpdate("UPDATE Usuario SET U='"+request.getParameter("u")+"' WHERE CE='"+session.getAttribute("u")+"'");
                        out.print("<script>location.assign('Perfil.jsp');</script>");
                        s.execute("COMMIT");
                    } break;
                    case "Utxtj": {
                        s.executeUpdate("UPDATE Jardin SET C="+((request.getParameter("txt") == null) ? "NULL" : "'"+request.getParameter("txt")+"'")+" WHERE Id="+request.getParameter("id"));
                        out.print("<script>location.assign('Jardin.jsp');</script>");
                        s.execute("COMMIT");
                    } break;
                    case "Ulj": {
                        s.executeUpdate("UPDATE Jardin SET L="+request.getParameter("l")+" WHERE Id="+request.getParameter("id"));
                        out.print("<script>location.assign('Jardin.jsp');</script>");
                        s.execute("COMMIT");
                    } break;
                    case "Upj": {
                        s.executeUpdate("UPDATE Jardin SET P="+request.getParameter("p")+" WHERE Id="+request.getParameter("id"));
                        out.print("<script>location.assign('Jardin.jsp');</script>");
                        s.execute("COMMIT");
                    } break;
                    case "Upv": {
                        s.executeUpdate("UPDATE Producto SET P="+request.getParameter("p")+" WHERE Id="+request.getParameter("id"));
                        out.print("<script>location.assign('Ventas.jsp');</script>");
                        s.execute("COMMIT");
                    } break;
                    case "Ucv": {
                        s.executeUpdate("UPDATE Producto SET Cupo="+request.getParameter("c")+" WHERE Id="+request.getParameter("id"));
                        out.print("<script>location.assign('Ventas.jsp');</script>");
                        s.execute("COMMIT");
                    } break;
                    case "Utxtv": {
                        s.executeUpdate("UPDATE Producto SET D="+((request.getParameter("txt") == null) ? "NULL" : "'"+request.getParameter("txt")+"'")+" WHERE Id="+request.getParameter("id"));
                        out.print("<script>location.assign('Ventas.jsp');</script>");
                        s.execute("COMMIT");
                    } break;
                    case "D2": {
                        if (request.getParameter("t").equals("Producto")) {
                            r = s.executeQuery("SELECT Img FROM Producto WHERE Id="+request.getParameter("id"));
                            r.next();
                            (new File("C:\\Users\\Marlon\\PlantiSHOP\\src\\main\\webapp\\imgs\\prods\\"+r.getString(1))).delete();
                            r.close();
                        }
                        s.executeUpdate("DELETE FROM "+request.getParameter("t")+" WHERE Id="+request.getParameter("id"));
                        out.print("<script>location.assign('Perfil.jsp');</script>");
                        s.execute("COMMIT");
                    } break;
                    case "B": {
                        r = s.executeQuery("SELECT CE,N,D,P,Img,Cupo FROM Producto WHERE Id="+request.getParameter("id"));
                        r.next();
                        String[] $v = {r.getString(1), r.getString(2), r.getString(3), String.valueOf(r.getFloat(4)), r.getString(5)};
                        int cupo = r.getInt(6);
                        s.executeUpdate("INSERT INTO Compra(V,C,NP,DP,PP,ImgP,X,LP) VALUES ('"+$v[0]+"','"+session.getAttribute("u")+"','"+$v[1]+"',"+(($v[2] == null) ? "NULL" : "'"+$v[2]+"'")+","+$v[3]+",'"+$v[4]+"',1,"+((cupo < 100) ? cupo : 0)+")");
                        out.print("<div class='success-container'>");
                            out.print("<div class='success-content'>");
                                out.print("<h1 class='success-title'>Compra REALIZADA</h1>");
                                out.print("<img src='imgs/csql.png' alt='C' class='success-image'/>");
                            out.print("</div>");
                        out.print("</div>");
                        out.print("<script>setTimeout(function () { location.assign('Mercado.jsp'); }, 5000);</script>");
                        r.close();
                        s.execute("COMMIT");
                    } break;
                    case "B1": {
                        s.executeUpdate("UPDATE Compra SET X=2,LP="+request.getParameter("n")+",TP="+request.getParameter("pt")+",U='"+request.getParameter("u")+"',Fh='"+LocalDateTime.parse(request.getParameter("fh"), DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss")).toString()+"' WHERE Id="+request.getParameter("id"));
                        out.print("<div class='success-container'>");
                            out.print("<div class='success-content'>");
                                out.print("<h1 class='success-title'>Notificación ENVIADA</h1>");
                                out.print("<img src='imgs/usql.png' alt='U' class='success-image'/>");
                            out.print("</div>");
                        out.print("</div>");
                        out.print("<script>setTimeout(function () { location.assign('Mensajeria.jsp'); }, 5000);</script>");
                        s.execute("COMMIT");
                    } break;
                    case "B2": {
                        if (Boolean.parseBoolean(request.getParameter("sn"))) {
                            s.executeUpdate("UPDATE Compra SET X=3,BMsg=FALSE WHERE Id="+request.getParameter("id"));
                            out.print("<div class='success-container'>");
                                out.print("<div class='success-content'>");
                                    out.print("<h1 class='success-title'>Oferta ACEPTADA</h1>");
                                    out.print("<img src='imgs/usql.png' alt='U' class='success-image'/>");
                                out.print("</div>");
                            out.print("</div>");
                        } else {
                            s.executeUpdate("UPDATE Compra SET X=1,LP=0,TP=0.00,U=NULL,Fh=NULL,BMsg=TRUE WHERE Id="+request.getParameter("id"));
                            out.print("<div class='success-container'>");
                                out.print("<div class='success-content'>");
                                    out.print("<h1 class='success-title'>Oferta RECHAZADA</h1>");
                                    out.print("<img src='imgs/bnot.png' alt='NB' class='success-image'/>");
                                out.print("</div>");
                            out.print("</div>");
                        }
                        out.print("<script>setTimeout(function () { location.assign('Mensajeria.jsp#tV'); }, 5000);</script>");
                        s.execute("COMMIT");
                    } break;
                    case "B3": {
                        r = s.executeQuery("SELECT N,AP,AM FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
                        r.next();
                        String[] $c = {r.getString(1), r.getString(2), r.getString(3)};
                        r.close();
                        r = null;
                        r = s.executeQuery("SELECT Producto.Pop,Producto.Id,Usuario.CE,Usuario.N,Usuario.AP,Usuario.AM,Compra.NP,Compra.LP,Compra.TP,Compra.Fh,Compra.U,Producto.Cupo FROM Producto (INNER JOIN Usuario ON Producto.CE=Usuario.CE (INNER JOIN Compra ON Usuario.CE=Compra.V)) WHERE Compra.C='"+session.getAttribute("u")+"' AND Compra.Id="+request.getParameter("id"));
                        r.next();
                        String[] inner = {String.valueOf(r.getLong(1) + 1L), String.valueOf(r.getLong(2)), r.getString(3), (r.getString(4)+" "+r.getString(5)+" "+r.getString(6)), r.getString(7), String.valueOf(r.getInt(12) - r.getByte(8)), String.valueOf(r.getByte(8)), String.valueOf(r.getFloat(9)), r.getString(10), r.getString(11)};
                        if (Boolean.parseBoolean(request.getParameter("sn"))) {
                            s.executeUpdate("UPDATE Compra SET X=4,DP=NULL,PP=0.00,LP=0,U=NULL,BMsg=NULL WHERE Id="+request.getParameter("id"));
                            s.executeUpdate("UPDATE Producto SET Pop="+inner[0]+",Cupo="+inner[5]+" WHERE Id="+inner[1]);
                            s.executeUpdate("INSERT INTO Notificacion(V,C,APC,AMC,N,P,LP,TP,Fh,U) VALUES ('"+inner[2]+"','"+$c[0]+"','"+$c[1]+"','"+$c[2]+"',TRUE,'"+inner[4]+"',"+inner[6]+","+inner[7]+",'"+inner[8]+"','"+inner[9]+"')");
                            File f = new File("D:\\C"+request.getParameter("id")+".txt");
                            f.createNewFile();
                            FileWriter w = new FileWriter(f);
                            w.write("Registro Comercial\n\nProducto: "+inner[4]+"\nVendedor: "+inner[3]+"\nComprador: "+$c[0]+" "+$c[1]+" "+$c[2]+"\nNo. de Lotes: "+inner[6]+"\nCosto: $"+inner[7]+"\nFecha y Hora: "+LocalDateTime.parse(inner[8], DateTimeFormatter.ofPattern("d / MMM / uuuu -- h:mm a"))+"\nUbicacion: "+inner[9]);
                            w.close();
                            out.print("<div class='success-container'>");
                                out.print("<div class='success-content'>");
                                    out.print("<h1 class='success-title'>Compra FINALIZADA</h1>");
                                    out.print("<img src='imgs/byes.png' alt='YB' class='success-image'/>");
                                out.print("</div>");
                            out.print("</div>");
                        } else {
                            s.executeUpdate("INSERT INTO Notificacion(V,C,APC,AMC,N,P) VALUES ('"+inner[2]+"','"+$c[0]+"','"+$c[1]+"','"+$c[2]+"',FALSE,'"+inner[4]+"')");
                            s.executeUpdate("DELETE FROM Compra WHERE Id="+request.getParameter("id"));
                            out.print("<div class='success-container'>");
                                out.print("<div class='success-content'>");
                                    out.print("<h1 class='success-title'>Compra CANCELADA</h1>");
                                    out.print("<img src='imgs/dsql.png' alt='D' class='success-image'/>");
                                out.print("</div>");
                            out.print("</div>");
                        }
                        out.print("<script>setTimeout(function () { location.assign('Mensajeria.jsp'); }, 5000);</script>");
                        r.close();
                        s.execute("COMMIT");
                    } break;
                    case "E": {
                        session.removeAttribute("u");
                        out.print("<script>location.assign('index.html');</script>");
                    } break;
                }
                r = null;
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