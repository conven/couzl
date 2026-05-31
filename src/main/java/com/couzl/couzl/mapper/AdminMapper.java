package com.couzl.couzl.mapper;

import com.couzl.couzl.dto.AdminDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AdminMapper {

    AdminDto findByLoginId(@Param("loginId") String loginId);

    void updateLastLoginAt(@Param("adminId") Long adminId);
}
