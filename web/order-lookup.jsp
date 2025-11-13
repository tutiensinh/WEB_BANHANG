<%-- File: order-lookup.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Tra cứu đơn hàng - NinhBinhStore</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <jsp:include page="header.jsp"><jsp:param name="title" value="Tra cứu"/></jsp:include>

            <main class="container my-5" style="max-width: 600px;">
                <div class="card p-4 p-md-5 shadow-sm border-0">
                    <h2 class="fw-bold mb-4 text-center">Tra cứu đơn hàng</h2>
                    <p class="text-muted text-center">Vui lòng nhập Email bạn đã dùng để đặt hàng:</p>
                    <form action="OrderLookupServlet" method="POST">
                        <div class="mb-3">
                            <input type="email" class="form-control form-control-lg" name="email" 
                                   placeholder="Nhập Email của bạn" required>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg fw-bold">Tra cứu</button>
                        </div>
                    </form>
                </div>
            </main>

        <jsp:include page="footer.jsp" />
    </body>
</html>