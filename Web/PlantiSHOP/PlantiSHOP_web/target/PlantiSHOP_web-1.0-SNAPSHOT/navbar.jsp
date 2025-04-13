<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Top Navbar: Logo, Search, Notifications, Profile -->
<nav class="navbar navbar-expand-lg navbar-dark bg-success px-3">
  <div class="container-fluid">
    <a class="navbar-brand d-flex align-items-center" href="#">
      <img src="src/logo.png" alt="Logo" width="30" height="30" class="me-2">
      PlantiSHOP
    </a>

    <form class="d-flex mx-3 size-search">
      <input class="form-control me-2" type="search" placeholder="Buscar..." aria-label="Buscar">
      <button class="btn btn-light" type="submit">
          <img src="src/search.png" alt="glass" widht="20" height="20">
      </button>
    </form>

    <div class="d-flex align-items-center">
      <div class="position-relative me-3">
        <img src="src/message.png" alt="Messages" width="24" height="auto">
        <span class="position-absolute top-0 start-100 translate-middle p-1 bg-danger border border-light rounded-circle"></span>
      </div>
      <img src="src/profileph.png" alt="Profile" width="30" height="30" class="rounded-circle">
    </div>
  </div>
</nav>

<!-- Bottom Navbar: Navigation Links -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-3">
  <div class="container-fluid">

    <!-- Botón navbar para pantallas pequeñas -->
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMenu">
      <span class="navbar-toggler-icon"></span>
    </button>
      
    <!-- Botón de menú hamburguesa independiente -->
    <div class="dropdown me-3">
      <button class="btn btn-dark dropdown-toggle d-flex align-items-center" type="button" id="menuDropdown" data-bs-toggle="dropdown" aria-expanded="false">
        <span class="navbar-toggler-icon"></span>
      </button>
      <ul class="dropdown-menu" aria-labelledby="menuDropdown">
        <li><a class="dropdown-item" href="#">Inicio</a></li>
        <li><a class="dropdown-item" href="#">Mi Cuenta</a></li>
        <li><a class="dropdown-item" href="#">Mis Pedidos</a></li>
        <li><a class="dropdown-item" href="#">Configuración</a></li>
        <li><hr class="dropdown-divider"></li>
        <li><a class="dropdown-item" href="#">Cerrar sesión</a></li>
      </ul>
    </div>

    <!-- Menú principal -->
    <div class="collapse navbar-collapse" id="navbarMenu">
      <ul class="navbar-nav w-100 d-flex justify-content-evenly text-center">
        <c:set var="page" value="${param.page}" />
        <c:forEach var="item" items="${['vender','plantas','arboles','fertilizantes','herramientas','vendedores','faq']}">
          <li class="nav-item flex-fill">
            <a class="nav-link <c:if test='${page == item}'>active</c:if>'" href="${item}.jsp">
              <c:choose>
                <c:when test="${item == 'vender'}">Vender</c:when>
                <c:when test="${item == 'plantas'}">Plantas</c:when>
                <c:when test="${item == 'arboles'}">Árboles</c:when>
                <c:when test="${item == 'fertilizantes'}">Fertilizantes</c:when>
                <c:when test="${item == 'herramientas'}">Herramientas</c:when>
                <c:when test="${item == 'vendedores'}">Vendedores</c:when>
                <c:when test="${item == 'faq'}">FAQ</c:when>
              </c:choose>
            </a>
          </li>
        </c:forEach>

        <!-- Premium dropdown evenly spaced too -->
        <li class="nav-item dropdown flex-fill">
          <a class="nav-link dropdown-toggle <c:if test='${page == "premium"}'>active</c:if>'" href="#" id="premiumDropdown" role="button" data-bs-toggle="dropdown">
            Premium
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">Opción 1</a></li>
            <li><a class="dropdown-item" href="#">Opción 2</a></li>
          </ul>
        </li>
      </ul>
</nav>
