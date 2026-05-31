package com.couzl.couzl.controller.admin;

import com.couzl.couzl.dto.AdminDto;
import com.couzl.couzl.dto.UserCouponDto;
import com.couzl.couzl.dto.UserDto;
import com.couzl.couzl.service.AdminUserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class AdminUserController {

    private final AdminUserService adminUserService;

    @GetMapping("/admin/users")
    public String list(@RequestParam(defaultValue = "") String keyword,
                       @RequestParam(defaultValue = "") String status,
                       @RequestParam(defaultValue = "1") int page,
                       HttpSession session,
                       Model model) {

        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        Map<String, Object> result = adminUserService.getUserList(keyword, status, page);
        model.addAttribute("users", result.get("users"));
        model.addAttribute("totalCount", result.get("totalCount"));
        model.addAttribute("totalPages", result.get("totalPages"));
        model.addAttribute("currentPage", result.get("currentPage"));
        model.addAttribute("keyword", keyword);
        model.addAttribute("status", status);
        return "admin/user-list";
    }

    @GetMapping("/admin/users/{userId}")
    public String detail(@PathVariable Long userId,
                         HttpSession session,
                         Model model) {

        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        UserDto user = adminUserService.getUserDetail(userId);
        List<UserCouponDto> userCoupons = adminUserService.getUserCoupons(userId);

        model.addAttribute("user", user);
        model.addAttribute("userCoupons", userCoupons);
        return "admin/user-detail";
    }

    @PostMapping("/admin/users/{userId}/status")
    public String updateStatus(@PathVariable Long userId,
                               @RequestParam String status,
                               HttpSession session) {

        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        try {
            adminUserService.updateStatus(userId, status, admin.getLoginId());
        } catch (RuntimeException e) {
            return "redirect:/admin/users/" + userId + "?msg=error";
        }
        return "redirect:/admin/users/" + userId;
    }

    private String guardAdminOnly(HttpSession session) {
        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        if (admin == null || admin.isStoreOwner()) {
            return "redirect:/admin/dashboard";
        }
        return null;
    }
}
