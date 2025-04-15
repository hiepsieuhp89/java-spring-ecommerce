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
    <title>Customers | E-Shop Admin</title>
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
            --dark-color: #5a5c69;
            --success-color: #1cc88a;
            --warning-color: #f6c23e;
            --info-color: #36b9cc;
        }
        
        body {
            font-family: 'Nunito', sans-serif;
            background-color: #f8f9fc;
            color: #5a5c69;
        }
        
        .navbar {
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        
        .page-title {
            font-weight: 700;
            margin-bottom: 1.5rem;
        }
        
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
            background-color: var(--accent-color);
            border: none;
            transition: all 0.2s;
        }
        
        .btn-danger:hover {
            background-color: #be3c30;
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
        
        .customer-count {
            color: var(--primary-color);
            font-weight: 600;
        }
        
        .customer-info {
            display: flex;
            align-items: center;
        }
        
        .customer-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--primary-color);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 10px;
            font-weight: 600;
        }
        
        .customer-name {
            font-weight: 600;
            color: var(--dark-color);
        }
        
        .customer-email {
            font-size: 0.875rem;
            color: #858796;
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
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: var(--primary-color);">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-store me-2"></i> E-Shop Admin
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="Dashboard">
                            <i class="fas fa-home me-1"></i> Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout">
                            <i class="fas fa-sign-out-alt me-1"></i> Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
    <!-- Main Content -->
    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="page-title">
                <i class="fas fa-users me-2"></i> Customer Management
            </h2>
            <!-- Optional: Add button for exporting customer data -->
            <button type="button" class="btn btn-primary">
                <i class="fas fa-download me-1"></i> Export Customers
            </button>
        </div>

        <!-- Customers List Card -->
        <div class="card mb-4">
            <div class="card-header py-3 d-flex justify-content-between align-items-center">
                <h6 class="m-0 font-weight-bold text-primary">Customers List</h6>
                <span class="customer-count">${customers.size()} Customers</span>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${customers.size() > 0}">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th scope="col">Customer</th>
                                        <th scope="col">Email</th>
                                        <th scope="col">Address</th>
                                        <th scope="col">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="customer" items="${customers}">
                                        <tr>
                                            <td>
                                                <div class="customer-info">
                                                    <div class="customer-avatar">
                                                        ${fn:substring(customer.username, 0, 1).toUpperCase()}
                                                    </div>
                                                    <div class="customer-name">${customer.username}</div>
                                                </div>
                                            </td>
                                            <td>
                                                <a href="mailto:${customer.email}" class="text-decoration-none">
                                                    <i class="fas fa-envelope me-1 text-muted"></i> ${customer.email}
                                                </a>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty customer.address}">
                                                        <i class="fas fa-map-marker-alt me-1 text-muted"></i> ${customer.address}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">No address provided</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="action-buttons">
                                                <button type="button" class="btn btn-primary btn-sm me-2">
                                                    <i class="fas fa-eye me-1"></i> View
                                                </button>
                                                <button type="button" class="btn btn-danger btn-sm">
                                                    <i class="fas fa-trash me-1"></i> Delete
                                                </button>
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
                                <i class="fas fa-users-slash"></i>
                            </div>
                            <h5>No Customers Found</h5>
                            <p class="text-muted">There are no customers in the database yet.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>