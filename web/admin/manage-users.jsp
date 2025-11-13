<%-- File: webapp/admin/manage-users.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Quản lý Người dùng - Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <%-- Bạn có thể thay thế bằng một file header_admin.jsp chung --%>
        <nav class="navbar navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">Trang Admin</a>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-light btn-sm">Quay lại Dashboard</a>
            </div>
        </nav>

        <main class="container my-5">
            <h2 class="fw-bold mb-4">Quản lý Người dùng</h2>

            <div class="card shadow-sm border-0">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Họ tên</th>
                                    <th>Tên đăng nhập</th>
                                    <th>Email</th>
                                    <th>Số điện thoại</th>
                                    <th>Địa chỉ</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${allUsers}">
                                    <tr>
                                        <td>${user.id}</td>
                                        <td>${user.hoten}</td>
                                        <td>${user.tendangnhap}</td>
                                        <td>${user.email}</td>
                                        <td>${user.sodienthoai}</td>
                                        <td>${user.diachi}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>