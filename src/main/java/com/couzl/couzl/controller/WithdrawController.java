package com.couzl.couzl.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WithdrawController {

    @GetMapping("/withdraw")
    public String withdraw() {
        return "withdraw";
    }
}
