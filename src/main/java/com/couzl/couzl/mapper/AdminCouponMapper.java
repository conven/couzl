package com.couzl.couzl.mapper;

import com.couzl.couzl.dto.CouponDto;
import com.couzl.couzl.dto.StoreDto;
import com.couzl.couzl.dto.UserCouponDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface AdminCouponMapper {

    List<CouponDto> findAll(@Param("keyword") String keyword,
                            @Param("storeId") Long storeId,
                            @Param("status") String status,
                            @Param("offset") int offset,
                            @Param("limit") int limit);

    int countAll(@Param("keyword") String keyword,
                 @Param("storeId") Long storeId,
                 @Param("status") String status);

    CouponDto findByCouponId(@Param("couponId") Long couponId);

    void insert(CouponDto couponDto);

    void update(CouponDto couponDto);

    void updateStatus(@Param("couponId") Long couponId,
                      @Param("status") String status,
                      @Param("updatedBy") String updatedBy);

    List<StoreDto> findActiveStores();

    List<UserCouponDto> findIssuedUsers(@Param("couponId") Long couponId);
}
