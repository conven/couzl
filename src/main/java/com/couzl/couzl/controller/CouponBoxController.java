package com.couzl.couzl.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CouponBoxController {

    @GetMapping("/coupon-box")
    public String couponBox() {
        return "coupon-box";
    }
}
