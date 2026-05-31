package com.couzl.couzl.controller.admin;

import com.couzl.couzl.dto.AdminDto;
import com.couzl.couzl.dto.UserCouponDto;
import com.couzl.couzl.service.CouponService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class AdminQrController {

    private final CouponService couponService;

    @GetMapping("/admin/qr-scan")
    public String scan(HttpSession session) {
        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        if (admin == null) return "redirect:/admin/login";
        if (!admin.isStoreOwner()) return "redirect:/admin/dashboard";
        return "admin/qr-scan";
    }

    @PostMapping("/admin/qr-scan/validate")
    @ResponseBody
    public Map<String, Object> validate(@RequestParam String couponCode,
                                        HttpSession session) {
        Map<String, Object> resp = new HashMap<>();
        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        if (admin == null || !admin.isStoreOwner()) {
            resp.put("success", false);
            resp.put("message", "권한이 없습니다");
            return resp;
        }

        try {
            UserCouponDto uc = couponService.validateCouponCode(couponCode, admin.getStoreId());
            resp.put("success", true);
            resp.put("userCouponId", uc.getUserCouponId());
            resp.put("couponName", uc.getCouponName());
            resp.put("benefit", uc.getBenefit());
            resp.put("storeName", uc.getStoreName());
            resp.put("userNickname", uc.getUserNickname());
            resp.put("expireDate", uc.getExpireDate() != null ? uc.getExpireDate().toString() : null);
            resp.put("status", uc.getStatus());
            return resp;
        } catch (RuntimeException e) {
            resp.put("success", false);
            resp.put("message", e.getMessage());
            return resp;
        }
    }

    @PostMapping("/admin/qr-scan/use")
    @ResponseBody
    public Map<String, Object> use(@RequestParam Long userCouponId,
                                   HttpSession session) {
        Map<String, Object> resp = new HashMap<>();
        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        if (admin == null || !admin.isStoreOwner()) {
            resp.put("success", false);
            resp.put("message", "권한이 없습니다");
            return resp;
        }

        try {
            couponService.useCoupon(userCouponId, admin.getAdminId(), admin.getStoreId());
            resp.put("success", true);
            resp.put("message", "사용 처리되었습니다");
            return resp;
        } catch (RuntimeException e) {
            resp.put("success", false);
            resp.put("message", e.getMessage());
            return resp;
        }
    }
}
