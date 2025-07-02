<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="auxs.Llavero"%>
<%!
    Connection c;
    Statement s;
    ResultSet r;
    String n, a, u;
%>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        c = DriverManager.getConnection("jdbc:mysql://localhost/PSHOP", "root", "n0m3l0");
        s = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        r = s.executeQuery("SELECT N,AP,AM,U FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
        r.next();
        n = r.getString(1);
        a = r.getString(2) + " " + r.getString(3);
        u = r.getString(4);
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-green: #2d5016;
                --secondary-green: #4a7c59;
                --accent-green: #7fb069;
                --light-green: #a7c957;
                --sage-green: #8fbc8f;
                --dark-forest: #1a3409;
                --cream: #fefae0;
                --soft-white: #ffffff;
                --text-dark: #2d3748;
                --text-muted: #718096;
                --border-light: #e2e8f0;
                --shadow-soft: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
                --shadow-medium: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
                --shadow-large: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            }
            * {
                box-sizing: border-box;
            }
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #f0f0f0;
                padding-top: 120px;
                line-height: 1.6;
                color: var(--text-dark);
            }
            @media (max-width: 768px) {
                body {
                    padding-top: 170px;
                }
            }
            .navbar-top {
                background: linear-gradient(135deg, var(--primary-green) 0%, var(--secondary-green) 100%);
                backdrop-filter: blur(10px);
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            }
            .navbar-bottom {
                background: linear-gradient(135deg, var(--dark-forest) 0%, var(--primary-green) 100%);
                backdrop-filter: blur(10px);
            }
            .nav-link {
                color: white !important;
                font-weight: 500;
                transition: all 0.3s ease;
                position: relative;
            }
            .nav-link:hover {
                color: var(--light-green) !important;
                transform: translateY(-1px);
            }
            .nav-link::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                width: 0;
                height: 2px;
                background: var(--light-green);
                transition: all 0.3s ease;
                transform: translateX(-50%);
            }
            .nav-link:hover::after {
                width: 80%;
            }
            .dropdown-menu {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border: 1px solid var(--border-light);
                box-shadow: var(--shadow-medium);
            }
            .dropdown-menu a:hover {
                background: linear-gradient(135deg, var(--accent-green) 0%, var(--light-green) 100%);
                color: white !important;
                transform: translateX(5px);
            }
            .profile-container {
                background: linear-gradient(135deg, var(--soft-white) 0%, var(--cream) 100%);
                border-radius: 24px;
                box-shadow: var(--shadow-large);
                overflow: hidden;
                position: relative;
            }
            .profile-container::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, var(--primary-green) 0%, var(--accent-green) 50%, var(--light-green) 100%);
            }
            .profile-header {
                background: linear-gradient(135deg, var(--sage-green) 0%, var(--accent-green) 100%);
                color: white;
                padding: 2rem;
                text-align: center;
                position: relative;
                overflow: hidden;
            }
            .profile-header::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="leaf" patternUnits="userSpaceOnUse" width="20" height="20"><path d="M10 2C6 2 3 5 3 9c0 2.5 1.5 4.5 3.5 5.5C8 16 10 18 10 18s2-2 3.5-3.5C15.5 13.5 17 11.5 17 9c0-4-3-7-7-7z" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23leaf)"/></svg>') repeat;
                animation: float 20s linear infinite;
                opacity: 0.1;
            }
            @keyframes float {
                0% { transform: translate(-50%, -50%) rotate(0deg); }
                100% { transform: translate(-50%, -50%) rotate(360deg); }
            }
            .profile-avatar {
                width: 150px;
                height: 150px;
                border-radius: 50%;
                border: 4px solid rgba(255, 255, 255, 0.3);
                box-shadow: var(--shadow-medium);
                transition: all 0.3s ease;
                position: relative;
                z-index: 2;
            }
            .profile-avatar:hover {
                transform: scale(1.05);
                border-color: rgba(255, 255, 255, 0.6);
            }
            .profile-name {
                font-family: 'Playfair Display', serif;
                font-size: 2rem;
                font-weight: 600;
                margin: 1rem 0 0.5rem;
                text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                position: relative;
                z-index: 2;
            }
            .profile-subtitle {
                font-size: 1.1rem;
                font-weight: 400;
                opacity: 0.9;
                position: relative;
                z-index: 2;
            }
            .garden-btn {
                background: linear-gradient(135deg, var(--primary-green) 0%, var(--secondary-green) 100%);
                border: none;
                border-radius: 50px;
                padding: 12px 30px;
                font-weight: 600;
                color: white;
                transition: all 0.3s ease;
                box-shadow: var(--shadow-soft);
                margin-top: 1rem;
                position: relative;
                z-index: 2;
                text-decoration: none;
                display: inline-block;
            }
            .garden-btn:hover {
                background: linear-gradient(135deg, var(--secondary-green) 0%, var(--accent-green) 100%);
                transform: translateY(-2px);
                box-shadow: var(--shadow-medium);
                color: white;
            }
            .garden-btn:active {
                transform: translateY(0);
            }
            .profile-info {
                padding: 2rem;
            }
            .info-card {
                background: rgba(255, 255, 255, 0.7);
                border-radius: 16px;
                padding: 1.5rem;
                margin-bottom: 1.5rem;
                border: 1px solid var(--border-light);
                backdrop-filter: blur(10px);
                transition: all 0.3s ease;
            }
            .info-card:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow-medium);
                background: rgba(255, 255, 255, 0.9);
            }
            .info-label {
                font-size: 0.9rem;
                font-weight: 500;
                color: var(--text-muted);
                margin-bottom: 0.25rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            .info-value {
                font-size: 1.1rem;
                font-weight: 600;
                color: var(--text-dark);
            }
            .form-group {
                background: rgba(255, 255, 255, 0.8);
                border-radius: 12px;
                padding: 1.5rem;
                margin-bottom: 1rem;
                border: 1px solid var(--border-light);
                transition: all 0.3s ease;
            }
            .form-group:hover {
                background: rgba(255, 255, 255, 0.95);
                border-color: var(--accent-green);
            }
            .form-label {
                font-weight: 600;
                color: var(--primary-green);
                margin-bottom: 0.5rem;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            .form-control {
                border: 2px solid var(--border-light);
                border-radius: 12px;
                padding: 12px 16px;
                font-size: 1rem;
                transition: all 0.3s ease;
                background: rgba(255, 255, 255, 0.9);
            }
            .form-control:focus {
                border-color: var(--accent-green);
                box-shadow: 0 0 0 0.2rem rgba(127, 176, 105, 0.25);
                background: white;
            }
            .btn-edit {
                background: linear-gradient(135deg, var(--accent-green) 0%, var(--light-green) 100%);
                border: none;
                border-radius: 50%;
                width: 40px;
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                transition: all 0.3s ease;
                box-shadow: var(--shadow-soft);
            }
            .btn-edit:hover {
                background: linear-gradient(135deg, var(--light-green) 0%, var(--sage-green) 100%);
                transform: scale(1.1);
                color: white;
            }
            .password-toggle {
                background: linear-gradient(135deg, var(--secondary-green) 0%, var(--accent-green) 100%);
                border: none;
                border-radius: 50px;
                padding: 12px 30px;
                font-weight: 600;
                color: white;
                transition: all 0.3s ease;
                box-shadow: var(--shadow-soft);
            }
            .password-toggle:hover {
                background: linear-gradient(135deg, var(--accent-green) 0%, var(--light-green) 100%);
                transform: translateY(-2px);
                box-shadow: var(--shadow-medium);
                color: white;
            }
            .password-section {
                background: linear-gradient(135deg, rgba(255, 255, 255, 0.9) 0%, rgba(254, 250, 224, 0.9) 100%);
                border: 2px solid var(--accent-green);
                border-radius: 20px;
                padding: 2rem;
                margin-top: 2rem;
                box-shadow: var(--shadow-medium);
                backdrop-filter: blur(10px);
            }
            .password-section legend {
                font-family: 'Playfair Display', serif;
                font-weight: 600;
                color: var(--primary-green);
                font-size: 1.5rem;
                background: linear-gradient(135deg, var(--accent-green) 0%, var(--light-green) 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }
            .password-buttons {
                display: flex;
                flex-wrap: wrap;
                gap: 1rem;
                justify-content: center;
                margin-bottom: 2rem;
            }
            .btn-password {
                background: linear-gradient(135deg, var(--accent-green) 0%, var(--light-green) 100%);
                border: none;
                border-radius: 25px;
                padding: 10px 20px;
                font-weight: 500;
                color: white;
                transition: all 0.3s ease;
                box-shadow: var(--shadow-soft);
            }
            .btn-password:hover {
                background: linear-gradient(135deg, var(--light-green) 0%, var(--sage-green) 100%);
                transform: translateY(-2px);
                color: white;
            }
            .btn-danger-custom {
                background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
                border: none;
                border-radius: 25px;
                padding: 10px 20px;
                font-weight: 500;
                color: white;
                transition: all 0.3s ease;
                box-shadow: var(--shadow-soft);
            }
            .btn-danger-custom:hover {
                background: linear-gradient(135deg, #c82333 0%, #a71e2a 100%);
                transform: translateY(-2px);
                color: white;
            }
            .btn-submit {
                background: linear-gradient(135deg, var(--primary-green) 0%, var(--secondary-green) 100%);
                border: none;
                border-radius: 50px;
                padding: 15px 40px;
                font-weight: 600;
                color: white;
                font-size: 1.1rem;
                transition: all 0.3s ease;
                box-shadow: var(--shadow-soft);
            }
            .btn-submit:hover {
                background: linear-gradient(135deg, var(--secondary-green) 0%, var(--accent-green) 100%);
                transform: translateY(-2px);
                box-shadow: var(--shadow-medium);
                color: white;
            }
            #gMap {
                height: 300px;
                width: 100%;
                margin-bottom: 1rem;
                border-radius: 12px;
                border: 2px solid var(--border-light);
                box-shadow: var(--shadow-soft);
            }
            @media (max-width: 768px) {
                .profile-name {
                    font-size: 1.5rem;
                }
                .profile-subtitle {
                    font-size: 1rem;
                }
                .profile-info {
                    padding: 1rem;
                }
                .form-group {
                    padding: 1rem;
                }
                .password-section {
                    padding: 1.5rem;
                }
                .password-buttons {
                    flex-direction: column;
                    align-items: center;
                }
            }
            @media (max-width: 576px) {
                .profile-avatar {
                    width: 120px;
                    height: 120px;
                }
            }
            .fade-in {
                animation: fadeIn 0.8s ease-out;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .slide-in {
                animation: slideIn 0.6s ease-out;
            }
            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateX(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }
        </style>
        <script src="https://maps.googleapis.com/maps/api/js?key=<%= Llavero.getApiGoogleMaps() %>&callback=initMap&v=weekly" defer></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                window.location.hash = "no-back-button";
                window.location.hash = "Again-No-back-button";
                window.onhashchange = function () {
                    window.location.hash = "";
                };
                document.querySelectorAll('.form-group, .info-card').forEach((el, index) => {
                    setTimeout(() => {
                        el.classList.add('slide-in');
                    }, (index * 100));
                });
            });
            function togglePassword() {
                const section = document.getElementById("passwordSection");
                if (section.style.display === "none" || section.style.display === "") {
                    section.style.display = "block";
                    section.classList.add('fade-in');
                } else {
                    section.style.display = "none";
                }
            }
            function toUcsD(i) {
                switch (i) {
                    case 0: {
                        document.getElementById('pwsD').value = "U0";
                        document.getElementById('UD').innerHTML = "<i class='bi bi-check-circle me-2'></i>CAMBIAR";
                        document.getElementById('i7').disabled = false;
                        document.getElementById('i8').disabled = false;
                        document.getElementById('nc').style.display = "block";
                        document.getElementById('ncr').style.display = "block";
                    } break;
                    case 1: {
                        document.getElementById('pwsD').value = "U1";
                        document.getElementById('UD').innerHTML = "<i class='bi bi-check-circle me-2'></i>CAMBIAR";
                        document.getElementById('i7').disabled = false;
                        document.getElementById('i8').disabled = true;
                        document.getElementById('nc').style.display = "block";
                        document.getElementById('ncr').style.display = "none";
                    } break;
                    case 2: {
                        document.getElementById('pwsD').value = "U2";
                        document.getElementById('UD').innerHTML = "<i class='bi bi-check-circle me-2'></i>CAMBIAR";
                        document.getElementById('i7').disabled = true;
                        document.getElementById('i8').disabled = false;
                        document.getElementById('nc').style.display = "none";
                        document.getElementById('ncr').style.display = "block";
                    } break;
                    case 3: {
                        document.getElementById('pwsD').value = "D";
                        document.getElementById('UD').innerHTML = "<i class='bi bi-trash me-2'></i>ELIMINAR Perfil";
                        document.getElementById('i7').disabled = true;
                        document.getElementById('i8').disabled = true;
                        document.getElementById('nc').style.display = "none";
                        document.getElementById('ncr').style.display = "none";
                    } break;
                }
            }
            window.initMap = function () {
                let latd, lngd;
                (new google.maps.Geocoder()).geocode({ address: "<%= u %>" }).then(function (r) {
                    latd = r.results[0].geometry.location.lat;
                    lngd = r.results[0].geometry.location.lng;
                });
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
        <%@include file="imgs/navbar.jsp"%>
        
        <div class="container my-5">
        <div class="profile-container fade-in">
            <div class="profile-header">
                <img src="imgs/perfil.jpg" alt="Perfil" class="profile-avatar">
                <h1 class="profile-name"><%= n %></h1>
                <p class="profile-subtitle"><%= a %></p>
                <a href="Jardin.jsp" class="garden-btn">
                    <i class="bi bi-flower2 me-2"></i>Tu JARDÍN
                </a>
            </div>
            <div class="profile-info">
                <div class="row">
                    <div class="col-md-6">
                        <div class="info-card">
                            <div class="info-label">
                                <i class="bi bi-envelope me-1"></i>Correo Electrónico:
                            </div>
                            <div class="info-value"><%= session.getAttribute("u") %></div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-card">
                            <div class="info-label">
                                <i class="bi bi-geo-alt me-1"></i>Ubicación Actual:
                            </div>
                            <div class="info-value"><%= u %></div>
                        </div>
                    </div>
                </div>
                <form action="Interfaz.jsp" method="post" class="form-group d-flex align-items-end">
                    <input type="hidden" name="x" value="Un">
                    <div class="flex-grow-1">
                        <label class="form-label" for="i1">
                            <i class="bi bi-person me-1"></i>Nombre(s):
                        </label>
                        <input class="form-control" id="i1" name="n" type="text" pattern="[A-Za-z\s]+" maxlength="25" required>
                    </div>
                    <button type="submit" class="btn-edit ms-3">
                        <i class="bi bi-pencil-square"></i>
                    </button>
                </form>
                <form action="Interfaz.jsp" method="post" class="form-group d-flex align-items-end">
                    <input type="hidden" name="x" value="Uap">
                    <div class="flex-grow-1">
                        <label class="form-label" for="i2">
                            <i class="bi bi-person me-1"></i>Apellido Paterno:
                        </label>
                        <input class="form-control" id="i2" name="ap" type="text" pattern="[A-Za-z\s']+" maxlength="15" required>
                    </div>
                    <button type="submit" class="btn-edit ms-3">
                        <i class="bi bi-pencil-square"></i>
                    </button>
                </form>
                <form action="Interfaz.jsp" method="post" class="form-group d-flex align-items-end">
                    <input type="hidden" name="x" value="Uam">
                    <div class="flex-grow-1">
                        <label class="form-label" for="i3">
                            <i class="bi bi-person me-1"></i>Apellido Materno:
                        </label>
                        <input class="form-control" id="i3" name="am" type="text" pattern="[A-Za-z\s']+" maxlength="15" required>
                    </div>
                    <button type="submit" class="btn-edit ms-3">
                        <i class="bi bi-pencil-square"></i>
                    </button>
                </form>
                <form action="Interfaz.jsp" method="post" class="form-group">
                    <input type="hidden" name="x" value="Uu">
                    <label class="form-label" for="i4">
                        <i class="bi bi-geo-alt me-1"></i>Ubicación:
                    </label>
                    <div id="gMap"></div>
                    <div class="d-flex align-items-end">
                        <input id="i4" name="u" class="form-control flex-grow-1" type="text" readonly value="Ciudad de Mexico, Mexico" required>
                        <button type="submit" class="btn-edit ms-3">
                            <i class="bi bi-pencil-square"></i>
                        </button>
                    </div>
                </form>
                <div class="text-center my-4">
                    <button class="password-toggle" onclick="togglePassword()">
                        <i class="bi bi-shield-lock me-2"></i>Gestionar Contraseñas
                    </button>
                </div>
            </div>
        </div>
        <fieldset class="password-section" id="passwordSection" style="display: none;">
            <legend>
                <i class="bi bi-key me-2"></i>Contraseñas:
            </legend>
            
            <div class="password-buttons">
                <button onclick="toUcsD(1)" class="btn-password">
                    <i class="bi bi-key me-1"></i>Cambiar Contraseña
                </button>
                <button onclick="toUcsD(2)" class="btn-password">
                    <i class="bi bi-shield me-1"></i>Cambiar Contraseña de Respaldo
                </button>
                <button onclick="toUcsD(0)" class="btn-password">
                    <i class="bi bi-shield-check me-1"></i>Cambiar ambas Contraseñas
                </button>
                <button onclick="toUcsD(3)" id="dP" class="btn-danger-custom">
                    <i class="bi bi-trash me-1"></i>Eliminar Perfil
                </button>
            </div>
            <form action="Interfaz.jsp" method="post">
                <input id="pwsD" name="x" type="hidden" value="U0">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="i5" class="form-label">
                            <i class="bi bi-lock me-1"></i>Contraseña Actual:
                        </label>
                        <input id="i5" name="c1" type="password" class="form-control" minlength="12" maxlength="20" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="i6" class="form-label">
                            <i class="bi bi-shield me-1"></i>Contraseña de Respaldo Actual:
                        </label>
                        <input id="i6" name="c2" type="password" class="form-control" minlength="12" maxlength="20" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3" id="nc">
                        <label for="i7" class="form-label">
                            <i class="bi bi-key me-1"></i>Nueva Contraseña:
                        </label>
                        <input id="i7" name="nc1" type="password" class="form-control" pattern="[A-Z]+[a-z]+[0-9]+[+-*/%$._!?]+" minlength="12" maxlength="20">
                    </div>
                    <div class="col-md-6 mb-3" id="ncr">
                        <label for="i8" class="form-label">
                            <i class="bi bi-shield-plus me-1"></i>Nueva Contraseña de Respaldo:
                        </label>
                        <input id="i8" name="nc2" type="password" class="form-control" pattern="[A-Z]+[a-z]+[0-9]+[+-*/%$._!?]+" minlength="12" maxlength="20">
                    </div>
                </div>
                <div class="text-center">
                    <button id="UD" type="submit" class="btn-submit">
                        <i class='bi bi-check-circle me-2'></i>CAMBIAR
                    </button>
                </div>
            </form>
        </fieldset>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=/K-GM/&callback=initMap&v=weekly" defer></script>
    </body>
</html>