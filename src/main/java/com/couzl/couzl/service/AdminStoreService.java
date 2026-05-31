package com.couzl.couzl.service;

import com.couzl.couzl.dto.AdminDto;
import com.couzl.couzl.dto.CategoryDto;
import com.couzl.couzl.dto.RegionDto;
import com.couzl.couzl.dto.StoreDto;
import com.couzl.couzl.mapper.AdminCategoryMapper;
import com.couzl.couzl.mapper.AdminStoreMapper;
import lombok.RequiredArgsConstructor;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class AdminStoreService {

    private static final int PAGE_SIZE = 15;
    private static final long MAX_IMAGE_SIZE = 5L * 1024 * 1024;
    private static final Set<String> ALLOWED_STATUSES = Set.of("ACTIVE", "INACTIVE");

    private final AdminStoreMapper adminStoreMapper;
    private final AdminCategoryMapper adminCategoryMapper;
    private final BCryptPasswordEncoder passwordEncoder;

    public Map<String, Object> getStoreList(String keyword, Long categoryId, String status, Long regionId, int page) {
        int safePage = Math.max(1, page);
        int offset = (safePage - 1) * PAGE_SIZE;

        List<StoreDto> stores = adminStoreMapper.findAll(keyword, categoryId, status, regionId, offset, PAGE_SIZE);
        int totalCount = adminStoreMapper.countAll(keyword, categoryId, status, regionId);
        int totalPages = Math.max(1, (int) Math.ceil(totalCount / (double) PAGE_SIZE));

        Map<String, Object> result = new HashMap<>();
        result.put("stores", stores);
        result.put("totalCount", totalCount);
        result.put("totalPages", totalPages);
        result.put("currentPage", safePage);
        return result;
    }

    public StoreDto getStoreDetail(Long storeId) {
        StoreDto store = adminStoreMapper.findByStoreId(storeId);
        if (store == null) {
            throw new IllegalArgumentException("존재하지 않는 가맹점입니다");
        }
        return store;
    }

    @Transactional
    public void registerStore(StoreDto storeDto, MultipartFile image,
                              String adminLoginId, String rawPassword) throws IOException {
        if (image != null && !image.isEmpty()) {
            applyImage(storeDto, image);
        }
        if (storeDto.getStatus() == null) {
            storeDto.setStatus("ACTIVE");
        }
        storeDto.setAdminLoginId(adminLoginId);
        applyCategoryCode(storeDto);

        adminStoreMapper.insert(storeDto);

        AdminDto storeOwner = new AdminDto();
        storeOwner.setLoginId(adminLoginId);
        storeOwner.setPassword(passwordEncoder.encode(rawPassword));
        storeOwner.setName(storeDto.getStoreName());
        storeOwner.setRole("STORE_OWNER");
        storeOwner.setStoreId(storeDto.getStoreId());
        storeOwner.setStatus("ACTIVE");

        adminStoreMapper.insertStoreOwnerAdmin(storeOwner);
    }

    @Transactional
    public void updateStore(StoreDto storeDto, MultipartFile image) throws IOException {
        if (image != null && !image.isEmpty()) {
            applyImage(storeDto, image);
        }
        applyCategoryCode(storeDto);
        adminStoreMapper.update(storeDto);
    }

    public void updateStatus(Long storeId, String status, String updatedBy) {
        if (status == null || !ALLOWED_STATUSES.contains(status)) {
            throw new IllegalArgumentException("유효하지 않은 상태값입니다");
        }
        adminStoreMapper.updateStatus(storeId, status, updatedBy);
    }

    public ResponseEntity<byte[]> getStoreImage(Long storeId) {
        StoreDto data = adminStoreMapper.findStoreImage(storeId);
        if (data == null || data.getStoreImage() == null) {
            return ResponseEntity.notFound().build();
        }

        MediaType type;
        try {
            type = MediaType.parseMediaType(
                    data.getStoreImageType() != null ? data.getStoreImageType() : "image/jpeg");
        } catch (Exception e) {
            type = MediaType.IMAGE_JPEG;
        }

        return ResponseEntity.ok()
                .contentType(type)
                .header(HttpHeaders.CACHE_CONTROL, "private, max-age=60")
                .body(data.getStoreImage());
    }

    public List<RegionDto> getAllRegions() {
        return adminStoreMapper.findAllRegions();
    }

    public List<CategoryDto> getAllActiveCategories() {
        return adminCategoryMapper.findAllActive();
    }

    /** category(코드) 컬럼은 호환성을 위해 함께 채움. categoryId로 카테고리 lookup. */
    private void applyCategoryCode(StoreDto storeDto) {
        if (storeDto.getCategoryId() == null) {
            throw new IllegalArgumentException("카테고리를 선택하세요");
        }
        CategoryDto category = adminCategoryMapper.findById(storeDto.getCategoryId());
        if (category == null) {
            throw new IllegalArgumentException("존재하지 않는 카테고리입니다");
        }
        storeDto.setCategory(category.getCode());
    }

    private void applyImage(StoreDto storeDto, MultipartFile image) throws IOException {
        if (image.getSize() > MAX_IMAGE_SIZE) {
            throw new IllegalArgumentException("이미지 크기는 5MB 이하만 가능합니다");
        }
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Thumbnails.of(image.getInputStream())
                .size(500, 500)
                .outputFormat("JPEG")
                .toOutputStream(baos);
        storeDto.setStoreImage(baos.toByteArray());
        storeDto.setStoreImageType("image/jpeg");
    }
}
