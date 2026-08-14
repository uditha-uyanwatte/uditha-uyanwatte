package model;

public class User {

    private int id;
    private String username;
    private String password;
    private String fullName;
    private String email;
    private String phone;
    private String role;


    // =========================
    // DEFAULT CONSTRUCTOR
    // =========================

    public User() {
    }


    // =========================
    // CONSTRUCTOR
    // =========================

    public User(
            int id,
            String username,
            String password,
            String fullName,
            String email,
            String phone,
            String role) {

        this.id = id;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.role = role;
    }


    // =========================
    // ID
    // =========================

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    // =========================
    // USERNAME
    // =========================

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }


    // =========================
    // PASSWORD
    // =========================

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }


    // =========================
    // FULL NAME
    // =========================

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }


    // =========================
    // EMAIL
    // =========================

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    // =========================
    // PHONE
    // =========================

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }


    // =========================
    // ROLE
    // =========================

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

}