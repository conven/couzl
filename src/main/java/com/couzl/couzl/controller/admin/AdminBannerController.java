package com.couzl.couzl.controller.admin;

import com.couzl.couzl.dto.AdminDto;
import com.couzl.couzl.dto.BannerDto;
import com.couzl.couzl.dto.CouponDto;
import com.couzl.couzl.dto.StoreDto;
import com.couzl.couzl.mapper.AdminCouponMapper;
import com.couzl.couzl.service.AdminBannerService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class AdminBannerController {

    private final AdminBannerService adminBannerService;
    private final AdminCouponMapper adminCouponMapper;

    @GetMapping("/admin/banners")
    public String list(@RequestParam(required = false) Integer isActive,
                       HttpSession session,
                       Model model) {
        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        model.addAttribute("banners", adminBannerService.getBannerList(isActive));
        model.addAttribute("isActive", isActive);
        return "admin/banner-list";
    }

    @GetMapping("/admin/banners/new")
    public String newForm(HttpSession session, Model model) {
        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        populateLinkOptions(model);
        return "admin/banner-form";
    }

    @PostMapping("/admin/banners/new")
    public String create(@RequestParam String title,
                         @RequestParam String linkType,
                         @RequestParam(required = false) String linkValue,
                         @RequestParam(required = false, defaultValue = "0") Integer displayOrder,
                         @RequestParam(required = false) String startDate,
                         @RequestParam(required = false) String endDate,
                         @RequestParam(required = false, defaultValue = "1") Integer isActive,
                         @RequestParam("image") MultipartFile image,
                         HttpSession session) {
        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");

        BannerDto dto = buildDto(null, title, linkType, linkValue,
                displayOrder, startDate, endDate, isActive);

        try {
            adminBannerService.registerBanner(dto, image, admin.getLoginId());
        } catch (Exception e) {
            return "redirect:/admin/banners/new?msg=error";
        }
        return "redirect:/admin/banners?msg=created";
    }

    @GetMapping("/admin/banners/{bannerId}")
    public String detail(@PathVariable Long bannerId,
                         HttpSession session,
                         Model model) {
        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        model.addAttribute("banner", adminBannerService.getBannerDetail(bannerId));
        populateLinkOptions(model);
        return "admin/banner-detail";
    }

    @PostMapping("/admin/banners/{bannerId}")
    public String update(@PathVariable Long bannerId,
                         @RequestParam String title,
                         @RequestParam String linkType,
                         @RequestParam(required = false) String linkValue,
                         @RequestParam(required = false, defaultValue = "0") Integer displayOrder,
                         @RequestParam(required = false) String startDate,
                         @RequestParam(required = false) String endDate,
                         @RequestParam(required = false, defaultValue = "1") Integer isActive,
                         @RequestParam(value = "image", required = false) MultipartFile image,
                         HttpSession session) {
        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");

        BannerDto dto = buildDto(bannerId, title, linkType, linkValue,
                displayOrder, startDate, endDate, isActive);

        try {
            adminBannerService.updateBanner(dto, image, admin.getLoginId());
        } catch (Exception e) {
            return "redirect:/admin/banners/" + bannerId + "?msg=error";
        }
        return "redirect:/admin/banners/" + bannerId + "?msg=updated";
    }

    @PostMapping("/admin/banners/{bannerId}/active")
    public String updateActive(@PathVariable Long bannerId,
                               @RequestParam int isActive,
                               HttpSession session) {
        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        try {
            adminBannerService.updateActive(bannerId, isActive, admin.getLoginId());
        } catch (RuntimeException e) {
            return "redirect:/admin/banners?msg=error";
        }
        return "redirect:/admin/banners";
    }

    @PostMapping("/admin/banners/{bannerId}/order")
    public String updateOrder(@PathVariable Long bannerId,
                              @RequestParam int displayOrder,
                              HttpSession session) {
        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        try {
            adminBannerService.updateOrder(bannerId, displayOrder, admin.getLoginId());
        } catch (RuntimeException e) {
            return "redirect:/admin/banners?msg=error";
        }
        return "redirect:/admin/banners";
    }

    @PostMapping("/admin/banners/{bannerId}/delete")
    public String delete(@PathVariable Long bannerId, HttpSession session) {
        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        try {
            adminBannerService.deleteBanner(bannerId, admin.getLoginId());
        } catch (RuntimeException e) {
            return "redirect:/admin/banners?msg=error";
        }
        return "redirect:/admin/banners?msg=deleted";
    }

    @GetMapping("/admin/banners/{bannerId}/image")
    public ResponseEntity<byte[]> image(@PathVariable Long bannerId) {
        BannerDto img = adminBannerService.getBannerImage(bannerId);
        if (img == null || img.getBannerImage() == null) {
            return ResponseEntity.notFound().build();
        }
        MediaType type;
        try {
            type = MediaType.parseMediaType(
                    img.getImageType() != null ? img.getImageType() : "image/jpeg");
        } catch (Exception e) {
            type = MediaType.IMAGE_JPEG;
        }
        return ResponseEntity.ok()
                .contentType(type)
                .header(HttpHeaders.CACHE_CONTROL, "private, max-age=60")
                .body(img.getBannerImage());
    }

    private BannerDto buildDto(Long bannerId, String title, String linkType, String linkValue,
                                Integer displayOrder, String startDate, String endDate, Integer isActive) {
        BannerDto dto = new BannerDto();
        dto.setBannerId(bannerId);
        dto.setTitle(title);
        dto.setLinkType(linkType);
        dto.setLinkValue(linkValue);
        dto.setDisplayOrder(displayOrder == null ? 0 : displayOrder);
        dto.setIsActive(isActive == null ? 1 : isActive);
        dto.setStartDate(parseDate(startDate));
        dto.setEndDate(parseDate(endDate));
        return dto;
    }

    private LocalDate parseDate(String s) {
        if (s == null || s.isBlank()) return null;
        return LocalDate.parse(s);
    }

    private void populateLinkOptions(Model model) {
        List<StoreDto> activeStores = adminCouponMapper.findActiveStores();
        List<CouponDto> activeCoupons = adminCouponMapper.findAll("", null, "ACTIVE", 0, 1000);
        model.addAttribute("activeStores", activeStores);
        model.addAttribute("activeCoupons", activeCoupons);
    }

    private String guardAdminOnly(HttpSession session) {
        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        if (admin == null) return "redirect:/admin/login";
        if (admin.isStoreOwner()) return "redirect:/admin/dashboard";
        return null;
    }
}
