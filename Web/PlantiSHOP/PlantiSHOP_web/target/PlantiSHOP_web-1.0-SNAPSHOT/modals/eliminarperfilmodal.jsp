<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Modal Eliminar Perfil -->
<div class="modal fade" id="modalEliminarCuenta" tabindex="-1" aria-labelledby="eliminarCuentaLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4">
            <div class="modal-header">
                <h5 class="modal-title" id="eliminarCuentaLabel">Eliminar Perfil</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <div class="modal-body">
                Esta acción eliminará tu cuenta permanentemente. ¿Deseas continuar?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary rounded-pill" data-bs-dismiss="modal">Cancelar</button>
                <a href="eliminarPerfil.jsp" class="btn btn-danger rounded-pill">Eliminar</a>
            </div>
        </div>
    </div>
</div>
