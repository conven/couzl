package com.couzl.couzl.controller;

import com.couzl.couzl.dto.ReviewImageDto;
import com.couzl.couzl.mapper.AdminReviewMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
@RequiredArgsConstructor
public class ReviewImageController {

    private final AdminReviewMapper adminReviewMapper;

    @GetMapping("/review-image/{reviewImageId}")
    public ResponseEntity<byte[]> get(@PathVariable Long reviewImageId) {
        ReviewImageDto img = adminReviewMapper.findImage(reviewImageId);
        if (img == null || img.getImage() == null) {
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
                .header(HttpHeaders.CACHE_CONTROL, "private, max-age=60")
                .body(img.getImage());
    }
}
