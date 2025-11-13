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
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author NGOCTU
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

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
            out.println("<title>Servlet RegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("register.jsp").forward(request, response);
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
        response.setContentType("text/html;charset=UTF-8");

        String hoten = request.getParameter("hoten");
        String tendangnhap = request.getParameter("tendangnhap");
        String matkhau = request.getParameter("matkhau"); // Mật khẩu thường
        String nhaplaimatkhau = request.getParameter("nhaplaimatkhau");
        String email = request.getParameter("email");
        String sodienthoai = request.getParameter("sodienthoai");
        String diachi = request.getParameter("diachi");

        if (!matkhau.equals(nhaplaimatkhau)) {
            request.setAttribute("errorMessage", "Mật khẩu nhập lại không khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
             
        Connection conn = null;
        PreparedStatement psCheck = null;
        PreparedStatement psInsert = null;
        ResultSet rs = null;

        try {
            conn = DBConnect.getConnection();
            
            // 1. Kiểm tra Tên đăng nhập đã tồn tại chưa
            String sqlCheck = "SELECT * FROM taikhoan WHERE tendangnhap = ?";
            psCheck = conn.prepareStatement(sqlCheck);
            psCheck.setString(1, tendangnhap);
            rs = psCheck.executeQuery();

            if (rs.next()) {
                request.setAttribute("errorMessage", "Tên đăng nhập đã được sử dụng!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // 2. Thêm tài khoản mới vào CSDL
            String sqlInsert = "INSERT INTO taikhoan (hoten, tendangnhap, matkhau, email, sodienthoai, diachi, vaitro) "
                             + "VALUES (?, ?, ?, ?, ?, ?, 'user')";
            
            psInsert = conn.prepareStatement(sqlInsert);
            psInsert.setString(1, hoten);
            psInsert.setString(2, tendangnhap);
            
            // **** THAY ĐỔI QUAN TRỌNG ****
            psInsert.setString(3, matkhau); // Lưu mật khẩu thường
            
            psInsert.setString(4, email);
            psInsert.setString(5, sodienthoai);
            psInsert.setString(6, diachi);

            int result = psInsert.executeUpdate();

            if (result > 0) {
                request.getSession().setAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
                response.sendRedirect("login.jsp");
            } else {
                request.setAttribute("errorMessage", "Đăng ký thất bại. Vui lòng thử lại.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi CSDL: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (psCheck != null) psCheck.close();
                if (psInsert != null) psInsert.close();
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
