package com.couzl.couzl.controller;

import com.couzl.couzl.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
public class RegisterController {

    private final UserService userService;

    @GetMapping("/register")
    public String register() {
        return "register";
    }

    @PostMapping("/register/check-id")
    @ResponseBody
    public Map<String, Object> checkId(@RequestParam String loginId) {
        Map<String, Object> res = new HashMap<>();
        if (loginId == null || loginId.trim().length() < 6 || loginId.length() > 20) {
            res.put("success", false);
            res.put("message", "아이디는 6~20자로 입력해주세요");
            return res;
        }
        boolean available = userService.isLoginIdAvailable(loginId.trim());
        res.put("success", available);
        res.put("message", available ? "사용 가능한 아이디입니다" : "이미 사용 중인 아이디입니다");
        return res;
    }

    @PostMapping("/register/send-code")
    @ResponseBody
    public Map<String, Object> sendCode(@RequestParam String loginId,
                                        @RequestParam String nickname,
                                        @RequestParam String email,
                                        @RequestParam String password) {
        Map<String, Object> res = new HashMap<>();
        try {
            userService.register(loginId, nickname, email, password);
            res.put("success", true);
            res.put("message", "인증코드가 발송되었습니다");
        } catch (IllegalArgumentException e) {
            res.put("success", false);
            res.put("message", e.getMessage());
        } catch (Exception e) {
            log.error("register send-code failed: email={}", email, e);
            res.put("success", false);
            res.put("message", "메일 발송에 실패했습니다: " + e.getMessage());
        }
        return res;
    }

    @PostMapping("/register/verify-code")
    @ResponseBody
    public Map<String, Object> verifyCode(@RequestParam String email,
                                          @RequestParam String code) {
        Map<String, Object> res = new HashMap<>();
        try {
            userService.verifyEmail(email, code);
            res.put("success", true);
            res.put("message", "인증이 완료되었습니다");
        } catch (IllegalArgumentException | IllegalStateException e) {
            res.put("success", false);
            res.put("message", e.getMessage());
        }
        return res;
    }

    @PostMapping("/register")
    public String register(@RequestParam String email, Model model) {
        try {
            userService.finalizeRegistration(email);
            return "redirect:/login?msg=registered";
        } catch (IllegalStateException e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "register";
        }
    }
}
