/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.io.File;
import database.ProductDAO;
import model.Product;
import java.util.List;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author NGOCTU
 */
// Đặt URL trong thư mục /admin/ để được bảo vệ
@WebServlet(name = "AdminProductServlet", urlPatterns = {"/admin/manage-products"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AdminProductServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminProductServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        ProductDAO dao = new ProductDAO();

        if (action == null) {
            // Mặc định: Hiển thị danh sách
            List<Product> list = dao.getAllProducts();
            request.setAttribute("listP", list);
            request.getRequestDispatcher("manage-products.jsp").forward(request, response);
        } else if (action.equals("delete")) {
            // Xóa sản phẩm
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteProduct(id);
            response.sendRedirect("manage-products");
        } else if (action.equals("edit")) {
            // Lấy thông tin sản phẩm để sửa
            int id = Integer.parseInt(request.getParameter("id"));
            Product p = dao.getProductById(id);
            request.setAttribute("detail", p);
            request.getRequestDispatcher("product-form.jsp").forward(request, response); // Chuyển sang form sửa
        } else if (action.equals("add")) {
            // Chuyển sang form thêm mới (trống)
            request.getRequestDispatcher("product-form.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        ProductDAO dao = new ProductDAO();

        // Lấy các thông tin văn bản
        String tensp = request.getParameter("tensp");
        String mota = request.getParameter("mota");
        // Xử lý lỗi nếu người dùng nhập giá/kho không phải số
        double dongia = 0;
        int tonkho = 0;
        try {
            dongia = Double.parseDouble(request.getParameter("dongia"));
            tonkho = Integer.parseInt(request.getParameter("tonkho"));
        } catch (NumberFormatException e) {
        } // Mặc định là 0 nếu lỗi

        String loai = request.getParameter("loai");

        // --- XỬ LÝ UPLOAD ẢNH ---
        String hinhanh = "";

        try {
            Part filePart = request.getPart("hinhanhFile");
            String fileName = filePart.getSubmittedFileName();

            // Nếu người dùng CÓ chọn file mới
            if (fileName != null && !fileName.isEmpty()) {
                // 1. Xác định thư mục lưu ảnh (webapp/images/products)
                // Lưu ý: getRealPath trỏ đến thư mục build, ảnh có thể mất khi Clean & Build
                String realPath = request.getServletContext().getRealPath("/") + "images" + File.separator + "products";

                // Tạo thư mục nếu chưa có
                File dir = new File(realPath);
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                // 2. Lưu file
                // Đặt tên file unique để tránh trùng lặp (dùng thời gian hệ thống)
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                filePart.write(realPath + File.separator + uniqueFileName);

                // 3. Lưu đường dẫn vào CSDL (đường dẫn tương đối)
                hinhanh = "images/products/" + uniqueFileName;
            } else {
                // Nếu KHÔNG chọn file mới, giữ nguyên ảnh cũ (lấy từ input hidden)
                hinhanh = request.getParameter("hinhanhCu");
                if (hinhanh == null) {
                    hinhanh = ""; // Phòng trường hợp null
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Nếu lỗi upload, giữ ảnh cũ
            hinhanh = request.getParameter("hinhanhCu");
        }
        // ------------------------

        if ("insert".equals(action)) {
            Product p = new Product(0, tensp, mota, dongia, hinhanh, loai, tonkho);
            dao.insertProduct(p);
            request.getSession().setAttribute("successMessage", "Đã thêm sản phẩm thành công!");
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Product p = new Product(id, tensp, mota, dongia, hinhanh, loai, tonkho);
            dao.updateProduct(p);
            request.getSession().setAttribute("successMessage", "Cập nhật sản phẩm thành công!");
        }

        response.sendRedirect("manage-products");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
