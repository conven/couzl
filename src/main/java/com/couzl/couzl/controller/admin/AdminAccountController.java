package com.couzl.couzl.controller.admin;

import com.couzl.couzl.dto.AdminDto;
import com.couzl.couzl.service.AdminAccountService;
import com.couzl.couzl.service.AdminAccountService.DuplicateLoginIdException;
import com.couzl.couzl.service.AdminAccountService.SelfDeactivateException;
import com.couzl.couzl.service.AdminCouponService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
@RequiredArgsConstructor
public class AdminAccountController {

    private final AdminAccountService adminAccountService;
    private final AdminCouponService adminCouponService;

    @GetMapping("/admin/accounts")
    public String list(@RequestParam(defaultValue = "") String keyword,
                       @RequestParam(defaultValue = "") String role,
                       @RequestParam(defaultValue = "") String status,
                       @RequestParam(defaultValue = "1") int page,
                       HttpSession session,
                       Model model) {

        String guard = guardSuperAdminOnly(session);
        if (guard != null) return guard;

        Map<String, Object> result = adminAccountService.getAdminList(keyword, role, status, page);
        model.addAttribute("admins", result.get("admins"));
        model.addAttribute("totalCount", result.get("totalCount"));
        model.addAttribute("totalPages", result.get("totalPages"));
        model.addAttribute("currentPage", result.get("currentPage"));
        model.addAttribute("keyword", keyword);
        model.addAttribute("role", role);
        model.addAttribute("status", status);
        return "admin/account-list";
    }

    @GetMapping("/admin/accounts/new")
    public String newForm(HttpSession session, Model model) {
        String guard = guardSuperAdminOnly(session);
        if (guard != null) return guard;

        model.addAttribute("activeStores", adminCouponService.getActiveStores());
        return "admin/account-form";
    }

    @PostMapping("/admin/accounts/new")
    public String create(@RequestParam String loginId,
                         @RequestParam String name,
                         @RequestParam String role,
                         @RequestParam(required = false) Long storeId,
                         @RequestParam String password,
                         @RequestParam String passwordConfirm,
                         HttpSession session) {

        String guard = guardSuperAdminOnly(session);
        if (guard != null) return guard;

        if (!password.equals(passwordConfirm)) {
            return "redirect:/admin/accounts/new?msg=pw-mismatch";
        }

        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        AdminDto dto = new AdminDto();
        dto.setLoginId(loginId);
        dto.setName(name);
        dto.setRole(role);
        dto.setStoreId(storeId);

        try {
            adminAccountService.registerAdmin(dto, password, admin.getLoginId());
        } catch (DuplicateLoginIdException e) {
            return "redirect:/admin/accounts/new?msg=duplicate";
        } catch (RuntimeException e) {
            return "redirect:/admin/accounts/new?msg=error";
        }
        return "redirect:/admin/accounts?msg=created";
    }

    @GetMapping("/admin/accounts/{adminId}")
    public String detail(@PathVariable Long adminId,
                         HttpSession session,
                         Model model) {

        String guard = guardSuperAdminOnly(session);
        if (guard != null) return guard;

        model.addAttribute("admin", adminAccountService.getAdminDetail(adminId));
        model.addAttribute("activeStores", adminCouponService.getActiveStores());
        return "admin/account-detail";
    }

    @PostMapping("/admin/accounts/{adminId}/info")
    public String updateInfo(@PathVariable Long adminId,
                             @RequestParam String name,
                             @RequestParam String role,
                             @RequestParam(required = false) Long storeId,
                             HttpSession session) {

        String guard = guardSuperAdminOnly(session);
        if (guard != null) return guard;

        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        AdminDto dto = new AdminDto();
        dto.setAdminId(adminId);
        dto.setName(name);
        dto.setRole(role);
        dto.setStoreId(storeId);

        try {
            adminAccountService.updateAdminInfo(dto, admin.getLoginId());
        } catch (RuntimeException e) {
            return "redirect:/admin/accounts/" + adminId + "?msg=error";
        }
        return "redirect:/admin/accounts/" + adminId + "?msg=updated";
    }

    @PostMapping("/admin/accounts/{adminId}/password")
    public String resetPassword(@PathVariable Long adminId,
                                @RequestParam String newPassword,
                                @RequestParam String newPasswordConfirm,
                                HttpSession session) {

        String guard = guardSuperAdminOnly(session);
        if (guard != null) return guard;

        if (!newPassword.equals(newPasswordConfirm)) {
            return "redirect:/admin/accounts/" + adminId + "?msg=pw-mismatch";
        }

        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        try {
            adminAccountService.resetPassword(adminId, newPassword, admin.getLoginId());
        } catch (RuntimeException e) {
            return "redirect:/admin/accounts/" + adminId + "?msg=error";
        }
        return "redirect:/admin/accounts/" + adminId + "?msg=pw-updated";
    }

    @PostMapping("/admin/accounts/{adminId}/status")
    public String updateStatus(@PathVariable Long adminId,
                               @RequestParam String status,
                               HttpSession session) {

        String guard = guardSuperAdminOnly(session);
        if (guard != null) return guard;

        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        try {
            adminAccountService.updateStatus(adminId, status, admin.getAdminId(), admin.getLoginId());
        } catch (SelfDeactivateException e) {
            return "redirect:/admin/accounts/" + adminId + "?msg=self-deactivate";
        } catch (RuntimeException e) {
            return "redirect:/admin/accounts/" + adminId + "?msg=error";
        }
        return "redirect:/admin/accounts/" + adminId;
    }

    private String guardSuperAdminOnly(HttpSession session) {
        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        if (admin == null) return "redirect:/admin/login";
        if (!admin.isSuperAdmin()) return "redirect:/admin/dashboard";
        return null;
    }
}
