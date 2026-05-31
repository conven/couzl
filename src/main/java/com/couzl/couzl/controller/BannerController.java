package com.couzl.couzl.controller;

import com.couzl.couzl.dto.BannerDto;
import com.couzl.couzl.mapper.AdminBannerMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
@RequiredArgsConstructor
public class BannerController {

    private final AdminBannerMapper adminBannerMapper;

    @GetMapping("/banner/image/{bannerId}")
    public ResponseEntity<byte[]> get(@PathVariable Long bannerId) {
        BannerDto img = adminBannerMapper.findBannerImage(bannerId);
        if (img == null || img.getBannerImage() == null) {
            return ResponseEntity.notFound().build();
        }
        MediaType type;
        try {
            type = MediaType.parseMediaType(
                    img.getImageType() != null ? img.getImageType() : "image/jpeg");
        } catch (Exception e) {
            type = MediaType.IMAGE_JPEG;
        }
        return ResponseEntity.ok()
                .contentType(type)
                .header(HttpHeaders.CACHE_CONTROL, "public, max-age=300")
                .body(img.getBannerImage());
    }
}
