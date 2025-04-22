<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Shopping Cart | E-Shop</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #2563eb;
            --secondary-color: #1e40af;
            --accent-color: #3b82f6;
            --background-color: #f8fafc;
            --text-color: #1e293b;
            --text-light: #64748b;
        }
        
        body {
            background-color: var(--background-color);
            font-family: 'Poppins', sans-serif;
            color: var(--text-color);
            padding-top: 76px;
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
        }
        
        .cart-title {
            font-weight: 700;
            margin-bottom: 1.5rem;
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
        
        .btn-danger {
            background-color: #ef4444;
            border: none;
            transition: all 0.3s ease;
        }
        
        .btn-danger:hover {
            background-color: #dc2626;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }
        
        .empty-cart {
            text-align: center;
            padding: 3rem 0;
        }
        
        .empty-cart i {
            font-size: 5rem;
            color: #e2e8f0;
            margin-bottom: 1.5rem;
        }
        
        .empty-cart h3 {
            font-weight: 600;
            margin-bottom: 1rem;
        }
        
        .empty-cart p {
            color: var(--text-light);
            margin-bottom: 2rem;
        }
        
        .cart-item {
            display: flex;
            align-items: center;
            padding: 1.5rem;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .cart-item:last-child {
            border-bottom: none;
        }
        
        .cart-item-image {
            width: 100px;
            height: 100px;
            object-fit: contain;
            margin-right: 1.5rem;
            background-color: #f1f5f9;
            border-radius: 8px;
            padding: 0.5rem;
        }
        
        .cart-item-details {
            flex-grow: 1;
        }
        
        .cart-item-title {
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 0.5rem;
        }
        
        .cart-item-price {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
        }
        
        .cart-item-actions {
            display: flex;
            align-items: center;
        }
        
        .cart-quantity-input {
            width: 80px;
            text-align: center;
            margin: 0 0.5rem;
        }
        
        .cart-summary {
            background-color: #f8fafc;
            padding: 1.5rem;
            border-radius: 16px;
        }
        
        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
        }
        
        .summary-item:last-child {
            border-top: 1px solid #e2e8f0;
            padding-top: 1rem;
            margin-top: 1rem;
            font-weight: 700;
            font-size: 1.2rem;
        }
        
        .alert {
            border-radius: 8px;
            border: none;
            margin-bottom: 1.5rem;
        }
        
        .alert-success {
            background-color: #ecfdf5;
            color: #065f46;
        }
        
        .alert-danger {
            background-color: #fef2f2;
            color: #991b1b;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-shopping-cart me-2"></i> E-Shop
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <div class="navbar-nav me-auto">
                    <a class="nav-link" href="/">
                        <i class="fas fa-home me-1"></i> Home
                    </a>
                    <a class="nav-link" href="/user/products">
                        <i class="fas fa-tags me-1"></i> Products
                    </a>
                </div>
                
                <div class="navbar-nav ms-auto">
                    <a class="nav-link active" href="/cart">
                        <i class="fas fa-shopping-cart me-1"></i> Cart
                    </a>
                    <a class="nav-link" href="/orders">
                        <i class="fas fa-box me-1"></i> Orders
                    </a>
                    <a class="nav-link" href="/profileDisplay">
                        <i class="fas fa-user me-1"></i> Profile
                    </a>
                    <a class="nav-link" href="/logout">
                        <i class="fas fa-sign-out-alt me-1"></i> Logout
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container my-5">
        <h1 class="cart-title">
            <i class="fas fa-shopping-cart me-2"></i> Shopping Cart
        </h1>
        
        <!-- Success or Error Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success" role="alert">
                <i class="fas fa-check-circle me-2"></i> ${successMessage}
            </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i> ${errorMessage}
            </div>
        </c:if>
        
        <div class="row g-4">
            <c:choose>
                <c:when test="${empty cartItems}">
                    <!-- Empty Cart -->
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="empty-cart">
                                    <i class="fas fa-shopping-cart"></i>
                                    <h3>Your cart is empty</h3>
                                    <p>Add some products to your cart to see them here.</p>
                                    <a href="/user/products" class="btn btn-primary">
                                        <i class="fas fa-shopping-bag me-2"></i> Continue Shopping
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Cart Items -->
                    <div class="col-lg-8">
                        <div class="card mb-4">
                            <div class="card-body p-0">
                                <c:forEach items="${cartItems}" var="item">
                                    <div class="cart-item">
                                        <img src="${item.product.image}" alt="${item.product.name}" class="cart-item-image">
                                        <div class="cart-item-details">
                                            <h5 class="cart-item-title">${item.product.name}</h5>
                                            <p class="cart-item-price">$${item.product.price}</p>
                                            <div class="cart-item-actions">
                                                <form action="/cart/update" method="post" class="d-flex align-items-center">
                                                    <input type="hidden" name="itemId" value="${item.id}">
                                                    <label for="quantity" class="form-label me-2 mb-0">Qty:</label>
                                                    <input type="number" name="quantity" value="${item.quantity}" min="1" max="99" class="form-control cart-quantity-input">
                                                    <button type="submit" class="btn btn-sm btn-outline-primary ms-2">
                                                        <i class="fas fa-sync-alt"></i>
                                                    </button>
                                                </form>
                                                <a href="/cart/remove?id=${item.product.id}" class="btn btn-sm btn-danger ms-3">
                                                    <i class="fas fa-trash-alt me-1"></i> Remove
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="d-flex justify-content-between mt-3">
                            <a href="/user/products" class="btn btn-outline-primary">
                                <i class="fas fa-arrow-left me-2"></i> Continue Shopping
                            </a>
                        </div>
                    </div>
                    
                    <!-- Cart Summary -->
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title mb-4">Order Summary</h5>
                                <div class="cart-summary">
                                    <div class="summary-item">
                                        <span>Subtotal</span>
                                        <span>$${cartTotal}</span>
                                    </div>
                                    <div class="summary-item">
                                        <span>Shipping</span>
                                        <span>Free</span>
                                    </div>
                                    <div class="summary-item">
                                        <span>Total</span>
                                        <span>$${cartTotal}</span>
                                    </div>
                                </div>
                                <a href="/checkout" class="btn btn-primary w-100 mt-4">
                                    <i class="fas fa-credit-card me-2"></i> Proceed to Checkout
                                </a>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>