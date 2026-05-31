package com.couzl.couzl.config;

import com.couzl.couzl.dto.RegionDto;
import com.couzl.couzl.mapper.RegionMapper;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.Collections;
import java.util.List;

@ControllerAdvice(basePackages = "com.couzl.couzl.controller")
@RequiredArgsConstructor
public class GlobalModelAdvice {

    private final RegionMapper regionMapper;

    @Value("${kakao.map.key:}")
    private String kakaoMapKey;

    @ModelAttribute("activeRegions")
    public List<RegionDto> activeRegions(HttpServletRequest request) {
        if (skip(request)) return Collections.emptyList();
        return regionMapper.findAllActive();
    }

    @ModelAttribute("kakaoMapKey")
    public String kakaoMapKey(HttpServletRequest request) {
        if (skip(request)) return "";
        return kakaoMapKey;
    }

    private boolean skip(HttpServletRequest request) {
        String uri = request.getRequestURI();
        if (uri == null) return false;
        if (uri.startsWith("/admin")) return true;
        // JSON / 이미지 / 정적 AJAX 엔드포인트는 모델 주입 불필요
        if (uri.startsWith("/map/stores")) return true;
        if (uri.startsWith("/main/content")) return true;
        if (uri.startsWith("/store/image/") || uri.startsWith("/banner/image/")
                || uri.startsWith("/profile-image/") || uri.startsWith("/review-image/")) return true;
        return false;
    }
}
