<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tất cả sản phẩm - NinhBinhStore</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>

        <%-- 1. Nhúng Header --%>
        <jsp:include page="header.jsp">
            <jsp:param name="title" value="Tất cả sản phẩm"/>
        </jsp:include>

        <main class="container my-5">
            <nav aria-label="breadcrumb" class="mb-4" data-aos="fade-right">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="HomeServlet" class="text-decoration-none">Trang chủ</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Tất cả sản phẩm</li>
                </ol>
            </nav>

            <fmt:setLocale value="vi_VN"/>

            <c:choose>
                <c:when test="${empty requestScope.allProductsList}">
                    <div class="alert alert-warning" role="alert">
                        Hiện chưa có sản phẩm nào.
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
                        <c:forEach var="p" items="${requestScope.allProductsList}" varStatus="loop">
                            <div class="col" data-aos="zoom-in" data-aos-delay="${loop.index * 100}">
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