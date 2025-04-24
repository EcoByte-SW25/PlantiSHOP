<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Sobre Nosotros - PlantiSHOP</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="src/about.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<!-- Hero -->
<div class="hero-about">
  <h1>Conoce PlantiSHOP</h1>
</div>

<!-- Paso 1 -->
<div class="section row g-5 align-items-center">
  <div class="col-md-6 text-side">
    <h2>Paso 1: Encuentra la planta ideal</h2>
    <p>
      Explora nuestro catálogo y descubre una amplia variedad de plantas disponibles por parte de diferentes proveedores. Filtra por tipo, ubicación o necesidades específicas y encuentra justo lo que estás buscando.
    </p>
  </div>
  <div class="col-md-6">
    <img src="img/search.png" alt="Búsqueda de plantas">
  </div>
</div>

<!-- Paso 2 -->
<div class="section row g-5 align-items-center flex-md-row-reverse">
  <div class="col-md-6 text-side">
    <h2>Paso 2: Contacta al proveedor</h2>
    <p>
      Una vez que encuentres la planta ideal, envía un mensaje al proveedor para acordar el punto de encuentro y la fecha de entrega. Todo ocurre desde nuestra plataforma, asegurando una comunicación fluida y segura.
    </p>
  </div>
  <div class="col-md-6">
    <img src="img/contact.png" alt="Contacto con proveedor">
  </div>
</div>

<!-- Paso 3 -->
<div class="section row g-5 align-items-center">
  <div class="col-md-6 text-side">
    <h2>Paso 3: Validación con código</h2>
    <p>
      Al momento de la entrega, comprador y vendedor validan un código único generado por el sistema. Esto confirma que la transacción se realizó correctamente. En caso de incumplimiento, se penalizará al responsable.
    </p>
  </div>
  <div class="col-md-6">
    <img src="img/code.png" alt="Validación de entrega">
  </div>
</div>

<!-- Planes de Suscripción -->
<section class="subscription-section py-5" style="background-color: #f8f9fa;">
  <div class="container">
    <h2 class="text-center mb-4">Planes de Suscripción</h2>
    <p class="text-center mb-5">Elige el plan que mejor se adapte a tus necesidades como amante de las plantas.</p>

    <div class="row justify-content-center align-items-end">
      <!-- Plan Gratis -->
      <div class="col-md-4 mb-4">
        <div class="card free-plan shadow-sm h-100">
          <div class="card-header text-center">
            <h4 class="my-2">Plan Gratis</h4>
          </div>
          <div class="card-body">
            <ul class="list-unstyled">
              <li><i class="bi bi-check-circle-fill text-success me-2"></i> Publicación de productos</li>
              <li><i class="bi bi-check-circle-fill text-success me-2"></i> Compra y venta seguras</li>
              <li><i class="bi bi-check-circle-fill text-success me-2"></i> Acceso al chat con otros usuarios</li>
              <li><i class="bi bi-check-circle-fill text-success me-2"></i> Gestión básica de perfil</li>
            </ul>
          </div>
          <div class="card-footer text-center">
            <strong class="text-muted">Precio: $0 MXN</strong>
          </div>
        </div>
      </div>

      <!-- Plan Premium -->
      <div class="col-md-6 mb-4">
        <div class="card premium-plan shadow-sm h-100">
          <div class="card-header text-center">
            <h4 class="my-2">Plan Premium</h4>
          </div>
          <div class="card-body">
            <ul class="list-unstyled">
              <li><i class="bi bi-check-circle-fill text-success me-2"></i> Todo lo del Plan Gratis</li>
              <li><i class="bi bi-robot text-success me-2"></i> Chatbot de cuidado personalizado</li>
              <li><i class="bi bi-bar-chart-fill text-success me-2"></i> Análisis de ventas con gráficos</li>
              <li><i class="bi bi-credit-card-2-back text-success me-2"></i> Recepción de pagos con tarjeta</li>
            </ul>
            <div class="text-center">
              <button class="btn btn-premium">Cambiar a Premium</button>
            </div>
          </div>
          <div class="card-footer text-center">
            <strong>Precio: $50 MXN / mes</strong>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
