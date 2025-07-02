<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="auxs.Llavero"%>
<!DOCTYPE html>
<html lang="es-MX">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro de Usuario</title>
        <link rel="icon" type="image/x-icon" href="imgs/logo.png">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            @font-face {
                font-family: 'Coco Gothic';
                src: url(fonts/CocoGothic.ttf);
            }
            @font-face {
                font-family: 'Agrandir';
                src: url(fonts/Agrandir.otf);
            }
            body {
                background-image: url(imgs/fondo.png);
                background-size: cover;
                background-attachment: fixed;
                background-position: center;
                background-repeat: no-repeat;
                font-family: 'Coco Gothic', sans-serif;
                min-height: 100vh;
            }
            .register-card {
                width: 95%;
                max-width: 850px;
                background-color: rgba(255, 255, 255, 0.95);
                border-radius: 20px;
                padding: 2.5em;
                margin: 2em auto;
                box-shadow: 0 0 25px rgba(0, 0, 0, 0.2);
            }
            h1 {
                text-align: center;
                font-family: 'Agrandir', sans-serif;
                color: whitesmoke;
                font-size: 5vw;
                margin-top: 1rem;
            }
            .logo {
                width: 1.5em;
                height: 1.5em;
                vertical-align: middle;
            }
            h2 {
                font-family: 'Agrandir', sans-serif;
                font-size: 2.2rem;
                margin-bottom: 1rem;
            }
            .form-label {
                font-weight: bold;
                margin-top: 1em;
            }
            input[type="text"],
            input[type="email"],
            input[type="password"] {
                width: 100%;
                padding: 0.6em;
                margin-top: 0.3em;
                border-radius: 8px;
                border: 1px solid #ccc;
            }
            #gMap {
                width: 100%;
                height: 12em;
                border-radius: 10px;
                margin-bottom: 1em;
                border: 1px solid #198754;
            }
            .btn-green {
                background-color: #198754;
                color: white;
                font-weight: bold;
                border-radius: 10px;
                padding: 0.8em 1.5em;
                border: none;
            }
            .btn-green:hover {
                background-color: #157347;
            }
            .divider {
                display: flex;
                align-items: center;
                text-align: center;
                margin-top: 2em;
                margin-bottom: 1em;
                color: #666;
                font-weight: bold;
            }
            .divider::before,
            .divider::after {
                content: "";
                flex: 1;
                border-bottom: 1px solid #bbb;
            }
            .divider::before {
                margin-right: .75em;
            }
            .divider::after {
                margin-left: .75em;
            }
            .text-link {
                display: block;
                text-align: center;
                font-weight: bold;
                color: #198754;
                text-decoration: none;
                font-size: 1rem;
                transition: color 0.3s ease;
            }
            .text-link:hover {
                text-decoration: underline;
                color: #145c38;
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
            });
            window.initMap = function () {
                (new google.maps.Map(document.getElementById('gMap'), {
                    center: {
                        lat: 19.4326077,
                        lng: -99.133208
                    },
                    zoom: 8,
                    mapTypeControl: false
                })).addListener('click', function (ev) {
                    (new google.maps.Geocoder()).geocode({ location: ev.latLng }).then(
                        function (r) {
                            document.getElementById('i7').value = r.results[0].formatted_address;
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
        <div class="text-center">
            <h1><img src="imgs/logo.png" alt="Logo" class="logo">&nbsp;PlantiSHOP</h1>
        </div>
        <div class="register-card">
            <h2 class="text-center"><strong>Registro</strong></h2>
            <form action="Interfaz.jsp" method="post">
                <input type="hidden" name="x" value="C">
                <label for="i1" class="form-label">Correo Electrónico:</label>
                <input id="i1" name="ce" type="email" required>
                <label for="i2" class="form-label">Contraseña:</label>
                <input id="i2" name="c1" type="password"
                       pattern="[A-Z]+[a-z]+[0-9]+[+-*/%$._!?]+"
                       minlength="12" maxlength="20"
                       title="Debe contener Mayúsculas, Minúsculas, Números y Símbolos (+-*/%$._!?)">
                <label for="i3" class="form-label">Contraseña de Respaldo:</label>
                <input id="i3" name="c2" type="password"
                       pattern="[A-Z]+[a-z]+[0-9]+[+-*/%$._!?]+"
                       minlength="12" maxlength="20"
                       title="Debe contener Mayúsculas, Minúsculas, Números y Símbolos (+-*/%$._!?)">
                <label for="i4" class="form-label">Nombre(s):</label>
                <input id="i4" name="n" type="text" pattern="[A-Za-z\s']+" maxlength="25" required>
                <label for="i5" class="form-label">Apellido Paterno:</label>
                <input id="i5" name="ap" type="text" pattern="[A-Za-z\s']+" maxlength="15" required>
                <label for="i6" class="form-label">Apellido Materno:</label>
                <input id="i6" name="am" type="text" pattern="[A-Za-z\s']+" maxlength="15" required>
                <label for="i7" class="form-label">Ubicación:</label>
                <div id="gMap"></div>
                <input id="i7" name="u" type="text" readonly title="Selecciona en el Mapa la ubicación de tu Huerto o Jardín :)" value="Ciudad de Mexico, Mexico" required>
                <div class="divider">¿Ya tienes una Cuenta?&nbsp;<a href="Sesion.html" class="text-link">Inicia Sesión AQUÍ</a></div>
                <div class="text-center">
                    <button type="submit" class="btn btn-green mt-2 w-50">REGISTRAR</button>
                </div>
            </form>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>