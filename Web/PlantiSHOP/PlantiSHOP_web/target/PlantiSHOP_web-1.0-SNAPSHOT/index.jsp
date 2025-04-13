<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>PlantiSHOP - Inicio</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .navbar-nav .nav-link.active {
      background-color: #3d8d4c;
      border-radius: 0.25rem;
    }

    .size-search {
      width: 30vw;
    }

    .hero {
      background-image: url('src/bgmain.png'); /* Reemplaza con tu imagen */
      background-size: cover;
      background-position: center;
      height: 45vh;
      display: flex;
      align-items: start;
      padding-top: 30px;
      justify-content: center;
      color: white;
      text-shadow: 0 2px 5px rgba(0, 0, 0, 0.7);
      position: relative;
      z-index: 1;
    }

    .card-section {
      margin-top: -25vh; /* SUPERPOSICIÓN LOCURAAA */
      position: relative;
      z-index: 10;
      padding: 3rem 2rem;
    }

    .card {
      background: rgba(255, 255, 255, 0.2); /* Blanco transparente */
      backdrop-filter: blur(12px); /* Vidrio difuminado */
      -webkit-backdrop-filter: blur(12px);
      border-radius: 20px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.25);
      border: 1px solid rgba(255, 255, 255, 0.3);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .card:hover {
      transform: translateY(-10px);
      box-shadow: 0 20px 50px rgba(0, 0, 0, 0.35);
    }

    .card img {
      object-fit: cover;
      height: 150px;
      border-top-left-radius: 20px;
      border-top-right-radius: 20px;
    }

    h2.text-white {
      text-shadow: 0 2px 6px rgba(0,0,0,0.8);
    }
  </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

  <!-- Hero Section -->
  <section class="hero">
    <div class="text-center align-items-start ">
      <h1 class="display-4 fw-bold">¡Bienvenido a PlantiSHOP!</h1>
      <p class="lead">Explora nuestras mejores ofertas verdes</p>
    </div>
  </section>

  <!-- Card Section GLASS & LOCURA -->
  <div class="container card-section">
    <h2 class="text-center mb-4 text-white">Ofertas Destacadas</h2>
    <div class="row row-cols-1 row-cols-md-3 g-4">

      <div class="col">
        <div class="card h-100">
          <img src="images/plant1.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Planta Suculenta</h5>
            <p class="card-text">Perfecta para interiores, bajo mantenimiento.</p>
          </div>
        </div>
      </div>

      <div class="col">
        <div class="card h-100">
          <img src="images/arbol1.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Árbol Frutal</h5>
            <p class="card-text">Dale vida y frutos a tu jardín.</p>
          </div>
        </div>
      </div>

      <div class="col">
        <div class="card h-100">
          <img src="images/fert1.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Fertilizante Orgánico</h5>
            <p class="card-text">Aumenta el crecimiento de forma natural.</p>
          </div>
        </div>
      </div>

      <div class="col">
        <div class="card h-100">
          <img src="images/herramienta1.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Set de Jardinería</h5>
            <p class="card-text">Todo lo que necesitas para cuidar tus plantas.</p>
          </div>
        </div>
      </div>

      <div class="col">
        <div class="card h-100">
          <img src="images/plant2.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Planta de Interior</h5>
            <p class="card-text">Decora tu hogar con vida y frescura.</p>
          </div>
        </div>
      </div>

      <div class="col">
        <div class="card h-100">
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
