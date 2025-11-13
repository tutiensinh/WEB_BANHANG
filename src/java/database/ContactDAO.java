/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Contact;

/**
 *
 * @author NGOCTU
 */
public class ContactDAO {

    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    /**
     * Lưu thông tin liên hệ vào cơ sở dữ liệu.
     *
     * @param hoten Tên người gửi
     * @param email Email người gửi
     * @param noidung Nội dung tin nhắn
     * @return true nếu lưu thành công, false nếu thất bại
     */
    public boolean saveContact(String hoten, String email, String noidung) {
        // Sử dụng NOW() của MySQL để tự động điền ngày giờ hiện tại
        String query = "INSERT INTO lienhe (hoten, email, noidung, ngaygui) VALUES (?, ?, ?, NOW())";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, hoten);
            ps.setString(2, email);
            ps.setString(3, noidung);

            int result = ps.executeUpdate();
            return result > 0; // Trả về true nếu có hàng nào đó được chèn

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return false;
    }

    // [ADMIN] Lấy tất cả liên hệ, mới nhất lên đầu
    public List<Contact> getAllContacts() {
        List<Contact> list = new ArrayList<>();
        String query = "SELECT * FROM lienhe ORDER BY ngaygui DESC";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Contact(
                        rs.getInt("id"),
                        rs.getString("hoten"),
                        rs.getString("email"),
                        rs.getString("noidung"),
                        rs.getTimestamp("ngaygui")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }

    // [ADMIN] Xóa liên hệ
    public boolean deleteContact(int id) {
        String query = "DELETE FROM lienhe WHERE id=?";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return false;
    }

    // Hàm đóng kết nối
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
}
