<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mercado</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/nouislider@15.7.0/dist/nouislider.min.css" rel="stylesheet">
    <link rel="stylesheet" href="src/market.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    
<%@ include file="navbar.jsp" %>

    <div class="market-header">
        <h1>Mercado</h1>
        <div class="container filter-container">
            <div class="d-flex flex-wrap justify-content-center align-items-center">
                <button class="filter-btn">Buscando: ElementoBuscado</button>
                <button class="filter-btn" data-bs-toggle="modal" data-bs-target="#modalCategoria" id="categoriaBtn">Plantas</button>
                <button class="filter-btn" data-bs-toggle="modal" data-bs-target="#modalPrecio" id="precioBtn">0$-50$</button>
                <button class="filter-btn" data-bs-toggle="modal" data-bs-target="#modalBrillo" id="brilloBtn"><i class="bi bi-brightness-high"></i> 0%-100%</button>
            </div>
        </div>
    </div>

  <!-- Productos -->
  <!--
  Aqui implementa la logica para las listas de productos,
  aplica tambien los filtros
  -->
    <%@ include file="cards/productcard.jsp" %>
    <%@ include file="cards/productcard.jsp" %>
    <%@ include file="cards/productcard.jsp" %>
    <%@ include file="cards/productcard.jsp" %>

    <!-- MODALS -->
    <!-- Oferta -->
    <%@ include file="modals/ofertamodal.jsp" %>
    <!-- Confirmacion -->
    <%@ include file="modals/confirmacionmodal.jsp" %>
    <!-- Filtros -->
    <!-- Categoría -->
    <%@ include file="modals/categoriamodal.jsp" %>
    <!-- Precio -->
    <%@ include file="modals/preciomodal.jsp" %>
    <!-- Brillo -->
    <%@ include file="modals/brillomodal.jsp" %>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        // ===== PRECIO =====
        const precioSlider = document.getElementById('precioSlider');
        const minPriceDisplay = document.getElementById('minPrice');
        const maxPriceDisplay = document.getElementById('maxPrice');
        const precioBtn = document.getElementById('precioBtn');

        noUiSlider.create(precioSlider, {
            start: [0, 5000],
            connect: true,
            range: {
                min: 0,
                max: 5000
            },
            tooltips: true,
            step: 50,
            format: {
                to: value => Math.round(value),
                from: value => Number(value)
            }
        });

        precioSlider.noUiSlider.on('update', (values) => {
            minPriceDisplay.textContent = values[0];
            maxPriceDisplay.textContent = values[1]; 
            document.querySelector('#modalPrecio .btn-success').addEventListener('click', () => {
                precioBtn.textContent = values[0] + '$ - ' + values[1] + '$';
            });
        });

        document.querySelector('#modalPrecio .btn-success').addEventListener('click', () => {
            const values = precioSlider.noUiSlider.get();
            precioBtn.textContent = '0$ - 5000$';
        });

        // ===== BRILLO =====
        const brilloSlider = document.getElementById('brilloSlider');
        const minLightDisplay = document.getElementById('minLight');
        const maxLightDisplay = document.getElementById('maxLight');
        const brilloBtn = document.getElementById('brilloBtn');

        noUiSlider.create(brilloSlider, {
            start: [0, 100],
            connect: true,
            range: {
                min: 0,
                max: 100
            },
            tooltips: true,
            step: 1,
            format: {
                to: value => Math.round(value),
                from: value => Number(value)
            }
        });

        brilloSlider.noUiSlider.on('update', (values) => {
            minLightDisplay.textContent = values[0]+'%';
            maxLightDisplay.textContent = values[1]+'%';
            document.querySelector('#modalBrillo .btn-success').addEventListener('click', () => {
                brilloBtn.textContent = values[0]+'% - ' + values[1] + '%';
            });
        });

        document.querySelector('#modalBrillo .btn-success').addEventListener('click', () => {
            const values = precioSlider.noUiSlider.get();
            brilloBtn.textContent = '0% - 100%';
        });

        // ===== CATEGORÍA =====
        const categoriaSelect = document.getElementById('categoriaSelect');
        const categoriaBtn = document.getElementById('categoriaBtn');
        const categoriaAplicar = document.getElementById('categoriaAplicar');

        categoriaAplicar.addEventListener('click', () => {
            categoriaBtn.textContent = categoriaSelect.value;
        });
    });
</script>

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/nouislider@15.7.0/dist/nouislider.min.js"></script>
</body>
</html>