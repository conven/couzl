package com.couzl.couzl.mapper;

import com.couzl.couzl.dto.UserDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {

    UserDto findByLoginId(String loginId);

    void updateRegion(@Param("userId") Long userId, @Param("regionId") Long regionId);

    void updateProfile(@Param("userId") Long userId,
                       @Param("nickname") String nickname,
                       @Param("profileImage") byte[] profileImage,
                       @Param("profileImageType") String profileImageType);

    UserDto selectProfileImage(@Param("userId") Long userId);
}
