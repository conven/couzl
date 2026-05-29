package com.couzl.couzl.service;

import com.couzl.couzl.dto.UserDto;
import com.couzl.couzl.mapper.UserMapper;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Base64;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserMapper userMapper;
    private final BCryptPasswordEncoder passwordEncoder;

    public UserDto login(String loginId, String rawPassword, HttpSession session) {
        UserDto user = userMapper.findByLoginId(loginId);

        if (user == null || !passwordEncoder.matches(rawPassword, user.getPassword())) {
            return null;
        }

        if (!"ACTIVE".equals(user.getStatus())) {
            return null;
        }

        user.setPassword(null);
        session.setAttribute("LOGIN_USER", user);
        if (user.getRegionName() != null) {
            session.setAttribute("USER_REGION", user.getRegionName());
        }
        return user;
    }

    public void updateProfile(Long userId, String nickname,
                              MultipartFile file, HttpSession session) throws IOException {
        byte[] profileImage = null;
        String profileImageType = null;

        if (file != null && !file.isEmpty()) {
            if (file.getSize() > 10L * 1024 * 1024) {
                throw new IllegalArgumentException("파일 크기는 10MB 이하만 가능합니다");
            }
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            Thumbnails.of(file.getInputStream())
                    .size(200, 200)
                    .outputFormat("JPEG")
                    .toOutputStream(baos);
            profileImage = baos.toByteArray();
            profileImageType = "image/jpeg";
        }

        userMapper.updateProfile(userId, nickname, profileImage, profileImageType);

        UserDto sessionUser = (UserDto) session.getAttribute("LOGIN_USER");
        if (sessionUser != null) {
            sessionUser.setNickname(nickname);
            session.setAttribute("LOGIN_USER", sessionUser);
        }
    }

    public String getProfileImageBase64(Long userId) {
        UserDto profileData = userMapper.selectProfileImage(userId);
        if (profileData != null && profileData.getProfileImage() != null) {
            return Base64.getEncoder().encodeToString(profileData.getProfileImage());
        }
        return null;
    }
}
