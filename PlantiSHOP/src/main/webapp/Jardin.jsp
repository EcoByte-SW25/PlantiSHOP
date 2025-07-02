<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%!
    Connection c;
    Statement s;
    ResultSet r;
    String na;
%>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        c = DriverManager.getConnection("jdbc:mysql://localhost/PSHOP", "root", "n0m3l0");
        s = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        r = s.executeQuery("SELECT N,AP,AM FROM Usuario WHERE CE='"+session.getAttribute("u")+"'");
        r.next();
        na = r.getString(1) + " " + r.getString(2) + " " + r.getString(3);
        r.close();
        r = null;
    } catch (Exception e) {
        out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
        out.print("<script>history.back();</script>");
    }
%>
<!DOCTYPE html>
<html lang="es-MX">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Jardin Personal</title>
        <link rel="icon" type="image/x-icon" href="imgs/logo.png">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
              background: #f0f0f0;
              background-size: cover;
              font-family: 'Segoe UI', sans-serif;
            }
            .section-title {
              color: #14532d;
            }
            .plant-block {
              border: 2px solid #ccc;
              border-radius: 10px;
              padding: 1rem;
              background-color: rgba(255, 255, 255, 0.9);
              margin-bottom: 2rem;
            }
            .plant-image {
              width: 100%;
              height: auto;
              max-height: 150px;
              object-fit: contain;
            }
            .btn-eliminar {
              background-color: #dc3545;
              color: white;
            }
            .btn-eliminar:hover {
              background-color: #c82333;
            }
            .btn-cambiar {
              background-color: #198754;
              color: white;
            }
            .btn-cambiar:hover {
              background-color: #157347;
            }
            .filtro-btn {
              background-color: #198754;
              color: white;
            }
            .hidden {
              display: none !important;
            }
        </style>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                window.location.hash = "no-back-button";
                window.location.hash = "Again-No-back-button";
                window.onhashchange = function () {
                    window.location.hash = "";
                };
            });
            function filtrar(tipo) {
                document.querySelectorAll('.plant-section').forEach(sec => {
                    if (tipo === 'TODOS' || sec.dataset.tipo === tipo) {
                        sec.classList.remove('hidden');
                    } else {
                        sec.classList.add('hidden');
                    }
                });
            }
        </script>
    </head>
    <body>
        <div class="container py-4">
            <h1 class="text-center section-title">Jardín Virtual Personal de <%= na %></h1>
            <div class="text-center mb-3">
                <a class="btn btn-outline-success" href="Perfil.jsp">Regresar al Perfil</a>
            </div>
            <div class="text-center mb-4">
                <label class="form-label">Filtrar:</label>
                <select class="form-select w-auto d-inline" onchange="filtrar(this.value)">
                    <option value="TODOS">Mostrar TODO</option>
                    <option value="PD">Plantas Decorativas</option>
                    <option value="PH">Plantas de Huerto</option>
                    <option value="PA">Plantas Acuáticas</option>
                    <option value="A">Árbol</option>
                    <option value="AH">Algas y/u Hongos</option>
                </select>
            </div>
            <form action="Interfaz.jsp" method="post" class="mb-5">
                <input name="x" type="hidden" value="Cj">
                <div class="card shadow p-4">
                    <h2 class="section-title text-center">Registro de Nuevas Plantaciones</h2>
                    <div class="mb-3">
                        <label class="form-label">Nombre:</label>
                        <input name="n" type="text" pattern="[A-Za-z0-9\s']+" maxlength="25" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Tipo:</label>
                        <select name="t" class="form-select" required>
                            <option value="PD">Planta Decorativa</option>
                            <option value="PH">Planta de Huerto</option>
                            <option value="PA">Planta Acuática</option>
                            <option value="A">Árbol</option>
                            <option value="AH">Alga / Hongo</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Consideraciones:</label>
                        <textarea name="txt" pattern="[A-Za-z0-9\s,';.]+" maxlength="250" class="form-control"></textarea>
                    </div>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Porcentaje de Luz:</label>
                            <input name="l" type="number" min="0" max="100" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Nivel de Prioridad:</label>
                            <input name="p" type="number" min="1" max="10" step="1" class="form-control" required>
                        </div>
                    </div>
                    <div class="text-center mt-4">
                        <button type="submit" class="btn btn-success">REGISTRAR</button>
                    </div>
                </div>
            </form>
            <hr>
            <%
                try {
                    String[] tipo = {"PD", "PH", "PA", "A", "AH"};
                    String[] titulo = {"Plantas Decorativas", "Plantas de Huerto", "Plantas Acuaticas", "Arboles", "Algas y/u Hongos"};
                    for (byte t = 0; t < 5; t++) {
                        r = s.executeQuery("SELECT Id,N,C,L,P FROM Jardin WHERE CE='"+session.getAttribute("u")+"' AND T='"+tipo[t]+"' ORDER BY P DESC");
                        if (r.next()) {
                            out.print("<div class='plant-section' data-tipo='"+tipo[t]+"'>");
                                out.print("<h3 class='section-title'>"+titulo[t]+"</h3>");
                                r.beforeFirst();
                                while (r.next()) {
                                    out.print("<div class='row plant-block'>");
                                        out.print("<div class='col-md-4 text-center'>");
                                            out.print("<img src='imgs/"+tipo[t]+".png' alt='"+titulo[t]+"' class='plant-image'/>");
                                            out.print("<a class='btn btn-eliminar mt-2' href='Interfaz.jsp?x=D2&t=Jardin&id="+r.getLong(1)+"'>ELIMINAR</a>");
                                        out.print("</div>");
                                        out.print("<div class='col-md-8'>");
                                            out.print("<h4>"+r.getString(2)+"</h4>");
                                            out.print("<form action='Interfaz.jsp' method='post' class='mb-2'>");
                                                out.print("<input name='x' type='hidden' value='Utxtj'><input name='id' type='hidden' value='"+r.getLong(1)+"'>");
                                                out.print("<textarea name='txt' class='form-control mb-2' pattern=\"[A-Za-z0-9\\s,';.]+\" maxlength='200'>"+r.getString(3)+"</textarea>");
                                                out.print("<button class='btn btn-cambiar'>CAMBIAR esta Consideración</button>");
                                            out.print("</form>");
                                            out.print("<form action='Interfaz.jsp' method='post' class='mb-2'>");
                                                out.print("<input name='x' type='hidden' value='Ulj'><input name='id' type='hidden' value='"+r.getLong(1)+"'>");
                                                out.print("<div class='input-group'><span class='input-group-text'>Porcentaje de Luz:</span><input name='l' type='number' min='0' max='100' value='"+r.getByte(4)+"' class='form-control' required><button class='btn btn-cambiar'>CAMBIAR</button></div>");
                                            out.print("</form>");
                                            out.print("<form action='Interfaz.jsp' method='post' class='mb-2'>");
                                                out.print("<input name='x' type='hidden' value='Upj'><input name='id' type='hidden' value='"+r.getLong(1)+"'>");
                                                out.print("<div class='input-group'><span class='input-group-text'>Nivel de Prioridad:</span><input name='p' type='number' min='1' max='10' step='1' value='"+r.getByte(5)+"' class='form-control' required><button class='btn btn-cambiar'>CAMBIAR</button></div>");
                                            out.print("</form>");
                                        out.print("</div>");
                                    out.print("</div>");
                                }
                            out.print("</div>");
                        }
                        r.close();
                        r = null;
                    }
                    s.close();
                    c.close();
                } catch (Exception e) {
                    out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                    out.print("<script>history.back();</script>");
                }
            %>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>