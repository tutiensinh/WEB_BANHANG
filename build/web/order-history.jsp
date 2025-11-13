<%-- Tạo file mới: webapp/order-history.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Lịch sử mua hàng - NinhBinhStore</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <jsp:include page="header.jsp"><jsp:param name="title" value="Lịch sử mua hàng"/></jsp:include>

            <main class="container my-5" style="max-width: 900px;">
                <h2 class="fw-bold mb-4">Lịch sử mua hàng của bạn</h2>
                <fmt:setLocale value="vi_VN"/>

                <c:choose>
                <%-- Nếu chưa có đơn hàng nào --%>
                <c:when test="${empty orders}">
                    <div class="alert alert-info text-center p-5">
                        <i class="bi bi-bag-check fs-1"></i>
                        <h4 class="mt-3">Bạn chưa có đơn hàng nào</h4>
                        <p>Hãy bắt đầu mua sắm ngay thôi!</p>
                        <a href="HomeServlet" class="btn btn-primary mt-2">Về trang chủ</a>
                    </div>
                </c:when>

                <%-- Nếu có đơn hàng --%>
                <c:otherwise>
                    <div class="accordion" id="orderAccordion">
                        <c:forEach var="order" items="${orders}" varStatus="loop">
                            <div class="accordion-item shadow-sm mb-3 border-0">
                                <h2 class="accordion-header">
                                    <button class="accordion-button ${loop.first ? '' : 'collapsed'}" type="button" 
                                            data-bs-toggle="collapse" data-bs-target="#collapse${order.id}">
                                        <span class="fw-bold me-2">Đơn hàng #${order.id}</span>

                                        <%-- Thêm màu sắc cho trạng thái --%>
                                        <c:choose>
                                            <c:when test="${order.trangthai == 'Chờ xử lý'}">
                                                <span class="badge bg-warning text-dark me-3">${order.trangthai}</span>
                                            </c:when>
                                            <c:when test="${order.trangthai == 'Đang giao'}">
                                                <span class="badge bg-info me-3">${order.trangthai}</span>
                                            </c:when>
                                            <c:when test="${order.trangthai == 'Hoàn thành'}">
                                                <span class="badge bg-success me-3">${order.trangthai}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger me-3">${order.trangthai}</span>
                                            </c:otherwise>
                                        </c:choose>

                                        <span class="text-muted ms-auto">
                                            Ngày đặt: <fmt:formatDate value="${order.ngaydat}" pattern="dd/MM/yyyy HH:mm"/>
                                        </span>
                                    </button>
                                </h2>
                                <div id="collapse${order.id}" class="accordion-collapse collapse ${loop.first ? 'show' : ''}" 
                                     data-bs-parent="#orderAccordion">
                                    <div class="accordion-body">
                                        <ul class="list-group list-group-flush">
                                            <c:forEach var="item" items="${order.items}">
                                                <li class="list-group-item d-flex align-items-center px-0">
                                                    <img src="${item.hinhanh}" alt="${item.tensp}" style="width: 60px; height: 60px; object-fit: cover; margin-right: 15px;" class="rounded">
                                                    <div class="flex-grow-1">
                                                        <h6 class="mb-0">${item.tensp}</h6>
                                                        <small class="text-muted">SL: ${item.soluong} x <fmt:formatNumber value="${item.dongia}" type="currency"/></small>
                                                    </div>
                                                    <span class="fw-bold text-dark"><fmt:formatNumber value="${item.totalPrice}" type="currency"/></span>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                        <h5 class="text-end fw-bold text-danger mt-3">
                                            Tổng cộng: <fmt:formatNumber value="${order.tongtien}" type="currency"/>
                                        </h5>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>

        <jsp:include page="footer.jsp" />
    </body>
</html>