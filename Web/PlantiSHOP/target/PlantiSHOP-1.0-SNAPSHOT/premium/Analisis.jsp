<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Locale"%>
<%@page import="java.time.format.TextStyle"%>
<%!
    Connection c;
    Statement s;
    ResultSet r;
    boolean cv, cvG;
    String mo, moG, xVM, yVM, lDP, vDP, xIAlT, yIAlT;
    double x_md, x_mdG, g_h, g_hG, vt, vtG, i, sp, spG;
%>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        c = DriverManager.getConnection("jdbc:mysql://192.168.1.66/PSHOP", "Crud", "PlantiSHOP-+CrUd*/https:02468.!?");
        s = c.createStatement();
        r = s.executeQuery("SELECT P FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
        r.next();
        if (!r.getBoolean(1)) {
            out.print("<script>alert('Lo sentimos, NO eres un Usuario PREMIUM... por lo que NO puedes hacer uso de este APARTADO...');</script>");
            out.print("<script>location.assign('../index.html');</script>");
        } else {
            r = s.executeQuery("SELECT TP FROM Compra WHERE V='"+session.getAttribute("u")+"' AND X=4 ORDER BY TP");
            double x, dt, md;
            x_md = x = md = g_h = vt = i = sp = 0;
            dt = 1d;
            cv = true;
            if (r.getFetchSize() > 0) {
                g_h = 1d;
                while (r.next()) {
                    vt += r.getDouble(1);
                    g_h *= r.getDouble(1);
                }
                x_md = x = vt / r.getFetchSize();
                g_h = Math.pow(g_h, (1d / r.getFetchSize()));
                if ((r.getFetchSize() - 1) % 2 == 0) {
                    r.absolute((r.getFetchSize() - 1) / 2);
                    md = r.getDouble(1);
                } else {
                    r.absolute(Math.floorDiv((r.getFetchSize() - 1), 2));
                    md = r.getDouble(1);
                    r.next();
                    md = (md + r.getDouble(1)) / 2;
                }
                r.beforeFirst();
                dt = 0;
                while (r.next()) {
                    dt += Math.pow((x_md - r.getDouble(1)), 2);
                }
                dt = Math.sqrt(dt / ((r.getFetchSize() > 30) ? r.getFetchSize() : (r.getFetchSize() - 1)));
                if (dt / x_md > 0.3d) {
                    cv = false;
                    x_md = md;
                    r.beforeFirst();
                    g_h = 0;
                    while (r.next()) {
                        g_h += 1d / r.getDouble(1);
                    }
                    g_h = r.getFetchSize() / g_h;
                }
            }
            r = s.executeQuery("SELECT N,Pop FROM Producto WHERE CE='"+session.getAttribute("u")+"' AND Pop>0 ORDER BY Pop DESC");
            mo = "<li>NINGUNO</li>";
            lDP = "\"Sin DATOS\"";
            vDP = "0";
            if (r.getFetchSize() > 0) {
                mo = lDP = vDP = "";
                while (r.next()) {
                    lDP += "\"" + r.getString(1) + "\",";
                    vDP += r.getLong(2) + ",";
                }
                lDP = lDP.substring(0, (lDP.length() - 2));
                vDP = vDP.substring(0, (vDP.length() - 2));
                r.beforeFirst();
                long n, pop;
                n = pop = 0;
                while (r.next() && r.getLong(2) >= pop) {
                    n = n + 1L;
                    pop = r.getLong(2);
                    mo += "<li>"+r.getString(1)+"</li>";
                }
                if (n == 1L) {
                    sp = (x - pop) / dt;
                } else if (n == r.getFetchSize()) {
                    mo = "<li>TODOS</li>";
                } else {
                    sp = (3d * (x - md)) / dt;
                }
            }
            xVM = yVM = xIAlT = yIAlT = "";
            for (byte m = 6; m > 0; m--) {
                r = s.executeQuery("SELECT TP FROM Compra WHERE V='"+session.getAttribute("u")+"' AND X=4 AND Fh>='"+LocalDate.now().minusMonths(m).withDayOfMonth(1)+" 00:00:00' AND Fh<'"+LocalDate.now().minusMonths(m - 1).withDayOfMonth(1)+" 00:00:00'");
                if (r.getFetchSize() > 0) {
                    x = 0;
                    while (r.next()) {
                        x += r.getDouble(1);
                    }
                    xVM += x + ",";
                } else {
                    xVM += "0,";
                }
                yVM += "\"" + LocalDate.now().minusMonths(m).getMonth().getDisplayName(TextStyle.FULL, Locale.forLanguageTag("es-MX")) + "\",";
            }
            xVM = xVM.substring(0, (xVM.length() - 2));
            yVM = yVM.substring(0, (yVM.length() - 2));
            x = 0;
            for (byte sm = 16; sm > 0; sm--) {
                r = s.executeQuery("SELECT TP FROM Compra WHERE V='"+session.getAttribute("u")+"' AND X=4 AND Fh>='"+LocalDate.now().minusWeeks(sm)+" 00:00:00' AND Fh<'"+LocalDate.now().minusWeeks(sm - 1)+" 00:00:00'");
                while (r.next()) {
                    x += r.getDouble(1);
                }
                yIAlT += x + ",";
                xIAlT += "\"-" + sm + "S\",";
            }
            xIAlT = xIAlT.substring(0, (xIAlT.length() - 2));
            yIAlT = yIAlT.substring(0, (yIAlT.length() - 2));
            r = s.executeQuery("SELECT TP FROM Compra WHERE X=4 ORDER BY TP");
            x_mdG = x = md = g_hG = vtG = spG = 0;
            dt = 1d;
            cvG = true;
            if (r.getFetchSize() > 0) {
                g_hG = 1d;
                while (r.next()) {
                    vtG += r.getDouble(1);
                    g_hG *= r.getDouble(1);
                }
                x_mdG = x = vtG / r.getFetchSize();
                g_hG = Math.pow(g_hG, (1d / r.getFetchSize()));
                if ((r.getFetchSize() - 1) % 2 == 0) {
                    r.absolute((r.getFetchSize() - 1) / 2);
                    md = r.getDouble(1);
                } else {
                    r.absolute(Math.floorDiv((r.getFetchSize() - 1), 2));
                    md = r.getDouble(1);
                    r.next();
                    md = (md + r.getDouble(1)) / 2;
                }
                r.beforeFirst();
                dt = 0;
                while (r.next()) {
                    dt += Math.pow((x_mdG - r.getDouble(1)), 2);
                }
                dt = Math.sqrt(dt / ((r.getFetchSize() > 30) ? r.getFetchSize() : (r.getFetchSize() - 1)));
                if (dt / x_mdG > 0.3d) {
                    cvG = false;
                    x_mdG = md;
                    r.beforeFirst();
                    g_hG = 0;
                    while (r.next()) {
                        g_hG += 1d / r.getDouble(1);
                    }
                    g_hG = r.getFetchSize() / g_hG;
                }
            }
            r = s.executeQuery("SELECT N,Pop FROM Producto WHERE Pop>0 ORDER BY Pop DESC");
            moG = "<li>NINGUNO</li>";
            if (r.getFetchSize() > 0) {
                moG = "";
                long n, pop;
                n = pop = 0;
                while (r.next() && r.getLong(2) >= pop) {
                    n = n + 1L;
                    pop = r.getLong(2);
                    moG += "<li>"+r.getString(1)+"</li>";
                }
                if (n == 1L) {
                    spG = (x - pop) / dt;
                } else if (n == r.getFetchSize()) {
                    moG = "<li>TODOS</li>";
                } else {
                    spG = (3d * (x - md)) / dt;
                }
            }
            r = s.executeQuery("SELECT A FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
            r.next();
            i = vt - r.getDouble(1);
            s.executeUpdate("UPDATE Usuario SET A="+vt+" WHERE CE='"+session.getAttribute("u")+"'");
            s.execute("COMMIT");
        }
        r.close();
        s.close();
        c.close();
    } catch (Exception e) {
        out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
        out.print("<script>history.back();</script>");
    }
%>
<!DOCTYPE html>
<html lang="es-MX">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Analisis de Datos del Usuario</title>
        <link rel="icon" type="image/x-icon" href="../imgs/logo.png">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                background-image: url(../imgs/fondo4.png);
                background-repeat: no-repeat;
                background-size: cover;
                background-attachment: fixed;
                background-position: center center;
            }
            p {
                text-align: justify;
                color: orange;
                font-weight: 600;
                font-family: Coco Gothic;
            }
            #RiA {
                text-align: right;
            }
            button {
                padding: 2em;
                border: none;
                border-radius: 5px;
                font-size: 1vw;
                font-weight: 600;
                font-family: Coco Gothic;
            }
            #r {
                background-color: gold;
            }
            #r:hover {
                color: white;
                background-color: goldenrod;
            }
            #iA {
                background-color: cyan;
            }
            #iA:hover {
                color: white;
                background-color: navy;
            }
            h1 {
                text-align: center;
                color: gold;
                font-family: Agrandir;
            }
            table {
                border: 2px inset gold;
                background-color: rgba(255, 255, 187, 0.75);
            }
            th, td {
                color: brown;
                font-family: Coco Gothic;
            }
            div {
                width: 98%;
                margin-left: auto;
                margin-right: auto;
            }
        </style>
        <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                window.location.hash = "no-back-button";
                window.location.hash = "Again-No-back-button";
                window.onhashchange = function () {
                    window.location.hash = "no-back-button";
                };
            });
            Plotly.newPlot("rVM", [{
                x: [<%= xVM %>],
                y: [<%= yVM %>],
                type: "bar",
                orientation: "h",
                marker: { color: "rgba(0,255,0,0.85)" }
            }], {
                title: "Ventas por Mes",
                xaxis: { title: "Número de Ventas" }
            });
            Plotly.newPlot("rDP", [{
                labels: [<%= lDP %>],
                values: [<%= vDP %>],
                hole: 0.35,
                type: "pie"
            }], { title: "Distribución por Producto" });
            Plotly.newPlot("rIAlT", [{
                x: [<%= xIAlT %>],
                y: [<%= yIAlT %>],
                type: "scatter",
                mode: "lines",
                marker: { color: "rgb(0,0,255)" }
            }], {
                title: "Ingresos Acumulados a lo largo del Tiempo",
                xaxis: { title: "Semanas" },
                yaxis: { title: "Ingresos Acumulados" }
            });
        </script>
    </head>
    <body>
        <p id="RiA"><button id="r" onclick="location.assign('Premium.jsp')">REGRESAR</button><button id="iA" onclick="location.assign('ChatBot.jsp')">Basil.IA</button></p>
        <h1>Analista Estadistico-Predictivo de tus Actividades Comerciales en la Aplicación y del Mercado Botanico de PlantiSHOP</h1>
        <table>
            <caption>Estadisticas</caption>
            <tr>
                <td></td>
                <th>Tus MEDIDAS</th>
                <th>Medidas del Mercado General</th>
            </tr>
            <tr>
                <th>Ventas Totales:</th>
                <td>$ <%= vt %></td>
                <td>$ <%= vtG %></td>
            </tr>
            <tr>
                <th>Producto(s) más Vendido(s):</th>
                <td>
                    <ul>
                        <%= mo %>
                    </ul>
                </td>
                <td>
                    <ul>
                        <%= moG %>
                    </ul>
                </td>
            </tr>
            <tr>
                <th>Ingresos:</th>
                <td>+$ <%= i %></td>
                <td></td>
            </tr>
            <tr>
                <th>Promedio de Ventas:</th>
                <td>$ <%= x_md %></td>
                <td>$ <%= x_mdG %></td>
            </tr>
            <tr>
                <th>2° Promedio de Ventas:</th>
                <td>$ <%= g_h + (cv ? " (Geometrico)" : " (Armonico)") %></td>
                <td>$ <%= g_hG + (cvG ? " (Geometrico)" : " (Armonico)") %></td>
            </tr>
        </table>
        <div id="rVM"></div>
        <div id="rDP"></div>
        <div id="rIAlT"></div>
        <br>
        <%
            if (sp > 0) {
                out.print("<p>La Distribución de tus Ventas tiene una Tendencia Positiva, por lo que tus Indices de Venta son Altos y, probablemente, si Continuas con la Metodologia Comercial que has estado Implementando, seguiras Obteniendo Buenas Ganancias en el Futuro Cercano ;D</p>");
            } else if (sp == 0) {
                out.print("<p>La Distribución de tus Ventas es Normal y tus Indices de Venta estan dentro de lo Ordinario, por lo que no hay Tendencias Significativas, asi que tal vez Deberias de Revisar tu Metodologia Comercial para que, de esta manera, Mejores tus Ganancias en el Futuro :3</p>");
            } else {
                out.print("<p>La Distribución de tus Ventas tiene una Tendencia Negativa, por lo que tus Indices de Venta son Bajos, asi que Debes de Modificar tu Metodologia Comercial Actual, tal vez Debas de Publicar otro Tipo de Productos, Hacerlos más Atractivos o Regular los Precios de tu Mercancia Actual, de esta manera, probablemente, Mejores tus Ganancias en el Futuro Cercano ;3</p>");
            }
            if (spG > 0) {
                out.print("<p>En tanto, el Mercado de PlantiSHOP cuenta con Indices de Venta Altos, por lo que se Prevee que la Actividad Comercial del Futuro Cercano probablemente sea Segura y Productiva, asi que Trata de Imitar las Tendencias del Mercado ;D</p>");
            } else if (spG == 0) {
                out.print("<p>En tanto, el Mercado de PlantiSHOP presenta Indices de Venta Ordinarios, por lo que la Actividad Comercial se ha Mantenido Estable, Moderada y sin Tendencias Significativas, pero te Sugerimos Mantenerte Pendiente :3</p>");
            } else {
                out.print("<p>En tanto, el Mercado de PlantiSHOP cuenta con Indices de Venta Bajos, por lo que se Prevee que la Actividad Comercial del Futuro Cercano probablemente sea Escasa e Inestable, asi que, en la medida de lo posible, Cuida de tus Ingresos y Trata de Diseñar Metodologias de Venta que Impulsen tu Negocio, como Publicar Productos más Atractivos o Regular los Precios de tus Actuales Mercancias ;3</p>");
            }
        %>
    </body>
</html>