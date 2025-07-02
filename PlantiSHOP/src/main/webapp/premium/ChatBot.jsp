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
        c = DriverManager.getConnection("jdbc:mysql://localhost/PSHOP", "root", "n0m3l0");
        s = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
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
                --ai-cyan: #00bcd4;
                --ai-cyan-dark: #0097a7;
                --analytics-orange: #ff9800;
                --analytics-orange-dark: #f57c00;
            }
            body {
                background-color: var(--background-color) !important;
                font-family: 'Poppins', sans-serif;
                color: var(--primary-green);
                min-height: 100vh;
            }
            .navigation-bar {
                background: linear-gradient(135deg, var(--primary-green) 0%, var(--secondary-green) 100%);
                padding: 1rem 0;
                margin-bottom: 2rem;
                box-shadow: 0 4px 15px rgba(45, 80, 22, 0.3);
            }
            .btn-nav {
                background: linear-gradient(135deg, var(--accent-green) 0%, var(--light-green) 100%);
                border: none;
                color: white;
                font-weight: 600;
                padding: 0.75rem 1.5rem;
                border-radius: 25px;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(108, 168, 60, 0.4);
                margin: 0 0.5rem;
            }
            .btn-nav:hover {
                background: linear-gradient(135deg, var(--light-green) 0%, var(--accent-green) 100%);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(108, 168, 60, 0.6);
                color: white;
            }
            .btn-analytics {
                background: linear-gradient(135deg, var(--analytics-orange) 0%, var(--analytics-orange-dark) 100%);
                box-shadow: 0 4px 15px rgba(255, 152, 0, 0.4);
            }
            .btn-analytics:hover {
                background: linear-gradient(135deg, var(--analytics-orange-dark) 0%, #e65100 100%);
                box-shadow: 0 6px 20px rgba(255, 152, 0, 0.6);
            }
            .basil-header {
                background: linear-gradient(135deg, var(--ai-cyan) 0%, var(--ai-cyan-dark) 100%);
                color: white;
                padding: 2rem;
                border-radius: 20px;
                margin-bottom: 2rem;
                box-shadow: 0 8px 25px rgba(0, 188, 212, 0.3);
                text-align: center;
            }
            .basil-avatar {
                width: 150px;
                height: 150px;
                border-radius: 50%;
                border: 5px solid white;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
                margin-bottom: 1rem;
                object-fit: cover;
            }
            .basil-title {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            }
            .basil-subtitle {
                font-size: 1.2rem;
                opacity: 0.9;
                margin-bottom: 0;
            }
            .chat-container {
                background: white;
                border-radius: 20px;
                padding: 2rem;
                margin-bottom: 2rem;
                box-shadow: 0 8px 25px rgba(45, 80, 22, 0.1);
                border: 2px solid var(--pale-green);
            }
            .basil-response {
                background: linear-gradient(135deg, #e0f7fa 0%, #b2ebf2 100%);
                border-left: 5px solid var(--ai-cyan);
                border-radius: 15px;
                padding: 1.5rem;
                margin-bottom: 2rem;
                font-size: 1.1rem;
                line-height: 1.6;
                position: relative;
            }
            .basil-response::before {
                content: "\f4ad";
                font-family: "Bootstrap Icons";
                position: absolute;
                top: -10px;
                left: 20px;
                background: var(--ai-cyan);
                color: white;
                padding: 8px;
                border-radius: 50%;
                font-size: 1rem;
            }
            .input-section {
                background: white;
                border-radius: 20px;
                padding: 2rem;
                margin-bottom: 2rem;
                box-shadow: 0 8px 25px rgba(45, 80, 22, 0.1);
                border: 2px solid var(--pale-green);
            }
            .form-control {
                border: 2px solid var(--pale-green);
                border-radius: 15px;
                padding: 1rem;
                font-size: 1rem;
                transition: all 0.3s ease;
                resize: vertical;
                min-height: 120px;
            }
            .form-control:focus {
                border-color: var(--ai-cyan);
                box-shadow: 0 0 0 0.2rem rgba(0, 188, 212, 0.25);
            }
            .btn-send {
                background: linear-gradient(135deg, var(--ai-cyan) 0%, var(--ai-cyan-dark) 100%);
                border: none;
                color: white;
                font-weight: 600;
                padding: 1rem 2rem;
                border-radius: 50px;
                font-size: 1.1rem;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(0, 188, 212, 0.4);
                width: 100%;
                margin-top: 1rem;
            }
            .btn-send:hover {
                background: linear-gradient(135deg, var(--ai-cyan-dark) 0%, #006064 100%);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(0, 188, 212, 0.6);
                color: white;
            }
            .image-search-section {
                background: white;
                border-radius: 20px;
                padding: 2rem;
                box-shadow: 0 8px 25px rgba(45, 80, 22, 0.1);
                border: 2px solid var(--pale-green);
            }
            .file-input-container {
                background: linear-gradient(135deg, var(--pale-green) 0%, #e8f5e8 100%);
                border: 3px dashed var(--accent-green);
                border-radius: 15px;
                padding: 2rem;
                text-align: center;
                margin-bottom: 1.5rem;
                transition: all 0.3s ease;
            }
            .file-input-container:hover {
                background: linear-gradient(135deg, var(--light-green) 0%, var(--accent-green) 100%);
                color: white;
            }
            .form-control[type="file"] {
                border: none;
                background: transparent;
                padding: 1rem;
                font-size: 1rem;
                color: var(--primary-green);
                font-weight: 500;
            }
            .btn-plant-search {
                background: linear-gradient(135deg, var(--accent-green) 0%, var(--light-green) 100%);
                border: none;
                color: white;
                font-weight: 600;
                padding: 1rem 2rem;
                border-radius: 50px;
                font-size: 1.1rem;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(108, 168, 60, 0.4);
                width: 100%;
            }
            .btn-plant-search:hover {
                background: linear-gradient(135deg, var(--light-green) 0%, var(--accent-green) 100%);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(108, 168, 60, 0.6);
                color: white;
            }
            .section-title {
                color: var(--primary-green);
                font-weight: 700;
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }
            .feature-icon {
                font-size: 1.5rem;
                color: var(--ai-cyan);
            }
            .plant-icon {
                font-size: 1.5rem;
                color: var(--accent-green);
            }
            @media (max-width: 768px) {
                .basil-title {
                    font-size: 2rem;
                }
                .basil-avatar {
                    width: 120px;
                    height: 120px;
                }
                .btn-nav {
                    font-size: 0.9rem;
                    padding: 0.5rem 1rem;
                    margin: 0.25rem;
                }
                .chat-container,
                .input-section,
                .image-search-section {
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
        </script>
    </head>
    <body>
        <div class="container-fluid">
            <div class="navigation-bar">
                <div class="container">
                    <div class="text-end">
                        <button class="btn btn-nav" onclick="location.assign('../Premium.jsp')">
                            <i class="bi bi-arrow-left me-2">REGRESAR</i>
                        </button>
                        <button class="btn btn-nav btn-analytics" onclick="location.assign('Analisis.jsp')">
                            <i class="bi bi-graph-up me-2">IR AL ANALISTA</i>
                        </button>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="basil-header">
                    <img src="../imgs/ia.jpg" alt="Basil.IA" class="basil-avatar"/>
                    <h1 class="basil-title">Basil.IA</h1>
                    <p class="basil-subtitle">Tu Asistente Personal de Jardinería</p>
                </div>
                <div class="chat-container">
                    <div class="basil-response">
                        <%
                            if (session.getAttribute("rIA") == null) {
                                out.print("¡Hola! Soy Basil.IA, tu Asistente Personal de Jardinería... Dime ¿En qué te puedo Ayudar?");
                            } else {
                                out.print(session.getAttribute("rIA"));
                                session.removeAttribute("rIA");
                            }
                        %>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 mb-4">
                        <div class="input-section">
                            <h3 class="section-title">
                                <i class="bi bi-chat-dots feature-icon">Preguntas o Solicitudes a Basil.IA</i>
                            </h3>
                            <form action="../BasilIA" method="post">
                                <input name="x" type="hidden" value="true">
                                <div class="mb-3">
                                    <label for="question" class="form-label">Haz una consulta sobre Jardinería:</label>
                                    <textarea id="question" name="req" class="form-control"
                                              placeholder="¿Cómo Cuidar mis Plantas?&NewLine;¿Qué Fertilizante debo Usar?&NewLine;¿Cuándo hay que Regar?"
                                              required></textarea>
                                </div>
                                <button type="submit" class="btn btn-send">
                                    <i class="bi bi-send me-2">ENVIAR</i>
                                </button>
                            </form>
                        </div>
                    </div>
                    <div class="col-lg-6 mb-4">
                        <div class="image-search-section">
                            <h3 class="section-title">
                                <i class="bi bi-camera plant-icon">Identificación de Plantas mediante Imagenes</i>
                            </h3>
                            <form action="../BasilIA" method="post" enctype="multipart/form-data">
                                <input name="x" type="hidden" value="false">
                                <div class="mb-3">
                                    <label for="plantImage" class="form-label">Sube una imagen de la Planta:</label>
                                    <div class="file-input-container">
                                        <i class="bi bi-cloud-upload plant-icon mb-2"></i>
                                        <p class="mb-2">Selecciona una Imagen JPEG</p>
                                        <input id="plantImage" name="img" type="file" class="form-control"
                                               accept="image/jpeg" required>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-plant-search">
                                    <i class="bi bi-search me-2">BUSCAR</i>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="chat-container">
                            <div class="row text-center">
                                <div class="col-md-4 mb-3">
                                    <i class="bi bi-lightbulb feature-icon mb-2"></i>
                                    <h5 style="color: var(--primary-green);">Consejos Personalizados</h5>
                                    <p class="text-muted">Recibe recomendaciones específicas para tus Plantas :3</p>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <i class="bi bi-camera feature-icon mb-2"></i>
                                    <h5 style="color: var(--primary-green);">Identificación Visual</h5>
                                    <p class="text-muted">Identifica plantas mediante Fotografías JPEG</p>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <i class="bi bi-chat-heart feature-icon mb-2"></i>
                                    <h5 style="color: var(--primary-green);">Asistencia 24/7</h5>
                                    <p class="text-muted">Disponible cuando lo necesites ;3</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>