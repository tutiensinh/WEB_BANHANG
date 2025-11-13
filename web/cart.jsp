<%-- File: cart.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Giỏ hàng - NinhBinhStore</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>

        <%-- 1. Nhúng Header --%>
        <jsp:include page="header.jsp">
            <jsp:param name="title" value="Giỏ hàng"/>
        </jsp:include>

        <main class="container my-5">
            <h2 class="display-6 fw-bold border-bottom pb-2 mb-4">Giỏ hàng của bạn</h2>

            <fmt:setLocale value="vi_VN"/>
            <c:set var="cart" value="${sessionScope.cart}" />

            <c:choose>
                <c:when test="${empty cart or empty cart.items}">
                    <div class="alert alert-info text-center py-5" role="alert">
                        <i class="bi bi-cart-x fs-1 text-muted d-block mb-3"></i>
                        <h4>Giỏ hàng của bạn đang trống</h4>
                        <p class="text-muted mb-4">Hãy chọn thêm sản phẩm để mua sắm nhé</p>
                        <a href="HomeServlet" class="btn btn-primary">Tiếp tục mua sắm</a>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="row">
                        <div class="col-lg-8">
                            <div class="table-responsive"> <%-- Thêm class này để bảng cuộn ngang trên mobile --%>
                                <table class="table align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th scope="col" colspan="2">Sản phẩm</th>
                                            <th scope="col">Đơn giá</th>
                                            <th scope="col">Số lượng</th>
                                            <th scope="col">Thành tiền</th>
                                            <th scope="col" class="text-center">Xóa</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${cart.items}">
                                            <tr id="cart-item-${item.product.id}">
                                                <td style="width: 100px;">
                                                    <img src="${item.product.hinhanh}" class="img-fluid rounded border" alt="${item.product.tensp}">
                                                </td>
                                                <td>
                                                    <a href="product-detail?id=${item.product.id}" class="text-decoration-none text-dark fw-semibold">
                                                        ${item.product.tensp}
                                                    </a>
                                                </td>
                                                <td><fmt:formatNumber value="${item.product.dongia}" type="currency"/></td>
                                                <td>
                                                    <%-- GIAO DIỆN TĂNG GIẢM SỐ LƯỢNG TRONG GIỎ --%>
                                                    <div class="quantity-group">
                                                        <button class="btn-decrease" type="button" 
                                                                onclick="updateCartItem(${item.product.id}, parseInt(this.nextElementSibling.value) - 1)">-</button>
                                                        <input type="number" class="quantity-input" value="${item.quantity}" min="1"
                                                               onchange="updateCartItem(${item.product.id}, this.value)">
                                                        <button class="btn-increase" type="button" 
                                                                onclick="updateCartItem(${item.product.id}, parseInt(this.previousElementSibling.value) + 1)">+</button>
                                                    </div>
                                                </td>
                                                <td class="item-total-price text-danger fw-bold" id="item-total-${item.product.id}">
                                                    <fmt:formatNumber value="${item.totalPrice}" type="currency"/>
                                                </td>
                                                <td class="text-center">
                                                    <a href="javascript:void(0);" onclick="confirmRemove(${item.product.id})" class="text-muted fs-5 remove-icon">
                                                        <i class="bi bi-x-lg"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <div class="card shadow-sm border-0 bg-light">
                                <div class="card-body">
                                    <h5 class="card-title fw-bold mb-3">Tổng cộng giỏ hàng</h5>
                                    <ul class="list-group list-group-flush bg-transparent">
                                        <li class="list-group-item d-flex justify-content-between bg-transparent px-0">
                                            <span>Tạm tính</span>
                                            <strong id="cart-subtotal"><fmt:formatNumber value="${cart.totalCartPrice}" type="currency"/></strong>
                                        </li>
                                        <li class="list-group-item d-flex justify-content-between bg-transparent px-0">
                                            <span>Phí vận chuyển</span>
                                            <span class="text-success">Miễn phí</span>
                                        </li>
                                        <li class="list-group-item d-flex justify-content-between bg-transparent px-0 py-3">
                                            <span class="fs-5 fw-semibold">Tổng tiền</span>
                                            <span class="fs-4 text-danger fw-bold" id="cart-total">
                                                <fmt:formatNumber value="${cart.totalCartPrice}" type="currency"/>
                                            </span>
                                        </li>
                                    </ul>
                                    <div class="d-grid gap-2 mt-4">
                                        <a href="shipping.jsp" class="btn btn-primary btn-lg fw-bold">ĐẶT HÀNG</a>
                                        <a href="HomeServlet" class="btn btn-outline-secondary fw-semibold">
                                            <i class="bi bi-arrow-left"></i> Tiếp tục mua sắm
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>

        <%-- 3. Nhúng Footer --%>
        <jsp:include page="footer.jsp" />

        <%-- JAVASCRIPT XỬ LÝ CHO GIỎ HÀNG --%>
        <script>
            // Hàm cập nhật giỏ hàng bằng AJAX
            function updateCartItem(productId, newQuantity) {
                if (newQuantity < 1)
                    newQuantity = 1; // Đảm bảo số lượng tối thiểu là 1

                // Tìm input để cập nhật giá trị hiển thị ngay lập tức
                const row = document.getElementById('cart-item-' + productId);
                const input = row.querySelector('.quantity-input');
                input.value = newQuantity;

                // Gọi AJAX lên UpdateCartServlet
                fetch('UpdateCartServlet?id=' + productId + '&quantity=' + newQuantity)
                        .then(response => response.json()) // Servlet trả về JSON
                        .then(data => {
                            // Cập nhật lại các giá trị trên giao diện
                            document.getElementById('item-total-' + productId).innerText = data.itemTotal;
                            document.getElementById('cart-subtotal').innerText = data.cartTotal;
                            document.getElementById('cart-total').innerText = data.cartTotal;

                            // Nếu bạn có badge số lượng trên header, hãy cập nhật nó ở đây
                            // const headerBadge = document.querySelector('.navbar .badge');
                            // if (headerBadge) headerBadge.innerText = data.totalItems;
                        })
                        .catch(error => console.error('Lỗi cập nhật giỏ hàng:', error));
            }

            // Hàm xác nhận xóa sản phẩm
            function confirmRemove(productId) {
                Swal.fire({
                    title: 'Bạn chắc chứ?',
                    text: "Bạn muốn xóa sản phẩm này khỏi giỏ hàng?",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#6c757d',
                    confirmButtonText: 'Xóa',
                    cancelButtonText: 'Hủy'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Nếu đồng ý, chuyển hướng đến Servlet xóa
                        window.location.href = 'RemoveFromCartServlet?id=' + productId;
                    }
                });
            }
        </script>
    </body>
</html>