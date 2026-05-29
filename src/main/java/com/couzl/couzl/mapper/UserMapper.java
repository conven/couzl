package com.couzl.couzl.mapper;

import com.couzl.couzl.dto.UserDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;

@Mapper
public interface UserMapper {

    UserDto findByLoginId(String loginId);

    UserDto findByEmail(String email);

    int countByLoginId(String loginId);

    int countByEmail(String email);

    void insertUser(UserDto user);

    void updateRegion(@Param("userId") Long userId, @Param("regionId") Long regionId);

    void updateProfile(@Param("userId") Long userId,
                       @Param("nickname") String nickname,
                       @Param("profileImage") byte[] profileImage,
                       @Param("profileImageType") String profileImageType);

    UserDto selectProfileImage(@Param("userId") Long userId);

    void updateEmailVerifyCode(@Param("email") String email,
                               @Param("code") String code,
                               @Param("expiry") LocalDateTime expiry);

    void markEmailVerified(@Param("email") String email);
}
