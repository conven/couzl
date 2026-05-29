package com.couzl.couzl.controller;

import com.couzl.couzl.dto.RegionDto;
import com.couzl.couzl.dto.UserDto;
import com.couzl.couzl.mapper.RegionMapper;
import com.couzl.couzl.mapper.UserMapper;
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
public class LocationController {

    private final RegionMapper regionMapper;
    private final UserMapper userMapper;

    @GetMapping("/location")
    public String location(HttpSession session, Model model) {
        List<RegionDto> regions = regionMapper.findAllActive();
        UserDto loginUser = (UserDto) session.getAttribute("LOGIN_USER");
        RegionDto currentRegion = (RegionDto) session.getAttribute("USER_REGION");

        model.addAttribute("regions", regions);
        model.addAttribute("currentRegion", currentRegion);
        model.addAttribute("currentRegionId", loginUser != null ? loginUser.getRegionId() : null);
        return "location";
    }

    @PostMapping("/location")
    public String saveLocation(@RequestParam Long regionId, HttpSession session) {
        UserDto loginUser = (UserDto) session.getAttribute("LOGIN_USER");
        boolean isFirstSetup = loginUser.getRegionId() == null;

        userMapper.updateRegion(loginUser.getUserId(), regionId);

        RegionDto region = regionMapper.findById(regionId);
        loginUser.setRegionId(regionId);
        loginUser.setRegionName(region.getRegionName());
        session.setAttribute("LOGIN_USER", loginUser);
        session.setAttribute("USER_REGION", region);

        return isFirstSetup ? "redirect:/main" : "redirect:/mypage";
    }
}
