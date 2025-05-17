<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Chat</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            height: 100vh;
            overflow: hidden;
            background-color: #e5e5e5;
        }
        .sidebar {
            height: 100%;
            overflow-y: auto;
            border-right: 1px solid #ddd;
        }
        .chat-list-item {
            display: flex;
            align-items: center;
            padding: 0.75rem;
            cursor: pointer;
            position: relative;
        }
        .chat-list-item:hover, .chat-list-item.active {
            background-color: #b3dbc8;
        }
        .chat-list-item img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 50%;
            margin-right: 1rem;
        }
        .notification-dot {
            width: 10px;
            height: 10px;
            background-color: red;
            border-radius: 50%;
            position: absolute;
            right: 10px;
            top: 20px;
        }
        .chat-box {
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .messages {
            flex: 1;
            overflow-y: auto;
            padding: 1rem;
            background-color: #fafafa;
        }
        .message {
            margin-bottom: 1rem;
            width: fit-content;
        }
        .message.sent {
            text-align: right;
            justify-self: flex-end;
        }
        .message.received {
            text-align: left;
        }
        .send-message {
            padding: 1rem;
            border-top: 1px solid #ddd;
            background-color: #fff;
            margin-bottom: 110px;
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="container-fluid h-100">
    <div class="row h-100">
        <!-- Sidebar de chats -->
        <div class="col-4 col-md-3 sidebar" style="background-color: #e4eee5">
            <div class="p-3">
                <input type="text" class="form-control mb-3" placeholder="Buscar chats..." id="buscarChats">
                <div id="listaChats">
                    <!-- Ejemplo de un chat -->
                    <div class="chat-list-item active rounded shadow-sm" data-chat-id="1" style="">
                        <img src="img/profileph.png" alt="Foto Perfil">
                        <div class="flex-grow-1">
                            <div><strong>Usuario 1</strong></div>
                            <div class="text-muted small">Último mensaje...</div>
                        </div>
                        <span class="notification-dot d-none"></span> <!-- Quitar d-none si hay mensaje no leído -->
                    </div>

                    <div class="chat-list-item rounded shadow-sm" data-chat-id="2">
                        <img src="img/profileph.png" alt="Foto Perfil">
                        <div class="flex-grow-1">
                            <div><strong>Usuario 2</strong></div>
                            <div class="text-muted small">Hola, ¿cómo estás?</div>
                        </div>
                        <span class="notification-dot"></span>
                    </div>
                        
                    <div class="chat-list-item rounded shadow-sm" data-chat-id="2">
                        <img src="img/profileph.png" alt="Foto Perfil">
                        <div class="flex-grow-1">
                            <div><strong>Usuario 2</strong></div>
                            <div class="text-muted small">Hola, ¿cómo estás?</div>
                        </div>
                        <span class="notification-dot"></span>
                    </div>
                    <div class="chat-list-item rounded shadow-sm" data-chat-id="2">
                        <img src="img/profileph.png" alt="Foto Perfil">
                        <div class="flex-grow-1">
                            <div><strong>Usuario 2</strong></div>
                            <div class="text-muted small">Hola, ¿cómo estás?</div>
                        </div>
                        <span class="notification-dot"></span>
                    </div>
                    <div class="chat-list-item rounded shadow-sm" data-chat-id="2">
                        <img src="img/profileph.png" alt="Foto Perfil">
                        <div class="flex-grow-1">
                            <div><strong>Usuario 2</strong></div>
                            <div class="text-muted small">Hola, ¿cómo estás?</div>
                        </div>
                        <span class="notification-dot"></span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Área del chat seleccionado -->
        <div class="col-8 col-md-9 p-0 d-flex flex-column">
            <div class="chat-box">
                <!-- Barra superior del chat -->
                <div class="d-flex align-items-center p-3 border-bottom" id="chatHeader" style="background-color: #337a4c; color: #fff">
                    <img src="img/profileph.png" alt="Foto Perfil" id="chatUserImg" class="rounded-circle" style="width: 50px; height: 50px; object-fit: cover; margin-right: 1rem;">
                    <div>
                        <div id="chatUserName" class="fw-bold">Nombre del Usuario</div>
                    </div>
                </div>

                <!-- Zona de mensajes -->
                <div class="messages" id="mensajesChat">
                    <div class="message received">
                        <div class="p-2 rounded text-white shadow" style="background-color: #599e71;">¡Hola!</div>
                    </div>
                    <div class="message sent">
                        <div class="p-2 rounded shadow" style="background-color: #ffffff;">Hola, ¿qué tal?</div>
                    </div>
                    <!-- Más mensajes aquí -->
                </div>

                <!-- Zona para enviar mensajes -->
                <div class="send-message">
                    <div class="input-group">
                        <input type="text" id="mensajeInput" class="form-control" placeholder="Escribe un mensaje...">
                        <button class="btn btn-success" id="btnEnviar"><i class="bi bi-send"></i></button>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Pseudofuncionalidad para la interacción básica
    document.querySelectorAll('.chat-list-item').forEach(item => {
        item.addEventListener('click', function() {
            // Quitar active de todos
            document.querySelectorAll('.chat-list-item').forEach(i => i.classList.remove('active'));
            // Poner active al seleccionado
            this.classList.add('active');

            // (Pseudocódigo) Cargar los mensajes del chat correspondiente
            const chatId = this.getAttribute('data-chat-id');
            console.log('Cargar mensajes del chat ID:', chatId);

            // Resetear notificación
            const dot = this.querySelector('.notification-dot');
            if (dot) dot.classList.add('d-none');
        });
    });

    // Enviar mensaje (solo frontend)
    document.getElementById('btnEnviar').addEventListener('click', function() {
        const input = document.getElementById('mensajeInput');
        const mensaje = input.value.trim();
        if (mensaje !== "") {
            const mensajes = document.getElementById('mensajesChat');
            const nuevoMensaje = document.createElement('div');
            nuevoMensaje.className = 'message sent';
            nuevoMensaje.innerHTML = `<div class="bg-primary text-white p-2 rounded">${mensaje}</div>`;
            mensajes.appendChild(nuevoMensaje);
            input.value = "";
            mensajes.scrollTop = mensajes.scrollHeight;
            // (Pseudocódigo) Aquí deberías también enviar el mensaje al servidor/backend
        }
    });
</script>
</body>
</html>

