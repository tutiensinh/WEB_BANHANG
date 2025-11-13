<%-- Tạo file mới: webapp/contact.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Liên hệ - NinhBinhStore</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <jsp:include page="header.jsp"><jsp:param name="title" value="Liên hệ"/></jsp:include>

            <main class="container my-5" style="max-width: 900px;">
                <div class="row g-5">
                    <div class="col-md-7">
                        <h2 class="fw-bold mb-4">Gửi thông tin liên hệ</h2>
                        <p class="text-muted mb-4">Chúng tôi luôn sẵn lòng lắng nghe bạn. Vui lòng điền vào biểu mẫu bên dưới để gửi câu hỏi hoặc góp ý.</p>

                    <%-- Hiển thị thông báo thành công (nếu có) --%>
                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${sessionScope.successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <% session.removeAttribute("successMessage");%>
                    </c:if>

                    <form action="ContactServlet" method="POST">
                        <div class="mb-3">
                            <label for="hoten" class="form-label fw-semibold">Họ và tên *</label>
                            <input type="text" class="form-control" id="hoten" name="hoten" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label fw-semibold">Email *</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="noidung" class="form-label fw-semibold">Nội dung *</label>
                            <textarea class="form-control" id="noidung" name="noidung" rows="6" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary fw-bold contact-form-button">Gửi liên hệ</button>
                    </form>
                </div>

                <div class="col-md-5 mt-4 mt-md-0">
                    <div class="card shadow-sm border-0 h-100 bg-light">
                        <div class="card-body p-4">
                            <h4 class="fw-bold mb-4 border-bottom pb-2">Thông tin của chúng tôi</h4>

                            <div class="d-flex mb-4">
                                <i class="bi bi-geo-alt-fill fs-4 text-primary me-3"></i>
                                <div>
                                    <h6 class="fw-semibold text-dark mb-0">Địa chỉ</h6>
                                    <p class="text-muted mb-0">Ninh Bình, Việt Nam</p>
                                </div>
                            </div>
                            <div class="d-flex mb-4">
                                <i class="bi bi-telephone-fill fs-4 text-primary me-3"></i>
                                <div>
                                    <h6 class="fw-semibold text-dark mb-0">Điện thoại</h6>
                                    <p class="text-muted mb-0">1900 1234</p>
                                </div>
                            </div>
                            <div class="d-flex mb-4">
                                <i class="bi bi-envelope-fill fs-4 text-primary me-3"></i>
                                <div>
                                    <h6 class="fw-semibold text-dark mb-0">Email</h6>
                                    <p class="text-muted mb-0">info@NinhBinhStore.com</p>
                                </div>
                            </div>

                            <div class="mt-4 pt-2 border-top">
                                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3744.113098595804!2d105.98634831495372!3d20.19894878648216!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x312f0ffb573a6a1f%3A0x6a1c1d0f5e3d73f1!2sNinh%20Binh!5e0!3m2!1sen!2sfr!4v1638209865123!5m2!1sen!2sfr" width="100%" height="200" style="border:0; border-radius: 8px;" allowfullscreen="" loading="lazy"></iframe>
                            </div>
                        </div>
                    </div>
                </div>
        </main>

        <jsp:include page="footer.jsp" />
    </body>
</html>