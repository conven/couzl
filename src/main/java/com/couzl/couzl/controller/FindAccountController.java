package com.couzl.couzl.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class FindAccountController {

    @GetMapping("/find-id")
    public String findId() {
        return "find-id";
    }

    @GetMapping("/find-pw")
    public String findPw() {
        return "find-pw";
    }
}
