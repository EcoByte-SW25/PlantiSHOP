<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>PlantiSHOP - Inicio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="src/index.css">
</head>
<body>
<%@ include file="navbar.jsp" %>

<!-- Hero Section -->
<section class="hero">
  <div class="text-center align-items-start">
    <h1 class="display-4 fw-bold">¡Bienvenido a PlantiSHOP!</h1>
    <p class="lead">Explora nuestras mejores ofertas verdes</p>
  </div>
</section>

<!-- Seccion glass -->
<div class="container card-section">
  <h2 class="text-center mb-4 text-white">Ofertas Destacadas</h2>
  <div class="row row-cols-1 row-cols-md-3 g-4">
    
<!-- Esas cartas tu las modificas con params para que envie a la pagina de mercado con algunos fitlros aplicados -->
    <%@ include file="glasscardindex.jsp" %>
    <%@ include file="glasscardindex.jsp" %>
    <%@ include file="glasscardindex.jsp" %>
    <%@ include file="glasscardindex.jsp" %>
    <%@ include file="glasscardindex.jsp" %>
    <%@ include file="glasscardindex.jsp" %>
  </div>
</div>

<!-- Seccion Planes -->
<section class="py-5" style="background-color: #eeeeee;">
  <div class="container bg-white p-4 rounded shadow-sm">
    <h3 class="text-center fw-bold mb-4">Conoce el Modelo de PlantiSHOP</h3>
    <div class="row align-items-center">
      <!-- Gratuito -->
      <div class="col-md-6">
        <h5 class="fw-bold mb-3">Plan Gratuito</h5>
        <ul class="list-unstyled">
          <li class="mb-3 d-flex align-items-center">
            <div class="icon-circle bg-success me-2">
              <i class="bi bi-tree"></i>
            </div>
            Mercado de Plantas
          </li>
          <li class="mb-3 d-flex align-items-center">
            <div class="icon-circle bg-success me-2">
              <i class="bi bi-chat-dots"></i>
            </div>
            Mensajería para Vendedores y Clientes
          </li>
          <li class="mb-3 d-flex align-items-center">
            <div class="icon-circle bg-success me-2">
              <i class="bi bi-cash"></i>
            </div>
            Métodos de Pago en Contra Entrega
          </li>
        </ul>
      </div>

      <!-- Premium -->
      <div class="col-md-6">
        <div class="p-3 rounded" style="background-color: #dce4cc;">
          <h5 class="fw-bold mb-3">Plan Premium</h5>
          <ul class="list-unstyled">
            <li class="mb-3 d-flex align-items-center">
              <div class="icon-circle bg-olive me-2">
                <i class="bi bi-robot"></i>
              </div>
              Asistente de Cuidados con IA
            </li>
            <li class="mb-3 d-flex align-items-center">
              <div class="icon-circle bg-olive me-2">
                <i class="bi bi-graph-up-arrow"></i>
              </div>
              Publicidad y Cifras para vendedores
            </li>
            <li class="mb-3 d-flex align-items-center">
              <div class="icon-circle bg-olive me-2">
                <i class="bi bi-credit-card-2-front"></i>
              </div>
              Métodos de Pago con Tarjeta
            </li>
          </ul>
        </div>
      </div>
    </div>

    <div class="text-center mt-4">
      <a href="about.jsp" class="btn btn-success px-4">Conócenos</a>
    </div>
  </div>
</section>

<!-- Vendedores Destacados -->
<section class="py-5" style="background-color: #eeeeee;">
  <div class="container bg-white p-4 rounded shadow-sm">
    <h3 class="text-center fw-bold mb-5">Vendedores Destacados</h3>
    <div class="row g-4">
      <div class="col-md-4">
        <%@ include file="vendedorindexcard.jsp" %>
      </div>
      <div class="col-md-4">
        <%@ include file="vendedorindexcard.jsp" %>
      </div>
      <div class="col-md-4">
        <%@ include file="vendedorindexcard.jsp" %>
      </div>
      <div class="col-md-4">
        <%@ include file="vendedorindexcard.jsp" %>
      </div>
      <div class="col-md-4">
        <%@ include file="vendedorindexcard.jsp" %>
      </div>
      <div class="col-md-4">
        <%@ include file="vendedorindexcard.jsp" %>
      </div>
    </div>
      <!-- Botón Ver más -->
  <div class="text-center mt-5">
    <a href="market.jsp" class="btn btn-success px-4">Ver más</a>
  </div>
  </div>
</section>
      
<!-- Productos Destacados -->
<section class="py-5" style="background-color: #eeeeee;">
  <div class="container bg-white p-4 rounded shadow-sm">
    <h3 class="text-center fw-bold mb-5">Vendedores Destacados</h3>
    <div class="row g-4">
      <div class="col-md-4">
        <%@ include file="productoindexcard.jsp" %>
      </div>
      <div class="col-md-4">
        <%@ include file="productoindexcard.jsp" %>
      </div>
      <div class="col-md-4">
        <%@ include file="productoindexcard.jsp" %>
      </div>
      <div class="col-md-4">
        <%@ include file="productoindexcard.jsp" %>
      </div>
      <div class="col-md-4">
        <%@ include file="productoindexcard.jsp" %>
      </div>
      <div class="col-md-4">
        <%@ include file="productoindexcard.jsp" %>
      </div>
    </div>
      <!-- Botón Ver más -->
  <div class="text-center mt-5">
    <a href="market.jsp" class="btn btn-success px-4">Ver más</a>
  </div>
  </div>
</section>
<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
