<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Precio -->
<div class="modal fade" id="modalPrecio" tabindex="-1" style="padding: 5rem;">
    <div class="modal-dialog">
        <div class="modal-content p-3">
            <h5>Rango de precio</h5>
            <label>Rango: <span id="minPrice">0</span>$ - <span id="maxPrice">5000</span>$</label>
            <div class="px-4" style="margin-top: 50px;">
                <div id="precioSlider" class="my-3"></div>
            </div>
            <button class="btn btn-success mt-3" data-bs-dismiss="modal">Aplicar</button>
        </div>
    </div>
</div>
