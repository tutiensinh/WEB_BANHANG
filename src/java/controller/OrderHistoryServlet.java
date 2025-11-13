/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import database.OrderDAO;
import model.Order;
import model.OrderItem;
import java.util.List;
import jakarta.servlet.http.HttpSession;
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
public class OrderHistoryServlet extends HttpServlet {

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
            out.println("<title>Servlet OrderHistoryServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderHistoryServlet at " + request.getContextPath() + "</h1>");
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
        Object userIdObj = session.getAttribute("id_taikhoan"); // Lấy ID đã lưu khi đăng nhập

        // BẢO VỆ: Nếu chưa đăng nhập, chuyển về trang Login
        if (userIdObj == null) {
            response.sendRedirect("LoginServlet?error=Vui lòng đăng nhập để xem lịch sử");
            return;
        }

        int userId = (int) userIdObj;
        OrderDAO dao = new OrderDAO();

        // 1. Lấy tất cả đơn hàng của user này
        List<Order> orders = dao.getOrdersByUserId(userId);

        // 2. Với mỗi đơn hàng, lấy các sản phẩm chi tiết của nó
        // (Tận dụng hàm getOrderDetails bạn đã tạo cho chức năng Tra cứu)
        for (Order order : orders) {
            List<OrderItem> items = dao.getOrderDetails(order.getId());
            order.setItems(items);
        }

        // 3. Gửi danh sách đơn hàng sang trang JSP
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("order-history.jsp").forward(request, response);
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
