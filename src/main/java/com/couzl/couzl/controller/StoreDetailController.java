package com.couzl.couzl.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class StoreDetailController {

    @GetMapping("/store")
    public String storeDetail() {
        return "store-detail";
    }
}
