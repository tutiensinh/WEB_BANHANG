<%-- File: webapp/admin/manage-contacts.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Quản lý Liên hệ - Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <nav class="navbar navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">Trang Admin</a>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-light btn-sm">
                    <i class="bi bi-arrow-left"></i> Quay lại Dashboard
                </a>
            </div>
        </nav>

        <main class="container my-5">
            <h2 class="fw-bold mb-4">Danh sách Phản hồi & Liên hệ</h2>

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
                                    <th>Người gửi</th>
                                    <th>Email</th>
                                    <th style="width: 40%;">Nội dung</th>
                                    <th>Ngày gửi</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="c" items="${contactList}">
                                <tr>
                                    <td>${c.id}</td>
                                    <td class="fw-bold">${c.hoten}</td>
                                    <td>${c.email}</td>
                                    <td>${c.noidung}</td>
                                    <td><fmt:formatDate value="${c.ngaygui}" pattern="dd/MM/yyyy HH:mm"/></td>
                                <td>
                                    <%-- Nút Phản hồi: Mở ứng dụng mail --%>
                                    <a href="mailto:${c.email}?subject=Phản hồi từ NinhBinhStore&body=Chào ${c.hoten}, chúng tôi đã nhận được tin nhắn của bạn..." 
                                       class="btn btn-success btn-sm" title="Gửi Email trả lời">
                                        <i class="bi bi-reply-fill"></i> Trả lời
                                    </a>

                                    <%-- Nút Xóa --%>
                                    <form action="manage-contacts" method="POST" class="d-inline" onsubmit="return confirm('Bạn có chắc muốn xóa tin nhắn này?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${c.id}">
                                        <button type="submit" class="btn btn-outline-danger btn-sm" title="Xóa">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </form>
                                </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty contactList}">
                                <tr>
                                    <td colspan="6" class="text-center py-4 text-muted">Chưa có liên hệ nào.</td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>