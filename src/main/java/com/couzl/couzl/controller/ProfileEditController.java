package com.couzl.couzl.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProfileEditController {

    @GetMapping("/profile-edit")
    public String profileEdit() {
        return "profile-edit";
    }
}
