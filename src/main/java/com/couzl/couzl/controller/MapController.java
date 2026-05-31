package com.couzl.couzl.controller;

import com.couzl.couzl.dto.StoreDto;
import com.couzl.couzl.mapper.MapMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Collections;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class MapController {

    private final MapMapper mapMapper;

    @Value("${kakao.map.key}")
    private String kakaoMapKey;

    @GetMapping("/map")
    public String map(Model model) {
        model.addAttribute("kakaoMapKey", kakaoMapKey);
        return "map";
    }

    @GetMapping("/map/stores")
    @ResponseBody
    public List<StoreDto> stores(@RequestParam(required = false) Double swLat,
                                 @RequestParam(required = false) Double swLng,
                                 @RequestParam(required = false) Double neLat,
                                 @RequestParam(required = false) Double neLng,
                                 @RequestParam(required = false) String category) {

        if (swLat == null || swLng == null || neLat == null || neLng == null) {
            return Collections.emptyList();
        }
        String cat = (category == null || category.isBlank()) ? null : category;
        return mapMapper.findStoresInBounds(swLat, swLng, neLat, neLng, cat);
    }
}
