package com.couzl.couzl.controller.admin;

import com.couzl.couzl.dto.AdminDto;
import com.couzl.couzl.service.AdminCouponService;
import com.couzl.couzl.service.AdminReviewService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
@RequiredArgsConstructor
public class AdminReviewController {

    private final AdminReviewService adminReviewService;
    private final AdminCouponService adminCouponService;

    @GetMapping("/admin/reviews")
    public String list(@RequestParam(defaultValue = "") String keyword,
                       @RequestParam(required = false) Long storeId,
                       @RequestParam(required = false) Integer rating,
                       @RequestParam(defaultValue = "") String status,
                       @RequestParam(defaultValue = "1") int page,
                       HttpSession session,
                       Model model) {

        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        Map<String, Object> result = adminReviewService.getReviewList(keyword, storeId, rating, status, page);
        model.addAttribute("reviews", result.get("reviews"));
        model.addAttribute("totalCount", result.get("totalCount"));
        model.addAttribute("totalPages", result.get("totalPages"));
        model.addAttribute("currentPage", result.get("currentPage"));
        model.addAttribute("keyword", keyword);
        model.addAttribute("storeId", storeId);
        model.addAttribute("rating", rating);
        model.addAttribute("status", status);
        model.addAttribute("stores", adminCouponService.getActiveStores());
        return "admin/review-list";
    }

    @GetMapping("/admin/reviews/{reviewId}")
    public String detail(@PathVariable Long reviewId,
                         HttpSession session,
                         Model model) {

        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        model.addAttribute("review", adminReviewService.getReviewDetail(reviewId));
        model.addAttribute("reviewImages", adminReviewService.getReviewImages(reviewId));
        return "admin/review-detail";
    }

    @PostMapping("/admin/reviews/{reviewId}/delete")
    public String delete(@PathVariable Long reviewId, HttpSession session) {
        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        try {
            adminReviewService.deleteReview(reviewId, admin.getLoginId());
        } catch (RuntimeException e) {
            return "redirect:/admin/reviews/" + reviewId + "?msg=error";
        }
        return "redirect:/admin/reviews?msg=deleted";
    }

    @PostMapping("/admin/reviews/{reviewId}/restore")
    public String restore(@PathVariable Long reviewId, HttpSession session) {
        String guard = guardAdminOnly(session);
        if (guard != null) return guard;

        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        try {
            adminReviewService.restoreReview(reviewId, admin.getLoginId());
        } catch (RuntimeException e) {
            return "redirect:/admin/reviews/" + reviewId + "?msg=error";
        }
        return "redirect:/admin/reviews/" + reviewId + "?msg=restored";
    }

    private String guardAdminOnly(HttpSession session) {
        AdminDto admin = (AdminDto) session.getAttribute("LOGIN_ADMIN");
        if (admin == null) return "redirect:/admin/login";
        if (admin.isStoreOwner()) return "redirect:/admin/dashboard";
        return null;
    }
}
