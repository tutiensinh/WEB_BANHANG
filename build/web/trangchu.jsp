<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang chủ - Đồ Gia Dụng</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>

        <%-- 1. Nhúng Header và truyền tham số "title" --%>
        <jsp:include page="header.jsp">
            <jsp:param name="title" value="Trang chủ"/>
        </jsp:include>

        <header class="hero-section"> 
            <video playsinline autoplay muted loop id="bg-video">
                <source src="images/products/banner-video.mp4" type="video/mp4">
                Trình duyệt của bạn không hỗ trợ video tag.
            </video> 

            <div class="container text-center hero-content">
                <h1 class="display-4 fw-bold">Thế Giới Đồ Gia Dụng</h1>
                <p class="lead">Mang tiện nghi đến mọi gia đình</p>
                <a href="#new-products" class="btn btn-primary btn-lg">Xem sản phẩm</a>
            </div>
        </header>

        <div class="service-bar py-4">
            <div class="container">
                <div class="row text-center">
                    <div class="col-md-4 mb-3 mb-md-0 service-item" data-aos="fade-up" data-aos-delay="100">
                        <i class="bi bi-truck"></i>
                        <h5 class="mt-2">Giao Hàng Toàn Quốc</h5> 
                        <p class="text-muted mb-0">Miễn phí cho đơn hàng trên 500.000đ</p>
                    </div>
                    <div class="col-md-4 mb-3 mb-md-0 service-item" data-aos="fade-up" data-aos-delay="200">
                        <i class="bi bi-shield-check"></i> 
                        <h5 class="mt-2">Bảo Hành Chính Hãng</h5>
                        <p class="text-muted mb-0">Lỗi 1 đổi 1 trong 30 ngày đầu tiên</p> 
                    </div>
                    <div class="col-md-4 service-item" data-aos="fade-up" data-aos-delay="300">
                        <i class="bi bi-headset"></i>
                        <h5 class="mt-2">Hỗ Trợ 24/7</h5>
                        <p class="text-muted mb-0">Hotline luôn sẵn sàng phục vụ</p> 
                    </div>
                </div>
            </div>
        </div>

        <main class="container my-5">
            <fmt:setLocale value="vi_VN"/>

            <section id="new-products" class="mb-5"> 
                <h2 class="display-6 fw-bold border-bottom pb-2 mb-4" data-aos="fade-right">Hàng Mới Nhất</h2>
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
                    <c:forEach var="p" items="${requestScope.newestProducts}" varStatus="loop"> 
                        <div class="col" data-aos="zoom-in" data-aos-delay="${loop.index * 100}">
                            <div class="card h-100 product-card"> 
                                <img src="${p.hinhanh}" class="card-img-top" alt="${p.tensp}">
                                <div class="card-body d-flex flex-column">
                                    <span class="badge bg-info align-self-start category-badge">${p.loai}</span> 
                                    <h5 class="card-title mt-2">${p.tensp}</h5>
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
            </section>

            <section id="kitchen-products" class="mb-5">
                <h2 class="display-6 fw-bold border-bottom pb-2 mb-4" data-aos="fade-right">Thiết Bị Nhà Bếp</h2>
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
                    <c:forEach var="p" items="${requestScope.kitchenProducts}" varStatus="loop"> 
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
            </section>

            <section id="cleaning-products" class="mb-5">
                <h2 class="display-6 fw-bold border-bottom pb-2 mb-4" data-aos="fade-right">Thiết Bị Làm Sạch</h2>
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4"> 
                    <c:forEach var="p" items="${requestScope.cleaningProducts}" varStatus="loop">
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
            </section>

            <section id="large-appliances" class="mb-5">
                <h2 class="display-6 fw-bold border-bottom pb-2 mb-4" data-aos="fade-right">Gia Dụng Lớn</h2>
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
                    <c:forEach var="p" items="${requestScope.largeAppliances}" varStatus="loop">
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
            </section>

            <section id="sale-products" class="mb-5">
                <h2 class="display-6 fw-bold border-bottom pb-2 mb-4 text-danger" data-aos="fade-right">Khuyến Mãi Sốc</h2>
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4"> 
                    <c:forEach var="p" items="${requestScope.saleProducts}" varStatus="loop">
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
            </section>
        </main>

        <div class="bg-light py-5">
            <div class="container"> 
                <h2 class="text-center display-6 fw-bold mb-4" data-aos="fade-up">Mua Sắm Theo Thương Hiệu</h2> 
                <div class="d-flex flex-wrap justify-content-center align-items-center brand-carousel">
                    <div class="p-4" data-aos="fade-up" data-aos-delay="100"><img src="https://logo.clearbit.com/sunhouse.com.vn" alt="Sunhouse"></div>
                    <div class="p-4" data-aos="fade-up" data-aos-delay="150"><img src="https://logo.clearbit.com/panasonic.com" alt="Panasonic"></div>
                    <div class="p-4" data-aos="fade-up" data-aos-delay="200"><img src="https://logo.clearbit.com/samsung.com" alt="Samsung"></div> 
                    <div class="p-4" data-aos="fade-up" data-aos-delay="250"><img src="https://logo.clearbit.com/lg.com" alt="LG"></div>
                    <div class="p-4" data-aos="fade-up" data-aos-delay="300"><img src="https://logo.clearbit.com/philips.com" alt="Philips"></div>
                    <div class="p-4" data-aos="fade-up" data-aos-delay="350"><img src="https://logo.clearbit.com/electrolux.com" alt="Electrolux"></div>
                </div>
            </div>
        </div>

        <%-- 3. Nhúng Footer --%>
        <jsp:include page="footer.jsp" />

    </body>
</html>