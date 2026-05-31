<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 인기 가맹점 -->
<section class="main-section">
    <div class="section-header">
        <h2 class="section-title">
            인기 가맹점
            <span class="section-region">${fn:escapeXml(regionName)}</span>
            <c:if test="${not empty category}">
                <span class="section-region">
                    <c:choose>
                        <c:when test="${category == 'CAFE'}">카페</c:when>
                        <c:when test="${category == 'FOOD'}">음식점</c:when>
                        <c:when test="${category == 'BEAUTY'}">뷰티</c:when>
                        <c:when test="${category == 'SHOPPING'}">쇼핑</c:when>
                        <c:when test="${category == 'FITNESS'}">피트니스</c:when>
                        <c:when test="${category == 'CONVENIENCE'}">편의점</c:when>
                        <c:otherwise>${fn:escapeXml(category)}</c:otherwise>
                    </c:choose>
                </span>
            </c:if>
        </h2>
    </div>

    <c:choose>
        <c:when test="${not empty popularStores}">
            <div class="popular-scroll">
                <c:forEach var="st" items="${popularStores}">
                    <a class="popular-card" href="/store?storeId=${st.storeId}">
                        <div class="popular-image">
                            <img src="/store/image/${st.storeId}" alt="${fn:escapeXml(st.storeName)}"
                                 onerror="this.style.display='none'">
                            <c:if test="${not empty st.emoji}">
                                <span class="popular-emoji">${st.emoji}</span>
                            </c:if>
                        </div>
                        <div class="popular-info">
                            <span class="shop-tag">
                                <c:choose>
                                    <c:when test="${st.category == 'CAFE'}">카페</c:when>
                                    <c:when test="${st.category == 'FOOD'}">음식점</c:when>
                                    <c:when test="${st.category == 'BEAUTY'}">뷰티</c:when>
                                    <c:when test="${st.category == 'SHOPPING'}">쇼핑</c:when>
                                    <c:when test="${st.category == 'FITNESS'}">피트니스</c:when>
                                    <c:when test="${st.category == 'CONVENIENCE'}">편의점</c:when>
                                    <c:otherwise>${fn:escapeXml(st.category)}</c:otherwise>
                                </c:choose>
                            </span>
                            <h3 class="popular-name">${fn:escapeXml(st.storeName)}</h3>
                            <div class="popular-meta">
                                <span class="shop-rating">★
                                    <fmt:formatNumber value="${st.ratingAvg}" pattern="0.0"/>
                                </span>
                                <span class="popular-used">🎟 ${empty st.usedCount ? 0 : st.usedCount}</span>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="section-empty">
                <c:choose>
                    <c:when test="${not empty category}">해당 카테고리의 인기 가맹점이 없습니다</c:when>
                    <c:otherwise>등록된 가맹점이 없습니다</c:otherwise>
                </c:choose>
            </div>
        </c:otherwise>
    </c:choose>
</section>

<!-- HOT 쿠폰 -->
<section class="main-section">
    <div class="section-header">
        <h2 class="section-title">HOT 쿠폰 🔥</h2>
    </div>

    <c:choose>
        <c:when test="${not empty hotCoupons}">
            <div class="coupon-scroll">
                <c:forEach var="cp" items="${hotCoupons}">
                    <a class="coupon-card" href="/store?storeId=${cp.storeId}#coupon">
                        <div class="coupon-upper">
                            <span class="coupon-shop-name">${fn:escapeXml(cp.storeName)}</span>
                            <p class="coupon-benefit">${fn:escapeXml(cp.benefit)}</p>
                        </div>
                        <div class="coupon-divider"></div>
                        <div class="coupon-lower">
                            <span class="coupon-name">${fn:escapeXml(cp.couponName)}</span>
                            <span class="coupon-expire">~${cp.expireDate}</span>
                            <span class="coupon-remain">
                                <c:choose>
                                    <c:when test="${cp.totalCount == 0}">무제한</c:when>
                                    <c:otherwise>잔여 ${cp.totalCount - cp.issuedCount}개</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="section-empty">등록된 쿠폰이 없습니다</div>
        </c:otherwise>
    </c:choose>
</section>

