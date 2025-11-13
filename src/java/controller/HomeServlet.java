/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.Product;
import database.ProductDAO;
import java.io.IOException;
import java.util.List;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author NGOCTU
 */

public class HomeServlet extends HttpServlet {

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
            out.println("<title>Servlet HomeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");

        ProductDAO dao = new ProductDAO();

// Lấy 4 sản phẩm cho mỗi danh mục để trang chủ gọn gàng
        List<Product> newestList = dao.getNewestProducts(4);
        List<Product> kitchenList = dao.getProductsByCategory("Nhà bếp", 4);
        List<Product> cleaningList = dao.getProductsByCategory("Làm sạch", 4);
        List<Product> saleList = dao.getProductsByCategory("Khuyến mãi", 4);

// *** PHẦN BỔ SUNG ***
        List<Product> largeAppliancesList = dao.getProductsByCategory("Gia dụng lớn", 4);

// Đặt các danh sách này vào request để gửi sang JSP
        request.setAttribute("newestProducts", newestList);
        request.setAttribute("kitchenProducts", kitchenList);
        request.setAttribute("cleaningProducts", cleaningList);
        request.setAttribute("saleProducts", saleList);

// *** PHẦN BỔ SUNG ***
        request.setAttribute("largeAppliances", largeAppliancesList);

// Chuyển tiếp đến trang index.jsp
        request.getRequestDispatcher("trangchu.jsp").forward(request, response);
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
        doGet(request, response);
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
