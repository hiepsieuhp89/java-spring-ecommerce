<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Admin Dashboard | E-Shop</title>
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
            border-radius: 5px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            transition: transform 0.3s ease;
        }
        
        .card:hover {
            transform: translateY(-5px);
        }
        
        .card-header {
            background-color: white;
            border-bottom: 1px solid #f1f1f1;
            padding: 1.25rem;
        }
        
        .card-body {
            padding: 1.25rem;
        }
        
        .stat-card {
            border-left: 5px solid;
        }
        
        .stat-card h4 {
            color: var(--dark-color);
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        
        .stat-card-primary {
            border-left-color: var(--primary-color);
        }
        
        .stat-card-success {
            border-left-color: var(--success-color);
        }
        
        .stat-card-info {
            border-left-color: var(--info-color);
        }
        
        .stat-card-warning {
            border-left-color: var(--warning-color);
        }
        
        .admin-card {
            text-align: center;
            height: 100%;
        }
        
        .admin-card .icon {
            font-size: 3rem;
            margin-bottom: 1.25rem;
            color: var(--primary-color);
        }
        
        .admin-card h4 {
            margin-bottom: 1rem;
            font-weight: 600;
        }
        
        .admin-card .btn {
            font-weight: 600;
            padding: 0.5rem 1.5rem;
            border-radius: 5px;
            transition: all 0.3s;
        }
        
        .admin-card .btn:hover {
            transform: translateY(-3px);
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
                <a class="nav-link active" href="/admin/">
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
                <a class="nav-link" href="/admin/products">
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
                <a class="nav-link" href="/admin/logout">
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
                        <a class="dropdown-item" href="#">
                            <i class="fas fa-list fa-sm fa-fw me-2 text-gray-400"></i>
                            Activity Log
                        </a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="/admin/logout">
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
            <div class="d-sm-flex align-items-center justify-content-between page-header">
                <h1>Admin Dashboard</h1>
                <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">
                    <i class="fas fa-download fa-sm text-white-50 me-1"></i> Generate Report
                </a>
            </div>
            
            <!-- Stat Cards Row -->
            <div class="row mb-4">
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card shadow h-100 py-2 stat-card stat-card-primary">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col me-2">
                                    <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                        Orders (Monthly)
                                    </div>
                                    <h4>350</h4>
                                    <div class="text-muted small">+12% from last month</div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-calendar fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card shadow h-100 py-2 stat-card stat-card-success">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col me-2">
                                    <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                        Revenue (Monthly)
                                    </div>
                                    <h4>$29,580</h4>
                                    <div class="text-muted small">+8.3% from last month</div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card shadow h-100 py-2 stat-card stat-card-info">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col me-2">
                                    <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                        Products
                                    </div>
                                    <h4>128</h4>
                                    <div class="text-muted small">Active products</div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-box fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card shadow h-100 py-2 stat-card stat-card-warning">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col me-2">
                                    <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                        Customers
                                    </div>
                                    <h4>528</h4>
                                    <div class="text-muted small">+24 new today</div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-users fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Admin Cards Row -->
            <div class="row">
                <div class="col-lg-4 mb-4">
                    <div class="card shadow mb-4 admin-card">
                        <div class="card-body">
                            <div class="icon">
                                <i class="fas fa-list-alt"></i>
                            </div>
                            <h4>Categories</h4>
                            <p class="mb-4">Manage product categories, add new categories, or edit existing ones.</p>
                            <a href="/admin/categories" class="btn btn-primary">
                                <i class="fas fa-cogs me-1"></i> Manage Categories
                            </a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 mb-4">
                    <div class="card shadow mb-4 admin-card">
                        <div class="card-body">
                            <div class="icon">
                                <i class="fas fa-box"></i>
                            </div>
                            <h4>Products</h4>
                            <p class="mb-4">Add, edit, or remove products from your inventory. Update prices and stock.</p>
                            <a href="/admin/products" class="btn btn-primary">
                                <i class="fas fa-cogs me-1"></i> Manage Products
                            </a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 mb-4">
                    <div class="card shadow mb-4 admin-card">
                        <div class="card-body">
                            <div class="icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <h4>Customers</h4>
                            <p class="mb-4">View customer information, purchase history, and manage accounts.</p>
                            <a href="/admin/customers" class="btn btn-primary">
                                <i class="fas fa-cogs me-1"></i> Manage Customers
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Chart Row -->
            <div class="row">
                <div class="col-xl-8 col-lg-7">
                    <div class="card shadow mb-4">
                        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 class="m-0 font-weight-bold text-primary">Earnings Overview</h6>
                        </div>
                        <div class="card-body">
                            <div class="chart-area" style="height: 320px; position: relative;">
                                <img src="https://via.placeholder.com/800x320?text=Earnings+Chart" class="img-fluid" alt="Earnings Chart">
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-xl-4 col-lg-5">
                    <div class="card shadow mb-4">
                        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 class="m-0 font-weight-bold text-primary">Revenue Sources</h6>
                        </div>
                        <div class="card-body">
                            <div class="chart-pie" style="height: 320px; position: relative;">
                                <img src="https://via.placeholder.com/400x320?text=Revenue+Sources" class="img-fluid" alt="Revenue Sources">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>