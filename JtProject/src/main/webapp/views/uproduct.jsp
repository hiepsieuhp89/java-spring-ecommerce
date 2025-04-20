<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Shop Products | E-Shop</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #ee4d2d;
            --secondary-color: #f8f9fc;
            --accent-color: #e74a3b;
            --dark-color: #5a5c69;
        }
        
        body {
            font-family: 'Nunito', sans-serif;
            background-color: #f8f9fc;
            color: #5a5c69;
        }
        
        .navbar {
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        
        .card {
            border: none;
            border-radius: 8px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            transition: all 0.3s ease;
        }
        
        .card:hover {
            transform: translateY(-5px);
        }
        
        .product-card {
            position: relative;
            overflow: hidden;
            height: 100%;
        }
        
        .product-card .card-body {
            display: flex;
            flex-direction: column;
        }
        
        .product-image {
            height: 200px;
            object-fit: contain;
            padding: 1rem;
            background-color: #fff;
            transition: transform 0.3s ease;
        }
        
        .product-image:hover {
            transform: scale(1.05);
        }
        
        .product-title {
            font-weight: 700;
            font-size: 1.1rem;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
        }
        
        .product-category {
            display: inline-block;
            background-color: var(--primary-color);
            color: white;
            font-size: 0.7rem;
            font-weight: 600;
            padding: 0.3rem 0.6rem;
            border-radius: 50rem;
            margin-bottom: 0.5rem;
        }
        
        .product-price {
            font-weight: 700;
            font-size: 1.25rem;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }
        
        .product-description {
            margin-bottom: 1rem;
        }
        
        .btn-add-to-cart {
            background-color: var(--primary-color);
            border: none;
            color: white;
            font-weight: 600;
            margin-top: auto;
            transition: all 0.3s;
        }
        
        .btn-add-to-cart:hover {
            background-color: #d73919;
            transform: translateY(-2px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        
        .page-title {
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: var(--dark-color);
        }
        
        .product-meta {
            display: flex;
            align-items: center;
            margin-bottom: 0.5rem;
            color: #858796;
            font-size: 0.9rem;
        }
        
        .product-meta i {
            margin-right: 0.5rem;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: var(--primary-color);">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-shopping-cart me-2"></i>E-Shop
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="/adminhome">
                            <i class="fas fa-home me-1"></i>Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/cart">
                            <i class="fas fa-shopping-cart me-1"></i>Cart
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/logout">
                            <i class="fas fa-sign-out-alt me-1"></i>Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
    <!-- Main Content -->
    <div class="container py-5">
        <h1 class="page-title">
            <i class="fas fa-shopping-bag me-2"></i>Available Products
        </h1>
        
        <div class="row g-4">
            <c:forEach var="product" items="${products}">
                <div class="col-md-4 col-lg-3">
                    <div class="card product-card">
                        <img src="${product.image}" class="card-img-top product-image" alt="${product.name}">
                        <div class="card-body">
                            <span class="product-category">${product.category.name}</span>
                            <h5 class="product-title">${product.name}</h5>
                            <div class="product-price">$${product.price}</div>
                            
                            <div class="product-meta">
                                <i class="fas fa-weight-hanging"></i>
                                <span>Weight: ${product.weight}g</span>
                            </div>
                            
                            <div class="product-meta">
                                <i class="fas fa-cubes"></i>
                                <span>Stock: ${product.quantity} units</span>
                            </div>
                            
                            <p class="product-description small text-muted">${product.description}</p>
                            
                            <form action="products/addtocart" method="get">
                                <input type="hidden" name="id" value="${product.id}">
                                <button type="submit" class="btn btn-add-to-cart w-100">
                                    <i class="fas fa-cart-plus me-2"></i>Add to Cart
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    
    <!-- Footer -->
    <footer class="py-4 bg-light mt-auto">
        <div class="container">
            <div class="d-flex align-items-center justify-content-between small">
                <div class="text-muted">Copyright &copy; E-Shop 2023</div>
                <div>
                    <a href="#" class="text-decoration-none">Privacy Policy</a>
                    &middot;
                    <a href="#" class="text-decoration-none">Terms &amp; Conditions</a>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>