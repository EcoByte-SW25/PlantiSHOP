<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Registro Parte 2 | PlantiSHOP</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="src/sessions.css">
</head>
<body>

<div class="text-center mt-4">
  <img src="img/logob.png" alt="PlantiSHOP" class="logo mb-2" style="max-width: 80px;">
  <h4><strong>PlantiSHOP</strong></h4>
</div>

<div class="register-card">
  <h5 class="mb-4 text-center"><strong>Completa tu Registro</strong></h5>

  <form id="secondRegisterForm" novalidate>
    <div class="mb-3">
      <label class="form-label">Nombre(s)</label>
      <input type="text" class="form-control" id="nombres" required>
      <div class="form-error" id="errorNombres"></div>
    </div>

    <div class="mb-3">
      <label class="form-label">Apellido Paterno</label>
      <input type="text" class="form-control" id="apellidoPaterno" required>
      <div class="form-error" id="errorApellidoPaterno"></div>
    </div>

    <div class="mb-3">
      <label class="form-label">Apellido Materno</label>
      <input type="text" class="form-control" id="apellidoMaterno" required>
      <div class="form-error" id="errorApellidoMaterno"></div>
    </div>

    <div class="mb-3">
      <label class="form-label">Edad</label>
      <input type="number" class="form-control" id="edad" required>
      <div class="form-error" id="errorEdad"></div>
    </div>

    <div class="mb-3">
      <label class="form-label">Ubicación</label>
      <div class="map-placeholder text-center">[Mapa será insertado aquí]</div>
    </div>

    <div class="mb-3">
      <label class="form-label">Descripción (opcional)</label>
      <textarea class="form-control" id="descripcion" maxlength="500" rows="3"></textarea>
    </div>

    <div class="mb-3 text-center">
      <img src="https://via.placeholder.com/150" alt="Preview" id="imgPreview" class="image-preview">
      <label for="profileImage">Seleccionar Foto de Perfil</label>
      <input type="file" id="profileImage" class="custom-file-input" accept=".jpg,.jpeg,.png">
      <div class="form-error" id="errorImagen"></div>
    </div>

    <div class="text-end">
      <button type="submit" class="btn btn-green">Finalizar Registro</button>
    </div>
  </form>
</div>

<!-- Modal de Error -->
<div class="modal fade" id="alertModal" tabindex="-1" aria-labelledby="alertModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title" id="alertModalLabel">Error en el formulario</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
      </div>
      <div class="modal-body">
        Por favor corrige los errores indicados para continuar con el registro.
      </div>
    </div>
  </div>
</div>

<!-- Modal de Registro Exitoso -->
<div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header bg-success text-white">
        <h5 class="modal-title" id="successModalLabel">¡Registro exitoso!</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
      </div>
      <div class="modal-body">
        Tu cuenta ha sido creada correctamente.
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-success" id="btnContinuar">Continuar</button>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  document.getElementById("secondRegisterForm").addEventListener("submit", function(e) {
    e.preventDefault();

    let isValid = true;

    // Limpiar errores previos
    const fields = ["Nombres", "ApellidoPaterno", "ApellidoMaterno", "Edad", "Imagen"];
    fields.forEach(field => document.getElementById("error" + field).textContent = "");

    const nombre = document.getElementById("nombres").value.trim();
    const apellidoP = document.getElementById("apellidoPaterno").value.trim();
    const apellidoM = document.getElementById("apellidoMaterno").value.trim();
    const edad = parseInt(document.getElementById("edad").value);
    const imagen = document.getElementById("profileImage").files[0];

    // Validaciones básicas
    if (nombre === "") {
      document.getElementById("errorNombres").textContent = "Ingresa tu(s) nombre(s)";
      isValid = false;
    }

    if (apellidoP === "") {
      document.getElementById("errorApellidoPaterno").textContent = "Ingresa tu apellido paterno";
      isValid = false;
    }

    if (apellidoM === "") {
      document.getElementById("errorApellidoMaterno").textContent = "Ingresa tu apellido materno";
      isValid = false;
    }

    if (isNaN(edad) || edad < 18) {
      document.getElementById("errorEdad").textContent = "Debes tener al menos 18 años";
      isValid = false;
    }

    if (imagen) {
      const allowed = ["image/png", "image/jpeg", "image/jpg"];
      if (!allowed.includes(imagen.type)) {
        document.getElementById("errorImagen").textContent = "Solo se permiten imágenes PNG, JPG o JPEG";
        isValid = false;
      }
    }

    if (!isValid) {
      const modal = new bootstrap.Modal(document.getElementById('alertModal'));
      modal.show();
    } else {
      const successModal = new bootstrap.Modal(document.getElementById('successModal'));
      successModal.show();

      document.getElementById("btnContinuar").onclick = () => {
        window.location.href = "index.jsp";
      };
    }
  });

  // Vista previa de imagen
  document.getElementById("profileImage").addEventListener("change", function () {
    const file = this.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = function(e) {
        document.getElementById("imgPreview").src = e.target.result;
      };
      reader.readAsDataURL(file);
    }
  });
</script>

</body>
</html>
