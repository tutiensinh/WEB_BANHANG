/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database;

import database.DBConnect;
import model.Product;
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
public class ProductDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // Hàm lấy tất cả sản phẩm theo loại (Category)
    public List<Product> getProductsByCategory(String categoryName, int limit) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM sanpham WHERE loai = ? LIMIT ?";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, categoryName);
            ps.setInt(2, limit);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("id"),
                        rs.getString("tensp"),
                        rs.getString("mota"),
                        rs.getDouble("dongia"),
                        rs.getString("hinhanh"),
                        rs.getString("loai"),
                        rs.getInt("tonkho")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }

    // Hàm lấy sản phẩm mới nhất
    public List<Product> getNewestProducts(int limit) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM sanpham ORDER BY id DESC LIMIT ?";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, limit);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("id"),
                        rs.getString("tensp"),
                        rs.getString("mota"),
                        rs.getDouble("dongia"),
                        rs.getString("hinhanh"),
                        rs.getString("loai"),
                        rs.getInt("tonkho")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }

    // Hàm tìm kiếm sản phẩm
    public List<Product> searchProducts(String searchQuery) {
        List<Product> list = new ArrayList<>();
        // Tìm kiếm trong cả Tên sản phẩm và Mô tả
        String query = "SELECT * FROM sanpham WHERE LOWER(tensp) LIKE ? OR LOWER(mota) LIKE ?";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            // Sửa tham số: Chuyển searchQuery về chữ thường
            String lowerCaseQuery = "%" + searchQuery.toLowerCase() + "%";
            ps.setString(1, lowerCaseQuery);
            ps.setString(2, lowerCaseQuery);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("id"),
                        rs.getString("tensp"),
                        rs.getString("mota"),
                        rs.getDouble("dongia"),
                        rs.getString("hinhanh"),
                        rs.getString("loai"),
                        rs.getInt("tonkho")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections(); // Hàm này bạn đã có
        }
        return list;
    }

    // Hàm mới để lấy gợi ý (chỉ lấy tên sản phẩm)
    public List<Product> getSearchSuggestions(String query, int limit) {
        List<Product> suggestions = new ArrayList<>();

        // Sửa câu SQL: Lấy tất cả các cột, không chỉ 'tensp'
        String sql = "SELECT * FROM sanpham WHERE LOWER(tensp) LIKE ? LIMIT ?";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + query.toLowerCase() + "%");
            ps.setInt(2, limit);
            rs = ps.executeQuery();

            while (rs.next()) {
                // Sửa logic: Thêm toàn bộ đối tượng Product vào danh sách
                suggestions.add(new Product(
                        rs.getInt("id"),
                        rs.getString("tensp"),
                        rs.getString("mota"),
                        rs.getDouble("dongia"), // Đảm bảo khớp CSDL (file SQL của bạn dùng 'dongia')
                        rs.getString("hinhanh"),
                        rs.getString("loai"),
                        rs.getInt("tonkho")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return suggestions;
    }

    // Hàm lấy 1 sản phẩm bằng ID
    public Product getProductById(int id) {
        String query = "SELECT * FROM sanpham WHERE id = ?";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(
                        rs.getInt("id"),
                        rs.getString("tensp"),
                        rs.getString("mota"),
                        rs.getDouble("dongia"),
                        rs.getString("hinhanh"),
                        rs.getString("loai"),
                        rs.getInt("tonkho")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return null; // Trả về null nếu không tìm thấy
    }

    /**
     * Lấy TẤT CẢ các danh mục (loai) duy nhất từ bảng sản phẩm. Dùng cho menu
     * dropdown.
     */
    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        // SELECT DISTINCT đảm bảo mỗi tên loại chỉ xuất hiện 1 lần
        String query = "SELECT DISTINCT loai FROM sanpham";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(rs.getString("loai"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections(); // Hàm này bạn đã có
        }
        return categories;
    }

    /**
     * Lấy TẤT CẢ sản phẩm thuộc về một danh mục cụ thể (không giới hạn). Dùng
     * cho trang hiển thị danh mục.
     */
    public List<Product> getProductsByCategory(String categoryName) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM sanpham WHERE loai = ?";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, categoryName);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("id"),
                        rs.getString("tensp"),
                        rs.getString("mota"),
                        rs.getDouble("dongia"),
                        rs.getString("hinhanh"),
                        rs.getString("loai"),
                        rs.getInt("tonkho")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }

    /**
     * Lấy TẤT CẢ sản phẩm từ cơ sở dữ liệu. Dùng cho trang "Xem tất cả sản
     * phẩm".
     */
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        // Sắp xếp theo ID giảm dần để sản phẩm mới nhất lên đầu
        String query = "SELECT * FROM sanpham ORDER BY id DESC";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("id"),
                        rs.getString("tensp"),
                        rs.getString("mota"),
                        rs.getDouble("dongia"),
                        rs.getString("hinhanh"),
                        rs.getString("loai"),
                        rs.getInt("tonkho")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections(); // Hàm này bạn đã có
        }
        return list;
    }

    public List<Product> getProductsByCategoryAndPrice(String categoryName, double minPrice, double maxPrice) {
        List<Product> list = new ArrayList<>();
        // Câu truy vấn lọc theo cả loại VÀ khoảng giá
        String query = "SELECT * FROM sanpham WHERE loai = ? AND dongia >= ? AND dongia <= ?";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, categoryName);
            ps.setDouble(2, minPrice);
            ps.setDouble(3, maxPrice);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("id"),
                        rs.getString("tensp"),
                        rs.getString("mota"),
                        rs.getDouble("dongia"),
                        rs.getString("hinhanh"),
                        rs.getString("loai"),
                        rs.getInt("tonkho")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections(); // Sử dụng lại hàm đóng kết nối bạn đã có
        }
        return list;
    }

    // [ADMIN] Thêm sản phẩm mới
    public boolean insertProduct(Product p) {
        String query = "INSERT INTO sanpham (tensp, mota, dongia, hinhanh, loai, tonkho) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, p.getTensp());
            ps.setString(2, p.getMota());
            ps.setDouble(3, p.getDongia());
            ps.setString(4, p.getHinhanh());
            ps.setString(5, p.getLoai());
            ps.setInt(6, p.getTonkho());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return false;
    }

    // [ADMIN] Cập nhật sản phẩm
    public boolean updateProduct(Product p) {
        String query = "UPDATE sanpham SET tensp=?, mota=?, dongia=?, hinhanh=?, loai=?, tonkho=? WHERE id=?";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, p.getTensp());
            ps.setString(2, p.getMota());
            ps.setDouble(3, p.getDongia());
            ps.setString(4, p.getHinhanh());
            ps.setString(5, p.getLoai());
            ps.setInt(6, p.getTonkho());
            ps.setInt(7, p.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return false;
    }

    // [ADMIN] Xóa sản phẩm
    public boolean deleteProduct(int id) {
        String query = "DELETE FROM sanpham WHERE id=?";
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
