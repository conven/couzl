package com.couzl.couzl.mapper;

import com.couzl.couzl.dto.CategoryDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface AdminCategoryMapper {

    /** 관리용: 비활성 포함 전체 (store_count도 함께) */
    List<CategoryDto> findAll();

    /** 가맹점 폼/검색용: 활성 카테고리만 */
    List<CategoryDto> findAllActive();

    CategoryDto findById(@Param("categoryId") Long categoryId);

    int countByCode(@Param("code") String code,
                    @Param("excludeId") Long excludeId);

    void insert(CategoryDto categoryDto);

    void update(CategoryDto categoryDto);

    void updateActive(@Param("categoryId") Long categoryId,
                      @Param("isActive") Integer isActive,
                      @Param("updatedBy") String updatedBy);

    /** 가맹점이 참조 중이면 0이 아님 (삭제/비활성 결정용) */
    int countStoresUsingCategory(@Param("categoryId") Long categoryId);
}
