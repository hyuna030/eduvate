package com.example.eduvate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;


import jakarta.servlet.http.HttpSession;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

@Controller
public class UserController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/register")
    public String registerForm(Model model) {
        model.addAttribute("userID", new User());
        return "register";
    }

    @PostMapping("/register")
    public String register(User user, Model model, HttpSession session) {
        String checkDuplicateUsernameQuery = "SELECT COUNT(*) FROM user WHERE username = ?";
        String checkDuplicateUserIDQuery = "SELECT COUNT(*) FROM user WHERE userID = ?";

        int usernameCount = jdbcTemplate.queryForObject(checkDuplicateUsernameQuery, Integer.class, user.getUsername());
        int userIDCount = jdbcTemplate.queryForObject(checkDuplicateUserIDQuery, Integer.class, user.getUserID());

        if (usernameCount > 0 && userIDCount > 0) {
            model.addAttribute("error", "아이디와 닉네임이 모두 중복입니다. 다른 아이디와 닉네임을 사용하세요.");
            return "register";
        } else if (usernameCount > 0) {
            model.addAttribute("error", "닉네임이 중복입니다. 다른 닉네임을 사용하세요.");
            return "register";
        } else if (userIDCount > 0) {
            model.addAttribute("error", "아이디가 중복입니다. 다른 아이디를 사용하세요.");
            return "register";
        }

        String insertQuery = "INSERT INTO user (userID, username, password) VALUES (?, ?, ?)";

        jdbcTemplate.update(insertQuery, new PreparedStatementSetter() {
            @Override
            public void setValues(PreparedStatement preparedStatement) throws SQLException {
                preparedStatement.setString(1, user.getUserID());
                preparedStatement.setString(2, user.getUsername());
                preparedStatement.setString(3, user.getPassword());
            }
        });
        session.setAttribute("user", user);

        return "redirect:/login";
    }

    @GetMapping("/login")
    public String loginForm(Model model) {
        model.addAttribute("user", new User());
        return "login";
    }

    @PostMapping("/login")
    public String login(HttpSession session, User user, Model model) {
        String sql = "SELECT * FROM user WHERE userID = ? AND password = ?";

        List<User> users = jdbcTemplate.query(sql, new PreparedStatementSetter() {
            @Override
            public void setValues(PreparedStatement preparedStatement) throws SQLException {
                preparedStatement.setString(1, user.getUserID());
                preparedStatement.setString(2, user.getPassword());
            }
        }, (resultSet, rowNum) -> {
            User storedUser = new User();
            storedUser.setUserID(resultSet.getString("userID"));
            storedUser.setUsername(resultSet.getString("username"));
            storedUser.setPassword(resultSet.getString("password"));
            return storedUser;
        });

        if (!users.isEmpty()) {
        	session.setAttribute("user", users.get(0)); // 변경된 부분
            System.out.println("User logged in: " + users.get(0).getUserID());
            return "redirect:/";
        } else {
            // 아이디와 비밀번호를 따로 체크하고 에러 메시지 설정
            String idCheckQuery = "SELECT COUNT(*) FROM user WHERE userID = ?";
            int idCount = jdbcTemplate.queryForObject(idCheckQuery, Integer.class, user.getUserID());

            if (idCount > 0) {
                model.addAttribute("error", "잘못된 비밀번호입니다.");
            } else {
                model.addAttribute("error", "존재하지 않는 아이디입니다.");
            }

            return "login";
        }
    }


    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}




