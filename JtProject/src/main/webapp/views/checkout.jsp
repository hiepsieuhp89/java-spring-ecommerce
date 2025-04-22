<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Checkout | E-Shop</title>
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
        
        .checkout-title {
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
        
        .payment-method {
            margin-bottom: 1rem;
        }
        
        .payment-method-option {
            padding: 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .payment-method-option:hover {
            border-color: var(--accent-color);
        }
        
        .payment-method-option.active {
            border-color: var(--primary-color);
            background-color: rgba(37, 99, 235, 0.1);
        }
        
        .payment-icon {
            font-size: 1.5rem;
            margin-right: 0.5rem;
            color: var(--primary-color);
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
        
        .order-item {
            display: flex;
            align-items: center;
            padding: 0.75rem 0;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .order-item:last-child {
            border-bottom: none;
        }
        
        .order-item-image {
            width: 50px;
            height: 50px;
            object-fit: contain;
            margin-right: 1rem;
            background-color: #f1f5f9;
            border-radius: 8px;
            padding: 0.25rem;
        }
        
        .order-item-details {
            flex-grow: 1;
        }
        
        .order-item-title {
            font-weight: 600;
            font-size: 0.9rem;
            margin-bottom: 0.25rem;
        }
        
        .order-item-price {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 1rem;
        }
        
        .order-item-quantity {
            margin-left: auto;
            background-color: #f1f5f9;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
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
                    <a class="nav-link" href="/cart">
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
        <h1 class="checkout-title">
            <i class="fas fa-credit-card me-2"></i> Checkout
        </h1>
        
        <div class="row g-4">
            <!-- Shipping and Payment Information -->
            <div class="col-lg-8">
                <div class="card mb-4">
                    <div class="card-body">
                        <h5 class="card-title mb-4">Shipping Address</h5>
                        
                        <form action="/placeOrder" method="post" id="checkoutForm">
                            <div class="mb-3">
                                <label for="shippingAddress" class="form-label">Shipping Address</label>
                                <textarea class="form-control" id="shippingAddress" name="shippingAddress" rows="3" required>${user.address}</textarea>
                            </div>
                            
                            <h5 class="card-title mb-3 mt-4">Payment Method</h5>
                            
                            <div class="payment-method">
                                <div class="payment-method-option active">
                                    <input type="radio" name="paymentMethod" id="creditCard" value="Credit Card" class="form-check-input" checked>
                                    <label for="creditCard" class="form-check-label">
                                        <i class="fab fa-cc-visa payment-icon"></i>
                                        <i class="fab fa-cc-mastercard payment-icon"></i>
                                        Credit Card
                                    </label>
                                </div>
                                <div class="payment-method-option">
                                    <input type="radio" name="paymentMethod" id="paypal" value="PayPal" class="form-check-input">
                                    <label for="paypal" class="form-check-label">
                                        <i class="fab fa-paypal payment-icon"></i>
                                        PayPal
                                    </label>
                                </div>
                                <div class="payment-method-option">
                                    <input type="radio" name="paymentMethod" id="cashOnDelivery" value="Cash on Delivery" class="form-check-input">
                                    <label for="cashOnDelivery" class="form-check-label">
                                        <i class="fas fa-money-bill-wave payment-icon"></i>
                                        Cash on Delivery
                                    </label>
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-check-circle me-2"></i> Place Order
                                </button>
                                <a href="/cart" class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left me-2"></i> Return to Cart
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            
            <!-- Order Summary -->
            <div class="col-lg-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title mb-4">Order Summary</h5>
                        
                        <div class="order-items mb-4">
                            <c:forEach items="${cartItems}" var="item">
                                <div class="order-item">
                                    <img src="${item.product.image}" alt="${item.product.name}" class="order-item-image">
                                    <div class="order-item-details">
                                        <h6 class="order-item-title">${item.product.name}</h6>
                                        <p class="order-item-price">$${item.product.price}</p>
                                    </div>
                                    <div class="order-item-quantity">
                                        Qty: ${item.quantity}
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        
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
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Handle payment method selection
            const paymentOptions = document.querySelectorAll('.payment-method-option');
            
            paymentOptions.forEach(option => {
                option.addEventListener('click', function() {
                    // Clear active class from all options
                    paymentOptions.forEach(opt => opt.classList.remove('active'));
                    
                    // Add active class to clicked option
                    this.classList.add('active');
                    
                    // Check the radio button
                    const radio = this.querySelector('input[type="radio"]');
                    radio.checked = true;
                });
            });
        });
    </script>
</body>
</html> 