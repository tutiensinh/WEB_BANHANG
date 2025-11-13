package controller;

import database.DBConnect;
import model.Cart;
import model.CartItem;
import model.User;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/CheckoutServlet"})
public class CheckoutServlet extends HttpServlet {

    // THÔNG TIN TÀI KHOẢN CỦA BẠN (TECHCOMBANK)
    private static final String BANK_ID = "970407";
    private static final String ACCOUNT_NO = "19039593941013";
    private static final String ACCOUNT_NAME = "NGUYEN NGOC TU";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");

        if (user == null || cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("confirm_shipping".equals(action)) {
            session.setAttribute("ship_fullName", request.getParameter("fullName"));
            session.setAttribute("ship_email", request.getParameter("email"));
            session.setAttribute("ship_phone", request.getParameter("phone"));
            session.setAttribute("ship_address", request.getParameter("address"));
            session.setAttribute("ship_note", request.getParameter("note"));

            long amount = (long) cart.getTotalCartPrice();
            String orderIdStr = "DH" + System.currentTimeMillis();

            try {
                String encodedName = URLEncoder.encode(ACCOUNT_NAME, StandardCharsets.UTF_8.toString()).replace("+", "%20");
                String description = orderIdStr;
                String encodedDesc = URLEncoder.encode(description, StandardCharsets.UTF_8.toString()).replace("+", "%20");
                String qrUrl = String.format("https://img.vietqr.io/image/%s-%s-compact2.png?amount=%d&addInfo=%s&accountName=%s",
                        BANK_ID, ACCOUNT_NO, amount, encodedDesc, encodedName);

                request.setAttribute("qrUrl", qrUrl);
                request.setAttribute("description", description);
            } catch (Exception e) {
                e.printStackTrace();
            }

            request.setAttribute("amount", amount);
            request.setAttribute("bankName", "Techcombank");
            request.setAttribute("accountNo", ACCOUNT_NO);
            request.setAttribute("accountName", ACCOUNT_NAME);

            request.getRequestDispatcher("checkout.jsp").forward(request, response);

        } else if ("complete_order".equals(action)) {
            // Kiểm tra bảo mật: Đảm bảo người dùng đã qua bước nhập thông tin
            if (session.getAttribute("ship_address") == null) {
                response.sendRedirect("cart.jsp");
                return;
            }
            completeOrder(request, response, session, cart, user.getId());
        }
    }

    private void completeOrder(HttpServletRequest request, HttpServletResponse response, HttpSession session, Cart cart, int userId) throws IOException {
        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psDetail = null;
        PreparedStatement psUpdateStock = null; // Thêm PreparedStatement để cập nhật kho
        ResultSet rs = null;
        try {
            conn = DBConnect.getConnection();
            conn.setAutoCommit(false);

            // 1. Lưu đơn hàng
            String sqlOrder = "INSERT INTO donhang (id_taikhoan, ngaydat, diachi, email, tongtien, trangthai) VALUES (?, NOW(), ?, ?, ?, 'Chờ xử lý')";
            psOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, userId);
            psOrder.setString(2, (String) session.getAttribute("ship_address"));
            psOrder.setString(3, (String) session.getAttribute("ship_email")); // Đã thêm email
            psOrder.setDouble(4, cart.getTotalCartPrice());
            psOrder.executeUpdate();

            rs = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // 2. Lưu chi tiết đơn hàng & Cập nhật tồn kho
            String sqlDetail = "INSERT INTO chitietdonhang (id_donhang, id_sanpham, soluong, dongia) VALUES (?, ?, ?, ?)";
            psDetail = conn.prepareStatement(sqlDetail);

            String sqlUpdateStock = "UPDATE sanpham SET tonkho = tonkho - ? WHERE id = ?";
            psUpdateStock = conn.prepareStatement(sqlUpdateStock);

            for (CartItem item : cart.getItems()) {
                // Thêm vào chi tiết đơn hàng
                psDetail.setInt(1, orderId);
                psDetail.setInt(2, item.getProduct().getId());
                psDetail.setInt(3, item.getQuantity());
                psDetail.setDouble(4, item.getProduct().getDongia());
                psDetail.addBatch();

                // Cập nhật tồn kho
                psUpdateStock.setInt(1, item.getQuantity());
                psUpdateStock.setInt(2, item.getProduct().getId());
                psUpdateStock.addBatch();
            }
            psDetail.executeBatch();
            psUpdateStock.executeBatch(); // Thực thi cập nhật kho

            conn.commit();

            // Lưu orderId vào session để hiển thị ở trang thành công
            session.setAttribute("last_order_id", orderId);

            // Xóa session không cần thiết
            session.removeAttribute("cart");
            session.removeAttribute("ship_fullName");
            session.removeAttribute("ship_email"); // Xóa cả ship_email
            session.removeAttribute("ship_phone");
            session.removeAttribute("ship_address");
            session.removeAttribute("ship_note");

            response.sendRedirect("order-success.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            response.sendRedirect("cart.jsp?error=order_failed");
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (psOrder != null) {
                    psOrder.close();
                }
                if (psDetail != null) {
                    psDetail.close();
                }
                if (psUpdateStock != null) {
                    psUpdateStock.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("cart.jsp");
    }
}
