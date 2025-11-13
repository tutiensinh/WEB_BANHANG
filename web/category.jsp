<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh mục: ${requestScope.categoryName} - NinhBinhStore</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>

        <%-- 1. Nhúng Header --%>
        <jsp:include page="header.jsp">
            <jsp:param name="title" value="Loại sản phẩm"/>
        </jsp:include>

        <main class="container my-5">
            <nav aria-label="breadcrumb" class="mb-4" data-aos="fade-right">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="HomeServlet" class="text-decoration-none">Trang chủ</a></li>
                    <li class="breadcrumb-item active" aria-current="page">${requestScope.categoryName}</li>
                </ol>
            </nav>

            <div class="row">
                <div class="col-lg-3 mb-4" data-aos="fade-right">
                    <div class="card shadow-sm border-0 sticky-top" style="top: 90px; z-index: 1;"> <div class="card-header bg-primary text-white fw-bold">
                            <i class="bi bi-funnel-fill"></i> Chọn sản phẩm
                        </div>
                        <div class="card-body">
                            <h6 class="fw-bold mb-3">Khoảng giá</h6>
                            <form action="CategoryServlet" method="GET">
                                <input type="hidden" name="loai" value="${requestScope.categoryName}">
                                <div class="mb-3">
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="radio" name="priceRange" id="priceAll" value="all" ${empty param.priceRange || param.priceRange == 'all' ? 'checked' : ''}>
                                        <label class="form-check-label" for="priceAll">Tất cả</label>
                                    </div>
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="radio" name="priceRange" id="price1" value="0-1000000" ${param.priceRange == '0-1000000' ? 'checked' : ''}>
                                        <label class="form-check-label" for="price1">Dưới 1 triệu</label>
                                    </div>
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="radio" name="priceRange" id="price2" value="1000000-5000000" ${param.priceRange == '1000000-5000000' ? 'checked' : ''}>
                                        <label class="form-check-label" for="price2">1 - 5 triệu</label>
                                    </div>
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="radio" name="priceRange" id="price3" value="5000000-10000000" ${param.priceRange == '5000000-10000000' ? 'checked' : ''}>
                                        <label class="form-check-label" for="price3">5 - 10 triệu</label>
                                    </div>
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="radio" name="priceRange" id="price4" value="10000000-999999999" ${param.priceRange == '10000000-999999999' ? 'checked' : ''}>
                                        <label class="form-check-label" for="price4">Trên 10 triệu</label>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary w-100 btn-sm fw-bold">
                                    <i class="bi bi-check2-circle"></i> Áp dụng
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-lg-9">
                    <fmt:setLocale value="vi_VN"/>
                    <c:choose>
                        <c:when test="${empty requestScope.productList}">
                            <div class="alert alert-warning text-center py-5" role="alert" data-aos="fade-up">
                                <i class="bi bi-search fs-1 text-muted d-block mb-3"></i>
                                <h4>Không tìm thấy sản phẩm nào!</h4>
                                <p class="text-muted">Vui lòng thử chọn khoảng giá khác.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4"> <c:forEach var="p" items="${requestScope.productList}" varStatus="loop">
                                    <div class="col" data-aos="zoom-in" data-aos-delay="${loop.index * 50}"> <div class="card h-100 product-card">
                                            <a href="product-detail?id=${p.id}" class="text-decoration-none"> <img src="${p.hinhanh}" class="card-img-top" alt="${p.tensp}">
                                            </a>
                                            <div class="card-body d-flex flex-column">
                                                <a href="product-detail?id=${p.id}" class="text-decoration-none text-dark">
                                                    <h5 class="card-title" title="${p.tensp}">${p.tensp}</h5> </a>
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
                </div>
            </div>
        </main>


        <%-- 3. Nhúng Footer --%>
        <jsp:include page="footer.jsp" />

    </body>
</html>