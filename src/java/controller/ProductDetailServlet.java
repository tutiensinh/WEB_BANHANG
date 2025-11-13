/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import database.ProductDAO;
import model.Product;
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
@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/product-detail"})
public class ProductDetailServlet extends HttpServlet {

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
            out.println("<title>Servlet ProductDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductDetailServlet at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");

        try {
            String idParam = request.getParameter("id");

            // Kiểm tra nếu không có ID hoặc ID rỗng thì quay về trang chủ
            if (idParam == null || idParam.isEmpty()) {
                response.sendRedirect("HomeServlet");
                return;
            }

            // 1. Lấy ID sản phẩm từ URL
            int id = Integer.parseInt(idParam);

            // 2. Gọi DAO để lấy thông tin sản phẩm
            ProductDAO dao = new ProductDAO();
            Product product = dao.getProductById(id);

            // Nếu không tìm thấy sản phẩm (ID sai), cũng quay về trang chủ hoặc trang lỗi
            if (product == null) {
                response.sendRedirect("HomeServlet");
                return;
            }

            // 3. Gửi thông tin sản phẩm sang file JSP
            request.setAttribute("product", product);

            // 4. Chuyển sang trang View (product-detail.jsp)
            request.getRequestDispatcher("product-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // Xử lý nếu ID không phải là số hợp lệ
            e.printStackTrace();
            response.sendRedirect("HomeServlet");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("HomeServlet");
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
