/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import database.DBConnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author NGOCTU
 */
public class ForgotPasswordServlet extends HttpServlet {

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
            out.println("<title>Servlet ForgotPasswordServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotPasswordServlet at " + request.getContextPath() + "</h1>");
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
        // Chỉ hiển thị form
        request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
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
        
        String email = request.getParameter("email");
        String newPass = request.getParameter("newPass");
        String confirmPass = request.getParameter("confirmPass");

        if (!newPass.equals(confirmPass)) {
            request.setAttribute("message", "Mật khẩu xác nhận không khớp!");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement psCheck = null;
        PreparedStatement psUpdate = null;
        ResultSet rs = null;

        try {
            conn = DBConnect.getConnection();
            
            // 1. Kiểm tra Email có tồn tại trong CSDL không
            String sqlCheck = "SELECT id FROM taikhoan WHERE email = ?";
            psCheck = conn.prepareStatement(sqlCheck);
            psCheck.setString(1, email);
            rs = psCheck.executeQuery();

            if (rs.next()) {
                // 2. Nếu Email tồn tại, tiến hành cập nhật mật khẩu
                String sqlUpdate = "UPDATE taikhoan SET matkhau = ? WHERE email = ?";
                psUpdate = conn.prepareStatement(sqlUpdate);
                
                // LƯU Ý: Nếu bạn đã áp dụng BCrypt, hãy mã hóa 'newPass' tại đây!
                psUpdate.setString(1, newPass); 
                psUpdate.setString(2, email);
                int result = psUpdate.executeUpdate();

                if (result > 0) {
                    // Thành công: Chuyển hướng về trang đăng nhập
                    request.getSession().setAttribute("successMessage", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập.");
                    response.sendRedirect("LoginServlet");
                    return;
                }
            }
            
            // Xử lý chung cho trường hợp email không tồn tại hoặc lỗi update
            request.setAttribute("message", "Email không tồn tại hoặc không thể đặt lại mật khẩu.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Lỗi CSDL: " + e.getMessage());
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (psCheck != null) psCheck.close();
                if (psUpdate != null) psUpdate.close();
                if (conn != null) conn.close();
            } catch (SQLException e) { e.printStackTrace(); }
        }
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
