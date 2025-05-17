<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--Carta de productos para market.jsp-->
<div class="container">
    <div class="card-product row align-items-center">
        <div class="col-md-2 text-center">
            <img src="img/plant.png" alt="Planta" class="img-fluid">
        </div>
        <div class="col-md-6">
            <h5>Planta chida W <small><i>(Nombre científico si es disponible)</i></small></h5>
            <p class="clickable text-success" onclick="location.href='perfilv.jsp'">
                <i class="bi bi-person-circle"></i> Vendedor Apellido Apellido
            </p>
            <p>Descripción breve y chida de la planta w, para saber cuidados básicos y eso</p>
            <p><i class="bi bi-brightness-high"></i> 50%</p>
        </div>
        <div class="col-md-2 text-end">
            <h4>$20MXN</h4>
        </div>
        <div class="col-md-2 text-center">
            <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalOferta">
                <i class="bi bi-cart-plus"></i>
            </button>
        </div>
    </div>
</div>
