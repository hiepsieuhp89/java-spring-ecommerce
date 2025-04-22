<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Order Details | E-Shop</title>
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
        
        .order-title {
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
        
        .order-status {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            display: inline-block;
            margin-left: 1rem;
        }
        
        .order-status.pending {
            background-color: #fef3c7;
            color: #92400e;
        }
        
        .order-status.processing {
            background-color: #e0f2fe;
            color: #0369a1;
        }
        
        .order-status.shipped {
            background-color: #dbeafe;
            color: #1e40af;
        }
        
        .order-status.delivered {
            background-color: #dcfce7;
            color: #166534;
        }
        
        .order-status.cancelled {
            background-color: #fee2e2;
            color: #991b1b;
        }
        
        .order-info {
            margin-bottom: 2rem;
        }
        
        .order-info-item {
            margin-bottom: 1rem;
        }
        
        .order-info-label {
            font-weight: 600;
            margin-bottom: 0.25rem;
        }
        
        .order-info-value {
            color: var(--text-light);
        }
        
        .order-item {
            display: flex;
            align-items: center;
            padding: 1.5rem;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .order-item:last-child {
            border-bottom: none;
        }
        
        .order-item-image {
            width: 80px;
            height: 80px;
            object-fit: contain;
            margin-right: 1.5rem;
            background-color: #f1f5f9;
            border-radius: 8px;
            padding: 0.5rem;
        }
        
        .order-item-details {
            flex-grow: 1;
        }
        
        .order-item-title {
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 0.5rem;
        }
        
        .order-item-price {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 1.1rem;
        }
        
        .order-item-quantity {
            background-color: #f1f5f9;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            margin-left: 0.5rem;
        }
        
        .order-item-subtotal {
            text-align: right;
            min-width: 100px;
        }
        
        .order-item-subtotal-label {
            color: var(--text-light);
            font-size: 0.9rem;
            margin-bottom: 0.25rem;
        }
        
        .order-item-subtotal-value {
            font-weight: 700;
            font-size: 1.1rem;
        }
        
        .order-summary {
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
                    <a class="nav-link active" href="/orders">
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
        <div class="d-flex align-items-center justify-content-between mb-4">
            <h1 class="order-title mb-0">
                <i class="fas fa-box me-2"></i> Order #${order.id}
                <span class="order-status ${order.status.toLowerCase()}">${order.status}</span>
            </h1>
            <a href="/orders" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left me-2"></i> Back to Orders
            </a>
        </div>
        
        <div class="row g-4">
            <!-- Order Information -->
            <div class="col-lg-4">
                <div class="card mb-4">
                    <div class="card-body">
                        <h5 class="card-title mb-4">Order Information</h5>
                        
                        <div class="order-info">
                            <div class="order-info-item">
                                <div class="order-info-label">Order Date</div>
                                <div class="order-info-value">${order.orderDate}</div>
                            </div>
                            <div class="order-info-item">
                                <div class="order-info-label">Payment Method</div>
                                <div class="order-info-value">${order.paymentMethod}</div>
                            </div>
                            <div class="order-info-item">
                                <div class="order-info-label">Status</div>
                                <div class="order-info-value">
                                    <span class="order-status ${order.status.toLowerCase()}">${order.status}</span>
                                </div>
                            </div>
                        </div>
                        
                        <h5 class="card-title mb-4">Shipping Address</h5>
                        
                        <div class="order-info">
                            <div class="order-info-value">
                                ${order.shippingAddress}
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title mb-4">Order Summary</h5>
                        
                        <div class="order-summary">
                            <div class="summary-item">
                                <span>Subtotal</span>
                                <span>$${order.totalPrice}</span>
                            </div>
                            <div class="summary-item">
                                <span>Shipping</span>
                                <span>Free</span>
                            </div>
                            <div class="summary-item">
                                <span>Total</span>
                                <span>$${order.totalPrice}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Order Items -->
            <div class="col-lg-8">
                <div class="card">
                    <div class="card-body p-0">
                        <div class="p-4 border-bottom">
                            <h5 class="card-title mb-0">Order Items</h5>
                        </div>
                        
                        <c:forEach items="${order.orderItems}" var="item">
                            <div class="order-item">
                                <img src="${item.product.image}" alt="${item.product.name}" class="order-item-image">
                                <div class="order-item-details">
                                    <h5 class="order-item-title">${item.product.name}</h5>
                                    <div>
                                        <span class="order-item-price">$${item.price}</span>
                                        <span class="order-item-quantity">Qty: ${item.quantity}</span>
                                    </div>
                                </div>
                                <div class="order-item-subtotal">
                                    <div class="order-item-subtotal-label">Subtotal</div>
                                    <div class="order-item-subtotal-value">$${item.price * item.quantity}</div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 