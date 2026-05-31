package com.couzl.couzl.mapper;

import com.couzl.couzl.dto.StoreDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MapMapper {

    List<StoreDto> findStoresInBounds(
            @Param("swLat") Double swLat,
            @Param("swLng") Double swLng,
            @Param("neLat") Double neLat,
            @Param("neLng") Double neLng,
            @Param("category") String category);
}
