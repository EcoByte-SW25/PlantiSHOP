<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Tarjeta de planta -->
<div class="card mb-4 shadow-sm rounded-4">
    <div class="card-body d-flex">
        <!-- Imagen de planta -->
        <div class="me-3">
            <div style="width: 120px; height: 120px; background-color: #c0c5be;"></div>
        </div>
        <!-- Detalles de planta -->
        <div class="flex-grow-1">
            <h4 class="fw-bold">Plantona Loca</h4>
            <p class="fst-italic text-muted m-0">Nombre científico (si es disponible)</p>
            <p>La descripcion de la plantona w</p>
            <div class="d-flex justify-content-between align-items-center">
                <div><i class="bi bi-brightness-high"></i> 25%</div>
                <div class="text-end">
                    Lotes: 25
                    <button class="btn btn-success btn-sm rounded-circle ms-2" data-bs-toggle="modal" data-bs-target="#modalEditar">
                        <i class="bi bi-pencil"></i>
                    </button>
                    <button class="btn btn-danger btn-sm rounded-circle" data-bs-toggle="modal" data-bs-target="#modalEliminar">
                        <i class="bi bi-trash"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
