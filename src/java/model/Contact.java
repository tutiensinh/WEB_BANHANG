/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author NGOCTU
 */
public class Contact {

    private int id;
    private String hoten;
    private String email;
    private String noidung;
    private Timestamp ngaygui;

    public Contact() {
    }

    public Contact(int id, String hoten, String email, String noidung, Timestamp ngaygui) {
        this.id = id;
        this.hoten = hoten;
        this.email = email;
        this.noidung = noidung;
        this.ngaygui = ngaygui;
    }

    // Getters and Setters
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNoidung() {
        return noidung;
    }

    public void setNoidung(String noidung) {
        this.noidung = noidung;
    }

    public Timestamp getNgaygui() {
        return ngaygui;
    }

    public void setNgaygui(Timestamp ngaygui) {
        this.ngaygui = ngaygui;
    }
}
