/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.text.NumberFormat;
import java.util.Locale;

public class Product {
    private int id;
    private String tensp;
    private String mota;
    private double dongia;
    private String hinhanh;
    private String loai;
    private int tonkho;

    // Constructor, Getters và Setters
    
    public Product() {}

    public Product(int id, String tensp, String mota, double dongia, String hinhanh, String loai, int tonkho) {
        this.id = id;
        this.tensp = tensp;
        this.mota = mota;
        this.dongia = dongia;
        this.hinhanh = hinhanh;
        this.loai = loai;
        this.tonkho = tonkho;
    }

    public double getDongia() {
        return dongia;
    }

    public void setDongia(double dongia) {
        this.dongia = dongia;
    }

    // --- Getters ---
    public int getId() { return id; }
    public String getTensp() { return tensp; }
    public String getMota() { return mota; }
    public String getHinhanh() { return hinhanh; }
    public String getLoai() { return loai; }
    public int getTonkho() { return tonkho; }
    
    // --- Setters ---
    public void setId(int id) { this.id = id; }
    public void setTensp(String tensp) { this.tensp = tensp; }
    public void setMota(String mota) { this.mota = mota; }
    public void setHinhanh(String hinhanh) { this.hinhanh = hinhanh; }
    public void setLoai(String loai) { this.loai = loai; }
    public void setTonkho(int tonkho) { this.tonkho = tonkho; }
    
    // --- Phương thức tiện ích để format giá tiền ---
    public String getGiaFormatted() {
        NumberFormat nf = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        return nf.format(this.dongia);
    }
}
