package com.couzl.couzl.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class ReviewImageDto {

    private Long reviewImageId;
    private Long reviewId;
    private byte[] image;
    private String imageType;
    private Integer sortOrder;
    private LocalDateTime createdAt;
    private String imgVer;
}
