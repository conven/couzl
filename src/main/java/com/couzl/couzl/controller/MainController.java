package com.couzl.couzl.controller;

import com.couzl.couzl.dto.RegionDto;
import com.couzl.couzl.dto.StoreDto;
import com.couzl.couzl.dto.UserDto;
import com.couzl.couzl.mapper.AdminStoreMapper;
import com.couzl.couzl.mapper.RegionMapper;
import com.couzl.couzl.service.MainService;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.InputStream;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class MainController {

    private final MainService mainService;
    private final AdminStoreMapper adminStoreMapper;
    private final RegionMapper regionMapper;
    private final ServletContext servletContext;

    @Value("${kakao.map.key}")
    private String kakaoMapKey;

    @GetMapping("/main")
    public String main(@RequestParam(required = false) String category,
                       @RequestParam(required = false, defaultValue = "") String keyword,
                       @RequestParam(required = false, defaultValue = "1") int page,
                       @RequestParam(required = false) Long regionId,
                       HttpSession session,
                       Model model) {

        populateSections(category, keyword, page, regionId, session, model);
        model.addAttribute("banners", mainService.getActiveBanners());
        model.addAttribute("kakaoMapKey", kakaoMapKey);
        return "main";
    }

    @GetMapping("/main/content")
    public String mainContent(@RequestParam(required = false) String category,
                              @RequestParam(required = false, defaultValue = "") String keyword,
                              @RequestParam(required = false, defaultValue = "1") int page,
                              @RequestParam(required = false) Long regionId,
                              HttpSession session,
                              Model model) {

        populateSections(category, keyword, page, regionId, session, model);
        return "main/_sections";
    }

    private void populateSections(String category, String keyword, int page, Long requestedRegionId,
                                  HttpSession session, Model model) {
        UserDto loginUser = (UserDto) session.getAttribute("LOGIN_USER");

        Long regionId;
        String regionName;
        if (loginUser != null) {
            // 로그인 유저: 세션 USER_REGION 우선
            RegionDto region = (RegionDto) session.getAttribute("USER_REGION");
            regionId = (region != null) ? region.getRegionId() : null;
            regionName = (region != null) ? region.getRegionName() : "전체";
        } else if (requestedRegionId != null) {
            // 비로그인: URL 파라미터 regionId
            RegionDto region = regionMapper.findById(requestedRegionId);
            regionId = (region != null) ? region.getRegionId() : null;
            regionName = (region != null) ? region.getRegionName() : "전체";
        } else {
            regionId = null;
            regionName = "전체";
        }

        Map<String, Object> storeList = mainService.getStoreList(regionId, category, keyword, page);
        String normalizedCategory = (String) storeList.get("category");

        model.addAttribute("popularStores", mainService.getPopularStores(regionId, normalizedCategory));
        model.addAttribute("hotCoupons", mainService.getHotCoupons(regionId));
        model.addAttribute("stores", storeList.get("stores"));
        model.addAttribute("totalCount", storeList.get("totalCount"));
        model.addAttribute("totalPages", storeList.get("totalPages"));
        model.addAttribute("currentPage", storeList.get("currentPage"));
        model.addAttribute("category", normalizedCategory);
        model.addAttribute("keyword", storeList.get("keyword"));
        model.addAttribute("regionName", regionName);
        model.addAttribute("regionId", regionId);
    }

    @GetMapping("/store/image/{storeId}")
    public ResponseEntity<byte[]> getStoreImage(@PathVariable Long storeId) {
        StoreDto store = adminStoreMapper.findStoreImage(storeId);

        if (store != null && store.getStoreImage() != null) {
            MediaType type;
            try {
                type = MediaType.parseMediaType(
                        store.getStoreImageType() != null ? store.getStoreImageType() : "image/jpeg");
            } catch (Exception e) {
                type = MediaType.IMAGE_JPEG;
            }
            return ResponseEntity.ok()
                    .contentType(type)
                    .header(HttpHeaders.CACHE_CONTROL, "public, max-age=300")
                    .body(store.getStoreImage());
        }

        return defaultStoreImage();
    }

    private ResponseEntity<byte[]> defaultStoreImage() {
        try (InputStream is = servletContext.getResourceAsStream("/static/images/default-store.png")) {
            if (is != null) {
                return ResponseEntity.ok()
                        .contentType(MediaType.IMAGE_PNG)
                        .header(HttpHeaders.CACHE_CONTROL, "public, max-age=3600")
                        .body(is.readAllBytes());
            }
        } catch (Exception ignored) {
        }

        try (InputStream is = new ClassPathResource("static/images/default-store.png").getInputStream()) {
            return ResponseEntity.ok()
                    .contentType(MediaType.IMAGE_PNG)
                    .header(HttpHeaders.CACHE_CONTROL, "public, max-age=3600")
                    .body(is.readAllBytes());
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }
}
