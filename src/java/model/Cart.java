/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.util.List;

public class Cart {

    private List<CartItem> items;

    public Cart() {
        items = new ArrayList<>();
    }

    // Thêm 1 sản phẩm vào giỏ
    public void addItem(CartItem item) {
        // Kiểm tra xem sản phẩm đã có trong giỏ chưa
        for (CartItem ci : items) {
            if (ci.getProduct().getId() == item.getProduct().getId()) {
                ci.setQuantity(ci.getQuantity() + item.getQuantity()); // Tăng số lượng
                return;
            }
        }
        // Nếu chưa có, thêm mới
        items.add(item);
    }

    // Xóa 1 sản phẩm khỏi giỏ
    public void removeItem(int productId) {
        items.removeIf(item -> item.getProduct().getId() == productId);
    }

    // Lấy tổng giá của toàn bộ giỏ hàng
    public double getTotalCartPrice() {
        double total = 0;
        for (CartItem item : items) {
            total += item.getTotalPrice();
        }
        return total;
    }

    // Lấy tổng số lượng sản phẩm trong giỏ
    public int getTotalItemCount() {
        int count = 0;
        for (CartItem item : items) {
            count += item.getQuantity();
        }
        return count;
    }

    // Lấy danh sách các item
    public List<CartItem> getItems() {
        return items;
    }
}
