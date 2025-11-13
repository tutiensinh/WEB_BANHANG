<%-- 
    Document   : login
    Created on : 23 Oct 2025, 21:56:53
    Author     : NGOCTU
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng nhập</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <style>
            body {
                /* Ảnh nền chủ đề gia dụng */
                background-image: url('https://images.unsplash.com/photo-1556911220-bff31c812dba');
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
                /* Hiệu ứng mờ kính (Frosted Glass) */
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.25);
                border-radius: 15px;
                padding: 2.5rem;
                box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
                width: 100%;
                max-width: 450px; /* Giới hạn chiều rộng form */
            }
        </style>
    </head>
    <body>

        <div class="container-fluid form-container">
            <div class="form-box">

                <h2 class="text-center mb-2 fw-bold">Đăng nhập</h2>
                <p class="text-center text-muted mb-4">Ninh Bình Store</p>
                <%
                    // Hiển thị thông báo lỗi (từ LoginServlet)
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null && !errorMessage.isEmpty()) {
                %>
                <div class="alert alert-danger" role="alert">
                    <%= errorMessage%>
                </div>
                <%
                    }
                %>

                <%
                    // Hiển thị thông báo thành công (từ RegisterServlet)
                    String successMessage = (String) session.getAttribute("successMessage");
                    if (successMessage != null && !successMessage.isEmpty()) {
                %>
                <div class="alert alert-success" role="alert">
                    <%= successMessage%>
                </div>
                <%
                        session.removeAttribute("successMessage"); // Xóa đi để không hiển thị lại
                    }
                %>
                <form action="LoginServlet" method="POST">

                    <div class="input-group mb-3">
                        <span class="input-group-text">
                            <i class="bi bi-person-fill"></i>
                        </span>
                        <input type="text" class="form-control" id="tendangnhap" 
                               name="tendangnhap" placeholder="Tên đăng nhập" required>
                    </div>

                    <div class="input-group mb-4">
                        <span class="input-group-text">
                            <i class="bi bi-lock-fill"></i>
                        </span>
                        <input type="password" class="form-control" id="matkhau" 
                               name="matkhau" placeholder="Mật khẩu" required>
                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                            <i class="bi bi-eye-fill"></i>
                        </button>
                    </div>               

                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-primary btn-lg fw-bold">Đăng nhập</button>
                    </div>

                    <div class="text-center">
                        <p>Chưa có tài khoản? <a href="register.jsp">Đăng ký ngay</a></p>
                    </div>

                    <div class="text-end mb-3">
                        <a href="ForgotPasswordServlet" class="text-danger small fw-semibold">Quên mật khẩu</a>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/login.js"></script>
    </body>
</html>