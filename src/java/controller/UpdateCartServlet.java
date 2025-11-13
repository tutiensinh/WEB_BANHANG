/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.NumberFormat;
import java.util.Locale;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import model.CartItem;
/**
 *
 * @author NGOCTU
 */
public class UpdateCartServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdateCartServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateCartServlet at " + request.getContextPath() + "</h1>");
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
       int productId = Integer.parseInt(request.getParameter("id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart != null) {
            // Tìm và cập nhật số lượng sản phẩm
            for (CartItem item : cart.getItems()) {
                if (item.getProduct().getId() == productId) {
                    if (quantity > 0) {
                        item.setQuantity(quantity);
                    } else {
                        // Nếu số lượng <= 0 thì xóa luôn (tùy chọn logic của bạn)
                        cart.removeItem(productId);
                    }
                    break;
                }
            }
            session.setAttribute("cart", cart);

            // Trả về dữ liệu JSON thủ công để cập nhật giao diện
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();

            NumberFormat nf = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
            double totalCart = cart.getTotalCartPrice();
            int totalItems = cart.getTotalItemCount();

            // Tìm lại item vừa update để lấy giá tổng của riêng nó
            double itemTotal = 0;
             for (CartItem item : cart.getItems()) {
                if (item.getProduct().getId() == productId) {
                    itemTotal = item.getTotalPrice();
                    break;
                }
            }
            
            // JSON trả về: { "itemTotal": "100.000 đ", "cartTotal": "5.000.000 đ", "totalItems": 5 }
            String json = String.format("{\"itemTotal\": \"%s\", \"cartTotal\": \"%s\", \"totalItems\": %d}", 
                    nf.format(itemTotal), 
                    nf.format(totalCart),
                    totalItems);
            
            out.print(json);
            out.flush();
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
