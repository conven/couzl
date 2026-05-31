package com.couzl.couzl.mapper;

import com.couzl.couzl.dto.ReviewDto;
import com.couzl.couzl.dto.ReviewImageDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface AdminReviewMapper {

    List<ReviewDto> findAll(@Param("keyword") String keyword,
                            @Param("storeId") Long storeId,
                            @Param("rating") Integer rating,
                            @Param("status") String status,
                            @Param("offset") int offset,
                            @Param("limit") int limit);

    int countAll(@Param("keyword") String keyword,
                 @Param("storeId") Long storeId,
                 @Param("rating") Integer rating,
                 @Param("status") String status);

    ReviewDto findByReviewId(@Param("reviewId") Long reviewId);

    void updateStatus(@Param("reviewId") Long reviewId,
                      @Param("status") String status,
                      @Param("updatedBy") String updatedBy);

    /** 메타데이터만 (review_image_id, image_type, sort_order). BLOB 제외 */
    List<ReviewImageDto> findImagesByReviewId(@Param("reviewId") Long reviewId);

    /** 단건 BLOB 조회 (이미지 endpoint에서 사용) */
    ReviewImageDto findImage(@Param("reviewImageId") Long reviewImageId);
}
