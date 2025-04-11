<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-success px-3">
  <a class="navbar-brand d-flex align-items-center" href="#">
    <img src="logo.png" alt="Logo" width="30" height="30" class="d-inline-block align-top me-2">
    PlantiSHOP
  </a>

  <form class="d-flex mx-3 flex-grow-1">
    <input class="form-control me-2" type="search" placeholder="Buscar..." aria-label="Buscar">
    <button class="btn btn-light" type="submit">
      <i class="bi bi-search"></i> <!-- Bootstrap Icon -->
    </button>
  </form>

  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMenu">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse bg-dark rounded px-3" id="navbarMenu">
    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
      <li class="nav-item"><a class="nav-link ${page eq 'vender' ? 'active' : ''}" href="vender.jsp">Vender</a></li>
      <li class="nav-item"><a class="nav-link ${page eq 'plantas' ? 'active' : ''}" href="plantas.jsp">Plantas</a></li>
      <li class="nav-item"><a class="nav-link ${page eq 'arboles' ? 'active' : ''}" href="arboles.jsp">Árboles</a></li>
      <li class="nav-item"><a class="nav-link ${page eq 'fertilizantes' ? 'active' : ''}" href="fertilizantes.jsp">Fertilizantes</a></li>
      <li class="nav-item"><a class="nav-link ${page eq 'herramientas' ? 'active' : ''}" href="herramientas.jsp">Herramientas</a></li>
      <li class="nav-item"><a class="nav-link ${page eq 'vendedores' ? 'active' : ''}" href="vendedores.jsp">Vendedores</a></li>
      <li class="nav-item"><a class="nav-link ${page eq 'faq' ? 'active' : ''}" href="faq.jsp">FAQ</a></li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle ${page eq 'premium' ? 'active' : ''}" href="#" id="premiumDropdown" role="button" data-bs-toggle="dropdown">
          Premium
        </a>
        <ul class="dropdown-menu">
          <li><a class="dropdown-item" href="#">Opción 1</a></li>
          <li><a class="dropdown-item" href="#">Opción 2</a></li>
        </ul>
      </li>
    </ul>

    <div class="d-flex align-items-center">
      <div class="position-relative me-3">
        <img src="mail.png" alt="Messages" width="24" height="24">
        <span class="position-absolute top-0 start-100 translate-middle p-1 bg-danger border border-light rounded-circle"></span>
      </div>
      <img src="user.png" alt="Profile" width="30" height="30" class="rounded-circle">
    </div>
  </div>
</nav>
