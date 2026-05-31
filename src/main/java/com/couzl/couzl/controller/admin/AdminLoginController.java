package com.couzl.couzl.controller.admin;

import com.couzl.couzl.dto.AdminDto;
import com.couzl.couzl.service.AdminService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class AdminLoginController {

    private final AdminService adminService;

    @GetMapping("/admin/login")
    public String loginForm(HttpSession session) {
        if (session.getAttribute("LOGIN_ADMIN") != null) {
            return "redirect:/admin/dashboard";
        }
        return "admin/login";
    }

    @PostMapping("/admin/login")
    public String login(@RequestParam String loginId,
                        @RequestParam String password,
                        HttpSession session) {
        AdminDto admin;
        try {
            admin = adminService.login(loginId, password, session);
        } catch (IllegalStateException e) {
            return "redirect:/admin/login?msg=inactive";
        } catch (IllegalArgumentException e) {
            return "redirect:/admin/login?msg=error";
        }

        if (admin.isStoreOwner()) {
            return "redirect:/admin/store";
        }
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/admin/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("LOGIN_ADMIN");
        return "redirect:/admin/login";
    }
}
