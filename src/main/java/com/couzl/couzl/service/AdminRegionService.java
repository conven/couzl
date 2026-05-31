package com.couzl.couzl.service;

import com.couzl.couzl.dto.RegionDto;
import com.couzl.couzl.mapper.AdminRegionMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminRegionService {

    public static class DuplicateRegionException extends RuntimeException {
        public DuplicateRegionException(String message) { super(message); }
    }

    public static class HasStoresException extends RuntimeException {
        public HasStoresException(String message) { super(message); }
    }

    private final AdminRegionMapper adminRegionMapper;

    public List<RegionDto> getRegionList(String keyword, Integer isActive) {
        return adminRegionMapper.findAll(keyword, isActive);
    }

    public RegionDto getRegionDetail(Long regionId) {
        RegionDto region = adminRegionMapper.findByRegionId(regionId);
        if (region == null) {
            throw new IllegalArgumentException("존재하지 않는 지역입니다");
        }
        return region;
    }

    public void registerRegion(String regionName, String createdBy) {
        String normalized = normalize(regionName);
        if (adminRegionMapper.countByRegionName(normalized, null) > 0) {
            throw new DuplicateRegionException("이미 존재하는 지역명입니다");
        }
        RegionDto dto = new RegionDto();
        dto.setRegionName(normalized);
        dto.setCreatedBy(createdBy);
        adminRegionMapper.insert(dto);
    }

    public void updateRegion(Long regionId, String regionName, String updatedBy) {
        getRegionDetail(regionId);
        String normalized = normalize(regionName);
        if (adminRegionMapper.countByRegionName(normalized, regionId) > 0) {
            throw new DuplicateRegionException("이미 존재하는 지역명입니다");
        }
        RegionDto dto = new RegionDto();
        dto.setRegionId(regionId);
        dto.setRegionName(normalized);
        dto.setUpdatedBy(updatedBy);
        adminRegionMapper.update(dto);
    }

    public void updateActive(Long regionId, int isActive, String updatedBy) {
        if (isActive != 0 && isActive != 1) {
            throw new IllegalArgumentException("유효하지 않은 값입니다");
        }

        RegionDto existing = getRegionDetail(regionId);

        if (isActive == 0 && existing.getStoreCount() != null && existing.getStoreCount() > 0) {
            throw new HasStoresException(
                    "해당 지역에 가맹점이 존재합니다. 가맹점을 먼저 이전하거나 비활성화하세요");
        }

        adminRegionMapper.updateActive(regionId, isActive, updatedBy);
    }

    private String normalize(String name) {
        if (name == null) throw new IllegalArgumentException("지역명을 입력하세요");
        String s = name.trim();
        if (s.isEmpty()) throw new IllegalArgumentException("지역명을 입력하세요");
        return s;
    }
}
