package com.couzl.couzl.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class UserDto {

    private Long userId;
    private String loginId;
    private String password;
    private String nickname;
    private String email;
    private String socialType;
    private String socialId;
    private String status;
    private Long regionId;
    private String regionName;
    private byte[] profileImage;
    private String profileImageType;
    private String emailVerifyCode;
    private LocalDateTime emailVerifyExpiry;
    private String emailVerified;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String imgVer;
}
