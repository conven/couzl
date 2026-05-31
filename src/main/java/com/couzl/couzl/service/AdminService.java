package com.couzl.couzl.service;

import com.couzl.couzl.dto.AdminDto;
import com.couzl.couzl.mapper.AdminMapper;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AdminService {

    private final AdminMapper adminMapper;
    private final BCryptPasswordEncoder passwordEncoder;

    public AdminDto login(String loginId, String rawPassword, HttpSession session) {
        AdminDto admin = adminMapper.findByLoginId(loginId);

        if (admin == null) {
            throw new IllegalArgumentException("아이디 또는 비밀번호가 올바르지 않습니다");
        }
        if (!passwordEncoder.matches(rawPassword, admin.getPassword())) {
            throw new IllegalArgumentException("아이디 또는 비밀번호가 올바르지 않습니다");
        }
        if (!"ACTIVE".equals(admin.getStatus())) {
            throw new IllegalStateException("비활성화된 계정입니다. 관리자에게 문의하세요");
        }

        adminMapper.updateLastLoginAt(admin.getAdminId());

        admin.setPassword(null);
        session.setAttribute("LOGIN_ADMIN", admin);
        return admin;
    }
}
