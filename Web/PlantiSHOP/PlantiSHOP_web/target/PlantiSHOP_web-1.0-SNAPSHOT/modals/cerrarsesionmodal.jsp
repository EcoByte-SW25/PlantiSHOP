<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Modal Cerrar Sesión -->
<div class="modal fade" id="modalCerrarSesion" tabindex="-1" aria-labelledby="cerrarSesionLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4">
            <div class="modal-header">
                <h5 class="modal-title" id="cerrarSesionLabel">Cerrar Sesión</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <div class="modal-body">
                ¿Estás seguro de que deseas cerrar sesión?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary rounded-pill" data-bs-dismiss="modal">Cancelar</button>
                <a href="login.jsp" class="btn btn-success rounded-pill">Cerrar Sesión</a>
            </div>
        </div>
    </div>
</div>
