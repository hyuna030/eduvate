package com.example.eduvate;


public class User {
    private String userID;
    private String username;
    private String password;

    // 생성자
    public User() {
    }

    public User(String userID, String username, String password) {
        this.userID = userID;
    	this.username = username;
        this.password = password;
    }

    // Getter, Setter
    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}


