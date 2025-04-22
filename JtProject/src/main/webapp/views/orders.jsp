<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>My Orders | E-Shop</title>
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
        
        .orders-title {
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
        
        .order-card {
            transition: all 0.3s ease;
            margin-bottom: 1.5rem;
        }
        
        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }
        
        .order-header {
            display: flex;
            justify-content: space-between;
            padding: 1rem 1.5rem;
            background-color: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .order-id {
            font-weight: 700;
            color: var(--primary-color);
        }
        
        .order-date {
            color: var(--text-light);
            font-size: 0.9rem;
        }
        
        .order-content {
            padding: 1.5rem;
        }
        
        .order-item {
            display: flex;
            margin-bottom: 1rem;
        }
        
        .order-item:last-child {
            margin-bottom: 0;
        }
        
        .order-item-image {
            width: 60px;
            height: 60px;
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
            margin-bottom: 0.25rem;
        }
        
        .order-item-quantity {
            font-size: 0.9rem;
            color: var(--text-light);
        }
        
        .order-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 1.5rem;
            background-color: #f8fafc;
            border-top: 1px solid #e2e8f0;
        }
        
        .order-total {
            font-weight: 700;
        }
        
        .order-status {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
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
        
        .empty-orders {
            text-align: center;
            padding: 3rem 0;
        }
        
        .empty-orders i {
            font-size: 5rem;
            color: #e2e8f0;
            margin-bottom: 1.5rem;
        }
        
        .empty-orders h3 {
            font-weight: 600;
            margin-bottom: 1rem;
        }
        
        .empty-orders p {
            color: var(--text-light);
            margin-bottom: 2rem;
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
        <h1 class="orders-title">
            <i class="fas fa-box me-2"></i> My Orders
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
        
        <c:choose>
            <c:when test="${empty orders}">
                <!-- Empty Orders -->
                <div class="card">
                    <div class="card-body">
                        <div class="empty-orders">
                            <i class="fas fa-box-open"></i>
                            <h3>No Orders Yet</h3>
                            <p>You haven't placed any orders yet. Start shopping to place your first order!</p>
                            <a href="/user/products" class="btn btn-primary">
                                <i class="fas fa-shopping-bag me-2"></i> Browse Products
                            </a>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Orders List -->
                <c:forEach items="${orders}" var="order">
                    <div class="card order-card">
                        <div class="order-header">
                            <div>
                                <span class="order-id">Order #${order.id}</span>
                                <span class="order-date">Placed on ${order.orderDate}</span>
                            </div>
                            <a href="/orders/${order.id}" class="btn btn-sm btn-outline-primary">
                                View Details
                            </a>
                        </div>
                        <div class="order-content">
                            <c:forEach items="${order.orderItems}" var="item" begin="0" end="2">
                                <div class="order-item">
                                    <img src="${item.product.image}" alt="${item.product.name}" class="order-item-image">
                                    <div class="order-item-details">
                                        <h6 class="order-item-title">${item.product.name}</h6>
                                        <div class="order-item-quantity">Qty: ${item.quantity} X $${item.price}</div>
                                    </div>
                                </div>
                            </c:forEach>
                            
                            <c:if test="${order.orderItems.size() > 3}">
                                <div class="text-center mt-2">
                                    <a href="/orders/${order.id}" class="btn btn-sm btn-link">
                                        +${order.orderItems.size() - 3} more items
                                    </a>
                                </div>
                            </c:if>
                        </div>
                        <div class="order-footer">
                            <div class="order-total">Total: $${order.totalPrice}</div>
                            <div class="order-status ${order.status.toLowerCase()}">
                                ${order.status}
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 