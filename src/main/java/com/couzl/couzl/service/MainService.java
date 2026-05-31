package com.couzl.couzl.service;

import com.couzl.couzl.dto.BannerDto;
import com.couzl.couzl.dto.CouponDto;
import com.couzl.couzl.dto.StoreDto;
import com.couzl.couzl.mapper.MainMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class MainService {

    private static final int POPULAR_LIMIT = 6;
    private static final int HOT_COUPON_LIMIT = 6;
    private static final int STORE_PAGE_SIZE = 12;

    private final MainMapper mainMapper;

    public List<BannerDto> getActiveBanners() {
        return mainMapper.findActiveBanners();
    }

    public List<StoreDto> getPopularStores(Long regionId, String category) {
        String normalized = (category == null || category.isBlank()) ? null : category;
        return mainMapper.findPopularStores(regionId, normalized, POPULAR_LIMIT);
    }

    public List<CouponDto> getHotCoupons(Long regionId) {
        return mainMapper.findHotCoupons(regionId, HOT_COUPON_LIMIT);
    }

    public Map<String, Object> getStoreList(Long regionId, String category, String keyword, int page) {
        int currentPage = Math.max(page, 1);
        String normalizedKeyword = (keyword == null) ? "" : keyword.trim();
        String normalizedCategory = (category == null || category.isBlank()) ? null : category;

        int totalCount = mainMapper.countStoresByCategory(regionId, normalizedCategory, normalizedKeyword);
        int totalPages = (int) Math.ceil(totalCount / (double) STORE_PAGE_SIZE);
        if (totalPages < 1) totalPages = 1;
        if (currentPage > totalPages) currentPage = totalPages;

        int offset = (currentPage - 1) * STORE_PAGE_SIZE;
        List<StoreDto> stores = mainMapper.findStoresByCategory(
                regionId, normalizedCategory, normalizedKeyword, offset, STORE_PAGE_SIZE);

        Map<String, Object> result = new HashMap<>();
        result.put("stores", stores);
        result.put("totalCount", totalCount);
        result.put("totalPages", totalPages);
        result.put("currentPage", currentPage);
        result.put("category", normalizedCategory);
        result.put("keyword", normalizedKeyword);
        return result;
    }
}
