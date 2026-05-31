package com.couzl.couzl.service;

import com.couzl.couzl.dto.CouponDto;
import com.couzl.couzl.dto.UserCouponDto;
import com.couzl.couzl.mapper.CouponMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CouponService {

    public static class CouponExpiredException extends RuntimeException {
        public CouponExpiredException(String message) { super(message); }
    }
    public static class CouponSoldOutException extends RuntimeException {
        public CouponSoldOutException(String message) { super(message); }
    }
    public static class CouponAlreadyIssuedException extends RuntimeException {
        public CouponAlreadyIssuedException(String message) { super(message); }
    }
    public static class CouponNotFoundException extends RuntimeException {
        public CouponNotFoundException(String message) { super(message); }
    }
    public static class CouponAlreadyUsedException extends RuntimeException {
        public CouponAlreadyUsedException(String message) { super(message); }
    }
    public static class CouponWrongStoreException extends RuntimeException {
        public CouponWrongStoreException(String message) { super(message); }
    }

    private static final int REVIEW_WRITABLE_DAYS = 5;

    private final CouponMapper couponMapper;

    @Transactional
    public void issueCoupon(Long couponId, Long userId) {
        CouponDto coupon = couponMapper.findByCouponId(couponId);
        if (coupon == null) {
            throw new CouponNotFoundException("쿠폰을 찾을 수 없습니다");
        }
        if (coupon.getExpireDate() != null
                && LocalDate.parse(coupon.getExpireDate()).isBefore(LocalDate.now())) {
            throw new CouponExpiredException("만료된 쿠폰입니다");
        }
        int total = coupon.getTotalCount() == null ? 0 : coupon.getTotalCount();
        int issued = coupon.getIssuedCount() == null ? 0 : coupon.getIssuedCount();
        if (total > 0 && issued >= total) {
            throw new CouponSoldOutException("마감된 쿠폰입니다");
        }

        int maxPerUser = coupon.getMaxPerUser() == null ? 1 : coupon.getMaxPerUser();
        int alreadyIssued = couponMapper.countUserCoupon(userId, couponId);
        if (alreadyIssued >= maxPerUser) {
            throw new CouponAlreadyIssuedException("이미 발급받은 쿠폰입니다");
        }

        UserCouponDto uc = new UserCouponDto();
        uc.setUserId(userId);
        uc.setCouponId(couponId);
        uc.setCouponCode(UUID.randomUUID().toString());
        uc.setCreatedBy(String.valueOf(userId));

        couponMapper.issueCoupon(uc);
        couponMapper.incrementIssuedCount(couponId);
    }

    public List<UserCouponDto> getUserCoupons(Long userId, String status) {
        List<UserCouponDto> list = couponMapper.findUserCoupons(userId, status);
        for (UserCouponDto uc : list) {
            uc.setCanWriteReview(isReviewWritable(uc));
        }
        return list;
    }

    public UserCouponDto getCouponDetail(Long userCouponId, Long userId) {
        UserCouponDto uc = couponMapper.findByUserCouponId(userCouponId);
        if (uc == null) {
            throw new CouponNotFoundException("쿠폰을 찾을 수 없습니다");
        }
        if (!uc.getUserId().equals(userId)) {
            throw new CouponNotFoundException("본인 쿠폰만 조회할 수 있습니다");
        }
        return uc;
    }

    @Transactional
    public void useCoupon(Long userCouponId, Long adminId, Long storeId) {
        UserCouponDto uc = couponMapper.findByUserCouponId(userCouponId);
        if (uc == null) {
            throw new CouponNotFoundException("쿠폰을 찾을 수 없습니다");
        }
        if ("USED".equals(uc.getStatus())) {
            throw new CouponAlreadyUsedException("이미 사용된 쿠폰입니다");
        }
        if ("EXPIRED".equals(uc.getStatus())) {
            throw new CouponExpiredException("만료된 쿠폰입니다");
        }
        if (uc.getExpireDate() != null && uc.getExpireDate().isBefore(LocalDate.now())) {
            throw new CouponExpiredException("만료된 쿠폰입니다");
        }
        if (storeId == null || !storeId.equals(uc.getStoreId())) {
            throw new CouponWrongStoreException("본 가맹점에서 사용할 수 있는 쿠폰이 아닙니다");
        }
        couponMapper.useCoupon(userCouponId, String.valueOf(adminId));
    }

    public UserCouponDto validateCouponCode(String couponCode, Long storeId) {
        UserCouponDto uc = couponMapper.findByCouponCode(couponCode);
        if (uc == null) {
            throw new CouponNotFoundException("등록되지 않은 쿠폰 코드입니다");
        }
        if (storeId == null || !storeId.equals(uc.getStoreId())) {
            throw new CouponWrongStoreException("본 가맹점에서 사용할 수 있는 쿠폰이 아닙니다");
        }
        return uc;
    }

    private boolean isReviewWritable(UserCouponDto uc) {
        if (!"USED".equals(uc.getStatus())) return false;
        if (uc.getUsedAt() == null) return false;
        if (uc.getUsedAt().isBefore(LocalDateTime.now().minusDays(REVIEW_WRITABLE_DAYS))) return false;
        return couponMapper.countReviewByUserCouponId(uc.getUserCouponId()) == 0;
    }
}
