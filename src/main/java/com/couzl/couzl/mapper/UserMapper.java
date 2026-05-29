package com.couzl.couzl.mapper;

import com.couzl.couzl.dto.UserDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {

    UserDto findByLoginId(String loginId);

    void updateRegion(@Param("userId") Long userId, @Param("regionId") Long regionId);
}
