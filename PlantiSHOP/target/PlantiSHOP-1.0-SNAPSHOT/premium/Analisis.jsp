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
        c = DriverManager.getConnection("jdbc:mysql://localhost/PSHOP", "root", "n0m3l0");
        s = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        r = s.executeQuery("SELECT P FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
        r.next();
        if (!r.getBoolean(1)) {
            out.print("<script>alert('Lo sentimos, NO eres un Usuario PREMIUM... por lo que NO puedes hacer uso de este APARTADO...');</script>");
            out.print("<script>location.assign('../index.html');</script>");
            r.close();
        } else {
            r.close();
            r = null;
            r = s.executeQuery("SELECT TP FROM Compra WHERE V='"+session.getAttribute("u")+"' AND X=4 ORDER BY TP");
            double x, dt, md;
            x_md = x = md = g_h = vt = i = sp = 0;
            dt = 1d;
            cv = true;
            if (r.next()) {
                g_h = 1d;
                long n = 0;
                r.beforeFirst();
                while (r.next()) {
                    vt += r.getDouble(1);
                    g_h *= r.getDouble(1);
                    n = n + 1L;
                }
                x_md = x = vt / n;
                g_h = Math.pow(g_h, (1d / n));
                if ((n - 1L) % 2 == 0) {
                    r.absolute((int) ((n - 1L) / 2L));
                    md = r.getDouble(1);
                } else {
                    r.absolute(Math.floorDiv(((int) (n - 1L)), 2));
                    md = r.getDouble(1);
                    r.next();
                    md = (md + r.getDouble(1)) / 2;
                }
                r.beforeFirst();
                dt = 0;
                while (r.next()) {
                    dt += Math.pow((x_md - r.getDouble(1)), 2);
                }
                dt = Math.sqrt(dt / ((n > 30L) ? n : (n - 1L)));
                if (dt / x_md > 0.3d) {
                    cv = false;
                    x_md = md;
                    r.beforeFirst();
                    g_h = 0;
                    while (r.next()) {
                        g_h += 1d / r.getDouble(1);
                    }
                    g_h = n / g_h;
                }
            }
            r.close();
            r = null;
            r = s.executeQuery("SELECT N,Pop FROM Producto WHERE CE='"+session.getAttribute("u")+"' AND Pop>0 ORDER BY Pop DESC");
            mo = "<li>NINGUNO</li>";
            lDP = "\"Sin DATOS\"";
            vDP = "0";
            if (r.next()) {
                mo = lDP = vDP = "";
                long aux = 0;
                r.beforeFirst();
                while (r.next()) {
                    lDP += "\"" + r.getString(1) + "\",";
                    vDP += r.getLong(2) + ",";
                    aux = aux + 1L;
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
                } else if (n == aux) {
                    mo = "<li>TODOS</li>";
                } else {
                    sp = (3d * (x - md)) / dt;
                }
            }
            r.close();
            r = null;
            xVM = yVM = xIAlT = yIAlT = "";
            for (byte m = 6; m > 0; m--) {
                r = s.executeQuery("SELECT TP FROM Compra WHERE V='"+session.getAttribute("u")+"' AND X=4 AND Fh>='"+LocalDate.now().minusMonths(m).withDayOfMonth(1).toString()+" 00:00:00' AND Fh<'"+LocalDate.now().minusMonths(m - 1).withDayOfMonth(1).toString()+" 00:00:00'");
                if (r.next()) {
                    x = 0;
                    r.beforeFirst();
                    while (r.next()) {
                        x += r.getDouble(1);
                    }
                    xVM += x + ",";
                } else {
                    xVM += "0,";
                }
                yVM += "\"" + LocalDate.now().minusMonths(m).getMonth().getDisplayName(TextStyle.FULL, Locale.forLanguageTag("es-MX")) + "\",";
                r.close();
                r = null;
            }
            xVM = xVM.substring(0, (xVM.length() - 2));
            yVM = yVM.substring(0, (yVM.length() - 2));
            x = 0;
            for (byte sm = 16; sm > 0; sm--) {
                r = s.executeQuery("SELECT TP FROM Compra WHERE V='"+session.getAttribute("u")+"' AND X=4 AND Fh>='"+LocalDate.now().minusWeeks(sm).toString()+" 00:00:00' AND Fh<'"+LocalDate.now().minusWeeks(sm - 1).toString()+" 00:00:00'");
                while (r.next()) {
                    x += r.getDouble(1);
                }
                yIAlT += x + ",";
                xIAlT += "\"-" + sm + "S\",";
                r.close();
                r = null;
            }
            xIAlT = xIAlT.substring(0, (xIAlT.length() - 2));
            yIAlT = yIAlT.substring(0, (yIAlT.length() - 2));
            r = s.executeQuery("SELECT TP FROM Compra WHERE X=4 ORDER BY TP");
            x_mdG = x = md = g_hG = vtG = spG = 0;
            dt = 1d;
            cvG = true;
            if (r.next()) {
                g_hG = 1d;
                long n = 0;
                r.beforeFirst();
                while (r.next()) {
                    vtG += r.getDouble(1);
                    g_hG *= r.getDouble(1);
                    n = n + 1L;
                }
                x_mdG = x = vtG / n;
                g_hG = Math.pow(g_hG, (1d / n));
                if ((n - 1L) % 2 == 0) {
                    r.absolute((int) ((n - 1L) / 2L));
                    md = r.getDouble(1);
                } else {
                    r.absolute(Math.floorDiv(((int) (n - 1L)), 2));
                    md = r.getDouble(1);
                    r.next();
                    md = (md + r.getDouble(1)) / 2;
                }
                r.beforeFirst();
                dt = 0;
                while (r.next()) {
                    dt += Math.pow((x_mdG - r.getDouble(1)), 2);
                }
                dt = Math.sqrt(dt / ((n > 30L) ? n : (n - 1L)));
                if (dt / x_mdG > 0.3d) {
                    cvG = false;
                    x_mdG = md;
                    r.beforeFirst();
                    g_hG = 0;
                    while (r.next()) {
                        g_hG += 1d / r.getDouble(1);
                    }
                    g_hG = n / g_hG;
                }
            }
            r.close();
            r = null;
            r = s.executeQuery("SELECT N,Pop FROM Producto WHERE Pop>0 ORDER BY Pop DESC");
            moG = "<li>NINGUNO</li>";
            if (r.next()) {
                long aux = 0;
                r.beforeFirst();
                while (r.next()) {
                    aux = aux + 1L;
                }
                moG = "";
                long n, pop;
                n = pop = 0;
                r.beforeFirst();
                while (r.next() && r.getLong(2) >= pop) {
                    n = n + 1L;
                    pop = r.getLong(2);
                    moG += "<li>"+r.getString(1)+"</li>";
                }
                if (n == 1L) {
                    spG = (x - pop) / dt;
                } else if (n == aux) {
                    moG = "<li>TODOS</li>";
                } else {
                    spG = (3d * (x - md)) / dt;
                }
            }
            r.close();
            r = null;
            r = s.executeQuery("SELECT A FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
            r.next();
            i = vt - r.getDouble(1);
            s.executeUpdate("UPDATE Usuario SET A="+vt+" WHERE CE='"+session.getAttribute("u")+"'");
            r.close();
            s.execute("COMMIT");
        }
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f0f0f0;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .navbar-custom {
                background: linear-gradient(135deg, #2d5016 0%, #4a7c2a 100%);
                padding: 0.8rem 0;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .btn-custom {
                border-radius: 25px;
                font-weight: 600;
                padding: 0.6rem 1.5rem;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-block;
                margin: 0 0.3rem;
            }
            .btn-success-custom {
                background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
                border: none;
                color: white;
            }
            .btn-success-custom:hover {
                background: linear-gradient(135deg, #1e7e34 0%, #17a2b8 100%);
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            }
            .btn-info-custom {
                background: linear-gradient(135deg, #17a2b8 0%, #6f42c1 100%);
                border: none;
                color: white;
            }
            .btn-info-custom:hover {
                background: linear-gradient(135deg, #138496 0%, #563d7c 100%);
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            }
            .main-title {
                background: linear-gradient(135deg, #2d5016 0%, #4a7c2a 100%);
                color: white;
                padding: 2rem;
                border-radius: 15px;
                margin: 2rem 0;
                text-align: center;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            }
            .main-title h1 {
                margin: 0;
                font-size: 1.8rem;
                font-weight: 700;
            }
            .stats-table {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                margin: 2rem 0;
            }
            .table-custom {
                margin: 0;
            }
            .table-custom thead {
                background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
                color: white;
            }
            .table-custom th {
                border: none;
                padding: 1rem;
                font-weight: 600;
            }
            .table-custom td {
                padding: 1rem;
                vertical-align: middle;
                border-bottom: 1px solid #e9ecef;
                color: #495057;
            }
            .table-custom tbody tr:hover {
                background-color: rgba(40, 167, 69, 0.05);
            }
            .chart-container {
                background: white;
                border-radius: 15px;
                padding: 1.5rem;
                margin: 2rem 0;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            }
            .analysis-text {
                background: white;
                border-radius: 15px;
                padding: 2rem;
                margin: 2rem 0;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                border-left: 5px solid #28a745;
            }
            .analysis-text p {
                color: #495057;
                font-size: 1.1rem;
                line-height: 1.6;
                margin-bottom: 1rem;
                text-align: justify;
            }
            .icon-stat {
                color: #28a745;
                margin-right: 0.5rem;
            }
            .value-highlight {
                color: #2d5016;
                font-weight: 700;
            }
            .stats-header {
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                padding: 1rem;
                border-bottom: 2px solid #28a745;
                text-align: center;
            }
            .stats-header h3 {
                margin: 0;
                color: #2d5016;
                font-weight: 700;
            }
        </style>
        <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                window.location.hash = "no-back-button";
                window.location.hash = "Again-No-back-button";
                window.onhashchange = function () {
                    window.location.hash = "";
                };
            });
            Plotly.newPlot("rVM", [{
                x: [<%= xVM %>],
                y: [<%= yVM %>],
                type: "bar",
                orientation: "h",
                marker: {
                    color: "rgba(40, 167, 69, 0.8)",
                    line: {
                        color: "rgba(45, 80, 22, 1)",
                        width: 1
                    }
                }
            }], {
                title: {
                    text: "Ventas por Mes",
                    font: {
                        color: "#2d5016",
                        size: 18
                    }
                },
                xaxis: {
                    title: "Número de Ventas",
                    color: "#495057"
                },
                yaxis: { color: "#495057" },
                plot_bgcolor: "rgba(0,0,0,0)",
                paper_bgcolor: "rgba(0,0,0,0)"
            });
            Plotly.newPlot("rDP", [{
                labels: [<%= lDP %>],
                values: [<%= vDP %>],
                hole: 0.35,
                type: "pie",
                marker: {
                    colors: ['rgba(40, 167, 69, 0.8)', 'rgba(32, 201, 151, 0.8)', 'rgba(23, 162, 184, 0.8)', 'rgba(111, 66, 193, 0.8)', 'rgba(253, 126, 20, 0.8)']
                }
            }], {
                title: {
                    text: "Distribución por Producto",
                    font: {
                        color: "#2d5016",
                        size: 18
                    }
                },
                plot_bgcolor: "rgba(0,0,0,0)",
                paper_bgcolor: "rgba(0,0,0,0)"
            });
            Plotly.newPlot("rIAlT", [{
                x: [<%= xIAlT %>],
                y: [<%= yIAlT %>],
                type: "scatter",
                mode: "lines+markers",
                line: {
                    color: "rgba(40, 167, 69, 1)",
                    width: 3
                },
                marker: {
                    color: "rgba(45, 80, 22, 1)",
                    size: 6
                }
            }], {
                title: {
                    text: "Ingresos Acumulados a lo largo del Tiempo",
                    font: {
                        color: "#2d5016",
                        size: 18
                    }
                },
                xaxis: {
                    title: "Semanas",
                    color: "#495057"
                },
                yaxis: {
                    title: "Ingresos Acumulados",
                    color: "#495057"
                },
                plot_bgcolor: "rgba(0,0,0,0)",
                paper_bgcolor: "rgba(0,0,0,0)"
            });
        </script>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-custom">
            <div class="container">
                <div class="ms-auto">
                    <a href="../Premium.jsp" class="btn btn-custom btn-success-custom">
                        <i class="fas fa-arrow-left"></i>REGRESAR
                    </a>
                    <a href="ChatBot.jsp" class="btn btn-custom btn-info-custom">
                        <i class="fas fa-robot"></i>Basil.IA
                    </a>
                </div>
            </div>
        </nav>
        <div class="container">
            <div class="main-title">
                <h1><i class="fas fa-chart-line me-3"></i>Analista Estadístico-Predictivo de PlantiSHOP</h1>
                <p class="mb-0 mt-2">Análisis de tus Actividades Comerciales y del Mercado Botánico General</p>
            </div>
            <div class="stats-table">
                <div class="stats-header">
                    <h3><i class="fas fa-table me-2"></i>Estadísticas Comparativas</h3>
                </div>
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th scope="col"></th>
                            <th scope="col"><i class="fas fa-user icon-stat"></i>Tus Medidas</th>
                            <th scope="col"><i class="fas fa-globe icon-stat"></i>Mercado General</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th scope="row"><i class="fas fa-dollar-sign icon-stat"></i>Ventas Totales:</th>
                            <td class="value-highlight">$ <%= vt %></td>
                            <td class="value-highlight">$ <%= vtG %></td>
                        </tr>
                        <tr>
                            <th scope="row"><i class="fas fa-crown icon-stat"></i>Producto(s) más Vendido(s):</th>
                            <td>
                                <ul class="list-unstyled mb-0">
                                    <%= mo %>
                                </ul>
                            </td>
                            <td>
                                <ul class="list-unstyled mb-0">
                                    <%= moG %>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><i class="fas fa-chart-up icon-stat"></i>Ingresos:</th>
                            <td class="value-highlight">+$ <%= i %></td>
                            <td></td>
                        </tr>
                        <tr>
                            <th scope="row"><i class="fas fa-calculator icon-stat"></i>Promedio de Ventas:</th>
                            <td class="value-highlight">$ <%= x_md %></td>
                            <td class="value-highlight">$ <%= x_mdG %></td>
                        </tr>
                        <tr>
                            <th scope="row"><i class="fas fa-balance-scale icon-stat"></i>2° Promedio de Ventas:</th>
                            <td class="value-highlight">$ <%= g_h + (cv ? " (Geométrico)" : " (Armónico)") %></td>
                            <td class="value-highlight">$ <%= g_hG + (cvG ? " (Geométrico)" : " (Armónico)") %></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="chart-container">
                        <div id="rVM"></div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="chart-container">
                        <div id="rDP"></div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="chart-container">
                        <div id="rIAlT"></div>
                    </div>
                </div>
            </div>
            <div class="analysis-text">
                <h4><i class="fas fa-lightbulb icon-stat"></i>Análisis Predictivo</h4>
                <%
                    if (sp > 0) {
                        out.print("<p>La Distribución de tus Ventas tiene una Tendencia Positiva, por lo que tus Índices de Venta son Altos y, probablemente, si Continúas con la Metodología Comercial que has estado Implementando, seguirás Obteniendo Buenas Ganancias en el Futuro Cercano 🌱</p>");
                    } else if (sp == 0) {
                        out.print("<p>La Distribución de tus Ventas es Normal y tus Índices de Venta están dentro de lo Ordinario, por lo que no hay Tendencias Significativas, así que tal vez Deberías de Revisar tu Metodología Comercial para que, de esta manera, Mejores tus Ganancias en el Futuro 🌿</p>");
                    } else {
                        out.print("<p>La Distribución de tus Ventas tiene una Tendencia Negativa, por lo que tus Índices de Venta son Bajos, así que Debes de Modificar tu Metodología Comercial Actual, tal vez Debas de Publicar otro Tipo de Productos, Hacerlos más Atractivos o Regular los Precios de tu Mercancía Actual, de esta manera, probablemente, Mejores tus Ganancias en el Futuro Cercano 📈</p>");
                    }
                    if (spG > 0) {
                        out.print("<p>En tanto, el Mercado de PlantiSHOP cuenta con Índices de Venta Altos, por lo que se Prevé que la Actividad Comercial del Futuro Cercano probablemente sea Segura y Productiva, así que Trata de Imitar las Tendencias del Mercado 🚀</p>");
                    } else if (spG == 0) {
                        out.print("<p>En tanto, el Mercado de PlantiSHOP presenta Índices de Venta Ordinarios, por lo que la Actividad Comercial se ha Mantenido Estable, Moderada y sin Tendencias Significativas, pero te Sugerimos Mantenerte Pendiente 👀</p>");
                    } else {
                        out.print("<p>En tanto, el Mercado de PlantiSHOP cuenta con Índices de Venta Bajos, por lo que se Prevé que la Actividad Comercial del Futuro Cercano probablemente sea Escasa e Inestable, así que, en la medida de lo posible, Cuida de tus Ingresos y Trata de Diseñar Metodologías de Venta que Impulsen tu Negocio, como Publicar Productos más Atractivos o Regular los Precios de tus Actuales Mercancías ⚠️</p>");
                    }
                %>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>