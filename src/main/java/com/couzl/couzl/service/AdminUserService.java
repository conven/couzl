package com.couzl.couzl.service;

import com.couzl.couzl.dto.UserCouponDto;
import com.couzl.couzl.dto.UserDto;
import com.couzl.couzl.mapper.AdminUserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class AdminUserService {

    private static final int PAGE_SIZE = 15;
    private static final Set<String> ALLOWED_STATUSES = Set.of("ACTIVE", "SUSPENDED", "WITHDRAWN");

    private final AdminUserMapper adminUserMapper;

    public Map<String, Object> getUserList(String keyword, String status, int page) {
        int safePage = Math.max(1, page);
        int offset = (safePage - 1) * PAGE_SIZE;

        List<UserDto> users = adminUserMapper.findAll(keyword, status, offset, PAGE_SIZE);
        int totalCount = adminUserMapper.countAll(keyword, status);
        int totalPages = Math.max(1, (int) Math.ceil(totalCount / (double) PAGE_SIZE));

        Map<String, Object> result = new HashMap<>();
        result.put("users", users);
        result.put("totalCount", totalCount);
        result.put("totalPages", totalPages);
        result.put("currentPage", safePage);
        return result;
    }

    public UserDto getUserDetail(Long userId) {
        UserDto user = adminUserMapper.findByUserId(userId);
        if (user == null) {
            throw new IllegalArgumentException("존재하지 않는 회원입니다");
        }
        return user;
    }

    public List<UserCouponDto> getUserCoupons(Long userId) {
        return adminUserMapper.findUserCoupons(userId);
    }

    public void updateStatus(Long userId, String status, String updatedBy) {
        if (status == null || !ALLOWED_STATUSES.contains(status)) {
            throw new IllegalArgumentException("유효하지 않은 상태값입니다");
        }

        UserDto existing = adminUserMapper.findByUserId(userId);
        if (existing == null) {
            throw new IllegalArgumentException("존재하지 않는 회원입니다");
        }
        if ("WITHDRAWN".equals(existing.getStatus())) {
            throw new IllegalStateException("탈퇴한 회원은 상태를 변경할 수 없습니다");
        }

        adminUserMapper.updateStatus(userId, status, updatedBy);
    }
}
