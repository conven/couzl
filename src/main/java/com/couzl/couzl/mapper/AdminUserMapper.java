package com.couzl.couzl.mapper;

import com.couzl.couzl.dto.UserCouponDto;
import com.couzl.couzl.dto.UserDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface AdminUserMapper {

    List<UserDto> findAll(@Param("keyword") String keyword,
                          @Param("status") String status,
                          @Param("offset") int offset,
                          @Param("limit") int limit);

    int countAll(@Param("keyword") String keyword,
                 @Param("status") String status);

    UserDto findByUserId(@Param("userId") Long userId);

    void updateStatus(@Param("userId") Long userId,
                      @Param("status") String status,
                      @Param("updatedBy") String updatedBy);

    List<UserCouponDto> findUserCoupons(@Param("userId") Long userId);
}
