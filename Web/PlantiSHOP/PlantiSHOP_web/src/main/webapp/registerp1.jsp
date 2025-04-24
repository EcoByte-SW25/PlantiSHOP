<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro | PlantiSHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="src/sessions.css">
</head>
<body>

  <div class="text-center mt-4">
    <img src="img/logob.png" alt="PlantiSHOP" class="logo mb-2">
    <h4><strong>PlantiSHOP</strong></h4>
  </div>

  <div class="login-card text-center">
    <h5 class="mb-4"><strong>Registro</strong></h5>

    <form id="registerForm" novalidate>
      <div class="mb-3 text-start">
        <label class="form-label">Correo Electrónico</label>
        <input type="email" class="form-control" id="email" name="email" required>
        <div class="error-msg" id="emailError"></div>
      </div>
      <div class="mb-3 text-start">
        <label class="form-label">Contraseña</label>
        <input type="password" class="form-control" id="password" name="password" required>
        <div class="error-msg" id="passwordError"></div>
      </div>
      <div class="mb-4 text-start">
        <label class="form-label">Confirmar Contraseña</label>
        <input type="password" class="form-control" id="password2" name="password2" required>
        <div class="error-msg" id="password2Error"></div>
      </div>
      <div class="text-end mb-3">
        <button type="submit" class="btn btn-green">Siguiente</button>
      </div>
    </form>

    <div class="divider">¿Ya tienes una Cuenta?</div>

    <a href="login.jsp" class="btn btn-green w-100">Iniciar Sesión en PlantiSHOP</a>
  </div>

  <script>
    document.getElementById('registerForm').addEventListener('submit', function(e) {
      e.preventDefault();

      let valid = true;

      const email = document.getElementById('email');
      const password = document.getElementById('password');
      const password2 = document.getElementById('password2');

      const emailError = document.getElementById('emailError');
      const passwordError = document.getElementById('passwordError');
      const password2Error = document.getElementById('password2Error');

      emailError.textContent = '';
      passwordError.textContent = '';
      password2Error.textContent = '';

      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

      if (!emailRegex.test(email.value)) {
        emailError.textContent = 'Ingresa un correo electrónico válido.';
        valid = false;
      }

      const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{12,}$/;

      if (!passwordRegex.test(password.value)) {
        passwordError.textContent = 'La contraseña debe tener al menos 12 caracteres, incluyendo mayúscula, minúscula, número y carácter especial.';
        valid = false;
      }

      if (password2.value !== password.value) {
        password2Error.textContent = 'Las contraseñas no coinciden.';
        valid = false;
      }

      if (valid) {
        this.submit(); // Esto es eliminable cuando conectes con el back, solo es para visualizar el front
            window.location.href = 'verification.jsp';
      }
    });
  </script>

</body>
</html>
