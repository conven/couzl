package com.couzl.couzl.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class AdminDto {

    private Long adminId;
    private String loginId;
    private String password;
    private String name;
    private String role;
    private Long storeId;
    private String storeName;
    private String status;
    private LocalDateTime lastLoginAt;
    private String createdBy;
    private String updatedBy;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public boolean isSuperAdmin() {
        return "SUPER_ADMIN".equals(role);
    }

    public boolean isAdmin() {
        return "ADMIN".equals(role);
    }

    public boolean isStoreOwner() {
        return "STORE_OWNER".equals(role);
    }
}
