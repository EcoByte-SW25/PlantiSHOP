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
        if (session.getAttribute("msg") != null) {
            out.print("<script>alert('"+session.getAttribute("msg")+"');</script>");
            session.removeAttribute("msg");
        }
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
        <title>Ventas del Usuario</title>
        <link rel="icon" type="image/x-icon" href="imgs/logo.png">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-green: #2d5a27;
                --secondary-green: #4a7c59;
                --accent-green: #7fb069;
                --light-green: #a7c957;
                --bg-color: #f0f0f0;
                --card-bg: #ffffff;
                --text-dark: #2c3e50;
            }
            body {
                background-color: var(--bg-color);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                color: var(--text-dark);
            }
            .header-section {
                background: linear-gradient(135deg, var(--primary-green), var(--secondary-green));
                color: white;
                padding: 2rem 0;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                margin-bottom: 2rem;
            }
            .header-section h1 {
                margin: 0;
                font-weight: 600;
                font-size: 2.2rem;
            }
            .register-form {
                background: var(--card-bg);
                border-radius: 15px;
                padding: 2rem;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                margin-bottom: 2rem;
                border-left: 5px solid var(--accent-green);
            }
            .register-form h2 {
                color: var(--primary-green);
                margin-bottom: 1.5rem;
                font-weight: 600;
            }
            .form-control, .form-select {
                border: 2px solid #e9ecef;
                border-radius: 8px;
                padding: 0.75rem;
                transition: all 0.3s ease;
            }
            .form-control:focus, .form-select:focus {
                border-color: var(--accent-green);
                box-shadow: 0 0 0 0.2rem rgba(127, 176, 105, 0.25);
            }
            .btn-register {
                background: linear-gradient(135deg, var(--primary-green), var(--secondary-green));
                border: none;
                color: white;
                padding: 0.75rem 2rem;
                border-radius: 8px;
                font-weight: 600;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            .btn-register:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.2);
                background: linear-gradient(135deg, var(--secondary-green), var(--primary-green));
            }
            .product-section {
                margin-bottom: 2rem;
            }
            .section-header {
                background: linear-gradient(135deg, var(--accent-green), var(--light-green));
                color: white;
                padding: 1rem 1.5rem;
                border-radius: 10px 10px 0 0;
                margin-bottom: 0;
                font-weight: 600;
                text-align: center;
            }
            .product-card {
                background: var(--card-bg);
                border-radius: 0 0 15px 15px;
                overflow: hidden;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                margin-bottom: 1.5rem;
                transition: transform 0.3s ease;
            }
            .product-card:hover {
                transform: translateY(-5px);
            }
            .product-row {
                display: flex;
                align-items: stretch;
                min-height: 200px;
            }
            .product-image-section {
                flex: 0 0 250px;
                padding: 1rem;
                background: linear-gradient(135deg, #f8f9fa, #e9ecef);
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 0.5rem;
            }
            .product-image {
                width: 100%;
                height: 120px;
                object-fit: cover;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }
            .product-details {
                flex: 1;
                padding: 1.5rem;
            }
            .product-title {
                color: var(--primary-green);
                font-size: 1.5rem;
                font-weight: 600;
                margin-bottom: 1rem;
                border-bottom: 2px solid var(--light-green);
                padding-bottom: 0.5rem;
            }
            .btn-action {
                border-radius: 6px;
                font-size: 0.85rem;
                padding: 0.4rem 1rem;
                margin: 0.25rem;
                transition: all 0.3s ease;
                font-weight: 500;
            }
            .btn-update {
                background-color: var(--secondary-green);
                border-color: var(--secondary-green);
                color: white;
            }
            .btn-update:hover {
                background-color: var(--primary-green);
                border-color: var(--primary-green);
                transform: translateY(-1px);
            }
            .btn-delete {
                background-color: #dc3545;
                border-color: #dc3545;
                color: white;
            }
            .btn-delete:hover {
                background-color: #c82333;
                border-color: #bd2130;
                transform: translateY(-1px);
            }
            .btn-change-image {
                background-color: var(--accent-green);
                border-color: var(--accent-green);
                color: white;
                font-size: 0.8rem;
            }
            .btn-change-image:hover {
                background-color: var(--secondary-green);
                border-color: var(--secondary-green);
            }
            .input-group-sm .form-control {
                padding: 0.5rem;
            }
            .form-floating textarea {
                min-height: 80px;
            }
            .pD .section-header { background: linear-gradient(135deg, #e8f5e8, #d4edda); color: var(--primary-green); }
            .pH .section-header { background: linear-gradient(135deg, #fff3cd, #ffeaa7); color: #856404; }
            .pA .section-header { background: linear-gradient(135deg, #d1ecf1, #bee5eb); color: #0c5460; }
            .A .section-header { background: linear-gradient(135deg, #d4edda, #c3e6cb); color: var(--primary-green); }
            .aH .section-header { background: linear-gradient(135deg, #f8d7da, #f5c6cb); color: #721c24; }
            .F .section-header { background: linear-gradient(135deg, #ffeaa7, #fdcb6e); color: #856404; }
            .H .section-header { background: linear-gradient(135deg, #e2e3e5, #d6d8db); color: #383d41; }
            @media (max-width: 768px) {
                .product-row {
                    flex-direction: column;
                }
                .product-image-section {
                    flex: none;
                }
                .header-section h1 {
                    font-size: 1.8rem;
                }
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
        </script>
    </head>
    <body>
        <%@include file="imgs/navbar.jsp"%>
        
        <div class="header-section">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col">
                        <h1><i class="fas fa-leaf me-3"></i>Ventas de <%= na %></h1>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="register-form">
                <h2><i class="fas fa-plus-circle me-2"></i>Registro de Productos en el Sistema</h2>
                <form action="UpVentas" method="post" enctype="multipart/form-data">
                    <input name="x" type="hidden" value="true">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <div class="form-floating">
                                <input id="i1" name="n" type="text" class="form-control" pattern="[A-Za-z0-9\s,']+" maxlength="80" placeholder="Nombre del Producto" required>
                                <label for="i1"><i class="fas fa-seedling me-2"></i>Nombre del Producto</label>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="form-floating">
                                <select id="i3" name="t" class="form-select" required>
                                    <optgroup label="Plantaciones">
                                        <option value="PD" selected>Planta Decorativa</option>
                                        <option value="PH">Planta de Huerto</option>
                                        <option value="PA">Planta Acuática</option>
                                        <option value="A">Árbol</option>
                                        <option value="AH">Alga / Hongo</option>
                                    </optgroup>
                                    <option value="F">Fertilizante</option>
                                    <option value="H">Herramienta</option>
                                </select>
                                <label for="i3"><i class="fas fa-tags me-2"></i>Tipo</label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <div class="form-floating">
                                <input id="i4" name="p" type="number" class="form-control" min="1" max="5000000" placeholder="Precio ($1.00 - $5,000,000)" required>
                                <label for="i4"><i class="fas fa-dollar-sign me-2"></i>Precio del Producto</label>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="form-floating">
                                <input id="i5" name="c" type="number" class="form-control" min="1" max="1000000" step="1" placeholder="Cantidad (1 - 1,000,000)" required>
                                <label for="i5"><i class="fas fa-boxes me-2"></i>Cantidad del Producto</label>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="i6" class="form-label"><i class="fas fa-image me-2"></i>Imagen del Producto</label>
                            <input id="i6" name="i" type="file" class="form-control" accept="image/*" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <div class="form-floating">
                            <textarea id="i2" name="txt" class="form-control" pattern="[A-Za-z0-9\s,';.]+" maxlength="800" placeholder="Descripción" style="height: 100px;"></textarea>
                            <label for="i2"><i class="fas fa-align-left me-2"></i>Descripción del Producto</label>
                        </div>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-register">
                            <i class="fas fa-save me-2"></i>REGISTRAR
                        </button>
                    </div>
                </form>
            </div>
            <hr>
            <%
                try {
                    r = s.executeQuery("SELECT Img,Id,N,P,D,Cupo FROM Producto WHERE CE='"+session.getAttribute("u")+"' AND T='PD' ORDER BY Pop DESC, Cupo ASC");
                    if (r.next()) {
                        out.print("<div class='product-section pD'>");
                            out.print("<div class='section-header'><i class='fas fa-leaf me-2'></i>Plantas Decorativas</div>");
                            r.beforeFirst();
                            while (r.next()) {
                                out.print("<div class='product-card'>");
                                    out.print("<div class='product-row'>");
                                        out.print("<div class='product-image-section'>");
                                            out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Planta Decorativa' class='product-image'/>");
                                            out.print("<form action='UpVentas' method='post' enctype='multipart/form-data' class='w-100'>");
                                                out.print("<input name='x' type='hidden' value='false'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                out.print("<input name='i' type='file' class='form-control form-control-sm mb-2' accept='image/*' required>");
                                                out.print("<button type='submit' class='btn btn-change-image btn-sm w-100'>CAMBIAR Imagen</button>");
                                            out.print("</form>");
                                            out.print("<button class='btn btn-delete btn-sm w-100' onclick=\"location.assign('Interfaz.jsp?x=D2&t=Producto&id="+r.getLong(2)+"')\"><i class='fas fa-trash me-1'></i>ELIMINAR</button>");
                                        out.print("</div>");
                                    out.print("</div>");
                                    out.print("<div class='product-details'>");
                                        out.print("<h3 class='product-title'>"+r.getString(3)+"</h3>");
                                        out.print("<div class='row mb-3'>");
                                            out.print("<div class='col-md-6'>");
                                                out.print("<form action='Interfaz.jsp' method='post' class='d-flex align-items-center'>");
                                                    out.print("<input name='x' type='hidden' value='Upv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                    out.print("<div class='input-group input-group-sm'><span class='input-group-text'><i class='fas fa-dollar-sign'></i>Precio:</span><input name='p' type='number' min='1' max='5000000' class='form-control' value='"+r.getFloat(4)+"' required><button class='btn btn-update btn-action' type='submit'>CAMBIAR</button></div>");
                                                out.print("</form>");
                                            out.print("</div>");
                                            out.print("<div class='col-md-6'>");
                                                out.print("<form action='Interfaz.jsp' method='post' class='d-flex align-items-center'>");
                                                    out.print("<input name='x' type='hidden' value='Ucv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                    out.print("<div class='input-group input-group-sm'><span class='input-group-text'><i class='fas fa-boxes'></i>Cantidad:</span><input name='c' type='number' min='1' max='1000000' step='1' class='form-control' value='"+r.getInt(6)+"' required><button class='btn btn-update btn-action' type='submit'>CAMBIAR</button></div>");
                                                out.print("</form>");
                                            out.print("</div>");
                                            out.print("<form action='Interfaz.jsp' method='post'>");
                                                out.print("<input name='x' type='hidden' value='Utxtv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                out.print("<div class='input-group'>");
                                                    out.print("<textarea name='txt' class='form-control' pattern='[A-Za-z0-9\\s]+' maxlength='800' placeholder='Descripción del Producto'>"+r.getString(5)+"</textarea>");
                                                    out.print("<button class='btn btn-update btn-action' type='submit'><i class='fas fa-edit me-1'></i>CAMBIAR Descripción</button>");
                                                out.print("</div>");
                                            out.print("</form>");
                                        out.print("</div>");
                                    out.print("</div>");
                                out.print("</div>");
                            }
                        out.print("</div>");
                    }
                    r.close();
                    r = null;
                    r = s.executeQuery("SELECT Img,Id,N,P,D,Cupo FROM Producto WHERE CE='"+session.getAttribute("u")+"' AND T='PH' ORDER BY Pop DESC, Cupo ASC");
                    if (r.next()) {
                        out.print("<div class='product-section pH'>");
                            out.print("<div class='section-header'><i class='fas fa-leaf me-2'></i>Plantas de Huerto</div>");
                            r.beforeFirst();
                            while (r.next()) {
                                out.print("<div class='product-card'>");
                                    out.print("<div class='product-row'>");
                                        out.print("<div class='product-image-section'>");
                                            out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Planta de Huerto' class='product-image'/>");
                                            out.print("<form action='UpVentas' method='post' enctype='multipart/form-data' class='w-100'>");
                                                out.print("<input name='x' type='hidden' value='false'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                out.print("<input name='i' type='file' class='form-control form-control-sm mb-2' accept='image/*' required>");
                                                out.print("<button type='submit' class='btn btn-change-image btn-sm w-100'>CAMBIAR Imagen</button>");
                                            out.print("</form>");
                                            out.print("<button class='btn btn-delete btn-sm w-100' onclick=\"location.assign('Interfaz.jsp?x=D2&t=Producto&id="+r.getLong(2)+"')\"><i class='fas fa-trash me-1'></i>ELIMINAR</button>");
                                        out.print("</div>");
                                    out.print("</div>");
                                    out.print("<div class='product-details'>");
                                        out.print("<h3 class='product-title'>"+r.getString(3)+"</h3>");
                                        out.print("<div class='row mb-3'>");
                                            out.print("<div class='col-md-6'>");
                                                out.print("<form action='Interfaz.jsp' method='post' class='d-flex align-items-center'>");
                                                    out.print("<input name='x' type='hidden' value='Upv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                    out.print("<div class='input-group input-group-sm'><span class='input-group-text'><i class='fas fa-dollar-sign'></i>Precio:</span><input name='p' type='number' min='1' max='5000000' class='form-control' value='"+r.getFloat(4)+"' required><button class='btn btn-update btn-action' type='submit'>CAMBIAR</button></div>");
                                                out.print("</form>");
                                            out.print("</div>");
                                            out.print("<div class='col-md-6'>");
                                                out.print("<form action='Interfaz.jsp' method='post' class='d-flex align-items-center'>");
                                                    out.print("<input name='x' type='hidden' value='Ucv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                    out.print("<div class='input-group input-group-sm'><span class='input-group-text'><i class='fas fa-boxes'></i>Cantidad:</span><input name='c' type='number' min='1' max='1000000' step='1' class='form-control' value='"+r.getInt(6)+"' required><button class='btn btn-update btn-action' type='submit'>CAMBIAR</button></div>");
                                                out.print("</form>");
                                            out.print("</div>");
                                            out.print("<form action='Interfaz.jsp' method='post'>");
                                                out.print("<input name='x' type='hidden' value='Utxtv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                out.print("<div class='input-group'>");
                                                    out.print("<textarea name='txt' class='form-control' pattern='[A-Za-z0-9\\s]+' maxlength='800' placeholder='Descripción del Producto'>"+r.getString(5)+"</textarea>");
                                                    out.print("<button class='btn btn-update btn-action' type='submit'><i class='fas fa-edit me-1'></i>CAMBIAR Descripción</button>");
                                                out.print("</div>");
                                            out.print("</form>");
                                        out.print("</div>");
                                    out.print("</div>");
                                out.print("</div>");
                            }
                        out.print("</div>");
                    }
                    r.close();
                    r = null;
                    r = s.executeQuery("SELECT Img,Id,N,P,D,Cupo FROM Producto WHERE CE='"+session.getAttribute("u")+"' AND T='PA' ORDER BY Pop DESC, Cupo ASC");
                    if (r.next()) {
                        out.print("<div class='product-section pA'>");
                            out.print("<div class='section-header'><i class='fas fa-leaf me-2'></i>Plantas Acuaticas</div>");
                            r.beforeFirst();
                            while (r.next()) {
                                out.print("<div class='product-card'>");
                                    out.print("<div class='product-row'>");
                                        out.print("<div class='product-image-section'>");
                                            out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Planta Acuatica' class='product-image'/>");
                                            out.print("<form action='UpVentas' method='post' enctype='multipart/form-data' class='w-100'>");
                                                out.print("<input name='x' type='hidden' value='false'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                out.print("<input name='i' type='file' class='form-control form-control-sm mb-2' accept='image/*' required>");
                                                out.print("<button type='submit' class='btn btn-change-image btn-sm w-100'>CAMBIAR Imagen</button>");
                                            out.print("</form>");
                                            out.print("<button class='btn btn-delete btn-sm w-100' onclick=\"location.assign('Interfaz.jsp?x=D2&t=Producto&id="+r.getLong(2)+"')\"><i class='fas fa-trash me-1'></i>ELIMINAR</button>");
                                        out.print("</div>");
                                    out.print("</div>");
                                    out.print("<div class='product-details'>");
                                        out.print("<h3 class='product-title'>"+r.getString(3)+"</h3>");
                                        out.print("<div class='row mb-3'>");
                                            out.print("<div class='col-md-6'>");
                                                out.print("<form action='Interfaz.jsp' method='post' class='d-flex align-items-center'>");
                                                    out.print("<input name='x' type='hidden' value='Upv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                    out.print("<div class='input-group input-group-sm'><span class='input-group-text'><i class='fas fa-dollar-sign'></i>Precio:</span><input name='p' type='number' min='1' max='5000000' class='form-control' value='"+r.getFloat(4)+"' required><button class='btn btn-update btn-action' type='submit'>CAMBIAR</button></div>");
                                                out.print("</form>");
                                            out.print("</div>");
                                            out.print("<div class='col-md-6'>");
                                                out.print("<form action='Interfaz.jsp' method='post' class='d-flex align-items-center'>");
                                                    out.print("<input name='x' type='hidden' value='Ucv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                    out.print("<div class='input-group input-group-sm'><span class='input-group-text'><i class='fas fa-boxes'></i>Cantidad:</span><input name='c' type='number' min='1' max='1000000' step='1' class='form-control' value='"+r.getInt(6)+"' required><button class='btn btn-update btn-action' type='submit'>CAMBIAR</button></div>");
                                                out.print("</form>");
                                            out.print("</div>");
                                            out.print("<form action='Interfaz.jsp' method='post'>");
                                                out.print("<input name='x' type='hidden' value='Utxtv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                out.print("<div class='input-group'>");
                                                    out.print("<textarea name='txt' class='form-control' pattern='[A-Za-z0-9\\s]+' maxlength='800' placeholder='Descripción del Producto'>"+r.getString(5)+"</textarea>");
                                                    out.print("<button class='btn btn-update btn-action' type='submit'><i class='fas fa-edit me-1'></i>CAMBIAR Descripción</button>");
                                                out.print("</div>");
                                            out.print("</form>");
                                        out.print("</div>");
                                    out.print("</div>");
                                out.print("</div>");
                            }
                        out.print("</div>");
                    }
                    r.close();
                    r = null;
                    r = s.executeQuery("SELECT Img,Id,N,P,D,Cupo FROM Producto WHERE CE='"+session.getAttribute("u")+"' AND T='A' ORDER BY Pop DESC, Cupo ASC");
                    if (r.next()) {
                        out.print("<div class='product-section A'>");
                            out.print("<div class='section-header'><i class='fas fa-leaf me-2'></i>Arboles</div>");
                            r.beforeFirst();
                            while (r.next()) {
                                out.print("<div class='product-card'>");
                                    out.print("<div class='product-row'>");
                                        out.print("<div class='product-image-section'>");
                                            out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Arbol' class='product-image'/>");
                                            out.print("<form action='UpVentas' method='post' enctype='multipart/form-data' class='w-100'>");
                                                out.print("<input name='x' type='hidden' value='false'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                out.print("<input name='i' type='file' class='form-control form-control-sm mb-2' accept='image/*' required>");
                                                out.print("<button type='submit' class='btn btn-change-image btn-sm w-100'>CAMBIAR Imagen</button>");
                                            out.print("</form>");
                                            out.print("<button class='btn btn-delete btn-sm w-100' onclick=\"location.assign('Interfaz.jsp?x=D2&t=Producto&id="+r.getLong(2)+"')\"><i class='fas fa-trash me-1'></i>ELIMINAR</button>");
                                        out.print("</div>");
                                    out.print("</div>");
                                    out.print("<div class='product-details'>");
                                        out.print("<h3 class='product-title'>"+r.getString(3)+"</h3>");
                                        out.print("<div class='row mb-3'>");
                                            out.print("<div class='col-md-6'>");
                                                out.print("<form action='Interfaz.jsp' method='post' class='d-flex align-items-center'>");
                                                    out.print("<input name='x' type='hidden' value='Upv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                    out.print("<div class='input-group input-group-sm'><span class='input-group-text'><i class='fas fa-dollar-sign'></i>Precio:</span><input name='p' type='number' min='1' max='5000000' class='form-control' value='"+r.getFloat(4)+"' required><button class='btn btn-update btn-action' type='submit'>CAMBIAR</button></div>");
                                                out.print("</form>");
                                            out.print("</div>");
                                            out.print("<div class='col-md-6'>");
                                                out.print("<form action='Interfaz.jsp' method='post' class='d-flex align-items-center'>");
                                                    out.print("<input name='x' type='hidden' value='Ucv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                    out.print("<div class='input-group input-group-sm'><span class='input-group-text'><i class='fas fa-boxes'></i>Cantidad:</span><input name='c' type='number' min='1' max='1000000' step='1' class='form-control' value='"+r.getInt(6)+"' required><button class='btn btn-update btn-action' type='submit'>CAMBIAR</button></div>");
                                                out.print("</form>");
                                            out.print("</div>");
                                            out.print("<form action='Interfaz.jsp' method='post'>");
                                                out.print("<input name='x' type='hidden' value='Utxtv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                out.print("<div class='input-group'>");
                                                    out.print("<textarea name='txt' class='form-control' pattern='[A-Za-z0-9\\s]+' maxlength='800' placeholder='Descripción del Producto'>"+r.getString(5)+"</textarea>");
                                                    out.print("<button class='btn btn-update btn-action' type='submit'><i class='fas fa-edit me-1'></i>CAMBIAR Descripción</button>");
                                                out.print("</div>");
                                            out.print("</form>");
                                        out.print("</div>");
                                    out.print("</div>");
                                out.print("</div>");
                            }
                        out.print("</div>");
                    }
                    r.close();
                    r = null;
                    r = s.executeQuery("SELECT Img,Id,N,P,D,Cupo FROM Producto WHERE CE='"+session.getAttribute("u")+"' AND T='AH' ORDER BY Pop DESC, Cupo ASC");
                    if (r.next()) {
                        out.print("<div class='product-section aH'>");
                            out.print("<div class='section-header'><i class='fas fa-leaf me-2'></i>Algas y/u Hongos</div>");
                            r.beforeFirst();
                            while (r.next()) {
                                out.print("<div class='product-card'>");
                                    out.print("<div class='product-row'>");
                                        out.print("<div class='product-image-section'>");
                                            out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Alga u Hongo' class='product-image'/>");
                                            out.print("<form action='UpVentas' method='post' enctype='multipart/form-data' class='w-100'>");
                                                out.print("<input name='x' type='hidden' value='false'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                out.print("<input name='i' type='file' class='form-control form-control-sm mb-2' accept='image/*' required>");
                                                out.print("<button type='submit' class='btn btn-change-image btn-sm w-100'>CAMBIAR Imagen</button>");
                                            out.print("</form>");
                                            out.print("<button class='btn btn-delete btn-sm w-100' onclick=\"location.assign('Interfaz.jsp?x=D2&t=Producto&id="+r.getLong(2)+"')\"><i class='fas fa-trash me-1'></i>ELIMINAR</button>");
                                        out.print("</div>");
                                    out.print("</div>");
                                    out.print("<div class='product-details'>");
                                        out.print("<h3 class='product-title'>"+r.getString(3)+"</h3>");
                                        out.print("<div class='row mb-3'>");
                                            out.print("<div class='col-md-6'>");
                                                out.print("<form action='Interfaz.jsp' method='post' class='d-flex align-items-center'>");
                                                    out.print("<input name='x' type='hidden' value='Upv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                    out.print("<div class='input-group input-group-sm'><span class='input-group-text'><i class='fas fa-dollar-sign'></i>Precio:</span><input name='p' type='number' min='1' max='5000000' class='form-control' value='"+r.getFloat(4)+"' required><button class='btn btn-update btn-action' type='submit'>CAMBIAR</button></div>");
                                                out.print("</form>");
                                            out.print("</div>");
                                            out.print("<div class='col-md-6'>");
                                                out.print("<form action='Interfaz.jsp' method='post' class='d-flex align-items-center'>");
                                                    out.print("<input name='x' type='hidden' value='Ucv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                    out.print("<div class='input-group input-group-sm'><span class='input-group-text'><i class='fas fa-boxes'></i>Cantidad:</span><input name='c' type='number' min='1' max='1000000' step='1' class='form-control' value='"+r.getInt(6)+"' required><button class='btn btn-update btn-action' type='submit'>CAMBIAR</button></div>");
                                                out.print("</form>");
                                            out.print("</div>");
                                            out.print("<form action='Interfaz.jsp' method='post'>");
                                                out.print("<input name='x' type='hidden' value='Utxtv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                out.print("<div class='input-group'>");
                                                    out.print("<textarea name='txt' class='form-control' pattern='[A-Za-z0-9\\s]+' maxlength='800' placeholder='Descripción del Producto'>"+r.getString(5)+"</textarea>");
                                                    out.print("<button class='btn btn-update btn-action' type='submit'><i class='fas fa-edit me-1'></i>CAMBIAR Descripción</button>");
                                                out.print("</div>");
                                            out.print("</form>");
                                        out.print("</div>");
                                    out.print("</div>");
                                out.print("</div>");
                            }
                        out.print("</div>");
                    }
                    r.close();
                    r = null;
                    r = s.executeQuery("SELECT Img,Id,N,P,D,Cupo FROM Producto WHERE CE='"+session.getAttribute("u")+"' AND T='F' ORDER BY Pop DESC, Cupo ASC");
                    if (r.next()) {
                        out.print("<div class='product-section F'>");
                            out.print("<div class='section-header'><i class='fas fa-leaf me-2'></i>Fertilizantes</div>");
                            r.beforeFirst();
                            while (r.next()) {
                                out.print("<div class='product-card'>");
                                    out.print("<div class='product-row'>");
                                        out.print("<div class='product-image-section'>");
                                            out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Fertilizante' class='product-image'/>");
                                            out.print("<form action='UpVentas' method='post' enctype='multipart/form-data' class='w-100'>");
                                                out.print("<input name='x' type='hidden' value='false'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                out.print("<input name='i' type='file' class='form-control form-control-sm mb-2' accept='image/*' required>");
                                                out.print("<button type='submit' class='btn btn-change-image btn-sm w-100'>CAMBIAR Imagen</button>");
                                            out.print("</form>");
                                            out.print("<button class='btn btn-delete btn-sm w-100' onclick=\"location.assign('Interfaz.jsp?x=D2&t=Producto&id="+r.getLong(2)+"')\"><i class='fas fa-trash me-1'></i>ELIMINAR</button>");
                                        out.print("</div>");
                                    out.print("</div>");
                                    out.print("<div class='product-details'>");
                                        out.print("<h3 class='product-title'>"+r.getString(3)+"</h3>");
                                        out.print("<div class='row mb-3'>");
                                            out.print("<div class='col-md-6'>");
                                                out.print("<form action='Interfaz.jsp' method='post' class='d-flex align-items-center'>");
                                                    out.print("<input name='x' type='hidden' value='Upv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                    out.print("<div class='input-group input-group-sm'><span class='input-group-text'><i class='fas fa-dollar-sign'></i>Precio:</span><input name='p' type='number' min='1' max='5000000' class='form-control' value='"+r.getFloat(4)+"' required><button class='btn btn-update btn-action' type='submit'>CAMBIAR</button></div>");
                                                out.print("</form>");
                                            out.print("</div>");
                                            out.print("<div class='col-md-6'>");
                                                out.print("<form action='Interfaz.jsp' method='post' class='d-flex align-items-center'>");
                                                    out.print("<input name='x' type='hidden' value='Ucv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                    out.print("<div class='input-group input-group-sm'><span class='input-group-text'><i class='fas fa-boxes'></i>Cantidad:</span><input name='c' type='number' min='1' max='1000000' step='1' class='form-control' value='"+r.getInt(6)+"' required><button class='btn btn-update btn-action' type='submit'>CAMBIAR</button></div>");
                                                out.print("</form>");
                                            out.print("</div>");
                                            out.print("<form action='Interfaz.jsp' method='post'>");
                                                out.print("<input name='x' type='hidden' value='Utxtv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                out.print("<div class='input-group'>");
                                                    out.print("<textarea name='txt' class='form-control' pattern='[A-Za-z0-9\\s]+' maxlength='800' placeholder='Descripción del Producto'>"+r.getString(5)+"</textarea>");
                                                    out.print("<button class='btn btn-update btn-action' type='submit'><i class='fas fa-edit me-1'></i>CAMBIAR Descripción</button>");
                                                out.print("</div>");
                                            out.print("</form>");
                                        out.print("</div>");
                                    out.print("</div>");
                                out.print("</div>");
                            }
                        out.print("</div>");
                    }
                    r.close();
                    r = null;
                    r = s.executeQuery("SELECT Img,Id,N,P,D,Cupo FROM Producto WHERE CE='"+session.getAttribute("u")+"' AND T='H' ORDER BY Pop DESC, Cupo ASC");
                    if (r.next()) {
                        out.print("<div class='product-section H'>");
                            out.print("<div class='section-header'><i class='fas fa-leaf me-2'></i>Herramientas</div>");
                            r.beforeFirst();
                            while (r.next()) {
                                out.print("<div class='product-card'>");
                                    out.print("<div class='product-row'>");
                                        out.print("<div class='product-image-section'>");
                                            out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Herramienta' class='product-image'/>");
                                            out.print("<form action='UpVentas' method='post' enctype='multipart/form-data' class='w-100'>");
                                                out.print("<input name='x' type='hidden' value='false'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                out.print("<input name='i' type='file' class='form-control form-control-sm mb-2' accept='image/*' required>");
                                                out.print("<button type='submit' class='btn btn-change-image btn-sm w-100'>CAMBIAR Imagen</button>");
                                            out.print("</form>");
                                            out.print("<button class='btn btn-delete btn-sm w-100' onclick=\"location.assign('Interfaz.jsp?x=D2&t=Producto&id="+r.getLong(2)+"')\"><i class='fas fa-trash me-1'></i>ELIMINAR</button>");
                                        out.print("</div>");
                                    out.print("</div>");
                                    out.print("<div class='product-details'>");
                                        out.print("<h3 class='product-title'>"+r.getString(3)+"</h3>");
                                        out.print("<div class='row mb-3'>");
                                            out.print("<div class='col-md-6'>");
                                                out.print("<form action='Interfaz.jsp' method='post' class='d-flex align-items-center'>");
                                                    out.print("<input name='x' type='hidden' value='Upv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                    out.print("<div class='input-group input-group-sm'><span class='input-group-text'><i class='fas fa-dollar-sign'></i>Precio:</span><input name='p' type='number' min='1' max='5000000' class='form-control' value='"+r.getFloat(4)+"' required><button class='btn btn-update btn-action' type='submit'>CAMBIAR</button></div>");
                                                out.print("</form>");
                                            out.print("</div>");
                                            out.print("<div class='col-md-6'>");
                                                out.print("<form action='Interfaz.jsp' method='post' class='d-flex align-items-center'>");
                                                    out.print("<input name='x' type='hidden' value='Ucv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                    out.print("<div class='input-group input-group-sm'><span class='input-group-text'><i class='fas fa-boxes'></i>Cantidad:</span><input name='c' type='number' min='1' max='1000000' step='1' class='form-control' value='"+r.getInt(6)+"' required><button class='btn btn-update btn-action' type='submit'>CAMBIAR</button></div>");
                                                out.print("</form>");
                                            out.print("</div>");
                                            out.print("<form action='Interfaz.jsp' method='post'>");
                                                out.print("<input name='x' type='hidden' value='Utxtv'><input name='id' type='hidden' value='"+r.getLong(2)+"'>");
                                                out.print("<div class='input-group'>");
                                                    out.print("<textarea name='txt' class='form-control' pattern='[A-Za-z0-9\\s]+' maxlength='800' placeholder='Descripción del Producto'>"+r.getString(5)+"</textarea>");
                                                    out.print("<button class='btn btn-update btn-action' type='submit'><i class='fas fa-edit me-1'></i>CAMBIAR Descripción</button>");
                                                out.print("</div>");
                                            out.print("</form>");
                                        out.print("</div>");
                                    out.print("</div>");
                                out.print("</div>");
                            }
                        out.print("</div>");
                    }
                    r.close();
                    s.close();
                    c.close();
                } catch (Exception e) {
                    out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                    out.print("<script>history.back();</script>");
                }
            %>
        </div>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    </body>
</html>