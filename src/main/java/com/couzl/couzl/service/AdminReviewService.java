package com.couzl.couzl.service;

import com.couzl.couzl.dto.ReviewDto;
import com.couzl.couzl.dto.ReviewImageDto;
import com.couzl.couzl.mapper.AdminReviewMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class AdminReviewService {

    private static final int PAGE_SIZE = 15;

    private final AdminReviewMapper adminReviewMapper;

    public Map<String, Object> getReviewList(String keyword, Long storeId, Integer rating, String status, int page) {
        int safePage = Math.max(1, page);
        int offset = (safePage - 1) * PAGE_SIZE;

        List<ReviewDto> reviews = adminReviewMapper.findAll(keyword, storeId, rating, status, offset, PAGE_SIZE);
        int totalCount = adminReviewMapper.countAll(keyword, storeId, rating, status);
        int totalPages = Math.max(1, (int) Math.ceil(totalCount / (double) PAGE_SIZE));

        Map<String, Object> result = new HashMap<>();
        result.put("reviews", reviews);
        result.put("totalCount", totalCount);
        result.put("totalPages", totalPages);
        result.put("currentPage", safePage);
        return result;
    }

    public ReviewDto getReviewDetail(Long reviewId) {
        ReviewDto review = adminReviewMapper.findByReviewId(reviewId);
        if (review == null) {
            throw new IllegalArgumentException("존재하지 않는 리뷰입니다");
        }
        return review;
    }

    public List<ReviewImageDto> getReviewImages(Long reviewId) {
        return adminReviewMapper.findImagesByReviewId(reviewId);
    }

    public void deleteReview(Long reviewId, String updatedBy) {
        ReviewDto existing = getReviewDetail(reviewId);
        if ("DELETED".equals(existing.getStatus())) {
            throw new IllegalStateException("이미 삭제된 리뷰입니다");
        }
        adminReviewMapper.updateStatus(reviewId, "DELETED", updatedBy);
    }

    public void restoreReview(Long reviewId, String updatedBy) {
        ReviewDto existing = getReviewDetail(reviewId);
        if ("ACTIVE".equals(existing.getStatus())) {
            throw new IllegalStateException("이미 활성 상태인 리뷰입니다");
        }
        adminReviewMapper.updateStatus(reviewId, "ACTIVE", updatedBy);
    }
}
