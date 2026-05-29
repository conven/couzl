package com.couzl.couzl.service;

import com.couzl.couzl.dto.UserDto;
import com.couzl.couzl.mapper.UserMapper;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Base64;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserMapper userMapper;
    private final BCryptPasswordEncoder passwordEncoder;
    private final EmailService emailService;

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

    public boolean isLoginIdAvailable(String loginId) {
        return userMapper.countByLoginId(loginId) == 0;
    }

    public boolean isEmailAvailable(String email) {
        return userMapper.countByEmail(email) == 0;
    }

    public void sendVerifyCode(String email) {
        if (userMapper.countByEmail(email) == 0) {
            throw new IllegalStateException("먼저 회원가입 정보를 입력해주세요");
        }
        emailService.sendVerifyCode(email);
    }

    public void verifyEmail(String email, String code) {
        UserDto user = userMapper.findByEmail(email);
        if (user == null || user.getEmailVerifyCode() == null) {
            throw new IllegalStateException("인증코드를 먼저 발송해주세요");
        }
        if (!user.getEmailVerifyCode().equals(code)) {
            throw new IllegalArgumentException("인증코드가 일치하지 않습니다");
        }
        if (user.getEmailVerifyExpiry() == null
                || user.getEmailVerifyExpiry().isBefore(java.time.LocalDateTime.now())) {
            throw new IllegalStateException("인증코드가 만료되었습니다. 다시 발송해주세요");
        }
        userMapper.markEmailVerified(email);
    }

    @Transactional
    public void register(String loginId, String nickname, String email, String rawPassword) {
        if (userMapper.countByLoginId(loginId) > 0) {
            throw new IllegalArgumentException("이미 사용 중인 아이디입니다");
        }
        if (userMapper.countByEmail(email) > 0) {
            throw new IllegalArgumentException("이미 사용 중인 이메일입니다");
        }

        UserDto user = new UserDto();
        user.setLoginId(loginId);
        user.setNickname(nickname);
        user.setEmail(email);
        user.setPassword(passwordEncoder.encode(rawPassword));
        userMapper.insertUser(user);

        emailService.sendVerifyCode(email);
    }

    public void finalizeRegistration(String email) {
        UserDto user = userMapper.findByEmail(email);
        if (user == null || !"Y".equals(user.getEmailVerified())) {
            throw new IllegalStateException("이메일 인증이 완료되지 않았습니다");
        }
    }
}
