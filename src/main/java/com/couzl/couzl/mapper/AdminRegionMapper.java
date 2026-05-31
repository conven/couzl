package com.couzl.couzl.mapper;

import com.couzl.couzl.dto.RegionDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface AdminRegionMapper {

    List<RegionDto> findAll(@Param("keyword") String keyword,
                            @Param("isActive") Integer isActive);

    RegionDto findByRegionId(@Param("regionId") Long regionId);

    void insert(RegionDto regionDto);

    void update(RegionDto regionDto);

    void updateActive(@Param("regionId") Long regionId,
                      @Param("isActive") int isActive,
                      @Param("updatedBy") String updatedBy);

    int countByRegionName(@Param("regionName") String regionName,
                          @Param("excludeRegionId") Long excludeRegionId);
}
