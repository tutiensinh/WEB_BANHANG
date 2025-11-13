/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.User;
import database.DBConnect; // Import lớp DBContext
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;

/**
 *
 * @author NGOCTU
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

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
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("login.jsp").forward(request, response);
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

        String tendangnhap = request.getParameter("tendangnhap");
        String matkhau = request.getParameter("matkhau"); // Mật khẩu thường

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnect.getConnection();
            String sql = "SELECT * FROM taikhoan WHERE tendangnhap = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, tendangnhap);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Lấy mật khẩu (dạng thường) từ CSDL
                String passwordFromDB = rs.getString("matkhau");

                // **** THAY ĐỔI QUAN TRỌNG ****
                // So sánh trực tiếp mật khẩu thường
                if (matkhau.equals(passwordFromDB)) {
                    // Mật khẩu khớp! Đăng nhập thành công
                    HttpSession session = request.getSession();

                    // 1. Lấy vai trò (role)
                    String vaitro = rs.getString("vaitro");
                    int userId = rs.getInt("id");
                    String hoten = rs.getString("hoten");

                    // 2. Tạo đối tượng User đầy đủ (như đã làm trước đó)
                    User user = new User();
                    user.setId(userId);
                    user.setHoten(hoten);
                    user.setTendangnhap(rs.getString("tendangnhap"));
                    user.setMatkhau(rs.getString("matkhau")); // Cẩn thận, không nên lưu pass vào session, nhưng ta làm theo code cũ
                    user.setEmail(rs.getString("email"));
                    user.setSodienthoai(rs.getString("sodienthoai"));
                    user.setDiachi(rs.getString("diachi"));
                    user.setVaitro(vaitro);

                    // 3. Lưu thông tin vào session
                    session.setAttribute("user", user);
                    session.setAttribute("id_taikhoan", userId);
                    session.setAttribute("hoten", hoten);
                    session.setAttribute("vaitro", vaitro);

                    // 4. ĐIỀU HƯỚNG PHÂN QUYỀN (THAY ĐỔI CHÍNH Ở ĐÂY)
                    if ("admin".equals(vaitro)) {
                        // Nếu là admin, chuyển hướng đến trang Dashboard của Admin
                        response.sendRedirect("admin/dashboard");
                    } else {
                        // Nếu là user, chuyển đến trang chủ bình thường
                        response.sendRedirect("HomeServlet");
                    }
                    return; // Rất quan trọng, kết thúc xử lý sau khi đã sendRedirect
                } else {
                    // Sai mật khẩu
                    request.setAttribute("errorMessage", "Sai mật khẩu. Vui lòng thử lại.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                // Không tìm thấy tên đăng nhập
                request.setAttribute("errorMessage", "Tài khoản này chưa tồn tại.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi CSDL: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
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
