/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database;

import model.Order;
import model.OrderItem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    private void closeConnections() {
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

    /**
     * Tìm các đơn hàng dựa trên Email (của tài khoản) hoặc Mã đơn hàng (ID).
     */
    public List<Order> findOrdersByEmail(String email) {
        List<Order> orders = new ArrayList<>();
        // Join donhang với taikhoan để lấy email và hoten
        String query = "SELECT d.id, d.ngaydat, d.tongtien, d.trangthai, t.hoten, t.email "
                + "FROM donhang d "
                + "JOIN taikhoan t ON d.id_taikhoan = t.id "
                + "WHERE t.email = ?"; // Chỉ tìm theo email

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, email); // Chỉ tìm theo email
            rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setNgaydat(rs.getTimestamp("ngaydat"));
                order.setTongtien(rs.getDouble("tongtien"));
                order.setTrangthai(rs.getString("trangthai"));
                order.setHoten(rs.getString("hoten"));
                order.setEmail(rs.getString("email"));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return orders;
    }

    /**
     * Lấy tất cả các sản phẩm chi tiết của một đơn hàng.
     */
    public List<OrderItem> getOrderDetails(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        // Join chitietdonhang với sanpham để lấy tên và ảnh SP
        String query = "SELECT ct.soluong, ct.dongia, sp.tensp, sp.hinhanh "
                + "FROM chitietdonhang ct "
                + "JOIN sanpham sp ON ct.id_sanpham = sp.id "
                + "WHERE ct.id_donhang = ?";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setSoluong(rs.getInt("soluong"));
                item.setDongia(rs.getDouble("dongia"));
                item.setTensp(rs.getString("tensp"));
                item.setHinhanh(rs.getString("hinhanh"));
                items.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return items;
    }

    /**
     * Lấy TẤT CẢ các đơn hàng của một ID tài khoản cụ thể. Sắp xếp theo ngày
     * mới nhất lên trước.
     */
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        // Join donhang với taikhoan (mặc dù chỉ cần userId, nhưng để lấy tên/email cho đầy đủ)
        String query = "SELECT d.id, d.ngaydat, d.tongtien, d.trangthai, t.hoten, t.email "
                + "FROM donhang d "
                + "JOIN taikhoan t ON d.id_taikhoan = t.id "
                + "WHERE d.id_taikhoan = ? "
                + // Đã xóa điều kiện trạng thái
                "ORDER BY d.ngaydat DESC";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setNgaydat(rs.getTimestamp("ngaydat"));
                order.setTongtien(rs.getDouble("tongtien"));
                order.setTrangthai(rs.getString("trangthai"));
                order.setHoten(rs.getString("hoten"));
                order.setEmail(rs.getString("email"));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return orders;
    }

    /**
     * [ADMIN] Lấy TẤT CẢ các đơn hàng trong hệ thống.
     */
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        // Sắp xếp theo đơn hàng mới nhất lên đầu
        String query = "SELECT d.id, d.ngaydat, d.tongtien, d.trangthai, t.hoten, t.email "
                + "FROM donhang d "
                + "JOIN taikhoan t ON d.id_taikhoan = t.id "
                + "ORDER BY d.ngaydat DESC";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setNgaydat(rs.getTimestamp("ngaydat"));
                order.setTongtien(rs.getDouble("tongtien"));
                order.setTrangthai(rs.getString("trangthai"));
                order.setHoten(rs.getString("hoten"));
                order.setEmail(rs.getString("email"));

                // Lấy chi tiết đơn hàng (có thể làm sau để tối ưu)
                // List<OrderItem> items = getOrderDetails(order.getId());
                // order.setItems(items);
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return orders;
    }

    /**
     * [ADMIN] Cập nhật trạng thái của một đơn hàng.
     */
    public boolean updateOrderStatus(int orderId, String newStatus) {
        String query = "UPDATE donhang SET trangthai = ? WHERE id = ?";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return false;
    }

}
