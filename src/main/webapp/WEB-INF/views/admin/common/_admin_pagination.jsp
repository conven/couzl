<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  공통 페이지네이션
  사용 측에서 아래 변수를 미리 set 해야 함:
    - currentPage  : 현재 페이지 (1-based)
    - totalPages   : 전체 페이지 수
    - baseUrl      : 페이지 파라미터 제외한 기본 URL (c:url로 생성, 끝에 page만 붙이면 됨)

  표시 정책:
    현재 페이지 좌우 ±2개씩 윈도우 (최대 5개 번호)
    윈도우 바깥쪽에 1·마지막 페이지 + … 점프 표시
    « ‹ [번호들] › »  (첫/이전/다음/마지막 버튼)
--%>
<c:if test="${totalPages > 1}">
    <c:set var="windowStart" value="${currentPage - 2 < 1 ? 1 : currentPage - 2}"/>
    <c:set var="windowEnd"   value="${currentPage + 2 > totalPages ? totalPages : currentPage + 2}"/>

    <nav class="admin-pagination">

        <c:choose>
            <c:when test="${currentPage > 1}">
                <a href="${baseUrl}&page=1" title="첫 페이지">«</a>
                <a href="${baseUrl}&page=${currentPage - 1}" title="이전">‹</a>
            </c:when>
            <c:otherwise>
                <span class="is-disabled">«</span>
                <span class="is-disabled">‹</span>
            </c:otherwise>
        </c:choose>

        <c:if test="${windowStart > 1}">
            <a href="${baseUrl}&page=1">1</a>
            <c:if test="${windowStart > 2}">
                <span class="is-ellipsis">…</span>
            </c:if>
        </c:if>

        <c:forEach var="p" begin="${windowStart}" end="${windowEnd}">
            <c:choose>
                <c:when test="${p == currentPage}">
                    <span class="is-active">${p}</span>
                </c:when>
                <c:otherwise>
                    <a href="${baseUrl}&page=${p}">${p}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${windowEnd < totalPages}">
            <c:if test="${windowEnd < totalPages - 1}">
                <span class="is-ellipsis">…</span>
            </c:if>
            <a href="${baseUrl}&page=${totalPages}">${totalPages}</a>
        </c:if>

        <c:choose>
            <c:when test="${currentPage < totalPages}">
                <a href="${baseUrl}&page=${currentPage + 1}" title="다음">›</a>
                <a href="${baseUrl}&page=${totalPages}" title="마지막 페이지">»</a>
            </c:when>
            <c:otherwise>
                <span class="is-disabled">›</span>
                <span class="is-disabled">»</span>
            </c:otherwise>
        </c:choose>

    </nav>
</c:if>
