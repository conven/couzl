package com.couzl.couzl.controller.admin;

import com.couzl.couzl.dto.AdminDto;
import com.couzl.couzl.dto.CategoryDto;
import com.couzl.couzl.service.AdminCategoryService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@Controller
@RequiredArgsConstructor
public class AdminCategoryController {

    private final AdminCategoryService adminCategoryService;

    @GetMapping("/admin/categories")
    public String list(HttpSession session, Model model) {
        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        model.addAttribute("categories", adminCategoryService.getAll());
        return "admin/category-list";
    }

    @PostMapping("/admin/categories/new")
    public String create(@RequestParam String code,
                         @RequestParam String name,
                         @RequestParam(required = false) String icon,
                         @RequestParam(required = false, defaultValue = "0") Integer sortOrder,
                         @RequestParam(required = false, defaultValue = "1") Integer isActive,
                         HttpSession session) {
        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        CategoryDto dto = new CategoryDto();
        dto.setCode(code != null ? code.trim().toUpperCase() : null);
        dto.setName(name);
        dto.setIcon(icon);
        dto.setSortOrder(sortOrder);
        dto.setIsActive(isActive);

        try {
            adminCategoryService.create(dto);
        } catch (RuntimeException e) {
            return "redirect:/admin/categories?msg=error&reason=" + encode(e.getMessage());
        }
        return "redirect:/admin/categories?msg=created";
    }

    @PostMapping("/admin/categories/{categoryId}")
    public String update(@PathVariable Long categoryId,
                         @RequestParam String code,
                         @RequestParam String name,
                         @RequestParam(required = false) String icon,
                         @RequestParam(required = false, defaultValue = "0") Integer sortOrder,
                         @RequestParam(required = false, defaultValue = "1") Integer isActive,
                         HttpSession session) {
        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        CategoryDto dto = new CategoryDto();
        dto.setCategoryId(categoryId);
        dto.setCode(code != null ? code.trim().toUpperCase() : null);
        dto.setName(name);
        dto.setIcon(icon);
        dto.setSortOrder(sortOrder);
        dto.setIsActive(isActive);

        try {
            adminCategoryService.update(dto);
        } catch (RuntimeException e) {
            return "redirect:/admin/categories?msg=error&reason=" + encode(e.getMessage());
        }
        return "redirect:/admin/categories?msg=updated";
    }

    @PostMapping("/admin/categories/{categoryId}/toggle")
    public String toggleActive(@PathVariable Long categoryId, HttpSession session) {
        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        try {
            adminCategoryService.toggleActive(categoryId, admin.getLoginId());
        } catch (RuntimeException e) {
            return "redirect:/admin/categories?msg=error&reason=" + encode(e.getMessage());
        }
        return "redirect:/admin/categories?msg=updated";
    }

    private String guardAdminOnly(HttpSession session) {
        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        if (admin == null) return "redirect:/admin/login";
        if (admin.isStoreOwner()) return "redirect:/admin/dashboard";
        return null;
    }

    private String encode(String value) {
        return URLEncoder.encode(value != null ? value : "", StandardCharsets.UTF_8);
    }
}
