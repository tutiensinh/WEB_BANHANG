<%-- File: header.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <%-- Lấy tiêu đề động từ trang gọi nó --%>
        <title>${param.title} - NinhBinhStore</title>

        <%-- Các link CSS chung --%>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

        <%-- Link tới file CSS tùy chỉnh của bạn (đã tách ở bước trước) --%>
        <link rel="stylesheet" href="css/style.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body>

        <%-- Thanh thông tin trên cùng (Hotline, Email) --%>
        <div class="bg-light border-bottom d-none d-lg-block">
            <div class="container d-flex justify-content-between py-1">
                <div class="d-flex">
                    <a href="tel:19001234" class="text-decoration-none text-muted me-3" style="font-size: 0.9rem;"><i class="bi bi-telephone-fill"></i> Hotline: 1900 1234</a>
                    <a href="mailto:info@NinhBinhStore.com" class="text-decoration-none text-muted" style="font-size: 0.9rem;"><i class="bi bi-envelope-fill"></i> info@NinhBinhStore.com</a> 
                </div>
                <div>
                    <a href="OrderHistoryServlet" class="text-decoration-none text-muted" style="font-size: 0.9rem;">Lịch sử mua hàng</a>
                </div>
            </div>
        </div>

        <%-- Thanh điều hướng chính (Navbar) --%>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
            <div class="container">
                <a class="navbar-brand fw-bold fs-4" href="HomeServlet">NinhBinhStore</a> 
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
                    <span class="navbar-toggler-icon"></span> 
                </button>
                <div class="collapse navbar-collapse" id="mainNav"> 
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <%-- Logic JSTL để làm nổi bật link "active" --%>
                        <c:set var="activePage" value="${param.title}"/>

                        <li class="nav-item"><a class="nav-link ${activePage == 'Trang chủ' ? 'active' : ''}" href="HomeServlet">Trang chủ</a></li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle ${activePage == 'Tất cả sản phẩm' or activePage == 'Danh mục' ? 'active' : ''}" href="#" id="navbarDropdownProducts" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Sản phẩm
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdownProducts">
                                <%-- Tải danh mục từ Application Scope (từ Listener) --%>
                                <c:forEach var="cat" items="${applicationScope.categories}">
                                    <li><a class="dropdown-item" href="CategoryServlet?loai=${cat}">${cat}</a></li>
                                    </c:forEach>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="AllProductsServlet">Xem tất cả sản phẩm</a></li>
                            </ul>
                        </li>

                        <li class="nav-item"><a class="nav-link ${activePage == 'Tra cứu đơn hàng' ? 'active' : ''}" href="order-lookup.jsp">Tra cứu đơn hàng</a></li>
                        <li class="nav-item"><a class="nav-link ${activePage == 'Liên hệ' ? 'active' : ''}" href="ContactServlet">Liên hệ</a></li>
                    </ul>

                    <%-- Form tìm kiếm (với gợi ý) --%>
                    <form class="d-flex mx-auto" action="SearchServlet" method="GET" style="width: 350px; position: relative;">
                        <div class="input-group">
                            <input class="form-control" type="search" name="query" id="search-input"
                                   placeholder="Tìm kiếm sản phẩm..." aria-label="Search" autocomplete="off" value="${requestScope.searchQuery}">
                            <button class="btn btn-primary" type="submit" id="button-search">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>
                        <div id="suggestion-box"></div> <%-- Box cho search-suggest.js --%>
                    </form>

                    <%-- Thông tin đăng nhập & Giỏ hàng --%>
                    <ul class="navbar-nav ms-auto d-flex align-items-center">
                        <c:choose>
                            <c:when test="${not empty sessionScope.hoten}"> 
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                        <i class="bi bi-person-circle"></i> Chào, ${sessionScope.hoten} 
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end">    
                                        <%-- --- ĐOẠN CODE MỚI THÊM VÀO --- --%>
                                        <%-- Kiểm tra: Nếu session 'vaitro' là 'admin' thì hiện nút này --%>
                                        <c:if test="${sessionScope.vaitro == 'admin'}">
                                            <li>
                                                <a class="dropdown-item text-danger fw-bold" href="${pageContext.request.contextPath}/admin/dashboard">
                                                    <i class="bi bi-speedometer2"></i> Trang quản trị
                                                </a>
                                            </li>
                                            <li><hr class="dropdown-divider"></li>
                                            </c:if>
                                            <%-- ------------------------------ --%>
                                        <li><a class="dropdown-item" href="AccountServlet">Thông tin tài khoản</a></li>                                                    
                                        <li><a class="dropdown-item" href="LogoutServlet">Đăng xuất</a></li>
                                    </ul> 
                                </li>
                            </c:when>
                            <c:otherwise> 
                                <li class="nav-item">
                                    <a class="nav-link" href="LoginServlet">Đăng nhập</a> 
                                </li>
                                <li class="nav-item">
                                    <a class="btn btn-primary btn-sm ms-2" href="RegisterServlet">Đăng ký</a> 
                                </li>
                            </c:otherwise>
                        </c:choose>

                        <%-- Icon Giỏ hàng (với số lượng động) --%>
                        <li class="nav-item"> 
                            <a class="nav-link ms-3 ${activePage == 'Giỏ hàng' ? 'active' : ''}" href="cart.jsp"> 
                                <i class="bi bi-cart-fill fs-5"></i>
                                <span class="badge rounded-pill bg-danger" style="position: relative; top: -10px; left: -5px;"> 
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.cart}">
                                            ${sessionScope.cart.totalItemCount} 
                                        </c:when>
                                        <c:otherwise>0</c:otherwise> 
                                    </c:choose>
                                </span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </body>
</html>