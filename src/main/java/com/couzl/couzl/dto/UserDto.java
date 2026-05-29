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
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
