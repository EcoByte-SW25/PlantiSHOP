<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Modal Editar Perfil -->
<div class="modal fade" id="modalEditarPerfil" tabindex="-1" aria-labelledby="editarPerfilLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4">
            <div class="modal-header">
                <h5 class="modal-title" id="editarPerfilLabel">Editar Perfil</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <form action="editarPerfil.jsp" method="post" enctype="multipart/form-data">
                <div class="modal-body">
                    <!-- Selector visual para imagen -->
                    <div class="mb-4 text-center">
                        <label for="nuevaFoto" class="d-block position-relative" style="cursor: pointer;">
                            <div id="previewContainer" class="border border-2 border-dashed rounded-4 mx-auto"
                                 style="width: 150px; height: 150px; display: flex; align-items: center; justify-content: center; overflow: hidden;">
                                <img id="previewImagen" src="img/profileph.png" alt="Previsualización" class="img-fluid" style="max-height: 100%; max-width: 100%; display: none;">
                                <span id="placeholderIcon" class="text-muted"><i class="bi bi-camera fs-1"></i></span>
                            </div>
                            <input type="file" id="nuevaFoto" name="nuevaFoto" class="d-none" accept="image/*">
                        </label>
                        <small class="text-muted d-block mt-2">Haz clic para cambiar la foto</small>
                    </div>

                    <!-- Nombre -->
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" value="Juan Pérez" required>
                    </div>

                    <!-- Descripción -->
                    <div class="mb-3">
                        <label for="descripcion" class="form-label">Descripción</label>
                        <textarea class="form-control" id="descripcion" name="descripcion" rows="2" required>La descripción de Juan Pérez</textarea>
                    </div>

                    <!-- Correo (no editable) -->
                    <div class="mb-3">
                        <label for="correo" class="form-label">Correo electrónico</label>
                        <input type="email" class="form-control" id="correo" value="juanpagon16@gmail.com" disabled>
                    </div>

                    <!-- Edad -->
                    <div class="mb-3">
                        <label for="edad" class="form-label">Edad</label>
                        <input type="number" class="form-control" id="edad" name="edad" value="18" min="1" required>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary rounded-pill" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-success rounded-pill">Guardar Cambios</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Script para mostrar imagen seleccionada -->
<script>
    document.getElementById('nuevaFoto').addEventListener('change', function (e) {
        const file = e.target.files[0];
        const preview = document.getElementById('previewImagen');
        const placeholder = document.getElementById('placeholderIcon');

        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
                preview.style.display = 'block';
                placeholder.style.display = 'none';
            };
            reader.readAsDataURL(file);
        }
    });
</script>
