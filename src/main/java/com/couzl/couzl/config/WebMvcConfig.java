package com.couzl.couzl.config;

import com.couzl.couzl.interceptor.AdminInterceptor;
import com.couzl.couzl.interceptor.LoginInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns(
                        "/",
                        "/splash",
                        "/login",
                        "/register",
                        "/register/**",
                        "/find-id",
                        "/find-pw",
                        "/terms",
                        "/privacy",
                        "/main",
                        "/main/**",
                        "/store",
                        "/store/**",
                        "/map",
                        "/map/**",
                        "/static/**",
                        "/css/**",
                        "/js/**",
                        "/profile-image/**",
                        "/review-image/**",
                        "/banner/image/**",
                        "/store/image/**",
                        "/admin/**"
                );

        registry.addInterceptor(new AdminInterceptor())
                .addPathPatterns("/admin/**")
                .excludePathPatterns("/admin/login");
    }
}
