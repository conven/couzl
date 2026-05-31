package com.couzl.couzl.service;

import com.couzl.couzl.dto.CategoryDto;
import com.couzl.couzl.mapper.AdminCategoryMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.regex.Pattern;

@Service
@RequiredArgsConstructor
public class AdminCategoryService {

    private static final Pattern CODE_PATTERN = Pattern.compile("^[A-Z][A-Z0-9_]{1,19}$");

    private final AdminCategoryMapper adminCategoryMapper;

    public List<CategoryDto> getAll() {
        return adminCategoryMapper.findAll();
    }

    public List<CategoryDto> getAllActive() {
        return adminCategoryMapper.findAllActive();
    }

    public CategoryDto getById(Long categoryId) {
        CategoryDto category = adminCategoryMapper.findById(categoryId);
        if (category == null) {
            throw new IllegalArgumentException("존재하지 않는 카테고리입니다");
        }
        return category;
    }

    public void create(CategoryDto categoryDto) {
        validate(categoryDto, null);
        if (categoryDto.getIsActive() == null) categoryDto.setIsActive(1);
        if (categoryDto.getSortOrder() == null) categoryDto.setSortOrder(0);
        adminCategoryMapper.insert(categoryDto);
    }

    public void update(CategoryDto categoryDto) {
        if (categoryDto.getCategoryId() == null) {
            throw new IllegalArgumentException("categoryId가 필요합니다");
        }
        validate(categoryDto, categoryDto.getCategoryId());
        if (categoryDto.getIsActive() == null) categoryDto.setIsActive(1);
        if (categoryDto.getSortOrder() == null) categoryDto.setSortOrder(0);
        adminCategoryMapper.update(categoryDto);
    }

    public void toggleActive(Long categoryId, String updatedBy) {
        CategoryDto existing = getById(categoryId);
        int next = (existing.getIsActive() != null && existing.getIsActive() == 1) ? 0 : 1;

        if (next == 0 && adminCategoryMapper.countStoresUsingCategory(categoryId) > 0) {
            throw new IllegalStateException("이 카테고리를 사용 중인 가맹점이 있어 비활성화할 수 없습니다");
        }
        adminCategoryMapper.updateActive(categoryId, next, updatedBy);
    }

    private void validate(CategoryDto dto, Long excludeId) {
        if (dto.getCode() == null || !CODE_PATTERN.matcher(dto.getCode()).matches()) {
            throw new IllegalArgumentException("코드는 영문 대문자/숫자/언더스코어 2~20자여야 합니다");
        }
        if (dto.getName() == null || dto.getName().isBlank()) {
            throw new IllegalArgumentException("이름은 필수입니다");
        }
        if (adminCategoryMapper.countByCode(dto.getCode(), excludeId) > 0) {
            throw new IllegalArgumentException("이미 사용 중인 코드입니다");
        }
    }
}
