/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import database.ProductDAO;
import model.Cart;
import model.CartItem;
import model.Product;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author NGOCTU
 */
public class AddToCartServlet extends HttpServlet {

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
            out.println("<title>Servlet AddToCartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddToCartServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();

        // --- KIỂM TRA ĐĂNG NHẬP ---
        if (session.getAttribute("id_taikhoan") == null) {
            // Nếu chưa đăng nhập:

            // 1. Lưu lại trang hiện tại để quay lại sau khi đăng nhập (Tùy chọn nâng cao)
            // String referer = request.getHeader("Referer");
            // session.setAttribute("redirectAfterLogin", referer);
            // 2. Kiểm tra xem yêu cầu là AJAX hay trang thường
            String requestedWith = request.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(requestedWith)) {
                // Nếu là AJAX (từ nút "Thêm vào giỏ"), trả về lỗi 401 Unauthorized
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            } else {
                // Nếu là truy cập trực tiếp (từ nút "Mua ngay"), chuyển hướng đến trang login
                // Thêm thông báo để hiển thị ở trang login
                request.setAttribute("errorMessage", "Vui lòng đăng nhập để mua hàng!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            return; // Dừng xử lý tại đây
        }

        try {
            int productId = Integer.parseInt(request.getParameter("id"));
            int quantity = 1;
            try {
                quantity = Integer.parseInt(request.getParameter("quantity"));
                if (quantity <= 0) {
                    quantity = 1; // Đảm bảo số lượng tối thiểu là 1
                }
            } catch (NumberFormatException e) {
                quantity = 1;
            }

            // Kiểm tra hành động: "add" (thêm vào giỏ) hay "buy" (mua ngay)
            String action = request.getParameter("action");
            if (action == null) {
                action = "add"; // Mặc định là thêm
            }
           
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
            }

            ProductDAO dao = new ProductDAO();
            Product product = dao.getProductById(productId);

            if (product != null) {
                CartItem item = new CartItem(product, quantity);
                cart.addItem(item);
            }

            session.setAttribute("cart", cart);

            // XỬ LÝ ĐIỀU HƯỚNG
            if ("buy".equals(action)) {
                // Nếu là "Mua ngay" -> Chuyển thẳng đến trang giỏ hàng
                response.sendRedirect("cart.jsp");
            } else {
                // Nếu là "Thêm vào giỏ" -> Trả về thành công để AJAX xử lý (không redirect)
                // Chúng ta chỉ cần gửi mã 200 OK là đủ để JS biết là thành công
                response.setStatus(HttpServletResponse.SC_OK);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
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
        processRequest(request, response);
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
