/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import database.OrderDAO;
import model.Order;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author NGOCTU
 */
// Đặt URL này bên trong thư mục /admin/ để được Filter bảo vệ
@WebServlet(name = "AdminOrderServlet", urlPatterns = {"/admin/manage-orders"})
public class AdminOrderServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminOrderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminOrderServlet at " + request.getContextPath() + "</h1>");
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
        OrderDAO dao = new OrderDAO();
        List<Order> allOrders = dao.getAllOrders(); // Lấy tất cả đơn hàng

        request.setAttribute("allOrders", allOrders);
        request.getRequestDispatcher("/admin/manage-orders.jsp").forward(request, response);
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
        // FIX: Thêm dòng này để hứng tiếng Việt từ JSP không bị lỗi font
        request.setCharacterEncoding("UTF-8");
        // Xử lý khi admin cập nhật trạng thái
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String newStatus = request.getParameter("newStatus");

            OrderDAO dao = new OrderDAO();
            dao.updateOrderStatus(orderId, newStatus);

            request.getSession().setAttribute("successMessage", "Cập nhật trạng thái đơn hàng #" + orderId + " thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật!");
        }
        // Tải lại trang
        // Dùng request.getContextPath() để lấy tên dự án (ví dụ: /WebBanDoGiaDung)
        // Sau đó cộng với đường dẫn đầy đủ của servlet (/admin/manage-orders)
        response.sendRedirect(request.getContextPath() + "/admin/manage-orders");
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
