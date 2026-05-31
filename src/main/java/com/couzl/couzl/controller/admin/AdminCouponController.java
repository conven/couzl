package com.couzl.couzl.controller.admin;

import com.couzl.couzl.dto.AdminDto;
import com.couzl.couzl.dto.CouponDto;
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
public class AdminCouponController {

    private final AdminCouponService adminCouponService;

    @GetMapping("/admin/coupons")
    public String list(@RequestParam(defaultValue = "") String keyword,
                       @RequestParam(required = false) Long storeId,
                       @RequestParam(defaultValue = "") String status,
                       @RequestParam(defaultValue = "1") int page,
                       HttpSession session,
                       Model model) {

        AdminDto admin = currentAdmin(session);
        if (admin == null) return "redirect:/admin/login";

        Long effectiveStoreId = admin.isStoreOwner() ? admin.getStoreId() : storeId;

        Map<String, Object> result = adminCouponService.getCouponList(keyword, effectiveStoreId, status, page);
        model.addAttribute("coupons", result.get("coupons"));
        model.addAttribute("totalCount", result.get("totalCount"));
        model.addAttribute("totalPages", result.get("totalPages"));
        model.addAttribute("currentPage", result.get("currentPage"));
        model.addAttribute("keyword", keyword);
        model.addAttribute("storeId", effectiveStoreId);
        model.addAttribute("status", status);

        if (!admin.isStoreOwner()) {
            model.addAttribute("stores", adminCouponService.getActiveStores());
        }
        return "admin/coupon-list";
    }

    @GetMapping("/admin/coupons/new")
    public String newForm(HttpSession session, Model model) {
        AdminDto admin = currentAdmin(session);
        if (admin == null) return "redirect:/admin/login";

        if (!admin.isStoreOwner()) {
            model.addAttribute("activeStores", adminCouponService.getActiveStores());
        }
        return "admin/coupon-form";
    }

    @PostMapping("/admin/coupons/new")
    public String create(@RequestParam(required = false) Long storeId,
                         @RequestParam String couponName,
                         @RequestParam String benefit,
                         @RequestParam(required = false) String conditionText,
                         @RequestParam String expireDate,
                         @RequestParam(required = false) String isUnlimited,
                         @RequestParam(required = false) Integer totalCount,
                         @RequestParam(required = false, defaultValue = "1") Integer maxPerUser,
                         HttpSession session) {

        AdminDto admin = currentAdmin(session);
        if (admin == null) return "redirect:/admin/login";

        CouponDto dto = new CouponDto();
        dto.setStoreId(admin.isStoreOwner() ? admin.getStoreId() : storeId);
        dto.setCouponName(couponName);
        dto.setBenefit(benefit);
        dto.setConditionText(conditionText);
        dto.setExpireDate(expireDate);
        dto.setTotalCount("on".equalsIgnoreCase(isUnlimited) ? 0 : (totalCount == null ? -1 : totalCount));
        dto.setMaxPerUser(maxPerUser);

        try {
            adminCouponService.registerCoupon(dto, admin.getLoginId());
        } catch (RuntimeException e) {
            return "redirect:/admin/coupons/new?msg=error";
        }
        return "redirect:/admin/coupons?msg=created";
    }

    @GetMapping("/admin/coupons/{couponId}")
    public String detail(@PathVariable Long couponId,
                         HttpSession session,
                         Model model) {

        AdminDto admin = currentAdmin(session);
        if (admin == null) return "redirect:/admin/login";

        CouponDto coupon = adminCouponService.getCouponDetail(couponId);

        if (admin.isStoreOwner() && (admin.getStoreId() == null
                || !admin.getStoreId().equals(coupon.getStoreId()))) {
            return "redirect:/admin/dashboard";
        }

        model.addAttribute("coupon", coupon);
        model.addAttribute("issuedUsers", adminCouponService.getIssuedUsers(couponId));
        if (!admin.isStoreOwner()) {
            model.addAttribute("activeStores", adminCouponService.getActiveStores());
        }
        return "admin/coupon-detail";
    }

    @PostMapping("/admin/coupons/{couponId}")
    public String update(@PathVariable Long couponId,
                         @RequestParam String couponName,
                         @RequestParam String benefit,
                         @RequestParam(required = false) String conditionText,
                         @RequestParam String expireDate,
                         @RequestParam(required = false) String isUnlimited,
                         @RequestParam(required = false) Integer totalCount,
                         @RequestParam(required = false, defaultValue = "1") Integer maxPerUser,
                         HttpSession session) {

        AdminDto admin = currentAdmin(session);
        if (admin == null) return "redirect:/admin/login";

        CouponDto existing = adminCouponService.getCouponDetail(couponId);
        if (admin.isStoreOwner() && (admin.getStoreId() == null
                || !admin.getStoreId().equals(existing.getStoreId()))) {
            return "redirect:/admin/dashboard";
        }

        CouponDto dto = new CouponDto();
        dto.setCouponId(couponId);
        dto.setStoreId(existing.getStoreId());
        dto.setCouponName(couponName);
        dto.setBenefit(benefit);
        dto.setConditionText(conditionText);
        dto.setExpireDate(expireDate);
        dto.setTotalCount("on".equalsIgnoreCase(isUnlimited) ? 0 : (totalCount == null ? -1 : totalCount));
        dto.setMaxPerUser(maxPerUser);

        try {
            adminCouponService.updateCoupon(dto, admin.getLoginId());
        } catch (RuntimeException e) {
            return "redirect:/admin/coupons/" + couponId + "?msg=error";
        }
        return "redirect:/admin/coupons/" + couponId + "?msg=updated";
    }

    @PostMapping("/admin/coupons/{couponId}/status")
    public String updateStatus(@PathVariable Long couponId,
                               @RequestParam String status,
                               HttpSession session) {

        AdminDto admin = currentAdmin(session);
        if (admin == null) return "redirect:/admin/login";

        CouponDto existing = adminCouponService.getCouponDetail(couponId);
        if (admin.isStoreOwner() && (admin.getStoreId() == null
                || !admin.getStoreId().equals(existing.getStoreId()))) {
            return "redirect:/admin/dashboard";
        }

        try {
            adminCouponService.updateStatus(couponId, status, admin.getLoginId());
        } catch (RuntimeException e) {
            return "redirect:/admin/coupons/" + couponId + "?msg=error";
        }
        return "redirect:/admin/coupons/" + couponId;
    }

    private AdminDto currentAdmin(HttpSession session) {
        return (AdminDto) session.getAttribute("LOGIN_ADMIN");
    }
}
