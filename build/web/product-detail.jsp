<%-- File: product-detail.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>${requestScope.product.tensp} - NinhBinhStore</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
        <style>
            .detail-img {
                max-width: 100%;
                height: auto;
                border-radius: 15px;
                box-shadow: 0 8px 16px rgba(0,0,0,0.1);
            }
            .detail-price {
                font-size: 2.5rem;
                font-weight: bold;
                color: #d70018;
            }
        </style>
    </head>
    <body>

        <%-- 1. Nhúng Header --%>
        <jsp:include page="header.jsp">
            <jsp:param name="title" value="Chi tiết sản phẩm"/>
        </jsp:include>

        <main class="container my-5">
            <fmt:setLocale value="vi_VN"/>
            <c:set var="p" value="${requestScope.product}" />

            <c:choose>
                <c:when test="${empty p}">
                    <div class="alert alert-danger" role="alert" data-aos="fade-up">
                        <h4 class="alert-heading">Lỗi!</h4>
                        <p>Không tìm thấy sản phẩm bạn yêu cầu. Có thể sản phẩm đã bị xóa hoặc đường dẫn không đúng.</p>
                        <hr>
                        <a href="HomeServlet" class="btn btn-primary">Quay về trang chủ</a>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="row" data-aos="fade-up">
                        <div class="col-lg-5 mb-4">
                            <img src="${p.hinhanh}" class="detail-img" alt="${p.tensp}">
                        </div>

                        <div class="col-lg-7">
                            <span class="badge bg-primary category-badge mb-2">${p.loai}</span>
                            <h2>${p.tensp}</h2>
                            <hr>

                            <div class="mb-3">
                                <span class="detail-price"><fmt:formatNumber value="${p.dongia}" type="currency"/></span>
                            </div>

                            <p class="lead">${p.mota}</p>
                            <hr>

                            <%-- GIAO DIỆN SỐ LƯỢNG & NÚT MUA MỚI --%>
                            <div class="d-flex align-items-center mb-4">
                                <label class="form-label me-3 mb-0 fw-bold">Số lượng:</label>
                                <div class="quantity-group">
                                    <button class="btn-decrease" type="button" onclick="updateDetailQuantity(-1)">-</button>
                                    <input type="number" class="quantity-input" id="detail-quantity" value="1" min="1" max="${p.tonkho}">
                                    <button class="btn-increase" type="button" onclick="updateDetailQuantity(1)">+</button>
                                </div>
                                <span class="ms-3 text-muted">(${p.tonkho} sản phẩm có sẵn)</span>
                            </div>

                            <div class="d-flex gap-2">
                                <button type="button" class="btn btn-outline-primary flex-grow-1 py-2" onclick="addToCartAJAX(${p.id})">
                                    <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                                </button>

                                <button type="button" class="btn btn-primary flex-grow-1 py-2" onclick="buyNow(${p.id})">
                                    <i class="bi bi-lightning-fill"></i> Mua ngay
                                </button>
                            </div>
                            <%-- KẾT THÚC GIAO DIỆN MỚI --%>

                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>

        <%-- 3. Nhúng Footer --%>
        <jsp:include page="footer.jsp" />

        <%-- JAVASCRIPT XỬ LÝ CHO TRANG CHI TIẾT --%>
        <script>
            // Hàm tăng giảm số lượng ở trang chi tiết
            function updateDetailQuantity(change) {
                const input = document.getElementById('detail-quantity');
                let newValue = parseInt(input.value) + change;
                // Đảm bảo số lượng không nhỏ hơn 1 và không lớn hơn tồn kho
                if (newValue < 1)
                    newValue = 1;
                const maxStock = parseInt(input.getAttribute('max'));
                if (newValue > maxStock)
                    newValue = maxStock;
                input.value = newValue;
            }

            // AJAX Thêm vào giỏ
            function addToCartAJAX(productId) {
                const quantity = document.getElementById('detail-quantity').value;
                // Gọi Servlet với tham số action=add
                fetch('AddToCartServlet?action=add&id=' + productId + '&quantity=' + quantity, {
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest' // Đánh dấu đây là yêu cầu AJAX
                    }
                })
                        .then(response => {
                            if (response.ok) {
                                // Hiện popup thành công
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Thông báo',
                                    text: 'Đã thêm vào giỏ hàng thành công!',
                                    confirmButtonText: 'OK',
                                    confirmButtonColor: '#0d6efd'
                                }).then((result) => {
                                    // Tải lại trang để cập nhật số lượng trên Header (nếu cần)
                                    location.reload();
                                });
                            } else if (response.status === 401) {
                                // NẾU LỖI 401: CHƯA ĐĂNG NHẬP
                                Swal.fire({
                                    icon: 'warning',
                                    title: 'Chưa đăng nhập',
                                    text: 'Bạn cần đăng nhập để thực hiện chức năng này.',
                                    showCancelButton: true,
                                    confirmButtonText: 'Đăng nhập ngay',
                                    cancelButtonText: 'Hủy',
                                    confirmButtonColor: '#0d6efd'
                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        window.location.href = 'LoginServlet'; // Chuyển đến trang đăng nhập
                                    }
                                });
                            } else {
                                Swal.fire({icon: 'error', title: 'Lỗi', text: 'Có lỗi xảy ra, vui lòng thử lại.'});
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            Swal.fire({icon: 'error', title: 'Lỗi kết nối', text: 'Không thể kết nối đến máy chủ.'});
                        });
            }

            // Hàm mua ngay
            function buyNow(productId) {
                const quantity = document.getElementById('detail-quantity').value;
                // Chuyển hướng ngay lập tức với action=buy
                window.location.href = 'AddToCartServlet?action=buy&id=' + productId + '&quantity=' + quantity;
            }
        </script>
    </body>
</html>