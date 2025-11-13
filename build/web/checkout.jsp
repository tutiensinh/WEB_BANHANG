<%-- File: checkout.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Thanh toán - NinhBinhStore</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <%-- Nhúng Header --%>
        <jsp:include page="header.jsp">
            <jsp:param name="title" value="Thanh toán"/>
        </jsp:include>

        <main class="container my-5">
            <h2 class="fw-bold mb-4">Thanh toán đơn hàng</h2>

            <div class="row">
                <div class="col-md-6 mb-4">
                    <div class="card shadow-sm h-100">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0"><i class="bi bi-receipt"></i> Thông tin đơn hàng</h5>
                        </div>
                        <div class="card-body">
                            <p class="mb-2"><strong>Người nhận:</strong> ${sessionScope.ship_fullName}</p>
                            <p class="mb-2"><strong>Email:</strong> ${sessionScope.ship_email}</p>
                            <p class="mb-2"><strong>Số điện thoại:</strong> ${sessionScope.ship_phone}</p>
                            <p class="mb-2"><strong>Địa chỉ giao hàng:</strong> ${sessionScope.ship_address}</p>
                            <c:if test="${not empty sessionScope.ship_note}">
                                <p class="mb-2"><strong>Ghi chú:</strong> <span class="text-muted fst-italic">${sessionScope.ship_note}</span></p>
                                </c:if>

                            <hr>
                            <h6 class="fw-bold">Sản phẩm:</h6>
                            <ul class="list-group list-group-flush mb-3">
                                <c:forEach var="item" items="${cart.items}">
                                    <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                        <span>${item.product.tensp} (x${item.quantity})</span>
                                        <span><fmt:formatNumber value="${item.totalPrice}" type="currency"/></span>
                                    </li>
                                </c:forEach>
                            </ul>
                            <h5 class="d-flex justify-content-between fw-bold pt-3 border-top">
                                <span>Tổng cộng:</span>
                                <span class="text-danger fs-4"><fmt:formatNumber value="${amount}" type="currency"/></span>
                            </h5>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 mb-4">
                    <div class="card shadow-sm text-center h-100 border-success">
                        <div class="card-header bg-success text-white">
                            <h5 class="mb-0"><i class="bi bi-qr-code-scan"></i> Quét mã để thanh toán</h5>
                        </div>
                        <div class="card-body">
                            <p class="text-muted mb-3">Mở ứng dụng ngân hàng của bạn và quét mã QR bên dưới:</p>

                            <img src="${qrUrl}" alt="Mã QR thanh toán" class="img-fluid border rounded p-2 mb-3 shadow-sm" style="max-width: 300px;">

                            <div class="alert alert-info text-start" role="alert">
                                <p class="mb-1"><strong>Ngân hàng:</strong> ${bankName}</p>
                                <p class="mb-1"><strong>Số tài khoản:</strong> ${accountNo} <i class="bi bi-clipboard cursor-pointer" title="Sao chép" onclick="navigator.clipboard.writeText('${accountNo}')"></i></p>
                                <p class="mb-1"><strong>Chủ tài khoản:</strong> ${accountName}</p>
                                <p class="mb-1"><strong>Số tiền:</strong> <strong class="text-danger"><fmt:formatNumber value="${amount}" type="currency"/></strong></p>
                                <p class="mb-0"><strong>Nội dung CK:</strong> <span class="badge bg-warning text-dark fs-6">${description}</span></p>
                            </div>

                            <form action="CheckoutServlet" method="POST">
                                <input type="hidden" name="action" value="complete_order"> 
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-success btn-lg fw-bold py-3">
                                        <i class="bi bi-check-circle-fill"></i> TÔI ĐÃ THANH TOÁN
                                    </button>
                                </div>
                            </form>
                            <p class="text-muted mt-3 small">
                                <i class="bi bi-info-circle"></i> Vui lòng nhấn nút trên sau khi bạn đã chuyển khoản thành công để chúng tôi xử lý đơn hàng.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <%-- Nhúng Footer --%>
        <jsp:include page="footer.jsp" />
    </body>
</html>