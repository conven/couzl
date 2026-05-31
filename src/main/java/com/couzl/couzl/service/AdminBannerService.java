package com.couzl.couzl.service;

import com.couzl.couzl.dto.BannerDto;
import com.couzl.couzl.mapper.AdminBannerMapper;
import lombok.RequiredArgsConstructor;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class AdminBannerService {

    /** FO banner-card 비율(5:2)에 맞춘 retina 대응 규격 */
    private static final int BANNER_WIDTH  = 800;
    private static final int BANNER_HEIGHT = 320;

    private static final long MAX_IMAGE_SIZE = 5L * 1024 * 1024;
    private static final Set<String> ALLOWED_LINK_TYPES = Set.of("NONE", "STORE", "COUPON");

    private final AdminBannerMapper adminBannerMapper;

    public List<BannerDto> getBannerList(Integer isActive) {
        return adminBannerMapper.findAll(isActive);
    }

    public BannerDto getBannerDetail(Long bannerId) {
        BannerDto banner = adminBannerMapper.findByBannerId(bannerId);
        if (banner == null) {
            throw new IllegalArgumentException("존재하지 않는 배너입니다");
        }
        return banner;
    }

    public void registerBanner(BannerDto bannerDto, MultipartFile image, String createdBy) throws IOException {
        if (image == null || image.isEmpty()) {
            throw new IllegalArgumentException("배너 이미지를 업로드하세요");
        }
        applyImage(bannerDto, image);
        validateLink(bannerDto);
        validateDates(bannerDto);

        if (bannerDto.getIsActive() == null) bannerDto.setIsActive(1);
        if (bannerDto.getDisplayOrder() == null) bannerDto.setDisplayOrder(0);
        bannerDto.setCreatedBy(createdBy);

        adminBannerMapper.insert(bannerDto);
    }

    public void updateBanner(BannerDto bannerDto, MultipartFile image, String updatedBy) throws IOException {
        if (bannerDto.getBannerId() == null) {
            throw new IllegalArgumentException("bannerId가 필요합니다");
        }
        getBannerDetail(bannerDto.getBannerId());

        if (image != null && !image.isEmpty()) {
            applyImage(bannerDto, image);
        }
        validateLink(bannerDto);
        validateDates(bannerDto);

        if (bannerDto.getIsActive() == null) bannerDto.setIsActive(1);
        if (bannerDto.getDisplayOrder() == null) bannerDto.setDisplayOrder(0);
        bannerDto.setUpdatedBy(updatedBy);

        adminBannerMapper.update(bannerDto);
    }

    public void updateActive(Long bannerId, int isActive, String updatedBy) {
        if (isActive != 0 && isActive != 1) {
            throw new IllegalArgumentException("유효하지 않은 값입니다");
        }
        adminBannerMapper.updateActive(bannerId, isActive, updatedBy);
    }

    public void updateOrder(Long bannerId, int displayOrder, String updatedBy) {
        adminBannerMapper.updateOrder(bannerId, displayOrder, updatedBy);
    }

    public void deleteBanner(Long bannerId, String updatedBy) {
        adminBannerMapper.delete(bannerId, updatedBy);
    }

    public List<BannerDto> getActiveBannersForFO() {
        return adminBannerMapper.findActiveBanners();
    }

    public BannerDto getBannerImage(Long bannerId) {
        return adminBannerMapper.findBannerImage(bannerId);
    }

    private void applyImage(BannerDto dto, MultipartFile image) throws IOException {
        if (image.getSize() > MAX_IMAGE_SIZE) {
            throw new IllegalArgumentException("이미지 크기는 5MB 이하만 가능합니다");
        }
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Thumbnails.of(image.getInputStream())
                .size(BANNER_WIDTH, BANNER_HEIGHT)
                .crop(net.coobird.thumbnailator.geometry.Positions.CENTER)
                .outputFormat("JPEG")
                .toOutputStream(baos);
        dto.setBannerImage(baos.toByteArray());
        dto.setImageType("image/jpeg");
    }

    private void validateLink(BannerDto dto) {
        if (dto.getLinkType() == null || !ALLOWED_LINK_TYPES.contains(dto.getLinkType())) {
            throw new IllegalArgumentException("유효하지 않은 링크 유형입니다");
        }
        if ("NONE".equals(dto.getLinkType())) {
            dto.setLinkValue(null);
        } else {
            if (dto.getLinkValue() == null || dto.getLinkValue().isBlank()) {
                throw new IllegalArgumentException("링크 대상을 선택하세요");
            }
        }
    }

    private void validateDates(BannerDto dto) {
        LocalDate start = dto.getStartDate();
        LocalDate end = dto.getEndDate();
        if (start != null && end != null && !start.isBefore(end)) {
            throw new IllegalArgumentException("종료일은 시작일 이후로 설정하세요");
        }
    }
}
