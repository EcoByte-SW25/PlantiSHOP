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
        <link rel="icon" type="image/x-icon" href="imgs/logo.png">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-green: #2d5016;
                --secondary-green: #4a7c28;
                --accent-green: #6ca83c;
                --light-green: #8bc34a;
                --pale-green: #c8e6c9;
                --earth-brown: #5d4037;
                --warm-beige: #8d6e63;
                --background-color: #f0f0f0;
            }
            body {
                background-color: var(--background-color) !important;
                font-family: 'Poppins', sans-serif;
                color: var(--primary-green);
                min-height: 100vh;
            }
            .premium-header {
                background: linear-gradient(135deg, var(--primary-green) 0%, var(--secondary-green) 100%);
                color: white;
                padding: 2rem 0;
                margin-bottom: 2rem;
                border-radius: 0 0 20px 20px;
                box-shadow: 0 4px 15px rgba(45, 80, 22, 0.3);
            }
            .premium-title {
                font-weight: 700;
                font-size: 2.5rem;
                margin-bottom: 1rem;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            }
            .premium-description {
                font-size: 1.1rem;
                opacity: 0.95;
                line-height: 1.6;
            }
            .feature-card {
                background: white;
                border-radius: 15px;
                padding: 2rem;
                margin-bottom: 1.5rem;
                box-shadow: 0 8px 25px rgba(45, 80, 22, 0.1);
                border: 2px solid var(--pale-green);
                transition: all 0.3s ease;
            }
            .feature-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 35px rgba(45, 80, 22, 0.15);
            }
            .btn-premium {
                background: linear-gradient(135deg, var(--accent-green) 0%, var(--light-green) 100%);
                border: none;
                color: white;
                font-weight: 600;
                padding: 1rem 2rem;
                border-radius: 50px;
                font-size: 1.1rem;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(108, 168, 60, 0.4);
            }
            .btn-premium:hover {
                background: linear-gradient(135deg, var(--light-green) 0%, var(--accent-green) 100%);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(108, 168, 60, 0.6);
                color: white;
            }
            .btn-basil {
                background: linear-gradient(135deg, #00bcd4 0%, #0097a7 100%);
                box-shadow: 0 4px 15px rgba(0, 188, 212, 0.4);
            }
            .btn-basil:hover {
                background: linear-gradient(135deg, #0097a7 0%, #006064 100%);
                box-shadow: 0 6px 20px rgba(0, 188, 212, 0.6);
            }
            .btn-analytics {
                background: linear-gradient(135deg, #ff9800 0%, #f57c00 100%);
                box-shadow: 0 4px 15px rgba(255, 152, 0, 0.4);
            }
            .btn-analytics:hover {
                background: linear-gradient(135deg, #f57c00 0%, #e65100 100%);
                box-shadow: 0 6px 20px rgba(255, 152, 0, 0.6);
            }
            .subscription-form {
                background: white;
                border-radius: 20px;
                padding: 2.5rem;
                box-shadow: 0 10px 30px rgba(45, 80, 22, 0.1);
                border: 3px solid var(--pale-green);
            }
            .form-control {
                border: 2px solid var(--pale-green);
                border-radius: 10px;
                padding: 0.75rem 1rem;
                font-size: 1rem;
                transition: all 0.3s ease;
            }
            .form-control:focus {
                border-color: var(--accent-green);
                box-shadow: 0 0 0 0.2rem rgba(108, 168, 60, 0.25);
            }
            .form-select {
                border: 2px solid var(--pale-green);
                border-radius: 10px;
                padding: 0.75rem 1rem;
                background-color: var(--pale-green);
                font-weight: 500;
            }
            .form-select:focus {
                border-color: var(--accent-green);
                box-shadow: 0 0 0 0.2rem rgba(108, 168, 60, 0.25);
                background-color: white;
            }
            .form-label {
                font-weight: 600;
                color: var(--primary-green);
                margin-bottom: 0.5rem;
            }
            .subscription-title {
                color: var(--primary-green);
                font-weight: 700;
                margin-bottom: 1.5rem;
            }
            .subscription-info {
                background: linear-gradient(135deg, var(--pale-green) 0%, #e8f5e8 100%);
                border-radius: 15px;
                padding: 1.5rem;
                margin-bottom: 2rem;
                border-left: 5px solid var(--accent-green);
            }
            .expiration-warning {
                background: linear-gradient(135deg, #fff3cd 0%, #ffeaa7 100%);
                border: 2px solid #f39c12;
                border-radius: 15px;
                padding: 1rem;
                margin-top: 1rem;
            }
            .checkbox-container {
                background: #f8f9fa;
                border-radius: 10px;
                padding: 1.5rem;
                border: 2px solid var(--pale-green);
                margin: 1.5rem 0;
            }
            .feature-icon {
                font-size: 3rem;
                color: var(--accent-green);
                margin-bottom: 1rem;
            }
            .divider {
                height: 3px;
                background: linear-gradient(135deg, var(--primary-green) 0%, var(--accent-green) 100%);
                border: none;
                border-radius: 2px;
                margin: 2rem 0;
            }
            @media (max-width: 768px) {
                .premium-title {
                    font-size: 2rem;
                }
                .btn-premium {
                    font-size: 1rem;
                    padding: 0.75rem 1.5rem;
                }
                .feature-card {
                    padding: 1.5rem;
                }
            }
        </style>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                window.location.hash = "no-back-button";
                window.location.hash = "Again-No-back-button";
                window.onhashchange = function () {
                    window.location.hash = "";
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
        <%@include file="imgs/navbar.jsp"%>
        
        <div class="container-fluid">
            <div class="premium-header text-center">
                <div class="container">
                    <i class="bi bi-gem feature-icon"></i>
                    <h1 class="premium-title">PREMIUM</h1>
                    <p class="premium-description">
                        ¡Pon a tu Disposición una Programación Especial de PlantiSHOP; y ten Acceso a nuestro ChatBot "Basil.IA", 
                        tu nuevo Asistente Personal de Jardinería, y a un Analista Estadístico-Predictivo de tus Actividades 
                        Comerciales en la Aplicación y del Mercado Botánico de PlantiSHOP!
                    </p>
                </div>
            </div>
            <div class="container">
                <%
                    try {
                        if (session.getAttribute("msg") != null) {
                            out.print("<script>alert('"+session.getAttribute("msg")+"');</script>");
                            session.removeAttribute("msg");
                        }
                        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
                        c = DriverManager.getConnection("jdbc:mysql://localhost/PSHOP", "root", "n0m3l0");
                        s = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                        r = s.executeQuery("SELECT P,FfS,N,AP,AM FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
                        r.next();
                        if (r.getBoolean(1)) {
                            out.print("<div class='row'>");
                                out.print("<div class='col-md-6 mb-4'>");
                                    out.print("<div class='feature-card text-center'>");
                                        out.print("<i class='bi bi-robot feature-icon' style='color: #00bcd4;'></i>");
                                        out.print("<h3 class='mb-3' style='color: var(--primary-green);'>Basil.IA</h3>");
                                        out.print("<p class='text-muted mb-4'>Tu Asistente Personal de Jardinería con Inteligencia Artificial</p>");
                                        out.print("<button class='btn btn-premium btn-basil w-100' onclick=\"location.assign('premium/ChatBot.jsp')\"><i class='bi bi-chat-dots me-2'></i>Acceder a Basil.IA</button>");
                                    out.print("</div>");
                                out.print("</div>");
                                out.print("<div class='col-md-6 mb-4'>");
                                    out.print("<div class='feature-card text-center'>");
                                        out.print("<i class='bi bi-graph-up feature-icon' style='color: #ff9800;'></i>");
                                        out.print("<h3 class='mb-3' style='color: var(--primary-green);'>Analisis de Datos</h3>");
                                        out.print("<p class='text-muted mb-4'>Estadísticas y Predicciones de tus Actividades Comerciales</p>");
                                        out.print("<button class='btn btn-premium btn-analytics w-100' onclick=\"location.assign('premium/Analisis.jsp')\"><i class='bi bi-bar-chart me-2'></i>Ver ANÁLISIS</button>");
                                    out.print("</div>");
                                out.print("</div>");
                            out.print("</div>");
                            out.print("<div class='subscription-info text-center'>");
                                out.print("<h2 class='subscription-title'><i class='bi bi-calendar-check me-2'></i>Tu Suscripción termina el "+r.getDate(2).toLocalDate().format(DateTimeFormatter.ofPattern("E, d / MMM / uuuu")).toUpperCase()+"</h2>");
                                if (LocalDate.now().until(r.getDate(2).toLocalDate(), ChronoUnit.DAYS) <= 8L) {
                                    out.print("<div class='expiration-warning'><i class='bi bi-exclamation-triangle me-2'></i><strong>¡Faltan "+LocalDate.now().until(r.getDate(2).toLocalDate(), ChronoUnit.DAYS)+" días para que termine tu Suscripción!</strong></div>");
                                }
                            out.print("</div>");
                        } else {
                            out.print("<div class='row justify-content-center'>");
                                out.print("<div class='col-lg-8 col-xl-6'>");
                                    out.print("<div class='subscription-form'>");
                                        out.print("<div class='text-center mb-4'><i class='bi bi-star-fill feature-icon'></i><h2 class='subscription-title'>¡Suscríbete a PlantiSHOP!</h2></div>");
                                        out.print("<form action='UpSuscripciones' method='post'>");
                                            out.print("<div class='subscription-info text-center'><p class='mb-0'><strong>"+session.getAttribute("u")+"</strong></p></div>");
                                            out.print("<div class='mb-3'>");
                                                out.print("<label for='i1' class='form-label'><i class='bi bi-credit-card me-2'></i>Clave Bancaria Estandarizada (CLABE) de tu Cuenta Bancaria:</label>");
                                                out.print("<input id='i1' name='CLABE' type='password' class='form-control' pattern='[0-9]{18}' maxlength='18' placeholder='Ingresa tu CLABE de 18 dígitos :3' required>");
                                            out.print("</div>");
                                            out.print("<div class='mb-3'>");
                                                out.print("<label for='i2' class='form-label'><i class='bi bi-telephone me-2'></i>Número de Teléfono asociado a la Cuenta:</label>");
                                                out.print("<input id='i2' name='tf' type='tel' class='form-control' maxlength='10' placeholder='10 dígitos :3' required>");
                                            out.print("</div>");
                                            out.print("<div class='mb-4'>");
                                                out.print("<label for='i3' class='form-label'><i class='bi bi-calendar me-2'></i>Plan de Suscripción:</label>");
                                                out.print("<select id='i3' name='ps' class='form-select' required>");
                                                    out.print("<option value='25.00' selected>Mensual (30 días) - $25.00</option>");
                                                    out.print("<option value='75.00'>Trimestral (3 meses) - $75.00</option>");
                                                    out.print("<option value='150.00'>Semestral (6 meses) - $150.00</option>");
                                                    out.print("<option value='300.00'>Anual (365 días) - $300.00</option>");
                                                out.print("</select>");
                                            out.print("</div>");
                                            out.print("<div class='checkbox-container'>");
                                                out.print("<div class='form-check'>");
                                                    out.print("<input class='form-check-input' type='checkbox' id='agreement' name='SI' onclick='sM(this.checked)' value='Yo, "+r.getString(3)+" "+r.getString(4)+" "+r.getString(5)+" ("+session.getAttribute("u")+"), Acepto y Confirmo esta Transferencia Bancaria a EcoByte, realizada el día "+LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/uuuu"))+", para el uso del Apartado PREMIUM de PlantiSHOP' required>");
                                                    out.print("<label class='form-check-label' for='agreement'><small>Yo, <strong>"+r.getString(3)+" "+r.getString(4)+" "+r.getString(5)+"</strong> (<strong>"+session.getAttribute("u")+"</strong>), Acepto y Confirmo esta Transferencia Bancaria a EcoByte, realizada el día <strong>"+LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/uuuu"))+"</strong>, para el uso del Apartado PREMIUM de PlantiSHOP</small></label>");
                                                out.print("</div>");
                                            out.print("</div>");
                                            out.print("<div class='text-center'><button id='sm' type='submit' class='btn btn-premium btn-lg' disabled><i class='bi bi-check-circle me-2'></i>SUSCRIBIRSE</button></div>");
                                        out.print("</form>");
                                    out.print("</div>");
                                out.print("</div>");
                            out.print("</div>");
                        }
                        r.close();
                        s.close();
                        c.close();
                    } catch (Exception e) {
                        out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                        out.print("<script>history.back();</script>");
                    }
                %>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>