package com.couzl.couzl.controller;

import com.couzl.couzl.dto.UserCouponDto;
import com.couzl.couzl.dto.UserDto;
import com.couzl.couzl.service.CouponService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class CouponBoxController {

    private final CouponService couponService;

    @GetMapping("/coupon-box")
    public String couponBox(@RequestParam(required = false) String status,
                            HttpSession session,
                            Model model) {
        UserDto user = (UserDto) session.getAttribute("LOGIN_USER");
        if (user == null) return "redirect:/login?msg=unauthorized";

        List<UserCouponDto> userCoupons = couponService.getUserCoupons(user.getUserId(), status);
        model.addAttribute("userCoupons", userCoupons);
        model.addAttribute("status", status);
        return "coupon-box";
    }

    @GetMapping("/coupon-box/{userCouponId}")
    public String couponQr(@PathVariable Long userCouponId,
                           HttpSession session,
                           Model model) {
        UserDto user = (UserDto) session.getAttribute("LOGIN_USER");
        if (user == null) return "redirect:/login?msg=unauthorized";

        UserCouponDto uc = couponService.getCouponDetail(userCouponId, user.getUserId());
        model.addAttribute("userCoupon", uc);
        return "coupon-use";
    }
}
