<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Kết quả tìm kiếm - NinhBinhStore</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>

        <%-- 1. Nhúng Header --%>
        <jsp:include page="header.jsp">
            <jsp:param name="title" value="Kết quả tìm kiếm"/>
        </jsp:include>

        <main class="container my-5">
            <h2 class="display-6 fw-bold border-bottom pb-2 mb-4">
                Kết quả tìm kiếm cho: "${requestScope.searchQuery}"
            </h2>

            <fmt:setLocale value="vi_VN"/>

            <c:choose>
                <%-- Nếu không tìm thấy kết quả --%>
                <c:when test="${empty requestScope.searchResults}">
                    <div class="alert alert-warning" role="alert">
                        Không tìm thấy sản phẩm nào phù hợp với từ khóa của bạn.
                    </div>
                </c:when>

                <%-- Nếu tìm thấy kết quả --%>
                <c:otherwise>
                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
                        <c:forEach var="p" items="${requestScope.searchResults}">
                            <div class="col">
                                <div class="card h-100 product-card">
                                    <img src="${p.hinhanh}" class="card-img-top" alt="${p.tensp}">
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title">${p.tensp}</h5>
                                        <div class="mt-auto">
                                            <span class="price-new"><fmt:formatNumber value="${p.dongia}" type="currency"/></span>
                                        </div>
                                    </div>
                                    <div class="card-footer p-0">
                                        <%-- Nút Xem chi tiết mới --%>
                                        <a href="product-detail?id=${p.id}" class="btn btn-primary w-100">
                                            <i class="bi bi-eye-fill"></i> Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>

        <%-- 3. Nhúng Footer --%>
        <jsp:include page="footer.jsp" />      
    </body>
</html>