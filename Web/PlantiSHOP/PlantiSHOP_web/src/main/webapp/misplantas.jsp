<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Mis Plantas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body style="background-color: #e2e2e2;">
    <%@ include file="navbar.jsp" %>
    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h1 class="fw-bold">Mis Plantas</h1>
            <button class="btn btn-success rounded-circle fs-4" data-bs-toggle="modal" data-bs-target="#modalAgregar">
                <i class="bi bi-plus"></i>
            </button>
        </div>

        <!-- Cartas de mis plantas-->
        <%@ include file="cards/miplantacard.jsp" %>
        <%@ include file="cards/miplantacard.jsp" %>
        <%@ include file="cards/miplantacard.jsp" %>
        <%@ include file="cards/miplantacard.jsp" %>
        <%@ include file="cards/miplantacard.jsp" %>
        <%@ include file="cards/miplantacard.jsp" %>
        <%@ include file="cards/miplantacard.jsp" %>
        <%@ include file="cards/miplantacard.jsp" %>
        <%@ include file="cards/miplantacard.jsp" %>

    </div> 

    <!-- Modal Agregar Planta -->
    <%@ include file="modals/agregarplantamodal.jsp" %>

    <!-- Modal Editar Planta -->
    <%@ include file="modals/editarplantamodal.jsp" %>

    <!-- Modal Eliminar -->
    <%@ include file="modals/editarplantamodal.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
