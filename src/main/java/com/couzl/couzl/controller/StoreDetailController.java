package com.couzl.couzl.controller;

import com.couzl.couzl.dto.CouponDto;
import com.couzl.couzl.dto.StoreDto;
import com.couzl.couzl.dto.UserDto;
import com.couzl.couzl.mapper.CouponMapper;
import com.couzl.couzl.mapper.StoreMapper;
import com.couzl.couzl.service.CouponService;
import com.couzl.couzl.service.CouponService.CouponAlreadyIssuedException;
import com.couzl.couzl.service.CouponService.CouponExpiredException;
import com.couzl.couzl.service.CouponService.CouponSoldOutException;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class StoreDetailController {

    private final StoreMapper storeMapper;
    private final CouponMapper couponMapper;
    private final CouponService couponService;

    @GetMapping("/store")
    public String storeDetail(@RequestParam(required = false) Long storeId,
                              HttpSession session,
                              Model model) {
        if (storeId == null) {
            return "redirect:/main";
        }

        StoreDto store = storeMapper.findById(storeId);
        if (store == null) {
            return "redirect:/main";
        }

        List<CouponDto> coupons = couponMapper.findActiveByStoreId(storeId);

        UserDto user = (UserDto) session.getAttribute("LOGIN_USER");
        if (user != null) {
            for (CouponDto co : coupons) {
                int issued = couponMapper.countUserCoupon(user.getUserId(), co.getCouponId());
                int max = co.getMaxPerUser() == null ? 1 : co.getMaxPerUser();
                co.setAlreadyIssued(issued >= max);
            }
        }

        model.addAttribute("store", store);
        model.addAttribute("coupons", coupons);
        return "store-detail";
    }

    @PostMapping("/store/coupon/issue")
    public String issueCoupon(@RequestParam Long couponId,
                              HttpSession session) {
        UserDto user = (UserDto) session.getAttribute("LOGIN_USER");
        if (user == null) {
            return "redirect:/login?msg=unauthorized";
        }

        Long storeIdForRedirect = null;
        CouponDto coupon = couponMapper.findByCouponId(couponId);
        if (coupon != null) storeIdForRedirect = coupon.getStoreId();

        try {
            couponService.issueCoupon(couponId, user.getUserId());
        } catch (CouponSoldOutException e) {
            return "redirect:/store?storeId=" + storeIdForRedirect + "&msg=sold-out";
        } catch (CouponAlreadyIssuedException e) {
            return "redirect:/store?storeId=" + storeIdForRedirect + "&msg=already-issued";
        } catch (CouponExpiredException e) {
            return "redirect:/store?storeId=" + storeIdForRedirect + "&msg=expired";
        } catch (RuntimeException e) {
            return "redirect:/store?storeId=" + storeIdForRedirect + "&msg=error";
        }
        return "redirect:/store?storeId=" + storeIdForRedirect + "&msg=issued";
    }
}
