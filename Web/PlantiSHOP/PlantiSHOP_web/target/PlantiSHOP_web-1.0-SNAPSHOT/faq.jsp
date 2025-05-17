<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <title>FAQ</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="src/faq.css">   
</head>
<body>
    
    <%@ include file="navbar.jsp" %>

    <main>
        <div class="faq-container">
            <h2 class="fw-bold">FAQ</h2>

            <div class="accordion" id="faqAccordion">
                <!-- PREGUENTAS FRECUENTES -->
                <!-- 
                Esta seccion llenala con las preguntas que ya habias implementado
                en tu version, la unica conexion con back es la de preguntas o
                feedback del usuario.
                -->
                <div class="accordion-item mb-3">
                    <h2 class="accordion-header" id="heading1">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapse1" aria-expanded="false" aria-controls="collapse1">
                            ¿Cuál es el tiempo de entrega?
                        </button>
                    </h2>
                    <div id="collapse1" class="accordion-collapse collapse" aria-labelledby="heading1"
                         data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            El tiempo de entrega es de 3 a 5 días hábiles dependiendo de tu ubicación.
                        </div>
                    </div>
                </div>

                <div class="accordion-item mb-3">
                    <h2 class="accordion-header" id="heading2">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapse2" aria-expanded="false" aria-controls="collapse2">
                            ¿Puedo devolver una planta si llega dañada?
                        </button>
                    </h2>
                    <div id="collapse2" class="accordion-collapse collapse" aria-labelledby="heading2"
                         data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            Sí, puedes devolver cualquier planta dañada dentro de los primeros 3 días después de recibirla.
                        </div>
                    </div>
                </div>

                <div class="accordion-item mb-3">
                    <h2 class="accordion-header" id="heading3">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapse3" aria-expanded="false" aria-controls="collapse3">
                            ¿Hacen envíos a todo México?
                        </button>
                    </h2>
                    <div id="collapse3" class="accordion-collapse collapse" aria-labelledby="heading3"
                         data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            Sí, realizamos envíos a todos los estados de la República Mexicana.
                        </div>
                    </div>
                </div>

                <div class="accordion-item mb-3">
                    <h2 class="accordion-header" id="heading4">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapse4" aria-expanded="false" aria-controls="collapse4">
                            ¿Qué métodos de pago aceptan?
                        </button>
                    </h2>
                    <div id="collapse4" class="accordion-collapse collapse" aria-labelledby="heading4"
                         data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            Aceptamos tarjetas de crédito, débito, PayPal y pagos en OXXO.
                        </div>
                    </div>
                </div>

                <div class="accordion-item mb-3">
                    <h2 class="accordion-header" id="heading5">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapse5" aria-expanded="false" aria-controls="collapse5">
                            ¿Puedo programar una entrega para una fecha específica?
                        </button>
                    </h2>
                    <div id="collapse5" class="accordion-collapse collapse" aria-labelledby="heading5"
                         data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            Claro, puedes elegir una fecha de entrega durante el proceso de compra.
                        </div>
                    </div>
                </div>
            </div>

            <p class="mt-4"><strong>¿Quieres mejorar PlantiSHOP? Escribe tu Feedback</strong></p>

            <form onsubmit="return enviarFeedback()" class="mb-4">
                <div class="mb-3">
                    <textarea id="feedback" class="form-control" rows="4" maxlength="500"
                              placeholder="Escribe un comentario o pregunta para nuestros desarrolladores..." required></textarea>
                    <div class="form-text text-end"><span id="charCount">0</span>/500</div>
                </div>
                <button type="submit" class="btn btn-success">Enviar</button>
            </form>
        </div>
    </main>

    <%@ include file="footer.jsp" %>

    <!-- Modal de confirmación -->
    <div class="modal fade" id="modalFeedback" tabindex="-1" aria-labelledby="modalFeedbackLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title" id="modalFeedbackLabel">¡Gracias por tu comentario!</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    Tu mensaje ha sido enviado a nuestros desarrolladores. ¡Lo tomaremos en cuenta!
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        const feedbackInput = document.getElementById('feedback');
        const charCount = document.getElementById('charCount');

        feedbackInput.addEventListener('input', () => {
            charCount.textContent = feedbackInput.value.length;
        });

        function enviarFeedback() {
            const mensaje = feedbackInput.value.trim();

            if (mensaje.length === 0) {
                alert("Por favor escribe un mensaje antes de enviar.");
                return false;
            }

            // Limpiar campo
            feedbackInput.value = "";
            charCount.textContent = "0";

            // Mostrar modal
            const modal = new bootstrap.Modal(document.getElementById('modalFeedback'));
            modal.show();

            return false; // Prevenir recarga de página
        }
    </script>
</body>
</html>
