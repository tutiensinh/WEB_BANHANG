<%-- File: webapp/admin/product-form.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>${empty detail ? "Thêm sản phẩm" : "Sửa sản phẩm"}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <main class="container my-5" style="max-width: 700px;">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">${empty detail ? "Thêm sản phẩm mới" : "Chỉnh sửa sản phẩm"}</h4>
                </div>
                <div class="card-body p-4">
                    <form action="manage-products" method="POST" enctype="multipart/form-data">
                        <%-- Nếu là sửa thì action là update, thêm mới là insert --%>
                        <input type="hidden" name="action" value="${empty detail ? 'insert' : 'update'}">

                        <%-- Nếu là sửa thì cần gửi kèm ID --%>
                        <c:if test="${not empty detail}">
                            <input type="hidden" name="id" value="${detail.id}">
                        </c:if>

                        <div class="mb-3">
                            <label class="form-label">Tên sản phẩm</label>
                            <input type="text" class="form-control" name="tensp" value="${detail.tensp}" required>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Đơn giá (VNĐ)</label>
                                <input type="number" class="form-control" name="dongia" value="${detail.dongia}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Tồn kho</label>
                                <input type="number" class="form-control" name="tonkho" value="${detail.tonkho}" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Danh mục</label>
                            <select class="form-select" name="loai">
                                <%-- Sử dụng danh sách danh mục từ applicationScope --%>
                                <c:forEach var="cat" items="${applicationScope.categories}">
                                    <option value="${cat}" ${detail.loai == cat ? 'selected' : ''}>${cat}</option>
                                </c:forEach>
                                <option value="Khác">Khác</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Hình ảnh sản phẩm</label>
                            <%-- Ô chọn file --%>
                            <input type="file" class="form-control" name="hinhanhFile" id="hinhanhFile" accept="image/*">

                            <%-- Input ẩn để giữ lại đường dẫn ảnh cũ khi sửa --%>
                            <input type="hidden" name="hinhanhCu" value="${detail.hinhanh}">

                            <%-- Hiển thị ảnh hiện tại nếu đang sửa --%>
                            <c:if test="${not empty detail.hinhanh}">
                                <div class="mt-2">
                                    <img src="${pageContext.request.contextPath}/${detail.hinhanh}" style="height: 100px; border: 1px solid #ddd; padding: 5px;">
                                    <small class="text-muted d-block">Ảnh hiện tại</small>
                                </div>
                            </c:if>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Mô tả sản phẩm</label>
                            <textarea class="form-control" name="mota" rows="4">${detail.mota}</textarea>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="manage-products" class="btn btn-secondary">Hủy bỏ</a>
                            <button type="submit" class="btn btn-primary px-4">Lưu lại</button>
                        </div>
                    </form>
                </div>
            </div>
        </main>

        <script>
// Khi người dùng chọn file mới
            document.getElementById('hinhanhFile').onchange = function (evt) {
                var tgt = evt.target || window.event.srcElement,
                        files = tgt.files;

// Kiểm tra xem có file được chọn không
                if (FileReader && files && files.length) {
                    var fr = new FileReader();
// Khi ảnh tải xong, gán nó vào thẻ img
                    fr.onload = function () {
// Tìm thẻ img hiển thị ảnh hiện tại và thay đổi src
                        var img = document.querySelector('img[src*="images/products"]');
                        if (img)
                            img.src = fr.result;
                    }
                    fr.readAsDataURL(files[0]);
                }
            }
        </script>
    </body>
</html>