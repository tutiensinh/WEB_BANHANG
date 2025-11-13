<%-- 
    Document   : register
    Created on : 23 Oct 2025, 22:10:00
    Author     : NGOCTU
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng ký</title>

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
                /* Thêm padding để form không bị dính sát khi cuộn */
                padding: 3rem 0;
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
                max-width: 650px; /* Form đăng ký rộng hơn 1 chút */
            }
        </style>
    </head>
    <body>

        <div class="container-fluid form-container">
            <div class="form-box">

                <h2 class="text-center mb-2 fw-bold">Đăng ký tài khoản</h2>
                <p class="text-center text-muted mb-4">Ninh Bình Store</p>
                <%
                    // Hiển thị thông báo lỗi (từ RegisterServlet)
                    String regErrorMessage = (String) request.getAttribute("errorMessage");
                    if (regErrorMessage != null && !regErrorMessage.isEmpty()) {
                %>
                <div class="alert alert-danger" role="alert">
                    <%= regErrorMessage%>
                </div>
                <%
                    }
                %>
                <form action="RegisterServlet" method="POST">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-person-badge"></i></span>
                                <input type="text" class="form-control" name="hoten" placeholder="Họ và tên" required>
                            </div>
                        </div>

                        <div class="col-md-6 mb-3">
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                                <input type="text" class="form-control" name="tendangnhap" placeholder="Tên đăng nhập" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                                <input type="password" class="form-control" id="matkhau" name="matkhau" placeholder="Mật khẩu" required>

                                <button class="btn btn-outline-secondary" type="button" id="toggleMatKhau">
                                    <i class="bi bi-eye-fill"></i>
                                </button>
                            </div>
                        </div>

                        <div class="col-md-6 mb-3">
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-shield-lock-fill"></i></span>
                                <input type="password" class="form-control" id="nhaplaimatkhau" name="nhaplaimatkhau" placeholder="Nhập lại mật khẩu" required>

                                <button class="btn btn-outline-secondary" type="button" id="toggleNhapLaiMatKhau">
                                    <i class="bi bi-eye-fill"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="input-group mb-3">
                        <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
                        <input type="email" class="form-control" name="email" placeholder="Email" required>
                    </div>

                    <div class="input-group mb-3">
                        <span class="input-group-text"><i class="bi bi-telephone-fill"></i></span>
                        <input type="tel" class="form-control" name="sodienthoai" placeholder="Số điện thoại">
                    </div>

                    <div class="input-group mb-4">
                        <span class="input-group-text"><i class="bi bi-geo-alt-fill"></i></span>
                        <input type="text" class="form-control" name="diachi" placeholder="Địa chỉ">
                    </div>

                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-success btn-lg fw-bold">Đăng ký</button>
                    </div>

                    <div class="text-center">
                        <p>Đã có tài khoản? <a href="login.jsp">Đăng nhập ngay</a></p>
                    </div>
                </form>

            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/register.js"></script>
    </body>
</html>
