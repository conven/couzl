package com.couzl.couzl.mapper;

import com.couzl.couzl.dto.BannerDto;
import com.couzl.couzl.dto.CouponDto;
import com.couzl.couzl.dto.StoreDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MainMapper {

    List<BannerDto> findActiveBanners();

    List<StoreDto> findPopularStores(@Param("regionId") Long regionId,
                                     @Param("category") String category,
                                     @Param("limit") int limit);

    List<StoreDto> findStoresByCategory(@Param("regionId") Long regionId,
                                        @Param("category") String category,
                                        @Param("keyword") String keyword,
                                        @Param("offset") int offset,
                                        @Param("limit") int limit);

    int countStoresByCategory(@Param("regionId") Long regionId,
                              @Param("category") String category,
                              @Param("keyword") String keyword);

    List<CouponDto> findHotCoupons(@Param("regionId") Long regionId,
                                   @Param("limit") int limit);
}
