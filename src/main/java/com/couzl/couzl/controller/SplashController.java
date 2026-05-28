package com.couzl.couzl.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SplashController {

    @GetMapping("/splash")
    public String splash() {
        return "splash";
    }
}
