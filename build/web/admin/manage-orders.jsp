<%-- File: webapp/admin/manage-orders.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Quản lý Đơn hàng - Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <%-- Đường dẫn CSS phải dùng ${pageContext.request.contextPath} vì đang ở trong thư mục con --%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <%-- (Bạn có thể tạo một header.jsp riêng cho admin) --%>
        <nav class="navbar navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="#">Trang Admin</a>

                <%-- THÊM NÚT NÀY VÀO HEADER --%>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-light btn-sm">
                    <i class="bi bi-arrow-left"></i> Quay lại Dashboard
                </a>
            </div>
        </nav>

        <main class="container my-5">
            <h2 class="fw-bold mb-4">Quản lý Đơn hàng</h2>
            <fmt:setLocale value="vi_VN"/>

            <%-- Hiển thị thông báo --%>
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("successMessage");%>
            </c:if>

            <div class="card shadow-sm border-0">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Mã ĐH</th>
                                    <th>Khách hàng</th>
                                    <th>Ngày đặt</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái hiện tại</th>
                                    <th>Cập nhật trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${allOrders}">
                                    <tr>
                                        <td><strong>#${order.id}</strong></td>
                                        <td>${order.hoten} (${order.email})</td>
                                        <td><fmt:formatDate value="${order.ngaydat}" pattern="dd/MM/yyyy HH:mm"/></td>
                                        <td class="text-danger fw-bold"><fmt:formatNumber value="${order.tongtien}" type="currency"/></td>
                                        <td>
                                            <%-- Hiển thị trạng thái với màu sắc --%>
                                            <span class="badge ${order.trangthai == 'Hoàn thành' ? 'bg-success' : (order.trangthai == 'Chờ xử lý' ? 'bg-warning text-dark' : (order.trangthai == 'Đang giao' ? 'bg-info' : 'bg-danger'))}">
                                                ${order.trangthai}
                                            </span>
                                        </td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/admin/manage-orders" method="POST" class="d-flex">
                                                <input type="hidden" name="orderId" value="${order.id}">
                                                <select name="newStatus" class="form-select form-select-sm" style="width: 150px;">
                                                    <option value="Chờ xử lý" ${order.trangthai == 'Chờ xử lý' ? 'selected' : ''}>Chờ xử lý</option>
                                                    <option value="Đang giao" ${order.trangthai == 'Đang giao' ? 'selected' : ''}>Đang giao</option>
                                                    <option value="Hoàn thành" ${order.trangthai == 'Hoàn thành' ? 'selected' : ''}>Hoàn thành</option>
                                                    <option value="Hủy" ${order.trangthai == 'Hủy' ? 'selected' : ''}>Hủy</option>
                                                </select>
                                                <button type="submit" class="btn btn-primary btn-sm ms-2">Lưu</button>
                                            </form>
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
    </body>
</html>