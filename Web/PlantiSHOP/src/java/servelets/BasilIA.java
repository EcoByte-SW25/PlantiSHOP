package servelets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.DataOutputStream;
import javax.servlet.annotation.MultipartConfig;
import java.net.URL;
import java.net.HttpURLConnection;

@MultipartConfig
@WebServlet(name = "BasilIA", urlPatterns = {"/BasilIA"})
public class BasilIA extends HttpServlet {

    @SuppressWarnings("UseSpecificCatch")
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            if (Boolean.parseBoolean(request.getParameter("x"))) {
                HttpURLConnection c = (HttpURLConnection) (new URL("https://api.openai.com/v1/chat/completions")).openConnection();
                c.setRequestMethod("POST");
                c.setDoOutput(true);
                c.setRequestProperty("Authorization", "/*Llave de OpenAI*/");
                c.setRequestProperty("Content-Type", "application/json");
                try (OutputStream out = c.getOutputStream()) {
                    byte[] json = ("{\"model\"=\"gpt-3.5-turbo\",\"messages\"=[{\"role\"=\"system\",\"content\"=\"Eres un asistente virtual especializado en el cuidado de plantas. Tu trabajo es ayudar a los usuarios a cuidar mejor sus plantas.\nSolo debes responder a preguntas que estén relacionadas con plantas, jardinería, botánica o temas similares. Si el usuario te pregunta algo que no esté relacionado con plantas, responde educadamente que solo puedes ayudar en temas de jardinería y cuidado de plantas.\nSiempre pide al usuario que te diga qué planta tiene y qué desea saber sobre ella, para poder ayudarlo mejor.\"},{\"role\"=\"user\",\"content\"=\""+request.getParameter("req")+"\"}]}").getBytes("UTF-8");
                    out.write(json, 0, json.length);
                }
                String res = "";
                try (BufferedReader bfrd = new BufferedReader(new InputStreamReader(c.getInputStream(), "UTF-8"))) {
                    String aux;
                    while ((aux = bfrd.readLine()) != null) {
                        res += aux.trim();
                    }
                }
                request.getSession().setAttribute("k", Boolean.TRUE);
                request.getSession().setAttribute("rIA", res.replace("\n", "<br>"));
            } else {
                HttpURLConnection c = (HttpURLConnection) (new URL("https://my-api.plantnet.org/v2/identify/all\\*Llave de PlantNET*\\")).openConnection();
                c.setRequestMethod("POST");
                c.setDoOutput(true);
                String boundary = "===" + System.currentTimeMillis() + "===";
                c.setRequestProperty("Content-Type", ("multipart/form-data; boundary=" + boundary));
                try (DataOutputStream o = new DataOutputStream(c.getOutputStream())) {
                    o.writeBytes("--" + boundary + "\r\n");
                    o.writeBytes("Content-Disposition: form-data; name=\"images\"; filename=\"planta.jpg\"\r\n");
                    o.writeBytes("Content-Type: image/jpeg\r\n\r\n");
                    try (InputStream img = request.getPart("img").getInputStream()) {
                        byte[] buffer = new byte[4096];
                        int aux;
                        while ((aux = img.read(buffer)) >= 0) {
                            o.write(buffer, 0, aux);
                        }
                    }
                    o.writeBytes("\r\n--" + boundary + "--\r\n");
                }
                String res = "";
                try (BufferedReader bfrd = new BufferedReader(new InputStreamReader(c.getInputStream()))) {
                    String aux;
                    while ((aux = bfrd.readLine()) != null) {
                        res += aux;
                    }
                }
                request.getPart("img").delete();
                request.getSession().setAttribute("rIA", res);
                request.getSession().setAttribute("k", Boolean.FALSE);
            }
        } catch (Exception e) {
            request.getSession().setAttribute("rIA", "#");
            request.getSession().setAttribute("k", Boolean.FALSE);
        }
        response.sendRedirect("premium/ChatBot.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servicio 3";
    }

}