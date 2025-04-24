<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <title>Preguntas Frecuentes - PlantiSHOP</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        html, body {
            height: 100%;
            margin: 0;
        }

        body {
            display: flex;
            flex-direction: column;
            background-color: #e5e5e5;
            font-family: 'Segoe UI', sans-serif;
        }

        main {
            flex: 1;
        }

        .accordion-button {
            background-color: #2d7a44;
            color: white;
            border-radius: 10px;
        }

        .accordion-button:not(.collapsed) {
            background-color: #256437;
            color: white;
        }

        .accordion-body {
            background-color: #f1f1f1;
            border-radius: 10px;
        }

        .faq-container {
            max-width: 700px;
            margin: 2rem auto;
            padding: 1rem;
        }

        .feedback-box {
            background-color: #ddd;
            padding: 1.5rem;
            border-radius: 10px;
            margin-top: 2rem;
            text-align: center;
            font-size: 0.95rem;
        }

        .feedback-box::placeholder {
            color: #888;
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <main>
        <div class="faq-container">
            <h2 class="fw-bold">FAQ</h2>

            <div class="accordion" id="faqAccordion">
                <%-- Ejemplo de ítems de FAQ --%>
                <div class="accordion-item mb-3">
                    <h2 class="accordion-header" id="headingOne">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                            ¿Preguntan?
                        </button>
                    </h2>
                    <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne"
                         data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            Responden Lorem ipsum dolor sit amet, consectetur adipiscing elit...
                        </div>
                    </div>
                </div>
                
                <div class="accordion-item mb-3">
                    <h2 class="accordion-header" id="headingOne">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                            ¿Preguntan?
                        </button>
                    </h2>
                    <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne"
                         data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            Responden Lorem ipsum dolor sit amet, consectetur adipiscing elit...
                        </div>
                    </div>
                </div>
                
                <div class="accordion-item mb-3">
                    <h2 class="accordion-header" id="headingOne">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                            ¿Preguntan?
                        </button>
                    </h2>
                    <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne"
                         data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            Responden Lorem ipsum dolor sit amet, consectetur adipiscing elit...
                        </div>
                    </div>
                </div>
                
                <div class="accordion-item mb-3">
                    <h2 class="accordion-header" id="headingOne">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                            ¿Preguntan?
                        </button>
                    </h2>
                    <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne"
                         data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            Responden Lorem ipsum dolor sit amet, consectetur adipiscing elit...
                        </div>
                    </div>
                </div>
                
                <div class="accordion-item mb-3">
                    <h2 class="accordion-header" id="headingOne">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                            ¿Preguntan?
                        </button>
                    </h2>
                    <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne"
                         data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            Responden Lorem ipsum dolor sit amet, consectetur adipiscing elit...
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
