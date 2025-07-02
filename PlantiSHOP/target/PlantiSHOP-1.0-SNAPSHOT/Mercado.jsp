<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%!
    Connection c;
    Statement s;
    ResultSet r;
%>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        c = DriverManager.getConnection("jdbc:mysql://localhost/PSHOP", "root", "n0m3l0");
        s = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
    } catch (Exception e) {
        out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
        out.print("<script>history.back();</script>");
    }
%>
<!DOCTYPE html>
<html lang="es-MX">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mercado</title>
        <link rel="icon" type="image/x-icon" href="imgs/logo.png">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome Icons -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
        
        <style>
            :root {
                --primary-green: #2d5016;
                --secondary-green: #4a7c59;
                --accent-green: #8fbc8f;
                --light-green: #e8f5e8;
                --earth-brown: #8b4513;
                --warm-orange: #ff8c42;
                --soft-yellow: #f9e784;
                --cream: #f5f5dc;
                --dark-text: #2c3e50;
                --light-text: #6c757d;
            }
            body {
                font-family: 'Poppins', sans-serif;
                background: #f0f0f0;
                color: var(--dark-text);
                min-height: 100vh;
            }
            .hero-section {
                background: linear-gradient(rgba(45, 80, 22, 0.8), rgba(45, 80, 22, 0.8)), url(imgs/fondo3.png) center/cover;
                color: white;
                padding: 4rem 0;
                margin-bottom: 3rem;
                border-radius: 0 0 50px 50px;
            }
            .hero-title {
                font-family: 'Playfair Display', serif;
                font-size: 3.5rem;
                font-weight: 700;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
                margin-bottom: 1rem;
            }
            .hero-subtitle {
                font-size: 1.2rem;
                opacity: 0.9;
                margin-bottom: 0;
            }
            .category-section {
                margin-bottom: 3rem;
                background: white;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                overflow: hidden;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }
            .category-section:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 40px rgba(0,0,0,0.15);
            }
            .category-header {
                padding: 1.5rem 2rem;
                font-family: 'Playfair Display', serif;
                font-size: 1.8rem;
                font-weight: 600;
                color: white;
                margin: 0;
                display: flex;
                align-items: center;
                gap: 15px;
            }
            .category-decorative { background: linear-gradient(135deg, var(--secondary-green), var(--accent-green)); }
            .category-garden { background: linear-gradient(135deg, var(--earth-brown), var(--warm-orange)); }
            .category-aquatic { background: linear-gradient(135deg, #4682b4, #87ceeb); }
            .category-trees { background: linear-gradient(135deg, var(--primary-green), var(--secondary-green)); }
            .category-algae { background: linear-gradient(135deg, #228b22, #90ee90); }
            .category-fertilizers { background: linear-gradient(135deg, var(--warm-orange), var(--soft-yellow)); }
            .category-tools { background: linear-gradient(135deg, #696969, #a9a9a9); }
            .products-container {
                padding: 2rem;
            }
            .product-card {
                background: white;
                border-radius: 15px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.08);
                margin-bottom: 2rem;
                overflow: hidden;
                transition: all 0.3s ease;
                border: 1px solid rgba(0,0,0,0.05);
            }
            .product-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            }
            .product-image {
                width: 100%;
                height: 180px;
                object-fit: cover;
                border-radius: 10px;
                margin-bottom: 1rem;
            }
            .product-title {
                font-family: 'Playfair Display', serif;
                font-size: 1.4rem;
                font-weight: 600;
                color: var(--primary-green);
                margin-bottom: 0.5rem;
            }
            .product-price {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--earth-brown);
                margin-bottom: 1rem;
            }
            .product-description {
                color: var(--light-text);
                font-size: 0.95rem;
                line-height: 1.5;
                margin-bottom: 1rem;
            }
            .seller-info {
                background: var(--light-green);
                padding: 1rem;
                border-radius: 10px;
                margin-bottom: 1rem;
            }
            .seller-name {
                font-weight: 600;
                color: var(--primary-green);
                font-size: 0.9rem;
                margin-bottom: 0.3rem;
            }
            .stock-info {
                font-size: 0.85rem;
                color: var(--secondary-green);
                font-weight: 500;
            }
            .buy-btn {
                background: linear-gradient(135deg, var(--secondary-green), var(--accent-green));
                border: none;
                color: white;
                padding: 12px 0;
                font-weight: 600;
                border-radius: 10px;
                width: 100%;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                font-size: 0.9rem;
            }
            .buy-btn:hover {
                background: linear-gradient(135deg, var(--accent-green), var(--secondary-green));
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(74, 124, 89, 0.4);
                color: white;
            }
            .no-products {
                text-align: center;
                padding: 3rem 2rem;
                color: var(--light-text);
                font-style: italic;
            }
            .category-icon {
                font-size: 1.5rem;
            }
            @media (max-width: 768px) {
                .hero-title {
                    font-size: 2.5rem;
                }
                .category-header {
                    font-size: 1.5rem;
                    padding: 1rem 1.5rem;
                }
                .products-container {
                    padding: 1rem;
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
        
        <div class="hero-section">
            <div class="container text-center">
                <h1 class="hero-title">
                    <i class="fas fa-leaf me-3"></i>
                    Mercado Verde
                </h1>
                <p class="hero-subtitle">Tu destino para Plantas, Jardinería y Vida Natural</p>
            </div>
        </div>
        <div class="container">
            <div class="category-section">
                <div class="category-header category-decorative">
                    <i class="fas fa-seedling category-icon"></i>
                    Plantas Decorativas
                </div>
                <div class="products-container" id="PD">
                    <%
                        try {
                            r = s.executeQuery("SELECT Producto.Img,Producto.Id,Producto.N,Producto.P,Producto.D,Usuario.N,Usuario.AP,Usuario.AM,Producto.Cupo FROM Producto INNER JOIN Usuario ON Producto.CE=Usuario.CE WHERE Producto.T='PD' AND Producto.Cupo>0 AND Producto.CE!='"+session.getAttribute("u")+"' ORDER BY Producto.Pop DESC, Producto.Cupo DESC");
                            if (r.next()) {
                                r.beforeFirst();
                                while (r.next()) {
                                    out.print("<div class='row mb-4'>");
                                        out.print("<div class='col-lg-3 col-md-4 col-sm-6 mb-3'>");
                                            out.print("<div class='text-center'>");
                                                out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Planta Decorativa' class='product-image'/>");
                                                out.print("<button class='btn buy-btn' onclick=\"location.assign('Interfaz.jsp?x=B&id="+r.getLong(2)+"')\"><i class='fas fa-shopping-cart me-2'></i>COMPRAR</button>");
                                            out.print("</div>");
                                        out.print("</div>");
                                        out.print("<div class='col-lg-9 col-md-8 col-sm-6'>");
                                            out.print("<div class='product-card h-100'>");
                                                out.print("<div class='p-3'>");
                                                    out.print("<h3 class='product-title'>"+r.getString(3)+"</h3>");
                                                    out.print("<div class='product-price'>$ "+r.getFloat(4)+"</div>");
                                                    out.print("<p class='product-description'>"+r.getString(5)+"</p>");
                                                    out.print("<div class='seller-info'>");
                                                        out.print("<div class='seller-name'><i class='fas fa-user me-2'></i>Vendedor: "+r.getString(6)+" "+r.getString(7)+" "+r.getString(8)+"</div>");
                                                        out.print("<div class='stock-info'><i class='fas fa-box me-2'></i>Cupo: "+r.getInt(9)+"</div>");
                                                    out.print("</div>");
                                                out.print("</div>");
                                            out.print("</div>");
                                        out.print("</div>");
                                    out.print("</div>");
                                }
                            } else {
                                out.print("<div class='no-products'><i class='fas fa-leaf fa-3x mb-3 opacity-50'></i><p>Lo sentimos... NO hay Ofertas en este apartado!</p></div>");
                            }
                            r.close();
                            r = null;
                        } catch (Exception e) {
                            out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                            out.print("<script>history.back();</script>");
                        }
                    %>
                </div>
            </div>
            <div class="category-section">
                <div class="category-header category-garden">
                    <i class="fas fa-carrot category-icon"></i>
                    Plantas de Huerto
                </div>
                <div class="products-container" id="PH">
                    <%
                        try {
                            r = s.executeQuery("SELECT Producto.Img,Producto.Id,Producto.N,Producto.P,Producto.D,Usuario.N,Usuario.AP,Usuario.AM,Producto.Cupo FROM Producto INNER JOIN Usuario ON Producto.CE=Usuario.CE WHERE Producto.T='PH' AND Producto.Cupo>0 AND Producto.CE!='"+session.getAttribute("u")+"' ORDER BY Producto.Pop DESC, Producto.Cupo DESC");
                            if (r.next()) {
                                r.beforeFirst();
                                while (r.next()) {
                                    out.print("<div class='row mb-4'>");
                                        out.print("<div class='col-lg-3 col-md-4 col-sm-6 mb-3'>");
                                            out.print("<div class='text-center'>");
                                                out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Planta de Huerto' class='product-image'/>");
                                                out.print("<button class='btn buy-btn' onclick=\"location.assign('Interfaz.jsp?x=B&id="+r.getLong(2)+"')\"><i class='fas fa-shopping-cart me-2'></i>COMPRAR</button>");
                                            out.print("</div>");
                                        out.print("</div>");
                                        out.print("<div class='col-lg-9 col-md-8 col-sm-6'>");
                                            out.print("<div class='product-card h-100'>");
                                                out.print("<div class='p-3'>");
                                                    out.print("<h3 class='product-title'>"+r.getString(3)+"</h3>");
                                                    out.print("<div class='product-price'>$ "+r.getFloat(4)+"</div>");
                                                    out.print("<p class='product-description'>"+r.getString(5)+"</p>");
                                                    out.print("<div class='seller-info'>");
                                                        out.print("<div class='seller-name'><i class='fas fa-user me-2'></i>Vendedor: "+r.getString(6)+" "+r.getString(7)+" "+r.getString(8)+"</div>");
                                                        out.print("<div class='stock-info'><i class='fas fa-box me-2'></i>Cupo: "+r.getInt(9)+"</div>");
                                                    out.print("</div>");
                                                out.print("</div>");
                                            out.print("</div>");
                                        out.print("</div>");
                                    out.print("</div>");
                                }
                            } else {
                                out.print("<div class='no-products'><i class='fas fa-carrot fa-3x mb-3 opacity-50'></i><p>Lo sentimos... NO hay Ofertas en este apartado!</p></div>");
                            }
                            r.close();
                            r = null;
                        } catch (Exception e) {
                            out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                            out.print("<script>history.back();</script>");
                        }
                    %>
                </div>
            </div>
            <div class="category-section">
                <div class="category-header category-aquatic">
                    <i class="fas fa-water category-icon"></i>
                    Plantas Acuáticas
                </div>
                <div class="products-container" id="PA">
                    <%
                        try {
                            r = s.executeQuery("SELECT Producto.Img,Producto.Id,Producto.N,Producto.P,Producto.D,Usuario.N,Usuario.AP,Usuario.AM,Producto.Cupo FROM Producto INNER JOIN Usuario ON Producto.CE=Usuario.CE WHERE Producto.T='PA' AND Producto.Cupo>0 AND Producto.CE!='"+session.getAttribute("u")+"' ORDER BY Producto.Pop DESC, Producto.Cupo DESC");
                            if (r.next()) {
                                r.beforeFirst();
                                while (r.next()) {
                                    out.print("<div class='row mb-4'>");
                                        out.print("<div class='col-lg-3 col-md-4 col-sm-6 mb-3'>");
                                            out.print("<div class='text-center'>");
                                                out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Planta Acuatica' class='product-image'/>");
                                                out.print("<button class='btn buy-btn' onclick=\"location.assign('Interfaz.jsp?x=B&id="+r.getLong(2)+"')\"><i class='fas fa-shopping-cart me-2'></i>COMPRAR</button>");
                                            out.print("</div>");
                                        out.print("</div>");
                                        out.print("<div class='col-lg-9 col-md-8 col-sm-6'>");
                                            out.print("<div class='product-card h-100'>");
                                                out.print("<div class='p-3'>");
                                                    out.print("<h3 class='product-title'>"+r.getString(3)+"</h3>");
                                                    out.print("<div class='product-price'>$ "+r.getFloat(4)+"</div>");
                                                    out.print("<p class='product-description'>"+r.getString(5)+"</p>");
                                                    out.print("<div class='seller-info'>");
                                                        out.print("<div class='seller-name'><i class='fas fa-user me-2'></i>Vendedor: "+r.getString(6)+" "+r.getString(7)+" "+r.getString(8)+"</div>");
                                                        out.print("<div class='stock-info'><i class='fas fa-box me-2'></i>Cupo: "+r.getInt(9)+"</div>");
                                                    out.print("</div>");
                                                out.print("</div>");
                                            out.print("</div>");
                                        out.print("</div>");
                                    out.print("</div>");
                                }
                            } else {
                                out.print("<div class='no-products'><i class='fas fa-water fa-3x mb-3 opacity-50'></i><p>Lo sentimos... NO hay Ofertas en este apartado!</p></div>");
                            }
                            r.close();
                            r = null;
                        } catch (Exception e) {
                            out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                            out.print("<script>history.back();</script>");
                        }
                    %>
                </div>
            </div>
            <div class="category-section">
                <div class="category-header category-trees">
                    <i class="fas fa-tree category-icon"></i>
                    Árboles
                </div>
                <div class="products-container" id="A">
                    <%
                        try {
                            r = s.executeQuery("SELECT Producto.Img,Producto.Id,Producto.N,Producto.P,Producto.D,Usuario.N,Usuario.AP,Usuario.AM,Producto.Cupo FROM Producto INNER JOIN Usuario ON Producto.CE=Usuario.CE WHERE Producto.T='A' AND Producto.Cupo>0 AND Producto.CE!='"+session.getAttribute("u")+"' ORDER BY Producto.Pop DESC, Producto.Cupo DESC");
                            if (r.next()) {
                                r.beforeFirst();
                                while (r.next()) {
                                    out.print("<div class='row mb-4'>");
                                        out.print("<div class='col-lg-3 col-md-4 col-sm-6 mb-3'>");
                                            out.print("<div class='text-center'>");
                                                out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Arbol' class='product-image'/>");
                                                out.print("<button class='btn buy-btn' onclick=\"location.assign('Interfaz.jsp?x=B&id="+r.getLong(2)+"')\"><i class='fas fa-shopping-cart me-2'></i>COMPRAR</button>");
                                            out.print("</div>");
                                        out.print("</div>");
                                        out.print("<div class='col-lg-9 col-md-8 col-sm-6'>");
                                            out.print("<div class='product-card h-100'>");
                                                out.print("<div class='p-3'>");
                                                    out.print("<h3 class='product-title'>"+r.getString(3)+"</h3>");
                                                    out.print("<div class='product-price'>$ "+r.getFloat(4)+"</div>");
                                                    out.print("<p class='product-description'>"+r.getString(5)+"</p>");
                                                    out.print("<div class='seller-info'>");
                                                        out.print("<div class='seller-name'><i class='fas fa-user me-2'></i>Vendedor: "+r.getString(6)+" "+r.getString(7)+" "+r.getString(8)+"</div>");
                                                        out.print("<div class='stock-info'><i class='fas fa-box me-2'></i>Cupo: "+r.getInt(9)+"</div>");
                                                    out.print("</div>");
                                                out.print("</div>");
                                            out.print("</div>");
                                        out.print("</div>");
                                    out.print("</div>");
                                }
                            } else {
                                out.print("<div class='no-products'><i class='fas fa-tree fa-3x mb-3 opacity-50'></i><p>Lo sentimos... NO hay Ofertas en este apartado!</p></div>");
                            }
                            r.close();
                            r = null;
                        } catch (Exception e) {
                            out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                            out.print("<script>history.back();</script>");
                        }
                    %>
                </div>
            </div>
            <div class="category-section">
                <div class="category-header category-algae">
                    <i class="fas fa-microscope category-icon"></i>
                    Algas y Hongos
                </div>
                <div class="products-container" id="AH">
                    <%
                        try {
                            r = s.executeQuery("SELECT Producto.Img,Producto.Id,Producto.N,Producto.P,Producto.D,Usuario.N,Usuario.AP,Usuario.AM,Producto.Cupo FROM Producto INNER JOIN Usuario ON Producto.CE=Usuario.CE WHERE Producto.T='AH' AND Producto.Cupo>0 AND Producto.CE!='"+session.getAttribute("u")+"' ORDER BY Producto.Pop DESC, Producto.Cupo DESC");
                            if (r.next()) {
                                r.beforeFirst();
                                while (r.next()) {
                                    out.print("<div class='row mb-4'>");
                                        out.print("<div class='col-lg-3 col-md-4 col-sm-6 mb-3'>");
                                            out.print("<div class='text-center'>");
                                                out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Alga / Hongo' class='product-image'/>");
                                                out.print("<button class='btn buy-btn' onclick=\"location.assign('Interfaz.jsp?x=B&id="+r.getLong(2)+"')\"><i class='fas fa-shopping-cart me-2'></i>COMPRAR</button>");
                                            out.print("</div>");
                                        out.print("</div>");
                                        out.print("<div class='col-lg-9 col-md-8 col-sm-6'>");
                                            out.print("<div class='product-card h-100'>");
                                                out.print("<div class='p-3'>");
                                                    out.print("<h3 class='product-title'>"+r.getString(3)+"</h3>");
                                                    out.print("<div class='product-price'>$ "+r.getFloat(4)+"</div>");
                                                    out.print("<p class='product-description'>"+r.getString(5)+"</p>");
                                                    out.print("<div class='seller-info'>");
                                                        out.print("<div class='seller-name'><i class='fas fa-user me-2'></i>Vendedor: "+r.getString(6)+" "+r.getString(7)+" "+r.getString(8)+"</div>");
                                                        out.print("<div class='stock-info'><i class='fas fa-box me-2'></i>Cupo: "+r.getInt(9)+"</div>");
                                                    out.print("</div>");
                                                out.print("</div>");
                                            out.print("</div>");
                                        out.print("</div>");
                                    out.print("</div>");
                                }
                            } else {
                                out.print("<div class='no-products'><i class='fas fa-microscope fa-3x mb-3 opacity-50'></i><p>Lo sentimos... NO hay Ofertas en este apartado!</p></div>");
                            }
                            r.close();
                            r = null;
                        } catch (Exception e) {
                            out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                            out.print("<script>history.back();</script>");
                        }
                    %>
                </div>
            </div>
            <div class="category-section">
                <div class="category-header category-fertilizers">
                    <i class="fas fa-flask category-icon"></i>
                    Fertilizantes
                </div>
                <div class="products-container" id="F">
                    <%
                        try {
                            r = s.executeQuery("SELECT Producto.Img,Producto.Id,Producto.N,Producto.P,Producto.D,Usuario.N,Usuario.AP,Usuario.AM,Producto.Cupo FROM Producto INNER JOIN Usuario ON Producto.CE=Usuario.CE WHERE Producto.T='F' AND Producto.Cupo>0 AND Producto.CE!='"+session.getAttribute("u")+"' ORDER BY Producto.Pop DESC, Producto.Cupo DESC");
                            if (r.next()) {
                                r.beforeFirst();
                                while (r.next()) {
                                    out.print("<div class='row mb-4'>");
                                        out.print("<div class='col-lg-3 col-md-4 col-sm-6 mb-3'>");
                                            out.print("<div class='text-center'>");
                                                out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Fertilizante' class='product-image'/>");
                                                out.print("<button class='btn buy-btn' onclick=\"location.assign('Interfaz.jsp?x=B&id="+r.getLong(2)+"')\"><i class='fas fa-shopping-cart me-2'></i>COMPRAR</button>");
                                            out.print("</div>");
                                        out.print("</div>");
                                        out.print("<div class='col-lg-9 col-md-8 col-sm-6'>");
                                            out.print("<div class='product-card h-100'>");
                                                out.print("<div class='p-3'>");
                                                    out.print("<h3 class='product-title'>"+r.getString(3)+"</h3>");
                                                    out.print("<div class='product-price'>$ "+r.getFloat(4)+"</div>");
                                                    out.print("<p class='product-description'>"+r.getString(5)+"</p>");
                                                    out.print("<div class='seller-info'>");
                                                        out.print("<div class='seller-name'><i class='fas fa-user me-2'></i>Vendedor: "+r.getString(6)+" "+r.getString(7)+" "+r.getString(8)+"</div>");
                                                        out.print("<div class='stock-info'><i class='fas fa-box me-2'></i>Cupo: "+r.getInt(9)+"</div>");
                                                    out.print("</div>");
                                                out.print("</div>");
                                            out.print("</div>");
                                        out.print("</div>");
                                    out.print("</div>");
                                }
                            } else {
                                out.print("<div class='no-products'><i class='fas fa-flask fa-3x mb-3 opacity-50'></i><p>Lo sentimos... NO hay Ofertas en este apartado!</p></div>");
                            }
                            r.close();
                            r = null;
                        } catch (Exception e) {
                            out.print("<script>alert('Lo sentimos, se produjo un ERROR... intentalo de NUEVO...');</script>");
                            out.print("<script>history.back();</script>");
                        }
                    %>
                </div>
            </div>
            <div class="category-section">
                <div class="category-header category-tools">
                    <i class="fas fa-tools category-icon"></i>
                    Herramientas
                </div>
                <div class="products-container" id="H">
                    <%
                        try {
                            r = s.executeQuery("SELECT Producto.Img,Producto.Id,Producto.N,Producto.P,Producto.D,Usuario.N,Usuario.AP,Usuario.AM,Producto.Cupo FROM Producto INNER JOIN Usuario ON Producto.CE=Usuario.CE WHERE Producto.T='H' AND Producto.Cupo>0 AND Producto.CE!='"+session.getAttribute("u")+"' ORDER BY Producto.Pop DESC, Producto.Cupo DESC");
                            if (r.next()) {
                                r.beforeFirst();
                                while (r.next()) {
                                    out.print("<div class='row mb-4'>");
                                        out.print("<div class='col-lg-3 col-md-4 col-sm-6 mb-3'>");
                                            out.print("<div class='text-center'>");
                                                out.print("<img src='imgs/prods/"+r.getString(1)+"' alt='Herramienta' class='product-image'/>");
                                                out.print("<button class='btn buy-btn' onclick=\"location.assign('Interfaz.jsp?x=B&id="+r.getLong(2)+"')\"><i class='fas fa-shopping-cart me-2'></i>COMPRAR</button>");
                                            out.print("</div>");
                                        out.print("</div>");
                                        out.print("<div class='col-lg-9 col-md-8 col-sm-6'>");
                                            out.print("<div class='product-card h-100'>");
                                                out.print("<div class='p-3'>");
                                                    out.print("<h3 class='product-title'>"+r.getString(3)+"</h3>");
                                                    out.print("<div class='product-price'>$ "+r.getFloat(4)+"</div>");
                                                    out.print("<p class='product-description'>"+r.getString(5)+"</p>");
                                                    out.print("<div class='seller-info'>");
                                                        out.print("<div class='seller-name'><i class='fas fa-user me-2'></i>Vendedor: "+r.getString(6)+" "+r.getString(7)+" "+r.getString(8)+"</div>");
                                                        out.print("<div class='stock-info'><i class='fas fa-box me-2'></i>Cupo: "+r.getInt(9)+"</div>");
                                                    out.print("</div>");
                                                out.print("</div>");
                                            out.print("</div>");
                                        out.print("</div>");
                                    out.print("</div>");
                                }
                            } else {
                                out.print("<div class='no-products'><i class='fas fa-tools fa-3x mb-3 opacity-50'></i><p>Lo sentimos... NO hay Ofertas en este apartado!</p></div>");
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
            </div>
        </div>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    </body>
</html>