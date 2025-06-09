package servelets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import java.math.BigDecimal;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.time.LocalDate;
/*
import mx.openpay.client.core.OpenpayAPI;
import mx.openpay.client.Customer;
import mx.openpay.client.BankAccount;
import mx.openpay.client.core.requests.transactions.CreateBankPayoutParams;
*/

@WebServlet(name = "UpSuscripciones", urlPatterns = {"/UpSuscripciones"})
public class UpSuscripciones extends HttpServlet {

    @SuppressWarnings("UseSpecificCatch")
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            try (Connection c = DriverManager.getConnection("jdbc:mysql://192.168.1.66/PSHOP", "Crud", "PlantiSHOP-+CrUd*/https:02468.!?")) {
                try (Statement s = c.createStatement()) {
                    try (ResultSet r = s.executeQuery("SELECT N,AP FROM Usuarios WHERE CE='"+request.getSession().getAttribute("u")+"'")) {
                        r.next();
                        /*
                        OpenpayAPI api = new OpenpayAPI("https://api.openpay.mx", "", "");
                        api.payouts().create(api.customers().create((new Customer()).name(r.getString(1)).lastName(r.getString(2)).email(request.getSession().getAttribute("u")).phoneNumber(request.getParameter("tf")).clabe(request.getParameter("CLABE"))).getId(), (new CreateBankPayoutParams()).bankAccount((new BankAccount()).clabe("").holderName("").alias("EcoByte")).amount(new BigDecimal(request.getParameter("ps"))).description(request.getParameter("SI")));
                        */
                    }
                    switch (request.getParameter("ps")) {
                        case "25.00": {
                            s.executeUpdate("UPDATE Usuario SET P=TRUE,FfS='"+LocalDate.now().plusDays(30L)+"' WHERE CE='"+request.getSession().getAttribute("u")+"'");
                        } break;
                        case "75.00": {
                            s.executeUpdate("UPDATE Usuario SET P=TRUE,FfS='"+LocalDate.now().plusMonths(3L)+"' WHERE CE='"+request.getSession().getAttribute("u")+"'");
                        } break;
                        case "150.00": {
                            s.executeUpdate("UPDATE Usuario SET P=TRUE,FfS='"+LocalDate.now().plusMonths(6L)+"' WHERE CE='"+request.getSession().getAttribute("u")+"'");
                        } break;
                        case "300.00": {
                            s.executeUpdate("UPDATE Usuario SET P=TRUE,FfS='"+LocalDate.now().plusYears(1L)+"' WHERE CE='"+request.getSession().getAttribute("u")+"'");
                        } break;
                    }
                    s.execute("COMMIT");
                }
            }
            request.getSession().setAttribute("msg", "Suscripción realizada EXITOSAMENTE\n¡Bienvenido al Apartado PREMIUM de PlantiSHOP!");
        } catch (Exception e) {
            request.getSession().setAttribute("msg", "Lo sentimos, se produjo un ERROR... intentalo de NUEVO...");
        }
        response.sendRedirect("premium/Premium.jsp");
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
        return "Servicio 2";
    }

}