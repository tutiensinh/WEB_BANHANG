<%-- File: footer.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <body>
        <footer class="bg-dark text-white pt-5 pb-4">
            <div class="container text-center text-md-start">
                <div class="row">
                    <div class="col-md-3 col-lg-4 mx-auto mb-4">
                        <h6 class="text-uppercase fw-bold">NinhBinhStore</h6> 
                        <hr class="mb-4 mt-0 d-inline-block mx-auto" style="width: 60px; background-color: #7c4dff; height: 2px"> 
                        <p>Mang đến những sản phẩm gia dụng chất lượng nhất với giá cả phải chăng, nâng tầm cuộc sống gia đình bạn.</p>
                    </div>
                    <div class="col-md-2 col-lg-2 mx-auto mb-4">
                        <h6 class="text-uppercase fw-bold">Sản phẩm</h6> 
                        <hr class="mb-4 mt-0 d-inline-block mx-auto" style="width: 60px; background-color: #7c4dff; height: 2px"> 
                        <p><a href="CategoryServlet?loai=Nhà bếp" class="text-white text-decoration-none">Đồ dùng bếp</a></p>
                        <p><a href="CategoryServlet?loai=Gia dụng lớn" class="text-white text-decoration-none">Thiết bị điện</a></p>
                        <p><a href="CategoryServlet?loai=Làm sạch" class="text-white text-decoration-none">Chăm sóc nhà cửa</a></p> 
                    </div>
                    <div class="col-md-3 col-lg-2 mx-auto mb-4">
                        <h6 class="text-uppercase fw-bold">Hỗ trợ</h6>
                        <hr class="mb-4 mt-0 d-inline-block mx-auto" style="width: 60px; background-color: #7c4dff; height: 2px"> 
                        <p><a href="#!" class="text-white text-decoration-none">Chính sách bảo hành</a></p>
                        <p><a href="#!" class="text-white text-decoration-none">Chính sách đổi trả</a></p>
                        <p><a href="#!" class="text-white text-decoration-none">Câu hỏi thường gặp</a></p> 
                    </div>
                    <div class="col-md-4 col-lg-3 mx-auto mb-md-0 mb-4">
                        <h6 class="text-uppercase fw-bold">Liên hệ</h6>
                        <hr class="mb-4 mt-0 d-inline-block mx-auto" style="width: 60px; background-color: #7c4dff; height: 2px">
                        <p><i class="bi bi-geo-alt-fill me-3"></i> Hoa Lư, Ninh Bình, Việt Nam</p>
                        <p><i class="bi bi-envelope-fill me-3"></i> info@NinhBinhStore.com</p>
                        <p><i class="bi bi-telephone-fill me-3"></i> +84 123 456 789</p> 
                    </div>
                </div>
            </div>
            <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2)">
                © 2025 Copyright:
                <a class="text-white text-decoration-none fw-bold" href="HomeServlet">NinhBinhStore.com</a> 
            </div>
        </footer>

        <%-- Các link SCRIPT chung --%>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

        <%-- Link tới file JS tùy chỉnh của bạn --%>
        <script src="js/search-suggest.js"></script>
        <script src="js/main.js"></script> <%-- (File này chứa AOS.init()) --%>

    </body>
</html>