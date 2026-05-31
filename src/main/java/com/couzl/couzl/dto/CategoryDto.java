package com.couzl.couzl.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class CategoryDto {

    private Long categoryId;
    private String code;
    private String name;
    private String icon;
    private Integer sortOrder;
    private Integer isActive;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private Integer storeCount;
}
