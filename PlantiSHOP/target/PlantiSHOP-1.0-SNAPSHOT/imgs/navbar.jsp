<style>
    body {
        font-family: 'Inter', sans-serif;
        margin: 0;
        padding-top: 120px;
        background-color: #f8f9fa;
    }
    iframe {
        width: 100%;
        height: calc(100vh - 120px);
        border: none;
    }
    .navbar-top {
        background-color: #198754;
    }
    .navbar-bottom {
        background-color: #000;
        z-index: 0;
    }
    .navbar-brand img {
        width: 2em;
        height: 2em;
        margin-right: 0.5rem;
    }
    .nav-link {
        color: white !important;
    }
    .nav-link:hover {
        color: #a4f3b5 !important;
    }
    .dropdown-menu a:hover {
        background-color: #198754;
        color: white !important;
    }
    .dropdown-toggle::after {
        margin-left: 0.4em;
    }
    @media (max-width: 768px) {
        body {
            padding-top: 170px;
        }
        iframe {
            height: calc(100vh - 170px);
        }
    }
    .navbar-bottom .navbar-nav {
        display: flex;
        justify-content: space-between;
        width: 100%;
    }
    .navbar-bottom .nav-item {
        flex-grow: 1;
        text-align: center;
    }
</style>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        window.location.hash = "no-back-button";
        window.location.hash = "Again-No-back-button";
        window.onhashchange = function () {
            window.location.hash = "";
        };
    });
</script>
<body style='background-color: #e9e9e9;'>
<nav class="navbar navbar-expand-lg navbar-dark navbar-top fixed-top shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <img src="imgs/logo.png" alt="Logo">
            <span class="fw">PlantiSHOP</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#topNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <ul class="navbar-nav ms-auto">
            <li class="nav-item"><a class="nav-link" href="Ventas.jsp">Tus Ventas</a></li>
            <li class="nav-item"><a class="nav-link" href="Mensajeria.jsp">Tus Compras y Pedidos</a></li>
            <li class="nav-item"><a class="nav-link" href="FAQ.html">FAQ</a></li>
            <li class="nav-item"><a class="nav-link" href="Premium.jsp">PREMIUM</a></li>
        </ul>
        <div class="collapse navbar-collapse" id="topNavbar">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown">
                        <img src="imgs/perfil.jpg" alt="Perfil" class="rounded-circle me-2" style="width: 2em; height: 2em;">
                        Perfil
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="Perfil.jsp">Tu Perfil</a></li>
                        <li><a class="dropdown-item" href="Jardin.jsp">Tu Jardín</a></li>
                        <li><a class="dropdown-item" href="Interfaz.jsp?x=E">Cerrar Sesión</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
<nav class="navbar navbar-expand-lg navbar-dark navbar-bottom fixed-top shadow-sm" style="top: 56px;">
    <div class="container-fluid">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#bottomNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="bottomNavbar">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="Mercado.jsp#PD">Plantas Decorativas</a></li>
                <li class="nav-item"><a class="nav-link" href="Mercado.jsp#PH">Plantas de Huerto</a></li>
                <li class="nav-item"><a class="nav-link" href="Mercado.jsp#PA">Plantas Acuáticas</a></li>
                <li class="nav-item"><a class="nav-link" href="Mercado.jsp#A">Árboles</a></li>
                <li class="nav-item"><a class="nav-link" href="Mercado.jsp#AH">Algas y Hongos</a></li>
                <li class="nav-item"><a class="nav-link" href="Mercado.jsp#F">Fertilizantes</a></li>
                <li class="nav-item"><a class="nav-link" href="Mercado.jsp#H">Herramientas</a></li>
            </ul>
        </div>
    </div>
</nav>