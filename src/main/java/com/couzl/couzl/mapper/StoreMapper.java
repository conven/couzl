package com.couzl.couzl.mapper;

import com.couzl.couzl.dto.CouponDto;
import com.couzl.couzl.dto.StoreDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StoreMapper {
    List<StoreDto> selectAllStoresWithLocation();
    List<CouponDto> selectCouponsByStoreId(Long storeId);
}
