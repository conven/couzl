package com.couzl.couzl.controller;

import com.couzl.couzl.dto.UserDto;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WelcomeController {

    @GetMapping("/welcome")
    public String welcome(HttpSession session) {
        UserDto loginUser = (UserDto) session.getAttribute("LOGIN_USER");

        if (loginUser == null) {
            return "redirect:/login";
        }

        if (loginUser.getRegionId() != null) {
            return "redirect:/main";
        }

        return "welcome";
    }
}
