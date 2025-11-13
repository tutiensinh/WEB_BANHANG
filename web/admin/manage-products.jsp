<%-- File: webapp/admin/manage-products.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Quản lý Sản phẩm - Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <%-- Header Admin --%>
        <nav class="navbar navbar-dark bg-dark mb-4">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">Trang Admin</a>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-light btn-sm">Quay lại Dashboard</a>
            </div>
        </nav>

        <main class="container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold">Quản lý Sản phẩm</h2>
                <%-- Nút thêm mới --%>
                <a href="manage-products?action=add" class="btn btn-success">
                    <i class="bi bi-plus-circle"></i> Thêm sản phẩm mới
                </a>
            </div>

            <%-- Thông báo --%>
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show">
                    ${sessionScope.successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("successMessage"); %>
            </c:if>

            <div class="card shadow-sm border-0">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Hình ảnh</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Giá</th>
                                    <th>Loại</th>
                                    <th>Kho</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${listP}">
                                    <tr>
                                        <td>${p.id}</td>
                                        <td><img src="${pageContext.request.contextPath}/${p.hinhanh}" style="width: 50px; height: 50px; object-fit: contain;"></td>
                                        <td style="max-width: 200px;" class="text-truncate" title="${p.tensp}">${p.tensp}</td>
                                        <td class="text-danger fw-bold"><fmt:formatNumber value="${p.dongia}" type="currency"/></td>
                                        <td><span class="badge bg-info text-dark">${p.loai}</span></td>
                                        <td>${p.tonkho}</td>
                                        <td>
                                            <%-- Nút Sửa --%>
                                            <a href="manage-products?action=edit&id=${p.id}" class="btn btn-primary btn-sm me-1">
                                                <i class="bi bi-pencil-square"></i>
                                            </a>
                                            <%-- Nút Xóa --%>
                                            <a href="#" onclick="confirmDelete(${p.id})" class="btn btn-danger btn-sm">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
                                                function confirmDelete(id) {
                                                    Swal.fire({
                                                        title: 'Bạn chắc chắn muốn xóa?',
                                                        text: "Hành động này không thể hoàn tác!",
                                                        icon: 'warning',
                                                        showCancelButton: true,
                                                        confirmButtonColor: '#d33',
                                                        cancelButtonColor: '#3085d6',
                                                        confirmButtonText: 'Xóa ngay',
                                                        cancelButtonText: 'Hủy'
                                                    }).then((result) => {
                                                        if (result.isConfirmed) {
                                                            window.location.href = "manage-products?action=delete&id=" + id;
                                                        }
                                                    })
                                                }
        </script>
    </body>
</html>