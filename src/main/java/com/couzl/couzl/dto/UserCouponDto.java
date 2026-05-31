package com.couzl.couzl.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class UserCouponDto {

    private Long userCouponId;
    private Long userId;
    private Long couponId;
    private String couponCode;
    private String couponName;
    private String storeName;
    private String benefit;
    private String status;
    private LocalDateTime usedAt;
    private LocalDateTime createdAt;
    private String createdBy;
    private Integer isDeleted;

    private String userLoginId;
    private String userNickname;
    private String userEmail;

    private Long storeId;
    private String conditionText;
    private java.time.LocalDate expireDate;
    private Boolean alreadyIssued;
    private Boolean canWriteReview;
}
