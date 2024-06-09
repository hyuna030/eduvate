package com.example.eduvate;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class MainController {

    @GetMapping("/")
    public String index(Model model, HttpSession session) {
        if (session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            model.addAttribute("isLoggedIn", true);
            model.addAttribute("username", user.getUsername());
        } else {
            model.addAttribute("isLoggedIn", false);
        }
        return "index";
    }
}




