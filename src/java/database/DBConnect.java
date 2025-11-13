/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBConnect {
    // Cấu hình thông tin kết nối CSDL của bạn
    private static final String DB_URL = "jdbc:mysql://localhost:3306/web_bandogiadung";
    private static final String USERNAME = "root"; // User XAMPP mặc định
    private static final String PASSWORD = ""; // Password XAMPP mặc định là rỗng

    public static Connection getConnection() {
        Connection conn = null;
        try {        
            Class.forName("com.mysql.cj.jdbc.Driver"); // Dùng cho driver mới          
            // Tạo kết nối
            conn = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
            
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
        }
        return conn;
    }

    public static void main(String[] args) {
         // Thử kết nối để kiểm tra
         Connection conn = getConnection();
         if (conn != null) {
             System.out.println("Kết nối CSDL thành công!");
         } else {
             System.out.println("Kết nối CSDL thất bại!");
         }
    }
}
