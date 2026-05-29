package com.couzl.couzl.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CouponDto {
    private Long couponId;
    private Long storeId;
    private String couponName;
    private String benefit;
    private String conditionText;
    private String expireDate;
}
