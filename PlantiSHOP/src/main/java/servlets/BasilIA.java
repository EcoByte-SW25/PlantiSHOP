package servlets;

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
import org.json.JSONObject;
import java.net.URL;
import auxs.Llavero;
import java.net.HttpURLConnection;

@WebServlet(name = "BasilIA", urlPatterns = {"/BasilIA"})
@MultipartConfig
public class BasilIA extends HttpServlet {

    @SuppressWarnings("UseSpecificCatch")
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            if (Boolean.parseBoolean(request.getParameter("x"))) {
                HttpURLConnection c = (HttpURLConnection) (new URL("https://api.openai.com/v1/chat/completions")).openConnection();
                c.setRequestMethod("POST");
                c.setDoOutput(true);
                c.setRequestProperty("Authorization", ("Bearer " + Llavero.getApiOpenAi()));
                c.setRequestProperty("Content-Type", "application/json");
                try (OutputStream out = c.getOutputStream()) {
                    String jsonPayload = "{"
                        + "\"model\": \"gpt-3.5-turbo\","
                        + "\"messages\": ["
                        + "  {\"role\": \"system\", \"content\": \"Eres un asistente virtual especializado en el cuidado de plantas. Tu trabajo es ayudar a los usuarios a cuidar mejor sus plantas. "
                        + "Solo debes responder a preguntas que estén relacionadas con plantas, jardinería, botánica o temas similares. Si el usuario te pregunta algo que no esté relacionado con plantas, "
                        + "responde educadamente que solo puedes ayudar en temas de jardinería y cuidado de plantas. "
                        + "Siempre pide al usuario que te diga qué planta tiene y qué desea saber sobre ella, para poder ayudarlo mejor.\"},"
                        + "  {\"role\": \"user\", \"content\": \"" + request.getParameter("req") + "\"}"
                        + "]"
                        + "}";
                    byte[] json = jsonPayload.getBytes("UTF-8");
                    out.write(json, 0, json.length);
                }
                String res = "";
                try (BufferedReader bfrd = new BufferedReader(new InputStreamReader(c.getInputStream(), "UTF-8"))) {
                    String aux;
                    while ((aux = bfrd.readLine()) != null) {
                        res += aux.trim();
                    }
                }
                request.getSession().setAttribute("rIA", (new JSONObject(res)).getJSONArray("choices").getJSONObject(0).getJSONObject("message").getString("content").replace("\n", "<br>"));
            } else {
                HttpURLConnection c = (HttpURLConnection) (new URL("https://my-api.plantnet.org/v2/identify/all?api-key=" + Llavero.getApiPlantNet())).openConnection();
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
                JSONObject json = new JSONObject(res);
                String opts = "";
                for (byte i = 0; i < ((byte) Math.min(3, json.getJSONArray("results").length())); i++) {
                    opts += "Nombre Cientifico de la Plantación: '" + json.getJSONArray("results").getJSONObject(i).getJSONObject("species").getString("scientificNameWithoutAuthor") + "' (" + (json.getJSONArray("results").getJSONObject(i).getDouble("score") * 100d) + "% de CERTEZA)<br>";
                }
                request.getSession().setAttribute("rIA", opts);
            }
        } catch (Exception e) {
            request.getSession().setAttribute("rIA", "Lo lamento, ha ocurrido un ERROR... intentalo de NUEVO...");
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
