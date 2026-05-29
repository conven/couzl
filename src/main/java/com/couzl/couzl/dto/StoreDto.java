package com.couzl.couzl.dto;

import lombok.Getter;
import lombok.Setter;
import java.util.List;

@Getter
@Setter
public class StoreDto {
    private Long storeId;
    private Long regionId;
    private String storeName;
    private String category;
    private String address;
    private String phone;
    private String businessHours;
    private String description;
    private String emoji;
    private Double ratingAvg;
    private String status;
    private Double latitude;
    private Double longitude;
    private List<CouponDto> coupons;
}
