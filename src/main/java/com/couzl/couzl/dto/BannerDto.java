package com.couzl.couzl.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
public class BannerDto {

    private Long bannerId;
    private String title;
    private byte[] bannerImage;
    private String imageType;
    private String linkType;
    private String linkValue;
    private String linkTargetName;
    private Long linkStoreId;
    private Long couponStoreId;
    private Integer displayOrder;
    private LocalDate startDate;
    private LocalDate endDate;
    private Integer isActive;
    private String createdBy;
    private LocalDateTime createdAt;
    private String updatedBy;
    private LocalDateTime updatedAt;
    private Integer isDeleted;
}
