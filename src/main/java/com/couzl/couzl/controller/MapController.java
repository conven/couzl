package com.couzl.couzl.controller;

import com.couzl.couzl.dto.CouponDto;
import com.couzl.couzl.dto.StoreDto;
import com.couzl.couzl.mapper.StoreMapper;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class MapController {

    private final StoreMapper storeMapper;
    private final ObjectMapper objectMapper;

    @Value("${kakao.map.key}")
    private String kakaoMapKey;

    @GetMapping("/map")
    public String map(HttpSession session, Model model) throws Exception {
        if (session.getAttribute("LOGIN_USER") == null) {
            return "redirect:/login";
        }

        List<StoreDto> storeList = storeMapper.selectAllStoresWithLocation();
        for (StoreDto store : storeList) {
            List<CouponDto> coupons = storeMapper.selectCouponsByStoreId(store.getStoreId());
            store.setCoupons(coupons);
        }

        model.addAttribute("storeListJson", objectMapper.writeValueAsString(storeList));
        model.addAttribute("kakaoMapKey", kakaoMapKey);

        return "map";
    }
}
