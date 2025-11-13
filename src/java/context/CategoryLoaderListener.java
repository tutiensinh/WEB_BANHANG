/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import database.ProductDAO;
import java.util.List;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 * ServletContextListener này sẽ chạy một lần duy nhất khi
 * ứng dụng web khởi động.
 */
@WebListener // Đăng ký Listener
public class CategoryLoaderListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Hàm này được gọi khi server (ví dụ: Tomcat/GlassFish) khởi động
        ProductDAO dao = new ProductDAO();
        List<String> categories = dao.getAllCategories();
        
        // Lấy ServletContext (Application Scope)
        ServletContext context = sce.getServletContext();
        
        // Lưu danh sách danh mục vào application scope
        context.setAttribute("categories", categories); 
        
        System.out.println(">>> Đã tải thành công danh sách danh mục vào Application Scope!");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Hàm này được gọi khi server tắt
    }
}
