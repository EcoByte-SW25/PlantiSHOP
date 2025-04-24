<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Login | PlantiSHOP</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #e5e5e5;
      font-family: 'Segoe UI', sans-serif;
    }

    .login-card {
      border-radius: 2rem;
      padding: 2rem;
      background-color: #fff;
      max-width: 420px;
      margin: 5vh auto;
      box-shadow: 0 10px 30px rgba(0,0,0,0.1);
    }

    .form-control {
      border-radius: 10px;
      border: 2px solid #444;
    }

    .btn-green {
      background-color: #2d7a44;
      color: white;
      border-radius: 10px;
      padding-inline: 2rem;
    }

    .btn-green:hover {
      background-color: #256437;
    }

    .divider {
      display: flex;
      align-items: center;
      text-align: center;
      margin: 1.5rem 0;
    }

    .divider::before, .divider::after {
      content: '';
      flex: 1;
      border-bottom: 1px solid #aaa;
    }

    .divider:not(:empty)::before {
      margin-right: .75em;
    }

    .divider:not(:empty)::after {
      margin-left: .75em;
    }

    .logo {
      max-width: 80px;
    }
  </style>
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
