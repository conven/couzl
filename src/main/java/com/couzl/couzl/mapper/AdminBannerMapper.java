package com.couzl.couzl.mapper;

import com.couzl.couzl.dto.BannerDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface AdminBannerMapper {

    List<BannerDto> findAll(@Param("isActive") Integer isActive);

    BannerDto findByBannerId(@Param("bannerId") Long bannerId);

    BannerDto findBannerImage(@Param("bannerId") Long bannerId);

    void insert(BannerDto bannerDto);

    void update(BannerDto bannerDto);

    void updateActive(@Param("bannerId") Long bannerId,
                      @Param("isActive") int isActive,
                      @Param("updatedBy") String updatedBy);

    void updateOrder(@Param("bannerId") Long bannerId,
                     @Param("displayOrder") int displayOrder,
                     @Param("updatedBy") String updatedBy);

    void delete(@Param("bannerId") Long bannerId,
                @Param("updatedBy") String updatedBy);

    List<BannerDto> findActiveBanners();
}
