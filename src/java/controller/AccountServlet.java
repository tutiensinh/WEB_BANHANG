/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import database.UserDAO;
import model.User;
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
public class AccountServlet extends HttpServlet {

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
            out.println("<title>Servlet AccountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AccountServlet at " + request.getContextPath() + "</h1>");
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

        // Lấy ID của người dùng đang đăng nhập từ session
        Object userIdObj = session.getAttribute("id_taikhoan");

        // Nếu chưa đăng nhập, đá về trang login
        if (userIdObj == null) {
            response.sendRedirect("LoginServlet");
            return;
        }

        int userId = (int) userIdObj;

        // Gọi DAO để lấy thông tin chi tiết nhất từ CSDL
        UserDAO dao = new UserDAO();
        User accountInfo = dao.getUserById(userId);

        // Gửi đối tượng User sang trang JSP
        request.setAttribute("accountInfo", accountInfo);

        // Chuyển hướng đến trang hiển thị
        request.getRequestDispatcher("account.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user"); // Lấy user hiện tại từ session

        if (currentUser == null) {
            response.sendRedirect("LoginServlet");
            return;
        }

        String action = request.getParameter("action");
        UserDAO dao = new UserDAO();

        if ("update_info".equals(action)) {
            // --- XỬ LÝ CẬP NHẬT THÔNG TIN ---
            String hoten = request.getParameter("hoten");
            String email = request.getParameter("email");
            String sdt = request.getParameter("sodienthoai");
            String diachi = request.getParameter("diachi");

            // Cập nhật vào đối tượng User hiện tại
            currentUser.setHoten(hoten);
            currentUser.setEmail(email);
            currentUser.setSodienthoai(sdt);
            currentUser.setDiachi(diachi);

            if (dao.updateUserInfo(currentUser)) {
                // Cập nhật thành công thì lưu lại vào session mới
                session.setAttribute("user", currentUser);
                session.setAttribute("hoten", hoten); // Cập nhật cả attribute lẻ nếu còn dùng
                session.setAttribute("successMessage", "Cập nhật thông tin thành công!");
            } else {
                session.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật!");
            }
        }
        // Quay lại trang account để hiển thị kết quả
        response.sendRedirect("AccountServlet");
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
