<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>LogIn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="src/sessions.css">
</head>
<body>
    <div class="text-center mt-4">
        <img src="img/logob.png" alt="PlantiSHOP" class="logo mb-2"> <!-- Replace with your logo path -->
        <h4><strong>PlantiSHOP</strong></h4>
    </div>

    <div class="login-card text-center">
        <h5 class="mb-4"><strong>Inicio de Sesión</strong></h5>
        <form action="tuLogin.jsp" method="post">
            <div class="mb-3 text-start">
                <label class="form-label">Nombre de Usuario o Correo Electrónico</label>
                <input type="text" class="form-control" name="usuario" required>
            </div>
            
            <div class="mb-4 text-start">
                <label class="form-label">Contraseña</label>
                <input type="password" class="form-control" name="contrasena" required>
            </div>
            
            <div class="text-end mb-3">
                <button type="submit" class="btn btn-green">Ingresar</button>
            </div>
        </form>

        <div class="divider">¿Nuevo en PlantiSHOP?</div>

        <a href="registerp1.jsp" class="btn btn-green w-100">Registrarte en PlantiSHOP</a>
    </div>
</body>
</html>