<!-- 가맹점 목록 -->
<section class="main-section">
    <div class="section-header">
        <h2 class="section-title">
            <c:choose>
                <c:when test="${not empty keyword}">'${fn:escapeXml(keyword)}' 검색 결과</c:when>
                <c:when test="${category == 'CAFE'}">카페</c:when>
                <c:when test="${category == 'FOOD'}">음식점</c:when>
                <c:when test="${category == 'BEAUTY'}">뷰티</c:when>
                <c:when test="${category == 'SHOPPING'}">쇼핑</c:when>
                <c:when test="${category == 'FITNESS'}">피트니스</c:when>
                <c:when test="${category == 'CONVENIENCE'}">편의점</c:when>
                <c:otherwise>전체 가맹점</c:otherwise>
            </c:choose>
            <span class="section-count">${totalCount}</span>
        </h2>
    </div>

    <c:choose>
        <c:when test="${not empty stores}">
            <div class="shop-grid">
                <c:forEach var="st" items="${stores}">
                    <a class="shop-card" href="/store?storeId=${st.storeId}">
                        <div class="shop-image">
                            <img src="/store/image/${st.storeId}" alt="${fn:escapeXml(st.storeName)}"
                                 onerror="this.style.display='none'">
                            <c:if test="${not empty st.emoji}">
                                <span class="shop-emoji">${st.emoji}</span>
                            </c:if>
                        </div>
                        <div class="shop-info">
                            <span class="shop-tag">
                                <c:choose>
                                    <c:when test="${st.category == 'CAFE'}">카페</c:when>
                                    <c:when test="${st.category == 'FOOD'}">음식점</c:when>
                                    <c:when test="${st.category == 'BEAUTY'}">뷰티</c:when>
                                    <c:when test="${st.category == 'SHOPPING'}">쇼핑</c:when>
                                    <c:when test="${st.category == 'FITNESS'}">피트니스</c:when>
                                    <c:when test="${st.category == 'CONVENIENCE'}">편의점</c:when>
                                    <c:otherwise>${fn:escapeXml(st.category)}</c:otherwise>
                                </c:choose>
                            </span>
                            <h3 class="shop-name">${fn:escapeXml(st.storeName)}</h3>
                            <div class="shop-meta">
                                <span class="shop-rating">★
                                    <fmt:formatNumber value="${st.ratingAvg}" pattern="0.0"/>
                                </span>
                                <span class="shop-review">리뷰 ${empty st.reviewCount ? 0 : st.reviewCount}</span>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>

            <c:if test="${totalPages > 1}">
                <c:set var="pageBaseQs" value=""/>
                <c:if test="${empty sessionScope.LOGIN_USER and not empty regionId}">
                    <c:set var="pageBaseQs" value="${pageBaseQs}&regionId=${regionId}"/>
                </c:if>
                <c:if test="${not empty category}">
                    <c:set var="pageBaseQs" value="${pageBaseQs}&category=${fn:escapeXml(category)}"/>
                </c:if>
                <c:if test="${not empty keyword}">
                    <c:set var="pageBaseQs" value="${pageBaseQs}&keyword=${fn:escapeXml(keyword)}"/>
                </c:if>

                <div class="pagination">
                    <c:choose>
                        <c:when test="${currentPage > 1}">
                            <a class="page-link" href="/main?page=${currentPage - 1}${pageBaseQs}">‹</a>
                        </c:when>
                        <c:otherwise>
                            <span class="page-link disabled">‹</span>
                        </c:otherwise>
                    </c:choose>

                    <c:set var="windowStart" value="${currentPage - 2}"/>
                    <c:if test="${windowStart < 1}"><c:set var="windowStart" value="1"/></c:if>
                    <c:set var="windowEnd" value="${windowStart + 4}"/>
                    <c:if test="${windowEnd > totalPages}"><c:set var="windowEnd" value="${totalPages}"/></c:if>
                    <c:if test="${windowEnd - windowStart < 4}">
                        <c:set var="windowStart" value="${windowEnd - 4}"/>
                        <c:if test="${windowStart < 1}"><c:set var="windowStart" value="1"/></c:if>
                    </c:if>

                    <c:forEach var="p" begin="${windowStart}" end="${windowEnd}">
                        <c:choose>
                            <c:when test="${p == currentPage}">
                                <span class="page-link active">${p}</span>
                            </c:when>
                            <c:otherwise>
                                <a class="page-link" href="/main?page=${p}${pageBaseQs}">${p}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:choose>
                        <c:when test="${currentPage < totalPages}">
                            <a class="page-link" href="/main?page=${currentPage + 1}${pageBaseQs}">›</a>
                        </c:when>
                        <c:otherwise>
                            <span class="page-link disabled">›</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </c:when>
        <c:otherwise>
            <div class="section-empty">
                <c:choose>
                    <c:when test="${not empty keyword}">'${fn:escapeXml(keyword)}' 검색 결과가 없습니다</c:when>
                    <c:when test="${not empty category}">해당 카테고리의 가맹점이 없습니다</c:when>
                    <c:otherwise>등록된 가맹점이 없습니다</c:otherwise>
                </c:choose>
            </div>
        </c:otherwise>
    </c:choose>
</section>
