package com.couzl.couzl.service;

import com.couzl.couzl.dto.AdminDto;
import com.couzl.couzl.mapper.AdminAccountMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class AdminAccountService {

    public static class DuplicateLoginIdException extends RuntimeException {
        public DuplicateLoginIdException(String message) { super(message); }
    }

    public static class SelfDeactivateException extends RuntimeException {
        public SelfDeactivateException(String message) { super(message); }
    }

    private static final int PAGE_SIZE = 15;
    private static final Set<String> ALLOWED_ROLES = Set.of("SUPER_ADMIN", "ADMIN", "STORE_OWNER");
    private static final Set<String> ALLOWED_STATUSES = Set.of("ACTIVE", "INACTIVE");

    private final AdminAccountMapper adminAccountMapper;
    private final BCryptPasswordEncoder passwordEncoder;

    public Map<String, Object> getAdminList(String keyword, String role, String status, int page) {
        int safePage = Math.max(1, page);
        int offset = (safePage - 1) * PAGE_SIZE;

        List<AdminDto> admins = adminAccountMapper.findAll(keyword, role, status, offset, PAGE_SIZE);
        int totalCount = adminAccountMapper.countAll(keyword, role, status);
        int totalPages = Math.max(1, (int) Math.ceil(totalCount / (double) PAGE_SIZE));

        Map<String, Object> result = new HashMap<>();
        result.put("admins", admins);
        result.put("totalCount", totalCount);
        result.put("totalPages", totalPages);
        result.put("currentPage", safePage);
        return result;
    }

    public AdminDto getAdminDetail(Long adminId) {
        AdminDto admin = adminAccountMapper.findByAdminId(adminId);
        if (admin == null) {
            throw new IllegalArgumentException("존재하지 않는 어드민 계정입니다");
        }
        return admin;
    }

    public void registerAdmin(AdminDto adminDto, String rawPassword, String createdBy) {
        validateLoginId(adminDto.getLoginId());
        if (adminAccountMapper.countByLoginId(adminDto.getLoginId(), null) > 0) {
            throw new DuplicateLoginIdException("이미 사용 중인 아이디입니다");
        }
        validateRole(adminDto.getRole());
        validatePassword(rawPassword);
        applyStoreIdByRole(adminDto);

        adminDto.setPassword(passwordEncoder.encode(rawPassword));
        adminDto.setCreatedBy(createdBy);

        adminAccountMapper.insert(adminDto);
    }

    public void updateAdminInfo(AdminDto adminDto, String updatedBy) {
        if (adminDto.getAdminId() == null) {
            throw new IllegalArgumentException("adminId가 필요합니다");
        }
        getAdminDetail(adminDto.getAdminId());
        validateRole(adminDto.getRole());
        applyStoreIdByRole(adminDto);

        adminDto.setUpdatedBy(updatedBy);
        adminAccountMapper.updateInfo(adminDto);
    }

    public void resetPassword(Long adminId, String newRawPassword, String updatedBy) {
        getAdminDetail(adminId);
        validatePassword(newRawPassword);
        adminAccountMapper.updatePassword(adminId, passwordEncoder.encode(newRawPassword), updatedBy);
    }

    public void updateStatus(Long adminId, String status, Long currentAdminId, String updatedBy) {
        if (status == null || !ALLOWED_STATUSES.contains(status)) {
            throw new IllegalArgumentException("유효하지 않은 상태값입니다");
        }
        if ("INACTIVE".equals(status) && adminId.equals(currentAdminId)) {
            throw new SelfDeactivateException("본인 계정은 비활성화할 수 없습니다");
        }
        getAdminDetail(adminId);
        adminAccountMapper.updateStatus(adminId, status, updatedBy);
    }

    private void validateLoginId(String loginId) {
        if (loginId == null || loginId.isBlank()) {
            throw new IllegalArgumentException("아이디를 입력하세요");
        }
        if (!loginId.matches("^[a-zA-Z0-9]{4,20}$")) {
            throw new IllegalArgumentException("아이디는 영문/숫자 4~20자여야 합니다");
        }
    }

    private void validateRole(String role) {
        if (role == null || !ALLOWED_ROLES.contains(role)) {
            throw new IllegalArgumentException("유효하지 않은 역할입니다");
        }
    }

    private void validatePassword(String rawPassword) {
        if (rawPassword == null || rawPassword.length() < 8) {
            throw new IllegalArgumentException("비밀번호는 8자 이상이어야 합니다");
        }
    }

    /** STORE_OWNER이면 storeId 필수, ADMIN/SUPER_ADMIN이면 storeId null로 강제 */
    private void applyStoreIdByRole(AdminDto adminDto) {
        if ("STORE_OWNER".equals(adminDto.getRole())) {
            if (adminDto.getStoreId() == null) {
                throw new IllegalArgumentException("STORE_OWNER는 가맹점을 선택해야 합니다");
            }
        } else {
            adminDto.setStoreId(null);
        }
    }
}
