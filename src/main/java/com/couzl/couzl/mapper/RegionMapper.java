package com.couzl.couzl.mapper;

import com.couzl.couzl.dto.RegionDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface RegionMapper {
    List<RegionDto> findAllActive();
    RegionDto findById(Long regionId);
}
