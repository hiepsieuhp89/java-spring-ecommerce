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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- AOS Animation Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #2563eb;
            --secondary-color: #1e40af;
            --accent-color: #3b82f6;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --info-color: #06b6d4;
            --background-color: #f8fafc;
            --text-color: #1e293b;
            --text-light: #64748b;
        }
        
        body {
            background-color: var(--background-color);
            font-family: 'Poppins', sans-serif;
            color: var(--text-color);
        }
        
        .navbar {
            background-color: rgba(255, 255, 255, 0.95) !important;
            backdrop-filter: blur(10px);
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            padding: 1rem 0;
        }

        .navbar-brand {
            font-weight: 700;
            color: var(--primary-color) !important;
            font-size: 1.5rem;
        }

        .nav-link {
            color: var(--text-color) !important;
            font-weight: 500;
            transition: all 0.3s ease;
            position: relative;
        }

        .nav-link:after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            background: var(--primary-color);
            bottom: 0;
            left: 0;
            transition: width 0.3s ease;
        }

        .nav-link:hover:after {
            width: 100%;
        }
        
        .card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            overflow: hidden;
            height: 100%;
        }
        
        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        
        .card-img-top {
            height: 220px;
            object-fit: cover;
            background-color: #fff;
            padding: 1rem;
            transition: transform 0.4s ease;
        }

        .card:hover .card-img-top {
            transform: scale(1.05);
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }
        
        .hero-section {
            min-height: 600px;
            display: flex;
            align-items: center;
            padding: 4rem 0;
            margin-top: 76px;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="rgba(255,255,255,0.1)" fill-opacity="1" d="M0,96L48,112C96,128,192,160,288,160C384,160,480,128,576,112C672,96,768,96,864,112C960,128,1056,160,1152,160C1248,160,1344,128,1392,112L1440,96L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
            background-position: bottom;
            background-repeat: no-repeat;
            opacity: 0.6;
        }
        
        .hero-title {
            font-weight: 800;
            font-size: 3.5rem;
            margin-bottom: 1.5rem;
            line-height: 1.2;
        }
        
        .hero-text {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            opacity: 0.9;
            line-height: 1.6;
        }
        
        .category-badge {
            background-color: var(--accent-color);
            color: white;
            font-size: 0.8rem;
            font-weight: 600;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            display: inline-block;
            margin-bottom: 0.8rem;
            transition: all 0.3s ease;
        }

        .category-badge:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }
        
        .product-price {
            color: var(--primary-color);
            font-size: 1.5rem;
            font-weight: 700;
        }
        
        .product-title {
            font-weight: 600;
            font-size: 1.2rem;
            color: var(--text-color);
            margin-bottom: 0.8rem;
            height: 2.8rem;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        
        .product-description {
            color: var(--text-light);
            font-size: 0.95rem;
            margin-bottom: 1.2rem;
            height: 4.2rem;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            line-height: 1.5;
        }
        
        .feature-box {
            text-align: center;
            padding: 2rem;
            background-color: white;
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
        }
        
        .feature-box::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .feature-box:hover::before {
            transform: scaleX(1);
        }
        
        .feature-box:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
        }
        
        .feature-icon {
            font-size: 2.8rem;
            color: var(--primary-color);
            margin-bottom: 1.2rem;
            transition: all 0.3s ease;
        }

        .feature-box:hover .feature-icon {
            transform: scale(1.1);
        }
        
        footer {
            background-color: #fff;
            box-shadow: 0 -1px 3px rgba(0, 0, 0, 0.1);
            padding: 4rem 0 2rem;
            margin-top: 5rem;
        }
        
        .section-title {
            font-weight: 700;
            font-size: 2.2rem;
            margin-bottom: 3rem;
            position: relative;
            padding-bottom: 1rem;
            text-align: center;
        }
        
        .section-title:after {
            content: '';
            position: absolute;
            width: 80px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            border-radius: 2px;
        }
        
        .social-icons a {
            color: var(--primary-color);
            transition: all 0.3s ease;
            margin: 0 0.5rem;
            font-size: 1.5rem;
        }
        
        .social-icons a:hover {
            color: var(--secondary-color);
            transform: translateY(-3px);
        }
        
        footer a {
            color: var(--text-color);
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-block;
            margin-bottom: 0.5rem;
        }
        
        footer a:hover {
            color: var(--primary-color);
            transform: translateX(5px);
        }
        
        .search-form {
            position: relative;
            max-width: 600px;
            margin: 0 auto;
        }
        
        .search-form input {
            height: 54px;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            padding-left: 20px;
            padding-right: 60px;
            background: rgba(255, 255, 255, 0.1);
            color: white;
            font-size: 1.1rem;
            backdrop-filter: blur(5px);
        }

        .search-form input::placeholder {
            color: rgba(255, 255, 255, 0.8);
        }

        .search-form input:focus {
            outline: none;
            border-color: rgba(255, 255, 255, 0.4);
            box-shadow: 0 0 0 4px rgba(255, 255, 255, 0.1);
        }
        
        .search-form button {
            position: absolute;
            right: 8px;
            top: 7px;
            height: 40px;
            width: 40px;
            background-color: rgba(255, 255, 255, 0.2);
            border: none;
            border-radius: 8px;
            color: white;
            transition: all 0.3s ease;
        }

        .search-form button:hover {
            background-color: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        /* Animation classes */
        .fade-up {
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.6s ease;
        }

        .fade-up.active {
            opacity: 1;
            transform: translateY(0);
        }

        /* Container max-width control */
        .container {
            max-width: 1280px;
            padding: 0 1rem;
        }

        /* Hero Section Improvements */
        .hero-img {
            max-height: 400px;
            width: 100%;
            object-fit: cover;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }

        /* Category Cards */
        .category-card {
            aspect-ratio: 16/9;
            height: auto;
            max-height: 250px;
        }

        .category-card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /* Product Cards Improvements */
        .product-card {
            position: relative;
            background: #fff;
            border: none;
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.3s ease;
            height: 100%;
            max-width: 300px;
            margin: 0 auto;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }

        .product-card .card-body {
            padding: 1.5rem;
        }

        .product-card .product-image-wrapper {
            position: relative;
            padding-top: 100%; /* 1:1 Aspect Ratio */
            background: #f8f9fa;
            overflow: hidden;
        }

        .product-card .product-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: contain;
            padding: 1rem;
            transition: transform 0.3s ease;
        }

        .product-card:hover .product-image {
            transform: scale(1.05);
        }

        .product-card .category-tag {
            position: absolute;
            top: 1rem;
            left: 1rem;
            background: rgba(37, 99, 235, 0.1);
            color: var(--primary-color);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
            z-index: 1;
        }

        .product-card .product-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-color);
            margin: 0.5rem 0;
            line-height: 1.4;
        }

        .product-card .product-price {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin: 0.5rem 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .product-card .product-price .currency {
            font-size: 1rem;
            font-weight: 500;
            color: var(--text-light);
        }

        .product-card .product-description {
            font-size: 0.95rem;
            color: var(--text-light);
            margin-bottom: 1rem;
            line-height: 1.6;
        }

        .product-card .rating {
            display: flex;
            align-items: center;
            gap: 0.25rem;
            margin-bottom: 0.5rem;
        }

        .product-card .rating i {
            color: #ffc107;
            font-size: 1rem;
        }

        .product-card .rating .rating-text {
            font-size: 0.9rem;
            color: var(--text-light);
            margin-left: 0.5rem;
        }

        .product-card .btn-add-to-cart {
            width: 100%;
            padding: 0.75rem;
            border-radius: 8px;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }

        .product-card .btn-add-to-cart:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.2);
        }

        .product-card .product-badge {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: var(--accent-color);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
            z-index: 1;
        }

        /* Responsive adjustments for product cards */
        @media (max-width: 768px) {
            .product-card {
                max-width: none;
            }

            .product-card .product-title {
                font-size: 1.1rem;
            }

            .product-card .product-price {
                font-size: 1.25rem;
            }

            .product-card .product-description {
                font-size: 0.9rem;
            }
        }

        @media (max-width: 576px) {
            .product-card .card-body {
                padding: 1rem;
            }

            .product-card .product-image-wrapper {
                padding-top: 75%; /* 4:3 Aspect Ratio for mobile */
            }
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg fixed-top">
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
                    <a class="nav-link" href="orders">
                        <i class="fas fa-box me-1"></i> My Orders
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

    <!-- Flash Messages -->
    <div class="container" style="margin-top: 90px;">
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i> ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i> ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
    </div>

    <!-- Hero Section -->
    <div class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6" data-aos="fade-right">
                    <h1 class="hero-title">Welcome to E-Shop, ${ username }</h1>
                    <p class="hero-text">Discover our amazing products at competitive prices. We offer fast shipping and excellent customer service.</p>
                    <div class="search-form mb-4">
                        <input type="text" class="form-control" placeholder="Search for products..." aria-label="Search">
                        <button type="submit">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                    <div class="d-flex gap-3">
                        <a href="#products" class="btn btn-light btn-lg">
                            <i class="fas fa-shopping-bag me-2"></i> Start Shopping
                        </a>
                        <a href="orders" class="btn btn-outline-light btn-lg">
                            <i class="fas fa-box me-2"></i> View My Orders
                        </a>
                    </div>
                </div>
                <div class="col-md-6 text-center" data-aos="fade-left">
                    <img src="https://images.unsplash.com/photo-1607082349566-187342175e2f?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" 
                         class="hero-img" alt="E-Shop">
                </div>
            </div>
        </div>
    </div>

    <!-- Categories Section -->
    <div class="container mb-5">
        <h2 class="section-title" data-aos="fade-up">Popular Categories</h2>
        <div class="row g-4">
            <div class="col-md-3" data-aos="fade-up" data-aos-delay="100">
                <div class="category-card">
                    <img src="https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" alt="Electronics">
                    <div class="category-content">
                        <h3>Electronics</h3>
                        <p>200+ Products</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3" data-aos="fade-up" data-aos-delay="200">
                <div class="category-card">
                    <img src="https://images.unsplash.com/photo-1441986300917-64674bd600d8?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" alt="Fashion">
                    <div class="category-content">
                        <h3>Fashion</h3>
                        <p>350+ Products</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3" data-aos="fade-up" data-aos-delay="300">
                <div class="category-card">
                    <img src="https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" alt="Home & Living">
                    <div class="category-content">
                        <h3>Home & Living</h3>
                        <p>150+ Products</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3" data-aos="fade-up" data-aos-delay="400">
                <div class="category-card">
                    <img src="https://images.unsplash.com/photo-1470309864661-68328b2cd0a5?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" alt="Beauty">
                    <div class="category-content">
                        <h3>Beauty</h3>
                        <p>180+ Products</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Features Section with new design -->
    <div class="features-section py-5 mb-5">
        <div class="container">
            <h2 class="section-title" data-aos="fade-up">Why Choose Us</h2>
            <div class="row">
                <div class="col-md-3" data-aos="fade-up" data-aos-delay="100">
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="fas fa-shipping-fast"></i>
                        </div>
                        <h4 class="mb-3">Fast Delivery</h4>
                        <p class="mb-0">Free shipping on orders over $50. 2-3 business days delivery.</p>
                    </div>
                </div>
                <div class="col-md-3" data-aos="fade-up" data-aos-delay="200">
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="fas fa-undo"></i>
                        </div>
                        <h4 class="mb-3">Easy Returns</h4>
                        <p class="mb-0">30 days return policy. No questions asked money back guarantee.</p>
                    </div>
                </div>
                <div class="col-md-3" data-aos="fade-up" data-aos-delay="300">
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="fas fa-headset"></i>
                        </div>
                        <h4 class="mb-3">24/7 Support</h4>
                        <p class="mb-0">Round the clock support. Call us anytime at +1 234 567 8900.</p>
                    </div>
                </div>
                <div class="col-md-3" data-aos="fade-up" data-aos-delay="400">
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h4 class="mb-3">Secure Payment</h4>
                        <p class="mb-0">100% secure payment methods. Multiple payment options available.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- New Arrivals Section -->
    <div class="container mb-5 new-arrivals">
        <h2 class="section-title" data-aos="fade-up">New Arrivals</h2>
        <div class="row g-4">
            <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="100">
                <div class="product-card">
                    <div class="badge">New</div>
                    <img src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" alt="Headphones">
                    <div class="product-details">
                        <h3>Wireless Headphones</h3>
                        <div class="rating">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star-half-alt"></i>
                            <span>(4.5)</span>
                        </div>
                        <p class="price">$129.99</p>
                        <button class="btn btn-primary w-100">Add to Cart</button>
                    </div>
                </div>
            </div>
            <!-- Add more new arrival products as needed -->
        </div>
    </div>

    <!-- Products Section -->
    <div class="container" id="products">
        <h2 class="section-title" data-aos="fade-up">Our Products</h2>
        <div class="row g-4">
            <c:forEach var="product" items="${products}" varStatus="status">
                <div class="col-md-3" data-aos="fade-up" data-aos-delay="${status.index * 100}">
                    <div class="product-card">
                        <div class="product-image-wrapper">
                            <span class="category-tag">${product.category.name}</span>
                            <img class="product-image" src="${product.image}" alt="${product.name}">
                        </div>
                        <div class="card-body">
                            <h3 class="product-title">${product.name}</h3>
                            <div class="rating">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star-half-alt"></i>
                                <span class="rating-text">(4.5)</span>
                            </div>
                            <div class="product-price">
                                <span class="currency">$</span>${product.price}
                            </div>
                            <p class="product-description">${product.description}</p>
                            <c:choose>
                                <c:when test="${product.quantity > 0}">
                                    <form action="cart/add" method="get" class="d-grid">
                                        <input type="hidden" name="id" value="${product.id}">
                                        <div class="d-flex mb-2">
                                            <input type="number" name="quantity" value="1" min="1" max="${product.quantity}" class="form-control me-2" style="max-width: 80px;">
                                            <button type="submit" class="btn btn-primary flex-grow-1">
                                                <i class="fas fa-cart-plus me-1"></i> Add to Cart
                                            </button>
                                        </div>
                                        <small class="text-muted">${product.quantity} in stock</small>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-secondary w-100" disabled>
                                        <i class="fas fa-times-circle me-1"></i> Out of Stock
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Newsletter Section -->
    <div class="newsletter-section py-5 my-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8 text-center">
                    <h2 class="section-title" data-aos="fade-up">Subscribe to Our Newsletter</h2>
                    <p class="mb-4" data-aos="fade-up">Stay updated with our latest products and offers!</p>
                    <form class="newsletter-form" data-aos="fade-up">
                        <div class="input-group">
                            <input type="email" class="form-control" placeholder="Enter your email">
                            <button class="btn btn-primary" type="submit">Subscribe</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-4" data-aos="fade-up">
                    <h5 class="mb-4"><i class="fas fa-shopping-cart me-2"></i> E-Shop</h5>
                    <p class="mb-4">We provide the best products at the most competitive prices.</p>
                    <div class="social-icons">
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-linkedin"></i></a>
                    </div>
                </div>
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
                    <h5 class="mb-4">Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="#"><i class="fas fa-angle-right me-2"></i> About Us</a></li>
                        <li><a href="#"><i class="fas fa-angle-right me-2"></i> Contact Us</a></li>
                        <li><a href="#"><i class="fas fa-angle-right me-2"></i> Terms & Conditions</a></li>
                        <li><a href="#"><i class="fas fa-angle-right me-2"></i> Privacy Policy</a></li>
                    </ul>
                </div>
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
                    <h5 class="mb-4">Contact Info</h5>
                    <address>
                        <p><i class="fas fa-map-marker-alt me-2"></i> 123 Street, City, Country</p>
                        <p><i class="fas fa-phone me-2"></i> +1 234 567 8900</p>
                        <p><i class="fas fa-envelope me-2"></i> info@eshop.com</p>
                    </address>
                </div>
            </div>
            <hr class="my-4">
            <div class="row">
                <div class="col-md-12 text-center">
                    <p class="mb-0">&copy; 2023 E-Shop. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- AOS Animation Library -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({
            duration: 800,
            once: true
        });

        // Smooth scroll for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });
    </script>
</body>
</html>