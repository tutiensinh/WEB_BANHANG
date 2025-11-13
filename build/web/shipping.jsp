<%-- File: shipping.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Thông tin giao hàng - NinhBinhStore</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <jsp:include page="header.jsp"><jsp:param name="title" value="Thông tin giao hàng"/></jsp:include>

            <main class="container my-5" style="max-width: 900px;">
                <div class="row">
                    <div class="col-md-7 pe-md-5">
                        <h4 class="mb-3">Thông tin giao hàng</h4>
                        <form action="CheckoutServlet" method="POST" id="shippingForm">
                            <input type="hidden" name="action" value="confirm_shipping">

                            <div class="mb-3">
                                <label for="fullName" class="form-label">Họ và tên</label>
                                <input type="text" class="form-control" id="fullName" name="fullName" 
                                       value="${sessionScope.user.hoten}" required>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" 
                                       value="${sessionScope.user.email}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="phone" class="form-label">Số điện thoại</label>
                                <input type="tel" class="form-control" id="phone" name="phone" 
                                       value="${sessionScope.user.sodienthoai}" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">Địa chỉ nhận hàng</label>
                            <input type="text" class="form-control" id="address" name="address" 
                                   value="${sessionScope.user.diachi}" required placeholder="Ví dụ: Số 123, Đường ABC...">
                        </div>
                        <div class="mb-4">
                            <label for="note" class="form-label">Ghi chú đơn hàng (Tùy chọn)</label>
                            <textarea class="form-control" id="note" name="note" rows="3" 
                                      placeholder="Ví dụ: Giao hàng giờ hành chính..."></textarea>
                        </div>

                        <hr class="my-4">
                        <button class="btn btn-primary btn-lg w-100 py-3 fw-bold" type="submit">
                            TIẾP TỤC ĐẾN THANH TOÁN <i class="bi bi-arrow-right"></i>
                        </button>
                    </form>
                </div>

                <div class="col-md-5 mt-4 mt-md-0 ps-md-5 border-start">
                    <h4 class="d-flex justify-content-between align-items-center mb-3">
                        <span class="text-primary">Đơn hàng của bạn</span>
                        <span class="badge bg-primary rounded-pill">${sessionScope.cart.totalItemCount}</span>
                    </h4>
                    <ul class="list-group mb-3">
                        <c:forEach var="item" items="${sessionScope.cart.items}">
                            <li class="list-group-item d-flex justify-content-between lh-sm">
                                <div>
                                    <h6 class="my-0">${item.product.tensp}</h6>
                                    <small class="text-muted">Số lượng: ${item.quantity}</small>
                                </div>
                                <span class="text-muted"><fmt:formatNumber value="${item.totalPrice}" type="currency"/></span>
                            </li>
                        </c:forEach>
                        <li class="list-group-item d-flex justify-content-between bg-light">
                            <span class="fw-bold">Tổng cộng (VNĐ)</span>
                            <strong class="text-danger fs-5"><fmt:formatNumber value="${sessionScope.cart.totalCartPrice}" type="currency"/></strong>
                        </li>
                    </ul>
                    <a href="cart.jsp" class="text-decoration-none"><i class="bi bi-arrow-left"></i> Quay lại giỏ hàng</a>
                </div>
            </div>
        </main>

        <jsp:include page="footer.jsp" />
    </body>
</html>