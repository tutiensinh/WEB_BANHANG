<%-- File: webapp/admin/dashboard.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Trang quản trị - NinhBinhStore</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <%-- Dùng contextPath vì đang ở trong thư mục con --%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>

        <nav class="navbar navbar-dark bg-dark shadow-sm">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/admin/dashboard">
                    NinhBinhStore Admin
                </a>
                <div class="d-flex">
                    <a href="${pageContext.request.contextPath}/HomeServlet" class="btn btn-outline-light me-2" target="_blank">
                        <i class="bi bi-eye"></i> Xem trang chủ
                    </a>
                    <span class="navbar-text me-3">
                        Chào, ${sessionScope.hoten}
                    </span>
                    <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn btn-danger">Đăng xuất</a>
                </div>
            </div>
        </nav>

        <main class="container my-5">
            <h1 class="fw-bold mb-4">Bảng điều khiển</h1>
            <div class="row g-4">

                <div class="col-md-4">
                    <div class="card shadow-sm h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-box-seam-fill fs-1 text-primary"></i>
                            <h4 class="card-title mt-3">Quản lý Sản phẩm</h4>
                            <p class="text-muted">Thêm, sửa, xóa sản phẩm trong cửa hàng.</p>
                            <a href="${pageContext.request.contextPath}/admin/manage-products" class="btn btn-primary">Đi đến</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card shadow-sm h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-receipt-cutoff fs-1 text-success"></i>
                            <h4 class="card-title mt-3">Quản lý Đơn hàng</h4>
                            <p class="text-muted">Xem và cập nhật trạng thái đơn hàng.</p>
                            <%-- Link đến servlet bạn đã tạo --%>
                            <a href="${pageContext.request.contextPath}/admin/manage-orders" class="btn btn-success">Đi đến</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card shadow-sm h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-people-fill fs-1 text-info"></i>
                            <h4 class="card-title mt-3">Quản lý Người dùng</h4>
                            <p class="text-muted">Xem danh sách người dùng đã đăng ký.</p>
                            <a href="${pageContext.request.contextPath}/admin/manage-users" class="btn btn-info text-white">Đi đến</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card shadow-sm h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-chat-left-dots-fill fs-1 text-warning"></i>
                            <h4 class="card-title mt-3">Phản hồi Liên hệ</h4>
                            <p class="text-muted">Đọc và trả lời tin nhắn của khách hàng.</p>
                            <a href="${pageContext.request.contextPath}/admin/manage-contacts" class="btn btn-warning text-dark">Đi đến</a>
                        </div>
                    </div>
                </div>

            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>