package com.couzl.couzl.mapper;

import com.couzl.couzl.dto.CouponDto;
import com.couzl.couzl.dto.UserCouponDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CouponMapper {

    /** ACTIVE 쿠폰 단건 조회 (store_name JOIN) */
    CouponDto findByCouponId(@Param("couponId") Long couponId);

    /** 해당 가맹점의 ACTIVE 쿠폰 목록 (FO store-detail용) */
    List<CouponDto> findActiveByStoreId(@Param("storeId") Long storeId);

    /** 해당 유저의 해당 쿠폰 발급 수 */
    int countUserCoupon(@Param("userId") Long userId,
                        @Param("couponId") Long couponId);

    void issueCoupon(UserCouponDto userCouponDto);

    void incrementIssuedCount(@Param("couponId") Long couponId);

    List<UserCouponDto> findUserCoupons(@Param("userId") Long userId,
                                        @Param("status") String status);

    UserCouponDto findByUserCouponId(@Param("userCouponId") Long userCouponId);

    UserCouponDto findByCouponCode(@Param("couponCode") String couponCode);

    void useCoupon(@Param("userCouponId") Long userCouponId,
                   @Param("updatedBy") String updatedBy);

    int countReviewByUserCouponId(@Param("userCouponId") Long userCouponId);
}
