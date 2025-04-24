package com.ecobyte.plantishop_app.helpers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/verificar-codigo")
public class Verification extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String codigoIngresado = request.getParameter("codigo");
        HttpSession session = request.getSession();
        String codigoEnviado = (String) session.getAttribute("codigoVerificacion");

        if (codigoEnviado != null && codigoIngresado != null && codigoIngresado.equals(codigoEnviado)) {
            // Código correcto, redirigir al siguiente paso del registro
            response.sendRedirect("registerp2.jsp");
        } else {
            // Código incorrecto, volver con mensaje de error
            request.setAttribute("error", "El código ingresado es incorrecto.");
            request.getRequestDispatcher("verificacion.jsp").forward(request, response);
        }
    }
}
