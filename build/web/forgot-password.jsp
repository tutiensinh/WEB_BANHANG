<%-- File: webapp/forgot-password.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Quên mật khẩu - NinhBinhStore</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="css/style.css">
        <%-- Kế thừa CSS riêng cho form đăng nhập/đăng ký --%>
        <style>
            body {
                background-image: url('https://images.unsplash.com/photo-1556911220-bff31c812dba'); /* Ảnh nền */
                background-size: cover;
                background-position: center;
                background-attachment: fixed;
                font-family: Arial, sans-serif;
            }
            .form-container {
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .form-box {
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 15px;
                padding: 2.5rem;
                box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
                width: 100%;
                max-width: 450px;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid form-container">
            <div class="form-box">
                <h2 class="text-center mb-2 fw-bold">Đặt lại mật khẩu</h2>
                <p class="text-center text-muted mb-4">Ninh Bình Store</p>

                <%-- Hiển thị thông báo (thành công/lỗi) --%>
                <c:if test="${not empty requestScope.message}">
                    <div class="alert alert-${requestScope.messageType == 'success' ? 'success' : 'danger'}" role="alert">
                        ${requestScope.message}
                    </div>
                </c:if>

                <form action="ForgotPasswordServlet" method="POST">
                    <div class="input-group mb-3">
                        <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
                        <input type="email" class="form-control" name="email" placeholder="Email đăng ký" required>
                    </div>

                    <div class="input-group mb-3">
                        <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                        <input type="password" class="form-control" name="newPass" id="newPass" placeholder="Mật khẩu mới" required minlength="6">
                        <button class="btn btn-outline-secondary" type="button" id="toggleNewPass"><i class="bi bi-eye-fill"></i></button>
                    </div>

                    <div class="input-group mb-4">
                        <span class="input-group-text"><i class="bi bi-shield-lock-fill"></i></span>
                        <input type="password" class="form-control" name="confirmPass" id="confirmPass" placeholder="Nhập lại mật khẩu mới" required minlength="6">
                        <button class="btn btn-outline-secondary" type="button" id="toggleConfirmPass"><i class="bi bi-eye-fill"></i></button>
                    </div>

                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-danger btn-lg fw-bold">Đặt lại mật khẩu</button>
                    </div>

                    <div class="text-center">
                        <p><a href="LoginServlet">Quay lại Đăng nhập</a></p>
                    </div>
                </form>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Hàm chung để xử lý bật/tắt
                function setupPasswordToggle(inputId, toggleId) {
                    const toggle = document.querySelector(toggleId);
                    const input = document.querySelector(inputId);

                    if (toggle && input) {
                        const icon = toggle.querySelector('i');
                        toggle.addEventListener('click', function () {
                            const type = input.getAttribute('type') === 'password' ? 'text' : 'password';
                            input.setAttribute('type', type);

                            if (type === 'password') {
                                icon.classList.remove('bi-eye-slash-fill');
                                icon.classList.add('bi-eye-fill');
                            } else {
                                icon.classList.remove('bi-eye-fill');
                                icon.classList.add('bi-eye-slash-fill');
                            }
                        });
                    }
                }

                // Áp dụng cho 2 ô mật khẩu của trang này
                setupPasswordToggle('#newPass', '#toggleNewPass');
                setupPasswordToggle('#confirmPass', '#toggleConfirmPass');
            });
        </script>
    </body>
</html>