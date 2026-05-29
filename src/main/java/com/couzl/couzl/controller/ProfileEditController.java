package com.couzl.couzl.controller;

import com.couzl.couzl.dto.UserDto;
import com.couzl.couzl.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequiredArgsConstructor
public class ProfileEditController {

    private final UserService userService;

    @GetMapping("/profile-edit")
    public String profileEditForm(HttpSession session, Model model) {
        UserDto user = (UserDto) session.getAttribute("LOGIN_USER");
        if (user == null) return "redirect:/login";

        model.addAttribute("user", user);
        String base64 = userService.getProfileImageBase64(user.getUserId());
        if (base64 != null) {
            model.addAttribute("profileImageBase64", base64);
        }
        return "profile-edit";
    }

    @PostMapping("/profile-edit")
    public String profileEditSubmit(
            @RequestParam String nickname,
            @RequestParam(required = false) MultipartFile profileImage,
            HttpSession session,
            Model model) {

        UserDto user = (UserDto) session.getAttribute("LOGIN_USER");
        if (user == null) return "redirect:/login";

        try {
            userService.updateProfile(user.getUserId(), nickname, profileImage, session);
            return "redirect:/mypage";
        } catch (IllegalArgumentException e) {
            model.addAttribute("errorMsg", e.getMessage());
        } catch (Exception e) {
            model.addAttribute("errorMsg", "프로필 수정 중 오류가 발생했습니다");
        }

        model.addAttribute("user", (UserDto) session.getAttribute("LOGIN_USER"));
        String base64 = userService.getProfileImageBase64(user.getUserId());
        if (base64 != null) {
            model.addAttribute("profileImageBase64", base64);
        }
        return "profile-edit";
    }
}
