package com.couzl.couzl.controller.admin;

import com.couzl.couzl.dto.AdminDto;
import com.couzl.couzl.service.AdminRegionService;
import com.couzl.couzl.service.AdminRegionService.DuplicateRegionException;
import com.couzl.couzl.service.AdminRegionService.HasStoresException;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class AdminRegionController {

    private final AdminRegionService adminRegionService;

    @GetMapping("/admin/regions")
    public String list(@RequestParam(defaultValue = "") String keyword,
                       @RequestParam(required = false) Integer isActive,
                       HttpSession session,
                       Model model) {
        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        model.addAttribute("regions", adminRegionService.getRegionList(keyword, isActive));
        model.addAttribute("keyword", keyword);
        model.addAttribute("isActive", isActive);
        return "admin/region-list";
    }

    @PostMapping("/admin/regions/new")
    public String create(@RequestParam String regionName, HttpSession session) {
        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        try {
            adminRegionService.registerRegion(regionName, admin.getLoginId());
        } catch (DuplicateRegionException e) {
            return "redirect:/admin/regions?msg=duplicate";
        } catch (RuntimeException e) {
            return "redirect:/admin/regions?msg=error";
        }
        return "redirect:/admin/regions?msg=created";
    }

    @PostMapping("/admin/regions/{regionId}/update")
    public String update(@PathVariable Long regionId,
                         @RequestParam String regionName,
                         HttpSession session) {
        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        try {
            adminRegionService.updateRegion(regionId, regionName, admin.getLoginId());
        } catch (DuplicateRegionException e) {
            return "redirect:/admin/regions?msg=duplicate";
        } catch (RuntimeException e) {
            return "redirect:/admin/regions?msg=error";
        }
        return "redirect:/admin/regions?msg=updated";
    }

    @PostMapping("/admin/regions/{regionId}/active")
    public String updateActive(@PathVariable Long regionId,
                               @RequestParam int isActive,
                               HttpSession session) {
        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        try {
            adminRegionService.updateActive(regionId, isActive, admin.getLoginId());
        } catch (HasStoresException e) {
            return "redirect:/admin/regions?msg=has-stores";
        } catch (RuntimeException e) {
            return "redirect:/admin/regions?msg=error";
        }
        return "redirect:/admin/regions?msg=updated";
    }

    private String guardAdminOnly(HttpSession session) {
        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        if (admin == null) return "redirect:/admin/login";
        if (admin.isStoreOwner()) return "redirect:/admin/dashboard";
        return null;
    }
}
