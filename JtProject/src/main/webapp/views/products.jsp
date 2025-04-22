<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import ="java.io.FileOutputStream" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import=" java.io.ObjectOutputStream" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Products | E-Shop Admin</title>
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
            --success-color: #1cc88a;
            --info-color: #36b9cc;
            --warning-color: #f6c23e;
            --danger-color: #e74a3b;
            --dark-color: #5a5c69;
        }
        
        body {
            font-family: 'Nunito', sans-serif;
            background-color: #f8f9fc;
            color: #5a5c69;
        }
        
        /* Sidebar Styles */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            bottom: 0;
            width: 250px;
            background: linear-gradient(180deg, var(--primary-color) 10%, #224abe 100%);
            color: white;
            z-index: 1000;
            transition: all 0.3s;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        
        .sidebar .sidebar-brand {
            height: 70px;
            display: flex;
            align-items: center;
            padding: 0 1.5rem;
            font-size: 1.5rem;
            font-weight: 700;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .sidebar-divider {
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            margin: 1rem 0;
        }
        
        .sidebar .nav-item {
            position: relative;
        }
        
        .sidebar .nav-item .nav-link {
            display: block;
            padding: 1rem 1.5rem;
            color: rgba(255, 255, 255, 0.8);
            font-weight: 600;
            transition: all 0.2s;
        }
        
        .sidebar .nav-item .nav-link:hover,
        .sidebar .nav-item .nav-link.active {
            color: white;
            background-color: rgba(255, 255, 255, 0.1);
            border-left: 4px solid white;
        }
        
        .sidebar .nav-item .nav-link i {
            margin-right: 0.5rem;
            opacity: 0.75;
            width: 18px;
        }
        
        /* Main content */
        .main-content {
            margin-left: 250px;
            padding: 20px;
            transition: all 0.3s;
        }
        
        /* Navbar */
        .topbar {
            height: 70px;
            background-color: white;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        
        .topbar .dropdown-toggle::after {
            display: none;
        }
        
        .topbar .nav-item .nav-link {
            color: #5a5c69;
            position: relative;
            height: 4.375rem;
            display: flex;
            align-items: center;
        }
        
        .topbar .nav-item .nav-link:hover {
            color: var(--primary-color);
        }
        
        /* Cards */
        .card {
            border: none;
            border-radius: 8px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
        }
        
        .table {
            color: var(--dark-color);
        }
        
        .table th {
            font-weight: 600;
            background-color: #f8f9fc;
            border-top: none;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border: none;
            transition: all 0.2s;
        }
        
        .btn-primary:hover {
            background-color: #2e59d9;
            transform: translateY(-2px);
        }
        
        .btn-danger {
            background-color: var(--danger-color);
            border: none;
            transition: all 0.2s;
        }
        
        .btn-danger:hover {
            background-color: #be3c30;
            transform: translateY(-2px);
        }
        
        .btn-warning {
            background-color: var(--warning-color);
            border: none;
            color: white;
            transition: all 0.2s;
        }
        
        .btn-warning:hover {
            background-color: #dda20a;
            color: white;
            transform: translateY(-2px);
        }
        
        .btn-sm {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
            border-radius: 0.2rem;
        }
        
        .action-buttons {
            white-space: nowrap;
        }
        
        .table-responsive {
            overflow-x: auto;
        }
        
        .product-count {
            color: var(--primary-color);
            font-weight: 600;
        }
        
        .product-image {
            width: 80px;
            height: 80px;
            object-fit: contain;
            border-radius: 5px;
            background-color: #fff;
            padding: 5px;
            border: 1px solid #e3e6f0;
        }
        
        .category-badge {
            background-color: var(--info-color);
            color: white;
            font-size: 0.7rem;
            padding: 0.35em 0.65em;
            border-radius: 50rem;
            display: inline-block;
            font-weight: 600;
        }
        
        .product-name {
            font-weight: 600;
            color: var(--dark-color);
        }
        
        .product-desc {
            max-width: 250px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .price {
            font-weight: 700;
            color: var(--primary-color);
        }
        
        .empty-state {
            text-align: center;
            padding: 2rem;
        }
        
        .empty-state-icon {
            font-size: 3rem;
            color: #d1d3e2;
            margin-bottom: 1rem;
        }
        
        /* Page heading */
        .page-header {
            margin-bottom: 2rem;
        }
        
        .page-header h1 {
            color: var(--dark-color);
            font-weight: 700;
            font-size: 1.75rem;
        }
        
        @media (max-width: 768px) {
            .sidebar {
                width: 6.5rem;
                overflow: hidden;
            }
            
            .sidebar .sidebar-brand {
                justify-content: center;
                padding: 0;
            }
            
            .sidebar .sidebar-brand-text {
                display: none;
            }
            
            .sidebar .nav-item .nav-link {
                text-align: center;
                padding: 0.75rem 1rem;
            }
            
            .sidebar .nav-item .nav-link span {
                display: none;
            }
            
            .sidebar .nav-item .nav-link i {
                margin-right: 0;
                font-size: 1.25rem;
            }
            
            .main-content {
                margin-left: 6.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-brand">
            <i class="fas fa-store me-2"></i>
            <span class="sidebar-brand-text">E-Shop Admin</span>
        </div>
        <hr class="sidebar-divider">
        <div class="nav">
            <div class="nav-item">
                <a class="nav-link" href="/admin/">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </div>
            <hr class="sidebar-divider">
            <div class="nav-item">
                <a class="nav-link" href="/admin/categories">
                    <i class="fas fa-fw fa-list-alt"></i>
                    <span>Categories</span>
                </a>
            </div>
            <div class="nav-item">
                <a class="nav-link active" href="/admin/products">
                    <i class="fas fa-fw fa-box"></i>
                    <span>Products</span>
                </a>
            </div>
            <div class="nav-item">
                <a class="nav-link" href="/admin/customers">
                    <i class="fas fa-fw fa-users"></i>
                    <span>Customers</span>
                </a>
            </div>
            <hr class="sidebar-divider">
            <div class="nav-item">
                <a class="nav-link" href="/admin/orders">
                    <i class="fas fa-fw fa-shopping-cart"></i>
                    <span>Orders</span>
                </a>
            </div>
            <div class="nav-item">
                <a class="nav-link" href="/admin/reports">
                    <i class="fas fa-fw fa-chart-line"></i>
                    <span>Reports</span>
                </a>
            </div>
            <hr class="sidebar-divider">
            <div class="nav-item">
                <a class="nav-link" href="/admin/settings">
                    <i class="fas fa-fw fa-cog"></i>
                    <span>Settings</span>
                </a>
            </div>
            <div class="nav-item">
                <a class="nav-link" href="/logout">
                    <i class="fas fa-fw fa-sign-out-alt"></i>
                    <span>Logout</span>
                </a>
            </div>
        </div>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
            <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle me-3">
                <i class="fa fa-bars"></i>
            </button>
            
            <div class="d-none d-sm-inline-block form-inline me-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                <div class="input-group">
                    <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="button">
                            <i class="fas fa-search fa-sm"></i>
                        </button>
                    </div>
                </div>
            </div>
            
            <!-- Topbar Navbar -->
            <ul class="navbar-nav ms-auto">
                <li class="nav-item dropdown no-arrow">
                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span class="me-2 d-none d-lg-inline text-gray-600 small">Admin User</span>
                        <img class="img-profile rounded-circle" src="https://via.placeholder.com/60" width="32" height="32">
                    </a>
                    <!-- Dropdown - User Information -->
                    <div class="dropdown-menu dropdown-menu-end shadow animated--grow-in" aria-labelledby="userDropdown">
                        <a class="dropdown-item" href="#">
                            <i class="fas fa-user fa-sm fa-fw me-2 text-gray-400"></i>
                            Profile
                        </a>
                        <a class="dropdown-item" href="#">
                            <i class="fas fa-cogs fa-sm fa-fw me-2 text-gray-400"></i>
                            Settings
                        </a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="/logout">
                            <i class="fas fa-sign-out-alt fa-sm fa-fw me-2 text-gray-400"></i>
                            Logout
                        </a>
                    </div>
                </li>
            </ul>
        </nav>
        
        <!-- Page Content -->
        <div class="container-fluid">
            <!-- Page Heading -->
            <div class="d-sm-flex align-items-center justify-content-between mb-4">
                <h1 class="h3 mb-0 text-gray-800">Products Management</h1>
                <a href="/admin/products/add" class="btn btn-primary">
                    <i class="fas fa-plus me-1"></i> Add Product
                </a>
            </div>

            <!-- Alert Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <strong>Error!</strong> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <strong>Error!</strong> ${param.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            
            <c:if test="${not empty param.success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <strong>Success!</strong> ${param.success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            
            <!-- Category Filter if category is selected -->
            <c:if test="${not empty categoryName}">
                <div class="alert alert-info mb-4">
                    <i class="fas fa-filter me-2"></i> Showing products in category: <strong>${categoryName}</strong>
                    <a href="/admin/products" class="btn btn-sm btn-outline-primary float-end">
                        <i class="fas fa-times me-1"></i> Clear Filter
                    </a>
                </div>
            </c:if>

            <!-- Products List Card -->
            <div class="card mb-4">
                <div class="card-header py-3 d-flex justify-content-between align-items-center">
                    <h6 class="m-0 font-weight-bold text-primary">Product List</h6>
                    <span class="product-count">${products.size()} Products</span>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${products.size() > 0}">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
                                    <thead>
                                        <tr>
                                            <th scope="col">ID</th>
                                            <th scope="col">Image</th>
                                            <th scope="col">Product Details</th>
                                            <th scope="col">Category</th>
                                            <th scope="col">Price</th>
                                            <th scope="col">Quantity</th>
                                            <th scope="col">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="product" items="${products}">
                                            <tr>
                                                <td>${product.id}</td>
                                                <td>
                                                    <img src="${product.image}" class="product-image" alt="${product.name}">
                                                </td>
                                                <td>
                                                    <div class="product-name">${product.name}</div>
                                                    <div class="product-desc text-muted small">${product.description}</div>
                                                    <div class="small text-muted mt-1">Weight: ${product.weight}g</div>
                                                </td>
                                                <td>
                                                    <span class="category-badge">${product.category.name}</span>
                                                </td>
                                                <td class="price">$${product.price}</td>
                                                <td>
                                                    <span class="badge bg-secondary">${product.quantity} in stock</span>
                                                </td>
                                                <td class="action-buttons">
                                                    <form action="products/update/${product.id}" method="get" class="d-inline">
                                                        <button type="submit" class="btn btn-warning btn-sm me-1">
                                                            <i class="fas fa-edit me-1"></i> Edit
                                                        </button>
                                                    </form>
                                                    <form action="products/delete" method="get" class="d-inline">
                                                        <input type="hidden" name="id" value="${product.id}">
                                                        <button type="submit" class="btn btn-danger btn-sm">
                                                            <i class="fas fa-trash me-1"></i> Delete
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <div class="empty-state-icon">
                                    <i class="fas fa-box-open"></i>
                                </div>
                                <h5>No Products Found</h5>
                                <p class="text-muted">There are no products in the database yet.</p>
                                <a href="/admin/products/add" class="btn btn-primary">
                                    <i class="fas fa-plus me-1"></i> Add First Product
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>