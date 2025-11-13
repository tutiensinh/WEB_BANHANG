<%-- File: account.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Thông tin tài khoản - NinhBinhStore</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <jsp:include page="header.jsp"><jsp:param name="title" value="Thông tin tài khoản"/></jsp:include>

            <main class="container my-5" style="max-width: 800px;">
                <h2 class="fw-bold mb-4">Thông tin tài khoản</h2>

            <%-- Hiển thị thông báo (nếu có) --%>
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("successMessage"); %>
            </c:if>
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${sessionScope.errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("errorMessage"); %>
            </c:if>
            <%-- Hết phần thông báo --%>

            <c:if test="${not empty accountInfo}">
                <div class="card shadow-sm border-0">
                    <div class="card-body p-4">
                        <form action="AccountServlet" method="POST">
                            <input type="hidden" name="action" value="update_info">

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">Họ và tên</label>
                                    <input type="text" class="form-control" name="hoten" value="${accountInfo.hoten}" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">Tên đăng nhập</label>
                                    <input type="text" class="form-control bg-light" value="${accountInfo.tendangnhap}" readonly disabled>
                                    <small class="text-muted">* Không thể thay đổi tên đăng nhập</small>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Email</label>
                                <input type="email" class="form-control" name="email" value="${accountInfo.email}" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Số điện thoại</label>
                                <input type="tel" class="form-control" name="sodienthoai" value="${accountInfo.sodienthoai}" required>
                            </div>
                            <div class="mb-4">
                                <label class="form-label fw-semibold">Địa chỉ</label>
                                <textarea class="form-control" name="diachi" rows="2" required>${accountInfo.diachi}</textarea>
                            </div>

                            <div class="text-center pt-3"> <%-- Căn giữa nút bấm --%>
                                <button type="submit" class="btn btn-primary px-5 btn-lg">
                                    <i class="bi bi-save"></i> Lưu thay đổi
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </c:if>
        </main>
      
        <jsp:include page="footer.jsp" />
       
    </body>
</html>