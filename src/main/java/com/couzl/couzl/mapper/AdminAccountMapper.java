package com.couzl.couzl.mapper;

import com.couzl.couzl.dto.AdminDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface AdminAccountMapper {

    List<AdminDto> findAll(@Param("keyword") String keyword,
                           @Param("role") String role,
                           @Param("status") String status,
                           @Param("offset") int offset,
                           @Param("limit") int limit);

    int countAll(@Param("keyword") String keyword,
                 @Param("role") String role,
                 @Param("status") String status);

    AdminDto findByAdminId(@Param("adminId") Long adminId);

    int countByLoginId(@Param("loginId") String loginId,
                       @Param("excludeAdminId") Long excludeAdminId);

    void insert(AdminDto adminDto);

    void updateInfo(AdminDto adminDto);

    void updatePassword(@Param("adminId") Long adminId,
                        @Param("password") String password,
                        @Param("updatedBy") String updatedBy);

    void updateStatus(@Param("adminId") Long adminId,
                      @Param("status") String status,
                      @Param("updatedBy") String updatedBy);
}
