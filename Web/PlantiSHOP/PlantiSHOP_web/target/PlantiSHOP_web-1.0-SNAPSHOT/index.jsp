<%@ include file="navbar.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>PlantiSHOP - Inicio</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .hero {
      background-image: url('images/hero.jpg'); /* replace with your image */
      background-size: cover;
      background-position: center;
      height: 50vh;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      text-shadow: 0 2px 5px rgba(0,0,0,0.7);
    }
    .card img {
      object-fit: cover;
      height: 150px;
    }
  </style>
</head>
<body>

  <!-- Hero Section -->
  <section class="hero">
    <div class="text-center">
      <h1 class="display-4 fw-bold">¡Bienvenido a PlantiSHOP!</h1>
      <p class="lead">Explora nuestras mejores ofertas verdes ?</p>
    </div>
  </section>

  <!-- Card Section -->
  <div class="container my-5">
    <h2 class="text-center mb-4">Ofertas Destacadas</h2>
    <div class="row row-cols-1 row-cols-md-3 g-4">

      <div class="col">
        <div class="card h-100 shadow-sm">
          <img src="images/plant1.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Planta Suculenta</h5>
            <p class="card-text">Perfecta para interiores, bajo mantenimiento.</p>
          </div>
        </div>
      </div>

      <div class="col">
        <div class="card h-100 shadow-sm">
          <img src="images/arbol1.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Árbol Frutal</h5>
            <p class="card-text">Dale vida y frutos a tu jardín.</p>
          </div>
        </div>
      </div>

      <div class="col">
        <div class="card h-100 shadow-sm">
          <img src="images/fert1.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Fertilizante Orgánico</h5>
            <p class="card-text">Aumenta el crecimiento de forma natural.</p>
          </div>
        </div>
      </div>

      <div class="col">
        <div class="card h-100 shadow-sm">
          <img src="images/herramienta1.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Set de Jardinería</h5>
            <p class="card-text">Todo lo que necesitas para cuidar tus plantas.</p>
          </div>
        </div>
      </div>

      <div class="col">
        <div class="card h-100 shadow-sm">
          <img src="images/plant2.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Planta de Interior</h5>
            <p class="card-text">Decora tu hogar con vida y frescura.</p>
          </div>
        </div>
      </div>

      <div class="col">
        <div class="card h-100 shadow-sm">
          <img src="images/oferta1.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Oferta Especial</h5>
            <p class="card-text">¡Solo esta semana! Descuentos de hasta 40%.</p>
          </div>
        </div>
      </div>

    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
