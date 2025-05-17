<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html lang="es">
            <!-- IMPORTANTE 
            Para este modulo es mas facil que desahabilites y habilites los 
            botones de personalizacion y asi para cada usuario en vez de hacer
            un nuevo modulo entonces trata de hacer eso.
            Para otros usuarios el texto de Mi Perfil obviamente cambiara a Perfil
            El unico boton habilitado seria el de Mis plantas que ahora pasaria a 
            Plantas.
            Para el misplantas.jsp podemos seguir la misma idea de habilitar y
            deshabilitar botones de personalizacion, si no lo crees viable, dime
            para modificarlo
            -->
<head>
    <meta charset="UTF-8">
    <title>Mi Perfil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #e2e2e2;
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <div class="container my-5">
        <h2 class="fw-bold mb-4 text-center">Mi Perfil</h2>

        <div class="bg-white rounded-4 p-4 d-flex flex-column flex-md-row align-items-center align-items-md-start gap-4 shadow mx-auto" style="max-width: 900px;">

            <!-- Imagen de perfil -->
            <div class="text-center position-relative">
                <img src="img/profileph.png" alt="Foto de perfil" class="rounded-circle border"
                     style="width: 150px; height: 150px; object-fit: cover;">
                <button class="btn btn-success rounded-circle position-absolute start-50 translate-middle-x"
                        style="width: 40px; height: 40px; top: 55%"
                        data-bs-toggle="modal" data-bs-target="#modalEditarPerfil">
                    <i class="bi bi-pencil-fill text-white"></i>
                </button>
                <div style="margin-top: 60px">
                    <p class="mb-0 fw-semibold">juanpagon16@gmail.com</p>
                    <p class="mb-0 text-muted">Edad: 18</p>
                    <div class="text-warning fs-5 mt-1">
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                    </div>
                </div>
            </div>

            <!-- Info del usuario -->
            <div class="flex-fill text-center text-md-center">
                <h3 class="fw-bold">Juan Pérez</h3>
                <p class="text-muted">La descripción de Juan Pérez</p>
                <div class="d-flex justify-content-center justify-content-md-center gap-5 my-3">
                    <span><strong>Ventas:</strong> 123</span>
                    <span><strong>Productos:</strong> 123</span>
                </div>

                <!-- Botones -->
                <div class="d-grid gap-2 col-12 col-md-6 mx-auto">
                    <a href="misplantas.jsp" class="btn btn-success rounded-pill">Mis Plantas</a>
                    <button class="btn btn-success rounded-pill" data-bs-toggle="modal"
                            data-bs-target="#modalCerrarSesion">Cerrar Sesión</button>
                    <button class="btn btn-success rounded-pill" data-bs-toggle="modal"
                            data-bs-target="#modalEliminarCuenta">Eliminar Perfil</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Cerrar Sesión -->
    <%@ include file="modals/cerrarsesionmodal.jsp" %>

    <!-- Modal Eliminar Perfil -->
    <%@ include file="modals/eliminarperfilmodal.jsp" %>

    <!-- Modal Editar Perfil -->
    <%@ include file="modals/editarperfilmodal.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
