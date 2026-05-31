package com.couzl.couzl.service;

import com.couzl.couzl.dto.CouponDto;
import com.couzl.couzl.dto.StoreDto;
import com.couzl.couzl.dto.UserCouponDto;
import com.couzl.couzl.mapper.AdminCouponMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class AdminCouponService {

    private static final int PAGE_SIZE = 15;
    private static final Set<String> ALLOWED_STATUSES = Set.of("ACTIVE", "INACTIVE");

    private final AdminCouponMapper adminCouponMapper;

    public Map<String, Object> getCouponList(String keyword, Long storeId, String status, int page) {
        int safePage = Math.max(1, page);
        int offset = (safePage - 1) * PAGE_SIZE;

        List<CouponDto> coupons = adminCouponMapper.findAll(keyword, storeId, status, offset, PAGE_SIZE);
        int totalCount = adminCouponMapper.countAll(keyword, storeId, status);
        int totalPages = Math.max(1, (int) Math.ceil(totalCount / (double) PAGE_SIZE));

        Map<String, Object> result = new HashMap<>();
        result.put("coupons", coupons);
        result.put("totalCount", totalCount);
        result.put("totalPages", totalPages);
        result.put("currentPage", safePage);
        return result;
    }

    public CouponDto getCouponDetail(Long couponId) {
        CouponDto coupon = adminCouponMapper.findByCouponId(couponId);
        if (coupon == null) {
            throw new IllegalArgumentException("존재하지 않는 쿠폰입니다");
        }
        return coupon;
    }

    public List<StoreDto> getActiveStores() {
        return adminCouponMapper.findActiveStores();
    }

    public List<UserCouponDto> getIssuedUsers(Long couponId) {
        return adminCouponMapper.findIssuedUsers(couponId);
    }

    public void registerCoupon(CouponDto couponDto, String createdBy) {
        validateBasic(couponDto);
        validateExpireDate(couponDto.getExpireDate());
        validateTotalCountForNew(couponDto.getTotalCount());
        validateMaxPerUser(couponDto);

        couponDto.setIssuedCount(0);
        if (couponDto.getStatus() == null) couponDto.setStatus("ACTIVE");
        couponDto.setCreatedBy(createdBy);

        adminCouponMapper.insert(couponDto);
    }

    public void updateCoupon(CouponDto couponDto, String updatedBy) {
        if (couponDto.getCouponId() == null) {
            throw new IllegalArgumentException("couponId가 필요합니다");
        }
        validateBasic(couponDto);
        validateExpireDate(couponDto.getExpireDate());

        CouponDto existing = adminCouponMapper.findByCouponId(couponDto.getCouponId());
        if (existing == null) {
            throw new IllegalArgumentException("존재하지 않는 쿠폰입니다");
        }

        int newTotal = couponDto.getTotalCount() == null ? 0 : couponDto.getTotalCount();
        int issued = existing.getIssuedCount() == null ? 0 : existing.getIssuedCount();
        if (newTotal != 0 && newTotal < issued) {
            throw new IllegalArgumentException("이미 발급된 수량(" + issued + ")보다 적게 설정할 수 없습니다");
        }

        validateMaxPerUser(couponDto);
        couponDto.setStatus(existing.getStatus());
        couponDto.setUpdatedBy(updatedBy);

        adminCouponMapper.update(couponDto);
    }

    public void updateStatus(Long couponId, String status, String updatedBy) {
        if (status == null || !ALLOWED_STATUSES.contains(status)) {
            throw new IllegalArgumentException("유효하지 않은 상태값입니다");
        }
        adminCouponMapper.updateStatus(couponId, status, updatedBy);
    }

    private void validateBasic(CouponDto dto) {
        if (dto.getStoreId() == null)              throw new IllegalArgumentException("가맹점을 선택하세요");
        if (isBlank(dto.getCouponName()))          throw new IllegalArgumentException("쿠폰명을 입력하세요");
        if (isBlank(dto.getBenefit()))             throw new IllegalArgumentException("혜택 내용을 입력하세요");
        if (isBlank(dto.getExpireDate()))          throw new IllegalArgumentException("만료일을 선택하세요");
    }

    private void validateExpireDate(String expireDate) {
        try {
            LocalDate d = LocalDate.parse(expireDate);
            if (!d.isAfter(LocalDate.now().minusDays(1))) {
                throw new IllegalArgumentException("만료일은 오늘 이후로 설정하세요");
            }
        } catch (java.time.format.DateTimeParseException e) {
            throw new IllegalArgumentException("만료일 형식이 올바르지 않습니다");
        }
    }

    private void validateTotalCountForNew(Integer totalCount) {
        if (totalCount == null || totalCount < 0) {
            throw new IllegalArgumentException("수량은 0(무제한) 또는 1 이상이어야 합니다");
        }
    }

    private void validateMaxPerUser(CouponDto dto) {
        if (dto.getMaxPerUser() == null || dto.getMaxPerUser() < 1) {
            dto.setMaxPerUser(1);
        }
    }

    private boolean isBlank(String s) {
        return s == null || s.isBlank();
    }
}
