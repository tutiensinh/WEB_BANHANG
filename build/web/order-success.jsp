<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Đặt hàng thành công</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                text-align: center;
                padding: 50px;
            }
            .success-message {
                color: green;
                font-size: 24px;
                margin-bottom: 20px;
            }
            .order-details {
                margin-top: 30px;
            }
        </style>
    </head>
    <body>
        <div class="success-message">
            🎉 Chúc mừng! Bạn đã đặt hàng thành công.
        </div>
        <p>Cảm ơn bạn đã mua sắm tại cửa hàng của chúng tôi.</p>

        <c:if test="${not empty sessionScope.last_order_id}">
            <div class="order-details">
                <p>Mã đơn hàng của bạn là: <strong>#${sessionScope.last_order_id}</strong></p>
                <p>Vui lòng ghi nhớ mã đơn hàng để tiện tra cứu.</p>
                <%-- Xóa mã đơn hàng khỏi session sau khi đã hiển thị --%>
                <% session.removeAttribute("last_order_id"); %>
            </div>
        </c:if>
        <c:if test="${empty sessionScope.last_order_id}">
             <div class="order-details">
                <p>Bạn chưa có đơn hàng mới nào.</p>
            </div>
        </c:if>

        <p>Chúng tôi sẽ sớm liên hệ với bạn để xác nhận đơn hàng.</p>
        <a href="HomeServlet">Quay về trang chủ</a>
    </body>
</html>