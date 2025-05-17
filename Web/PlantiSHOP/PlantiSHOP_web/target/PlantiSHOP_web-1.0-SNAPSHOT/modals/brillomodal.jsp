<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Brillo -->
<div class="modal fade" id="modalBrillo" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content p-3">
            <h5>Luz requerida</h5>
            <label>Rango: <span id="minLight">0%</span> - <span id="maxLight">100%</span></label>
            <div class="px-4" style="margin-top: 50px;">    
                <div id="brilloSlider" class="my-3"></div>
            </div>
            <button class="btn btn-success mt-3" data-bs-dismiss="modal">Aplicar</button>
        </div>
    </div>
</div>

