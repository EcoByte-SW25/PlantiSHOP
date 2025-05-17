<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="src/sessions.css">
</head>
<body>

    <div class="text-center mt-4">
        <img src="img/logob.png" alt="PlantiSHOP" class="logo mb-2">
        <h4><strong>PlantiSHOP</strong></h4>
    </div>

    <div class="verify-card text-center">
        <h5 class="mb-4"><strong>Verificación de Código</strong></h5>

        <form id="verifyForm" novalidate>
            <div class="mb-3 text-start">
                <label class="form-label">Código de Verificación</label>
                <input type="text" class="form-control" id="codeInput" name="code" maxlength="6" required>
            </div>
            <div class="text-end mb-3">
                <button type="submit" class="btn btn-green">Verificar</button>
            </div>
        </form>
    </div>

    <!-- Modal de error -->
    <%@ include file="modals/errormodal.jsp" %>

    <!-- Modal de éxito -->
    <%@ include file="modals/exitomodal.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('verifyForm').addEventListener('submit', function(e) {
            e.preventDefault();

            const codeInput = document.getElementById('codeInput');
            const correctCode = "123456";

            if (codeInput.value !== correctCode) {
                const errorModal = new bootstrap.Modal(document.getElementById('errorModal'));
                errorModal.show();
            } else {
                const successModal = new bootstrap.Modal(document.getElementById('successModal'));
                successModal.show();
            }
        });
    </script>

</body>
</html>
