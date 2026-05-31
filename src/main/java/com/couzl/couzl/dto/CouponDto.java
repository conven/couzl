package com.couzl.couzl.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class CouponDto {
    private Long couponId;
    private Long storeId;
    private String couponName;
    private String benefit;
    private String conditionText;
    private String expireDate;

    private Integer totalCount;
    private Integer issuedCount;
    private Integer maxPerUser;
    private String status;
    private String createdBy;
    private String updatedBy;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private String storeName;
    private String regionName;
    private Integer remainCount;
    private Boolean alreadyIssued;
}
