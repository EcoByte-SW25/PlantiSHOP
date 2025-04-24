package com.ecobyte.plantishop_app.handlers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Random;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

@WebServlet("/registerp1")
public class Register extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String pass1 = request.getParameter("password");
        String pass2 = request.getParameter("password2");

        if (email == null || pass1 == null || pass2 == null || !pass1.equals(pass2)) {
            request.setAttribute("error", "Las contraseñas no coinciden.");
            request.getRequestDispatcher("registerp1.jsp").forward(request, response);
            return;
        }

        // Generar código de verificación de 6 dígitos
        String codigo = String.format("%06d", new Random().nextInt(999999));

        // Guardar datos temporalmente en la sesión
        HttpSession session = request.getSession();
        session.setAttribute("tempEmail", email);
        session.setAttribute("tempPassword", pass1);
        session.setAttribute("codigoVerificacion", codigo);

        // Enviar email con código
        try {
            enviarCodigoPorCorreo(email, codigo);
        } catch (Exception e) {
            request.setAttribute("error", "No se pudo enviar el correo: " + e.getMessage());
            request.getRequestDispatcher("registerp1.jsp").forward(request, response);
            return;
        }

        // Redirigir a verificación
        response.sendRedirect("verification.jsp");
    }

    private void enviarCodigoPorCorreo(String destino, String codigo) throws Exception {
        final String remitente = "ecobyte.sw@gmail.com";
        final String clave = "ynjw nkwo afxb gxxo"; // Usa contraseña de app si es Gmail

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(remitente, clave);
            }
        });

        Message mensaje = new MimeMessage(session);
        mensaje.setFrom(new InternetAddress(remitente));
        mensaje.setRecipient(Message.RecipientType.TO, new InternetAddress(destino));
        mensaje.setSubject("Código de verificación - PlantiSHOP");
        mensaje.setText("Tu código de verificación es: " + codigo);

        Transport.send(mensaje);
    }
}