package com.couzl.couzl.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class RegionDto {
    private Long regionId;
    private String regionName;
    private Integer isActive;
    private Integer storeCount;
    private Integer userCount;
    private String createdBy;
    private LocalDateTime createdAt;
    private String updatedBy;
    private LocalDateTime updatedAt;
    private Integer isDeleted;
}
