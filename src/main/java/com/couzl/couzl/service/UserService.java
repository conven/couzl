package com.couzl.couzl.service;

import com.couzl.couzl.dto.UserDto;
import com.couzl.couzl.mapper.UserMapper;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

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
}
