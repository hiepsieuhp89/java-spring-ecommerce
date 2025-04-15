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
    <title>E-Shop | Home</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #f8f9fc;
            --accent-color: #e74a3b;
            --success-color: #1cc88a;
            --warning-color: #f6c23e;
            --info-color: #36b9cc;
        }
        
        body {
            background-color: #f8f9fc;
            font-family: 'Nunito', sans-serif;
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
            height: 100%;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 2rem 0 rgba(58, 59, 69, 0.15);
        }
        
        .card-img-top {
            height: 180px;
            object-fit: contain;
            background-color: #fff;
            padding: 20px;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border: none;
            padding: 0.5rem 1.5rem;
            border-radius: 5px;
        }
        
        .btn-primary:hover {
            background-color: #2e59d9;
            transform: translateY(-2px);
        }
        
        .hero-section {
            background: linear-gradient(135deg, var(--primary-color) 0%, #2a4db7 100%);
            color: white;
            padding: 5rem 0;
            margin-bottom: 2rem;
        }
        
        .hero-title {
            font-weight: 700;
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
        
        .hero-text {
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }
        
        .category-badge {
            background-color: var(--info-color);
            color: white;
            font-size: 0.8rem;
            font-weight: 600;
            padding: 0.3rem 0.6rem;
            border-radius: 20px;
            display: inline-block;
            margin-bottom: 0.5rem;
        }
        
        .product-price {
            color: var(--primary-color);
            font-size: 1.25rem;
            font-weight: 700;
        }
        
        .product-title {
            font-weight: 700;
            font-size: 1.2rem;
            color: #4e5358;
            margin-bottom: 0.5rem;
            height: 2.5rem;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        
        .product-description {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 1rem;
            height: 4rem;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
        }
        
        .feature-box {
            text-align: center;
            padding: 1.5rem;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            margin-bottom: 2rem;
        }
        
        .feature-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }
        
        footer {
            background-color: #fff;
            box-shadow: 0 -0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            padding: 2rem 0;
            margin-top: 3rem;
        }
        
        .section-title {
            font-weight: 700;
            font-size: 1.8rem;
            margin-bottom: 2rem;
            position: relative;
            padding-bottom: 0.5rem;
        }
        
        .section-title:after {
            content: '';
            position: absolute;
            width: 50px;
            height: 3px;
            background-color: var(--primary-color);
            bottom: 0;
            left: 0;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: var(--primary-color);">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-shopping-cart me-2"></i> E-Shop
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <div class="navbar-nav me-auto">
                    <a class="nav-link active" href="#">
                        <i class="fas fa-home me-1"></i> Home
                    </a>
                    <a class="nav-link" href="#">
                        <i class="fas fa-tags me-1"></i> Categories
                    </a>
                    <a class="nav-link" href="#">
                        <i class="fas fa-percent me-1"></i> Deals
                    </a>
                    <a class="nav-link" href="#">
                        <i class="fas fa-question-circle me-1"></i> Support
                    </a>
                </div>
                
                <div class="navbar-nav ms-auto">
                    <a class="nav-link" href="cart">
                        <i class="fas fa-shopping-cart me-1"></i> Cart
                    </a>
                    <a class="nav-link" href="profileDisplay">
                        <i class="fas fa-user me-1"></i> Profile
                    </a>
                    <a class="nav-link" href="logout">
                        <i class="fas fa-sign-out-alt me-1"></i> Logout
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h1 class="hero-title">Welcome to E-Shop, ${ username }</h1>
                    <p class="hero-text">Discover our amazing products at competitive prices. We offer fast shipping and excellent customer service.</p>
                    <a href="#products" class="btn btn-light btn-lg">
                        <i class="fas fa-shopping-bag me-2"></i> Start Shopping
                    </a>
                </div>
                <div class="col-md-6 text-center">
                    <img src="https://via.placeholder.com/500x300?text=E-Shop" class="img-fluid rounded" alt="E-Shop">
                </div>
            </div>
        </div>
    </div>

    <!-- Features Section -->
    <div class="container mb-5">
        <div class="row">
            <div class="col-md-4">
                <div class="feature-box">
                    <div class="feature-icon">
                        <i class="fas fa-shipping-fast"></i>
                    </div>
                    <h4>Fast Delivery</h4>
                    <p>Free shipping on all orders over $50</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-box">
                    <div class="feature-icon">
                        <i class="fas fa-undo"></i>
                    </div>
                    <h4>Easy Returns</h4>
                    <p>30 days money back guarantee</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-box">
                    <div class="feature-icon">
                        <i class="fas fa-headset"></i>
                    </div>
                    <h4>24/7 Support</h4>
                    <p>Dedicated support team</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Products Section -->
    <div class="container" id="products">
        <h2 class="section-title">Our Products</h2>
        <div class="row g-4">
            <c:forEach var="product" items="${products}">
                <div class="col-md-3">
                    <div class="card">
                        <img class="card-img-top" src="${product.image}" alt="${product.name}">
                        <div class="card-body d-flex flex-column">
                            <span class="category-badge">${product.category.name}</span>
                            <h5 class="product-title">${product.name}</h5>
                            <div class="product-price mb-2">$${product.price}</div>
                            <p class="product-description">${product.description}</p>
                            <div class="mt-auto">
                                <a href="cart/add?id=${product.id}" class="btn btn-primary w-100">
                                    <i class="fas fa-cart-plus me-2"></i> Add to Cart
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5><i class="fas fa-shopping-cart me-2"></i> E-Shop</h5>
                    <p>We provide the best products at the most competitive prices.</p>
                </div>
                <div class="col-md-4">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="#"><i class="fas fa-angle-right me-2"></i> About Us</a></li>
                        <li><a href="#"><i class="fas fa-angle-right me-2"></i> Contact Us</a></li>
                        <li><a href="#"><i class="fas fa-angle-right me-2"></i> Terms & Conditions</a></li>
                        <li><a href="#"><i class="fas fa-angle-right me-2"></i> Privacy Policy</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Contact Info</h5>
                    <address>
                        <i class="fas fa-map-marker-alt me-2"></i> 123 Street, City, Country<br>
                        <i class="fas fa-phone me-2"></i> +1 234 567 8900<br>
                        <i class="fas fa-envelope me-2"></i> info@eshop.com
                    </address>
                    <div class="social-icons">
                        <a href="#" class="me-2"><i class="fab fa-facebook fa-lg"></i></a>
                        <a href="#" class="me-2"><i class="fab fa-twitter fa-lg"></i></a>
                        <a href="#" class="me-2"><i class="fab fa-instagram fa-lg"></i></a>
                        <a href="#" class="me-2"><i class="fab fa-linkedin fa-lg"></i></a>
                    </div>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-md-12 text-center">
                    <p>&copy; 2023 E-Shop. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>