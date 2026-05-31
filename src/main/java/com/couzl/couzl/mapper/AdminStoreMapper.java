package com.couzl.couzl.mapper;

import com.couzl.couzl.dto.AdminDto;
import com.couzl.couzl.dto.RegionDto;
import com.couzl.couzl.dto.StoreDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface AdminStoreMapper {

    List<StoreDto> findAll(@Param("keyword") String keyword,
                           @Param("categoryId") Long categoryId,
                           @Param("status") String status,
                           @Param("regionId") Long regionId,
                           @Param("offset") int offset,
                           @Param("limit") int limit);

    int countAll(@Param("keyword") String keyword,
                 @Param("categoryId") Long categoryId,
                 @Param("status") String status,
                 @Param("regionId") Long regionId);

    StoreDto findByStoreId(@Param("storeId") Long storeId);

    void insert(StoreDto storeDto);

    void update(StoreDto storeDto);

    void updateStatus(@Param("storeId") Long storeId,
                      @Param("status") String status,
                      @Param("updatedBy") String updatedBy);

    StoreDto findStoreImage(@Param("storeId") Long storeId);

    List<RegionDto> findAllRegions();

    void insertStoreOwnerAdmin(AdminDto adminDto);
}
