<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Modal Oferta -->
<div class="modal fade" id="modalOferta" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content" style="color: black;">
      <div class="modal-body">
        
        <!-- Información Planta -->
        <div class="row align-items-center">
          <div class="col-md-2 text-center">
            <img src="img/plant.png" alt="Planta" class="img-fluid">
          </div>
          <div class="col-10">
            <h5>Nombre Planta</h5>
            <p>$20.00</p>
          </div>
        </div>

        <hr style="border-color: white;">

        <!-- Datos de Oferta -->
        <div class="row mb-3">
          <div class="col-6">
            <label for="numLotes" class="form-label">No. Lotes:</label>
            <input type="number" id="numLotes" class="form-control">
          </div>
          <div class="col-6">
            <label for="lugar" class="form-label">Lugar:</label>
            <input type="text" id="lugar" class="form-control">
          </div>
        </div>

        <!-- Espacio para el Mapa -->
        <div class="row mb-3">
          <div class="col-12">
            <label class="form-label">Ubicación:</label>
            <div id="mapa" style="width: 100%; height: 250px; background-color: #e9ecef; border: 1px solid #ced4da;">
              <!-- Aquí irá el mapa -->
            </div>
          </div>
        </div>

        <!-- Más datos de Oferta -->
        <div class="row mb-3">
          <div class="col-6">
            <label for="total" class="form-label">Total:</label>
            <input type="text" id="total" class="form-control">
          </div>
          <div class="col-6">
            <label for="fechaHora" class="form-label">Fecha/Hora:</label>
            <input type="datetime-local" id="fechaHora" class="form-control">
          </div>
        </div>

        <!-- Botón Enviar -->
        <div class="text-center mt-4">
          <button class="btn btn-success" style="background-color: #128048;" 
                  data-bs-toggle="modal" 
                  data-bs-target="#modalConfirmacion" 
                  data-bs-dismiss="modal">
            ENVIAR
          </button>
        </div>

      </div>
    </div>
  </div>
</div>
