package com.couzl.couzl.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class ReviewDto {

    private Long reviewId;
    private Long userId;
    private Long storeId;
    private Long userCouponId;
    private Integer rating;
    private String content;
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private String nickname;
    private String loginId;
    private String storeName;
    private String couponName;
}
