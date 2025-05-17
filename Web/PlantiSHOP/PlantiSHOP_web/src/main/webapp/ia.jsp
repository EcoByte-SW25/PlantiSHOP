<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>IA Premium - PlantiShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="src/ia.css" rel="stylesheet">
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="container mt-5 mb-5">
    <h2 class="fw-bold mb-4">🤖 Asistente Inteligente - PlantiShop Premium</h2>

    <!-- Chatbot -->
    <div class="bg-white rounded-4 shadow p-4 mb-5">
        <h5 class="fw-bold mb-3">Chatbot de Cuidado de Plantas</h5>
        <div class="chat-window d-flex flex-column mb-3" id="chatWindow">
            <!-- Mensajes aparecerán aquí -->
            <div class="message bot">¡Hola! Soy tu asistente de jardinería. ¿En qué puedo ayudarte hoy?</div>
        </div>
        <form class="d-flex" onsubmit="return sendMessage()">
            <input type="text" class="form-control me-2 chat-input" id="chatInput" placeholder="Escribe tu pregunta...">
            <button class="btn btn-success" type="submit"><i class="bi bi-send"></i></button>
        </form>
    </div>

    <!-- Reconocimiento por imagen -->
    <div class="bg-white rounded-4 shadow p-4">
        <h5 class="fw-bold mb-3">Identificación de Planta por Imagen</h5>
        <p class="mb-3">Sube una foto de una planta y nuestra IA intentará reconocer la especie.</p>

        <input type="file" class="form-control mb-3" accept="image/*" onchange="previewImage(event)" id="plantImage">
        <img id="imagePreview" class="preview-img d-none"/>

        <button class="btn btn-outline-success" onclick="identifyPlant()">🔍 Identificar Planta</button>

        <div class="mt-3" id="resultBox"></div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // CHATBOT - Conexión con API (simulación temporal)
    function sendMessage() {
        const input = document.getElementById('chatInput');
        const chatWindow = document.getElementById('chatWindow');
        const userMessage = input.value.trim();

        if (!userMessage) return false;

        const userDiv = document.createElement('div');
        userDiv.className = 'message user';
        userDiv.innerText = userMessage;
        chatWindow.appendChild(userDiv);
        input.value = '';

        // Simulación de respuesta (aquí va la llamada real a la API del chatbot)
        setTimeout(() => {
            const botDiv = document.createElement('div');
            botDiv.className = 'message bot';
            botDiv.innerText = '🌿 Estoy procesando tu consulta...';
            chatWindow.appendChild(botDiv);
            chatWindow.scrollTop = chatWindow.scrollHeight;
        }, 500);

        return false;
    }

    // IMAGEN - Vista previa
    function previewImage(event) {
        const img = document.getElementById('imagePreview');
        img.src = URL.createObjectURL(event.target.files[0]);
        img.classList.remove('d-none');
    }

    // Identificar planta usando Plant.id API (estructura de ejemplo)
    function identifyPlant() {
        const file = document.getElementById('plantImage').files[0];
        const resultBox = document.getElementById('resultBox');

        if (!file) {
            resultBox.innerHTML = '<p class="text-danger">⚠️ Por favor selecciona una imagen.</p>';
            return;
        }

        const reader = new FileReader();
        reader.onloadend = function () {
            const base64Image = reader.result.replace(/^data:image\/[a-z]+;base64,/, '');

            // Aquí se realizaría la llamada real a la API de Plant.id desde el backend (por seguridad)
            resultBox.innerHTML = '<p class="text-info">🔄 Procesando imagen... (simulado)</p>';

            // SIMULACIÓN de respuesta:
            setTimeout(() => {
                resultBox.innerHTML = `
                    <div class="alert alert-success mt-3">
                        🌱 Posible especie: <strong>Monstera deliciosa</strong><br>
                        🔎 Nivel de confianza: 87%
                    </div>`;
            }, 1500);
        };
        reader.readAsDataURL(file);
    }
</script>

</body>
</html>

