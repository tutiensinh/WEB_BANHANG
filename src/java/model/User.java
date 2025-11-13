/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author NGOCTU
 */
public class User {

    private int id;
    private String hoten;
    private String tendangnhap;
    private String matkhau;
    private String email;
    private String sodienthoai;
    private String diachi;
    private String vaitro; // quan trọng: 'admin' hoặc 'user'

    public User() {
    }

    public User(int id, String hoten, String tendangnhap, String matkhau, String vaitro) {
        this.id = id;
        this.hoten = hoten;
        this.tendangnhap = tendangnhap;
        this.matkhau = matkhau;
        this.vaitro = vaitro;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSodienthoai() {
        return sodienthoai;
    }

    public void setSodienthoai(String sodienthoai) {
        this.sodienthoai = sodienthoai;
    }

    public String getDiachi() {
        return diachi;
    }

    public void setDiachi(String diachi) {
        this.diachi = diachi;
    }

    // Getter và Setter cho tất cả các trường
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getHoten() {
        return hoten;
    }

    public void setHoten(String hoten) {
        this.hoten = hoten;
    }

    public String getTendangnhap() {
        return tendangnhap;
    }

    public void setTendangnhap(String tendangnhap) {
        this.tendangnhap = tendangnhap;
    }

    public String getMatkhau() {
        return matkhau;
    }

    public void setMatkhau(String matkhau) {
        this.matkhau = matkhau;
    }

    public String getVaitro() {
        return vaitro;
    }

    public void setVaitro(String vaitro) {
        this.vaitro = vaitro;
    }

    // Hàm tiện ích để kiểm tra nhanh
    public boolean isAdmin() {
        return "admin".equalsIgnoreCase(this.vaitro);
    }
}
