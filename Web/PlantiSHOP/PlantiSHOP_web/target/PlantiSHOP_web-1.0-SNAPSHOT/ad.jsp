<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Análisis de Datos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="src/ad.css" rel="stylesheet">
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="container mt-5 mb-5">
    <h2 class="fw-bold mb-4">📊 Análisis de Datos - Vendedor Premium</h2>

    <!-- Cifras clave -->
    <!--
    Cada una de estas las puedes convertir en cartas y los datos los puedes traer
    con variables de java embedadas, con servlets o con AJAX
    -->
    <div class="row g-4 mb-4">
        <div class="col-md-3">
            <div class="bg-white rounded-4 shadow p-4 text-center card-analytics">
                <i class="bi bi-cash-coin fs-1 text-success"></i>
                <h5 class="fw-bold mt-2">Ventas Totales</h5>
                <p class="fs-4 text-success">123</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="bg-white rounded-4 shadow p-4 text-center card-analytics">
                <i class="bi bi-tree fs-1 text-success"></i>
                <h5 class="fw-bold mt-2">Planta más Vendida</h5>
                <p class="fs-6">Suculenta Jade</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="bg-white rounded-4 shadow p-4 text-center card-analytics">
                <i class="bi bi-graph-up fs-1 text-success"></i>
                <h5 class="fw-bold mt-2">Ingresos</h5>
                <p class="fs-4 text-success">$4,520</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="bg-white rounded-4 shadow p-4 text-center card-analytics">
                <i class="bi bi-bar-chart-line fs-1 text-success"></i>
                <h5 class="fw-bold mt-2">Promedio por venta</h5>
                <p class="fs-4 text-success">$36.75</p>
            </div>
        </div>
    </div>

    <!-- Gráficas -->
    <div class="row g-4">
        <!-- Gráfica 1: Ventas por mes -->
        <div class="col-md-6">
            <h5 class="fw-bold">Ventas por Mes</h5>
            <!-- Ejes: X = Mes, Y = Número de ventas -->
            <canvas id="ventasMes"></canvas>
        </div>

        <!-- Gráfica 2: Distribución por tipo de planta -->
        <div class="col-md-6">
            <h5 class="fw-bold">Distribución por Tipo de Planta</h5>
            <!-- Ejes: Tipo de planta (% de participación) -->
            <canvas id="tipoPlanta"></canvas>
        </div>

        <!-- Gráfica 3: Ingresos a lo largo del tiempo -->
        <div class="col-12">
            <h5 class="fw-bold">Ingresos Acumulados</h5>
            <!-- Ejes: X = Tiempo (días o semanas), Y = Ingresos acumulados -->
            <canvas id="ingresosLinea"></canvas>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Datos de ejemplo (el backend en R los debe reemplazar dinámicamente)
    // Esto es para el funcionamiento de las graficas, tu con conexion en el back 
    // traes datos igual que para las cartas de datos importantes
    const ventasMesCtx = document.getElementById('ventasMes').getContext('2d');
    const tipoPlantaCtx = document.getElementById('tipoPlanta').getContext('2d');
    const ingresosLineaCtx = document.getElementById('ingresosLinea').getContext('2d');

    new Chart(ventasMesCtx, {
        type: 'bar',
        data: {
            labels: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun'],
            datasets: [{
                label: 'Ventas',
                data: [30, 45, 28, 60, 50, 70],
                backgroundColor: '#198754'
            }]
        },
        options: {
            responsive: true
        }
    });

    new Chart(tipoPlantaCtx, {
        type: 'pie',
        data: {
            labels: ['Suculentas', 'Cactus', 'Aromáticas', 'Ornamentales'],
            datasets: [{
                label: '% de Ventas',
                data: [40, 25, 20, 15],
                backgroundColor: ['#198754', '#28a745', '#4caf50', '#81c784']
            }]
        },
        options: {
            responsive: true
        }
    });

    new Chart(ingresosLineaCtx, {
        type: 'line',
        data: {
            labels: ['Semana 1', 'Semana 2', 'Semana 3', 'Semana 4'],
            datasets: [{
                label: 'Ingresos',
                data: [500, 1200, 2600, 4520],
                borderColor: '#198754',
                fill: false,
                tension: 0.3
            }]
        },
        options: {
            responsive: true
        }
    });
</script>
</body>
</html>

