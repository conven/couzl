package com.couzl.couzl.controller.admin;

import com.couzl.couzl.dto.AdminDto;
import com.couzl.couzl.dto.StoreDto;
import com.couzl.couzl.service.AdminStoreService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

@Controller
@RequiredArgsConstructor
public class AdminStoreController {

    private final AdminStoreService adminStoreService;

    @Value("${kakao.map.key}")
    private String kakaoMapKey;

    @GetMapping("/admin/stores")
    public String list(@RequestParam(defaultValue = "") String keyword,
                       @RequestParam(required = false) Long categoryId,
                       @RequestParam(defaultValue = "") String status,
                       @RequestParam(required = false) Long regionId,
                       @RequestParam(defaultValue = "1") int page,
                       HttpSession session,
                       Model model) {

        AdminDto admin = currentAdmin(session);
        if (admin == null) return "redirect:/admin/login";

        if (admin.isStoreOwner()) {
            if (admin.getStoreId() == null) return "redirect:/admin/dashboard";
            return "redirect:/admin/stores/" + admin.getStoreId();
        }

        Map<String, Object> result = adminStoreService.getStoreList(keyword, categoryId, status, regionId, page);
        model.addAttribute("stores", result.get("stores"));
        model.addAttribute("totalCount", result.get("totalCount"));
        model.addAttribute("totalPages", result.get("totalPages"));
        model.addAttribute("currentPage", result.get("currentPage"));
        model.addAttribute("keyword", keyword);
        model.addAttribute("categoryId", categoryId);
        model.addAttribute("status", status);
        model.addAttribute("regionId", regionId);
        model.addAttribute("regions", adminStoreService.getAllRegions());
        model.addAttribute("categories", adminStoreService.getAllActiveCategories());
        return "admin/store-list";
    }

    @GetMapping("/admin/stores/new")
    public String newForm(HttpSession session, Model model) {
        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        model.addAttribute("regions", adminStoreService.getAllRegions());
        model.addAttribute("categories", adminStoreService.getAllActiveCategories());
        model.addAttribute("kakaoMapKey", kakaoMapKey);
        return "admin/store-form";
    }

    @PostMapping("/admin/stores/new")
    public String create(@RequestParam String storeName,
                         @RequestParam Long categoryId,
                         @RequestParam Long regionId,
                         @RequestParam(required = false) String emoji,
                         @RequestParam(required = false) String phone,
                         @RequestParam(required = false) String businessHours,
                         @RequestParam(required = false) String description,
                         @RequestParam String address,
                         @RequestParam Double latitude,
                         @RequestParam Double longitude,
                         @RequestParam("adminLoginId") String adminLoginId,
                         @RequestParam("adminPassword") String adminPassword,
                         @RequestParam(value = "image", required = false) MultipartFile image,
                         HttpSession session) {

        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        StoreDto store = new StoreDto();
        store.setStoreName(storeName);
        store.setCategoryId(categoryId);
        store.setRegionId(regionId);
        store.setEmoji(emoji);
        store.setPhone(phone);
        store.setBusinessHours(businessHours);
        store.setDescription(description);
        store.setAddress(address);
        store.setLatitude(latitude);
        store.setLongitude(longitude);
        store.setStatus("ACTIVE");

        try {
            adminStoreService.registerStore(store, image, adminLoginId, adminPassword);
        } catch (Exception e) {
            return "redirect:/admin/stores/new?msg=error";
        }
        return "redirect:/admin/stores?msg=created";
    }

    @GetMapping("/admin/stores/{storeId}")
    public String detail(@PathVariable Long storeId,
                         HttpSession session,
                         Model model) {

        AdminDto admin = currentAdmin(session);
        if (admin == null) return "redirect:/admin/login";

        if (admin.isStoreOwner() && (admin.getStoreId() == null || !admin.getStoreId().equals(storeId))) {
            return "redirect:/admin/dashboard";
        }

        StoreDto store = adminStoreService.getStoreDetail(storeId);
        model.addAttribute("store", store);
        model.addAttribute("regions", adminStoreService.getAllRegions());
        model.addAttribute("categories", adminStoreService.getAllActiveCategories());
        model.addAttribute("kakaoMapKey", kakaoMapKey);
        return "admin/store-detail";
    }

    @PostMapping("/admin/stores/{storeId}")
    public String update(@PathVariable Long storeId,
                         @RequestParam String storeName,
                         @RequestParam Long categoryId,
                         @RequestParam Long regionId,
                         @RequestParam(required = false) String emoji,
                         @RequestParam(required = false) String phone,
                         @RequestParam(required = false) String businessHours,
                         @RequestParam(required = false) String description,
                         @RequestParam String address,
                         @RequestParam Double latitude,
                         @RequestParam Double longitude,
                         @RequestParam(value = "image", required = false) MultipartFile image,
                         HttpSession session) {

        AdminDto admin = currentAdmin(session);
        if (admin == null) return "redirect:/admin/login";

        if (admin.isStoreOwner() && (admin.getStoreId() == null || !admin.getStoreId().equals(storeId))) {
            return "redirect:/admin/dashboard";
        }

        StoreDto existing = adminStoreService.getStoreDetail(storeId);

        StoreDto store = new StoreDto();
        store.setStoreId(storeId);
        store.setStoreName(storeName);
        store.setCategoryId(categoryId);
        store.setRegionId(regionId);
        store.setEmoji(emoji);
        store.setPhone(phone);
        store.setBusinessHours(businessHours);
        store.setDescription(description);
        store.setAddress(address);
        store.setLatitude(latitude);
        store.setLongitude(longitude);
        store.setStatus(existing.getStatus());
        store.setAdminLoginId(admin.getLoginId());

        try {
            adminStoreService.updateStore(store, image);
        } catch (Exception e) {
            return "redirect:/admin/stores/" + storeId + "?msg=error";
        }
        return "redirect:/admin/stores/" + storeId + "?msg=updated";
    }

    @PostMapping("/admin/stores/{storeId}/status")
    public String updateStatus(@PathVariable Long storeId,
                               @RequestParam String status,
                               HttpSession session) {

        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        AdminDto admin = currentAdmin(session);
        try {
            adminStoreService.updateStatus(storeId, status, admin.getLoginId());
        } catch (RuntimeException e) {
            return "redirect:/admin/stores/" + storeId + "?msg=error";
        }
        return "redirect:/admin/stores/" + storeId;
    }

    @GetMapping("/admin/stores/{storeId}/image")
    public ResponseEntity<byte[]> image(@PathVariable Long storeId) {
        return adminStoreService.getStoreImage(storeId);
    }

    private AdminDto currentAdmin(HttpSession session) {
        return (AdminDto) session.getAttribute("LOGIN_ADMIN");
    }

    private String guardAdminOnly(HttpSession session) {
        AdminDto admin = currentAdmin(session);
        if (admin == null) return "redirect:/admin/login";
        if (admin.isStoreOwner()) return "redirect:/admin/dashboard";
        return null;
    }
}
