package com.couzl.couzl.controller;

import com.couzl.couzl.dto.RegionDto;
import com.couzl.couzl.dto.UserDto;
import com.couzl.couzl.mapper.RegionMapper;
import com.couzl.couzl.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class LoginController {

    private final UserService userService;
    private final RegionMapper regionMapper;

    @GetMapping("/login")
    public String loginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String loginId,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {

        UserDto user = userService.login(loginId, password, session);

        if (user == null) {
            model.addAttribute("errorMsg", "아이디 또는 비밀번호를 확인해주세요");
            return "login";
        }

        if (user.getRegionId() != null) {
            RegionDto regionDto = regionMapper.findById(user.getRegionId());
            session.setAttribute("USER_REGION", regionDto);
            return "redirect:/main";
        }

        return "redirect:/welcome";
    }
}
