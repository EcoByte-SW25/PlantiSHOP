<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Modal Editar Planta -->
<div class="modal fade" id="modalEditar" tabindex="-1" aria-labelledby="modalEditarLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content rounded-4">
      <div class="modal-header">
        <h5 class="modal-title">Editar Planta</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <form>
        <div class="modal-body">
          <!-- Vista previa imagen -->
          <div class="mb-3 text-center">
            <img id="previewEditar" src="https://via.placeholder.com/120x120?text=Foto" 
                 style="width: 120px; height: 120px; object-fit: cover; cursor: pointer;" 
                 class="rounded-3 border border-secondary"
                 onclick="document.getElementById('fotoEditar').click()">
            <input type="file" id="fotoEditar" accept="image/*" style="display: none" 
                   onchange="previewImage(this, 'previewEditar')">
          </div>
          <!-- Campos -->
          <div class="mb-3">
            <label>Nombre</label>
            <input type="text" class="form-control" value="Plantona Loca" required>
          </div>
          <div class="mb-3">
            <label>Nombre científico</label>
            <input type="text" class="form-control" value="">
          </div>
          <div class="mb-3">
            <label>Descripción</label>
            <textarea class="form-control" rows="2" required>La descripcion de la plantona w</textarea>
          </div>
          <div class="mb-3">
            <label>Nivel de luz (%)</label>
            <input type="number" class="form-control" value="25" required>
          </div>
          <div class="mb-3">
            <label>Cantidad de lotes</label>
            <input type="number" class="form-control" value="25" required>
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

<script>
function previewImage(input, previewId) {
    const file = input.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = e => document.getElementById(previewId).src = e.target.result;
        reader.readAsDataURL(file);
    }
}
</script>