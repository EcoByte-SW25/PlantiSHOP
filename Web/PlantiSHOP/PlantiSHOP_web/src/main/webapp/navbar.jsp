<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Top Navbar -->
<link rel="stylesheet" href="src/navbar.css">
<nav class="navbar navbar-expand-lg navbar-dark bg-success px-3">
  <div class="container-fluid">
    <a class="navbar-brand d-flex align-items-center" href="index.jsp">
      <img src="img/logo.png" alt="Logo" width="30" height="30" class="me-2">
      PlantiSHOP
    </a>

    <form class="d-flex mx-3 size-search">
      <input class="form-control me-2" type="search" placeholder="Buscar..." aria-label="Buscar">
      <button class="btn btn-light" type="submit">
        <img src="img/search.png" alt="glass" width="20" height="20">
      </button>
    </form>

    <div class="d-flex align-items-center" id="user-section">
      <!-- JS decidirá si mostrar perfil o login/register -->
    </div>
  </div>
</nav>

<!-- Bottom Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-3">
  <div class="container-fluid">
    <!-- Botón hamburguesa para móviles -->
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMenu">
      <span class="navbar-toggler-icon"></span>
    </button>

    <!-- Contenido colapsable -->
    <div class="collapse navbar-collapse" id="navbarMenu">
      <ul class="navbar-nav w-100 d-flex flex-column flex-lg-row justify-content-evenly text-center">
        <c:set var="filter" value="${param.filter}" />

        <!-- Elementos principales redirigen a market.jsp con filtro -->
        <c:forEach var="item" items="${['plantas','arboles','fertilizantes','herramientas','vendedores','faq']}">
            <li class="nav-item">
              <a class="nav-link <c:if test='${filter == item}'>active</c:if>'" 
                 href="<c:choose>
                         <c:when test='${item == "faq"}'>faq.jsp</c:when>
                         <c:otherwise>market.jsp</c:otherwise>
                       </c:choose>">
                <c:choose>
                  <c:when test="${item == 'plantas'}">Plantas</c:when>
                  <c:when test="${item == 'arboles'}">Árboles</c:when>
                  <c:when test="${item == 'fertilizantes'}">Fertilizantes</c:when>
                  <c:when test="${item == 'herramientas'}">Herramientas</c:when>
                  <c:when test="${item == 'vendedores'}">Vendedores</c:when>
                  <c:when test="${item == 'faq'}">FAQ</c:when>
                  <c:otherwise><c:out value="${item}" /></c:otherwise>
                </c:choose>
              </a>
            </li>
          </c:forEach>


        <!-- Premium con dropdown -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle <c:if test='${filter == "premium"}'>active</c:if>'" href="#" id="premiumDropdown" role="button" data-bs-toggle="dropdown">
            Premium
          </a>
          <ul class="dropdown-menu text-center" id="premiumMenu" aria-labelledby="premiumDropdown">
            <!-- JS rellena esto -->
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Script de pseudofuncionamiento -->
<script>
  const isLoggedIn = false;
  const isPremium = false;

  // Zona de usuario arriba
  const userSection = document.getElementById("user-section");
  if (!isLoggedIn) {
    userSection.innerHTML = `
      <a href="login.jsp" class="btn btn-outline-light me-2">Iniciar Sesión</a>
      <a href="registerp1.jsp" class="btn btn-light">Registrarse</a>
    `;
  } else {
    userSection.innerHTML = `
      <div class="position-relative me-3">
        <img src="src/message.png" alt="Messages" width="24">
        <span class="position-absolute top-0 start-100 translate-middle p-1 bg-danger border border-light rounded-circle"></span>
      </div>
      <img src="src/profileph.png" alt="Profile" width="30" height="30" class="rounded-circle">
    `;
  }

  // Menú Premium
  const premiumMenu = document.getElementById("premiumMenu");
  if (isPremium) {
    premiumMenu.innerHTML = `
      <li><a class="dropdown-item" href="ia.jsp">LirioBot</a></li>
      <li><a class="dropdown-item" href="ad.jsp">Datos</a></li>
    `;
  } else {
    premiumMenu.innerHTML = `
      <li><a class="dropdown-item" href="about.jsp">Planes</a></li>
    `;
  }
</script>
