package com.couzl.couzl.controller;

import com.couzl.couzl.dto.RegionDto;
import com.couzl.couzl.dto.UserDto;
import com.couzl.couzl.mapper.RegionMapper;
import com.couzl.couzl.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class LoginController {

    private final UserService userService;
    private final RegionMapper regionMapper;

    @GetMapping("/login")
    public String loginForm(@RequestParam(required = false) String redirect,
                            HttpSession session,
                            Model model) {
        if (session.getAttribute("LOGIN_USER") != null) {
            return "redirect:/main";
        }
        model.addAttribute("redirect", redirect);
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String loginId,
                        @RequestParam String password,
                        @RequestParam(required = false) String redirect,
                        HttpSession session,
                        Model model) {

        UserDto user = userService.login(loginId, password, session);

        if (user == null) {
            model.addAttribute("errorMsg", "아이디 또는 비밀번호를 확인해주세요");
            model.addAttribute("redirect", redirect);
            return "login";
        }

        if (user.getRegionId() != null) {
            RegionDto regionDto = regionMapper.findById(user.getRegionId());
            session.setAttribute("USER_REGION", regionDto);

            String target = resolveRedirect(redirect);
            if (target != null) {
                return "redirect:" + target;
            }
            return "redirect:/main";
        }

        return "redirect:/welcome";
    }

    private String resolveRedirect(String redirect) {
        if (redirect == null) return null;
        String trimmed = redirect.trim();
        if (trimmed.isEmpty()) return null;
        if (!trimmed.startsWith("/")) return null;
        if (trimmed.startsWith("//")) return null;
        String lower = trimmed.toLowerCase();
        if (lower.startsWith("/http:") || lower.startsWith("/https:")) return null;
        return trimmed;
    }
}
