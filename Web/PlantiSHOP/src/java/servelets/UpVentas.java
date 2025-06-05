package servelets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;

@WebServlet(name = "UpVentas", urlPatterns = {"/UpVentas"})
@MultipartConfig
public class UpVentas extends HttpServlet {

    @SuppressWarnings({"UseSpecificCatch", "ConvertToTryWithResources"})
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            Connection c = DriverManager.getConnection("jdbc:mysql://host/PSHOP", "Crud", "PlantiSHOP-+CrUd*/https:02468.!?");
            Statement s = c.createStatement();
            Part img = request.getPart("i");
            String ex = "";
            for (short ix = (short) (img.getContentType().length() - 1); ix >= 0; ix--) {
                if (img.getContentType().charAt(ix) == '/') { break; }
                ex += img.getContentType().charAt(ix);
            }
            ResultSet r = s.executeQuery("SELECT Img FROM Productos WHERE Img='"+img.getSubmittedFileName()+"'");
            if (!r.next() && (ex.equals("gpj") || ex.equals("gepj") || ex.equals("gepjp") || ex.equals("fifj") || ex.equals("pjp") || ex.equals("ruc") || ex.equals("oci") || ex.equals("gvs") || ex.equals("fig") || ex.equals("gnp") || ex.equals("gnpa"))) {
                img.write("imgs\\prods\\"+img.getSubmittedFileName());
                if (Boolean.parseBoolean(request.getParameter("x"))) {
                    s.executeUpdate("INSERT INTO Producto(CE,N,D,T,P,Img) VALUES ('"+request.getSession().getAttribute("u")+"','"+request.getParameter("n")+"','"+request.getParameter("txt")+"','"+request.getParameter("t")+"',"+request.getParameter("p")+",'"+img.getSubmittedFileName()+"')");
                    request.getSession().setAttribute("msg", "Producto subido EXITOSAMENTE");
                } else {
                    r = s.executeQuery("SELECT Img FROM Productos WHERE Id="+request.getParameter("id"));
                    r.next();
                    (new File("imgs\\prods\\"+r.getString(1))).delete();
                    s.executeUpdate("UPDATE Producto SET Img='"+img.getSubmittedFileName()+"' WHERE Id="+request.getParameter("id"));
                }
                s.execute("COMMIT");
            } else {
                request.getSession().setAttribute("msg", "Solo se pueden Subir al Sistema Imagenes de tipo JPEG, SVG, ICO, GIF, PNG o APNG, y cuyos Nombres no Repliquen a los de las Imagenes que ya estan en el SERVIDOR");
            }
            r.close();
            img.delete();
            s.close();
            c.close();
        } catch (Exception e) {
            request.getSession().setAttribute("msg", "Lo sentimos, se produjo un ERROR... intentalo de NUEVO...");
        }
        response.sendRedirect("Ventas.jsp");
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
        return "Servicio 1";
    }

}