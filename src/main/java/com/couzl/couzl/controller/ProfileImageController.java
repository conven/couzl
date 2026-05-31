package com.couzl.couzl.controller;

import com.couzl.couzl.dto.UserDto;
import com.couzl.couzl.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
@RequiredArgsConstructor
public class ProfileImageController {

    private final UserMapper userMapper;

    @GetMapping("/profile-image/{userId}")
    public ResponseEntity<byte[]> getProfileImage(@PathVariable Long userId) {
        UserDto profile = userMapper.selectProfileImage(userId);

        if (profile == null || profile.getProfileImage() == null) {
            return ResponseEntity.notFound().build();
        }

        MediaType type;
        try {
            type = MediaType.parseMediaType(
                    profile.getProfileImageType() != null ? profile.getProfileImageType() : "image/jpeg");
        } catch (Exception e) {
            type = MediaType.IMAGE_JPEG;
        }

        return ResponseEntity.ok()
                .contentType(type)
                .header(HttpHeaders.CACHE_CONTROL, "private, max-age=60")
                .body(profile.getProfileImage());
    }
}
