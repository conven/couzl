package com.couzl.couzl.controller;

import com.couzl.couzl.dto.UserDto;
import com.couzl.couzl.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class MypageController {

    private final UserService userService;

    @GetMapping("/mypage")
    public String mypage(HttpSession session, Model model) {
        UserDto user = (UserDto) session.getAttribute("LOGIN_USER");
        if (user != null) {
            model.addAttribute("user", user);
            String base64 = userService.getProfileImageBase64(user.getUserId());
            if (base64 != null) {
                model.addAttribute("profileImageBase64", base64);
            }
        }
        return "mypage";
    }
}
