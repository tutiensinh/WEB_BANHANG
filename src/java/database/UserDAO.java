/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database;

import model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author NGOCTU
 */
public class UserDAO {

    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    /**
     * Lấy thông tin chi tiết của người dùng dựa trên ID. Dùng cho trang "Thông
     * tin tài khoản".
     *
     * @param id ID của tài khoản cần lấy
     * @return Đối tượng User chứa đầy đủ thông tin, hoặc null nếu không tìm
     * thấy
     */
    public User getUserById(int id) {
        User user = null;
        String query = "SELECT * FROM taikhoan WHERE id = ?";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setHoten(rs.getString("hoten"));
                user.setTendangnhap(rs.getString("tendangnhap"));
                user.setMatkhau(rs.getString("matkhau"));
                user.setEmail(rs.getString("email"));
                user.setSodienthoai(rs.getString("sodienthoai"));
                user.setDiachi(rs.getString("diachi"));
                user.setVaitro(rs.getString("vaitro"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return user;
    }

    /**
     * Kiểm tra đăng nhập (Bạn có thể dùng hàm này thay thế code trong
     * LoginServlet sau này để gọn hơn)
     *
     * @param username Tên đăng nhập
     * @param password Mật khẩu
     * @return User nếu đăng nhập đúng, null nếu sai
     */
    public User checkLogin(String username, String password) {
        User user = null;
        String query = "SELECT * FROM taikhoan WHERE tendangnhap = ? AND matkhau = ?";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setHoten(rs.getString("hoten"));
                user.setTendangnhap(rs.getString("tendangnhap"));
                user.setMatkhau(rs.getString("matkhau"));
                // Các trường khác nếu cần thiết cho session ngay lúc login
                user.setVaitro(rs.getString("vaitro"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return user;
    }

    // Cập nhật thông tin cá nhân
    public boolean updateUserInfo(User user) {
        String query = "UPDATE taikhoan SET hoten=?, email=?, sodienthoai=?, diachi=? WHERE id=?";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, user.getHoten());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getSodienthoai());
            ps.setString(4, user.getDiachi());
            ps.setInt(5, user.getId());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return false;
    }

    // Đổi mật khẩu
    public boolean changePassword(int userId, String newPassword) {
        String query = "UPDATE taikhoan SET matkhau=? WHERE id=?";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            // LƯU Ý: Nếu bạn đã áp dụng mã hóa BCrypt, hãy mã hóa newPassword trước khi truyền vào đây!
            ps.setString(1, newPassword);
            ps.setInt(2, userId);

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return false;
    }

    // Kiểm tra mật khẩu cũ (để đảm bảo an toàn khi đổi mật khẩu)
    public boolean checkOldPassword(int userId, String oldPassword) {
        String query = "SELECT matkhau FROM taikhoan WHERE id=?";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                String currentPassword = rs.getString("matkhau");
                // Nếu dùng BCrypt: return BCrypt.checkpw(oldPassword, currentPassword);
                return oldPassword.equals(currentPassword);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return false;
    }

    /**
     * [ADMIN] Lấy TẤT CẢ các tài khoản người dùng (trừ admin).
     */
    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        // Lấy tất cả user, trừ admin
        String query = "SELECT * FROM taikhoan WHERE vaitro = 'user' ORDER BY id DESC";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setHoten(rs.getString("hoten"));
                user.setTendangnhap(rs.getString("tendangnhap"));
                user.setEmail(rs.getString("email"));
                user.setSodienthoai(rs.getString("sodienthoai"));
                user.setDiachi(rs.getString("diachi"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return userList;
    }
    
    // Hàm đóng kết nối để tránh rò rỉ tài nguyên
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
