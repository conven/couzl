<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="리뷰 상세"/>
    </jsp:include>
    <style>
        .rv-stars-lg { color: #f59e0b; letter-spacing: 2px; font-size: 26px; }
        .rv-stars-lg .empty { color: #d1d5db; }
        .rv-content-box {
            background-color: var(--admin-bg);
            border: 1px solid var(--admin-border);
            border-radius: var(--admin-radius-sm);
            padding: 16px;
            white-space: pre-wrap;
            line-height: 1.7;
            color: var(--admin-text-primary);
            font-size: 14px;
        }
        .rv-gallery {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
            gap: 12px;
        }
        .rv-gallery button {
            display: block;
            aspect-ratio: 1 / 1;
            border-radius: var(--admin-radius-sm);
            overflow: hidden;
            background-color: var(--admin-bg);
            border: 1px solid var(--admin-border);
            padding: 0;
            cursor: zoom-in;
            transition: transform 0.15s ease, box-shadow 0.15s ease;
        }
        .rv-gallery button:hover {
            transform: translateY(-2px);
            box-shadow: var(--admin-shadow-md);
        }
        .rv-gallery img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }
        .rv-lightbox {
            display: none;
            position: fixed;
            inset: 0;
            background-color: rgba(15, 23, 42, 0.85);
            z-index: 300;
            align-items: center;
            justify-content: center;
            cursor: zoom-out;
        }
        .rv-lightbox.is-open { display: flex; }
        .rv-lightbox img {
            max-width: 92vw;
            max-height: 92vh;
            border-radius: 6px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
        }
    </style>
</head>
<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/common/_admin_sidebar.jsp"/>

    <div class="admin-main">

        <jsp:include page="/WEB-INF/views/admin/common/_admin_header.jsp">
            <jsp:param name="title" value="리뷰 상세"/>
        </jsp:include>

        <div class="admin-content">

            <c:if test="${param.msg == 'restored'}">
                <div class="admin-form-success" style="margin-bottom:16px;">리뷰가 복구되었습니다</div>
            </c:if>
            <c:if test="${param.msg == 'error'}">
                <div class="admin-form-error" style="margin-bottom:16px;">처리 중 오류가 발생했습니다</div>
            </c:if>

            <!-- 리뷰 정보 -->
            <div class="admin-card">
                <div class="admin-card-header">
                    <h2 class="admin-card-title">리뷰 정보</h2>
                    <a href="/admin/reviews" class="btn-admin-secondary btn-admin-sm">목록으로</a>
                </div>

                <table class="admin-info-list">
                    <tbody>
                        <tr>
                            <th>가맹점</th>
                            <td><strong>${fn:escapeXml(review.storeName)}</strong></td>
                        </tr>
                        <tr>
                            <th>작성자</th>
                            <td>
                                ${fn:escapeXml(review.nickname)}
                                <span style="color:var(--admin-text-secondary); margin-left:6px;">(${fn:escapeXml(review.loginId)})</span>
                                <c:if test="${not empty review.userId}">
                                    <a href="/admin/users/${review.userId}" class="btn-admin-secondary btn-admin-sm" style="margin-left:10px;">회원 보기</a>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th>사용 쿠폰</th>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty review.couponName}">${fn:escapeXml(review.couponName)}</c:when>
                                    <c:otherwise><span style="color:var(--admin-text-secondary);">(쿠폰 정보 없음)</span></c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>별점</th>
                            <td>
                                <span class="rv-stars-lg">
                                    <c:forEach begin="1" end="5" var="i">
                                        <c:choose>
                                            <c:when test="${i <= review.rating}">★</c:when>
                                            <c:otherwise><span class="empty">★</span></c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </span>
                                <span style="margin-left:10px; font-size:18px; font-weight:700; color:var(--admin-text-primary);">${review.rating} / 5</span>
                            </td>
                        </tr>
                        <tr>
                            <th>작성일</th>
                            <td>${fn:replace(fn:substring(review.createdAt.toString(), 0, 16), 'T', ' ')}</td>
                        </tr>
                        <tr>
                            <th>현재 상태</th>
                            <td>
                                <c:choose>
                                    <c:when test="${review.status == 'ACTIVE'}">
                                        <span class="badge-status badge-status-active">ACTIVE</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-status badge-status-withdrawn">DELETED</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <div style="margin-top: 16px;">
                    <label class="admin-label">리뷰 내용</label>
                    <div class="rv-content-box">${fn:escapeXml(review.content)}</div>
                </div>
            </div>

            <!-- 첨부 사진 -->
            <div class="admin-card">
                <div class="admin-card-header">
                    <h2 class="admin-card-title">첨부 사진 (${reviewImages.size()}장)</h2>
                </div>

                <c:choose>
                    <c:when test="${empty reviewImages}">
                        <div class="admin-empty">첨부된 사진이 없습니다</div>
                    </c:when>
                    <c:otherwise>
                        <div class="rv-gallery">
                            <c:forEach var="img" items="${reviewImages}">
                                <button type="button" onclick="openLightbox(${img.reviewImageId})">
                                    <img src="/review-image/${img.reviewImageId}" alt="리뷰 사진" loading="lazy">
                                </button>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 관리 -->
            <div class="admin-card">
                <div class="admin-card-header">
                    <h2 class="admin-card-title">관리</h2>
                </div>

                <div style="display:flex; gap:16px; align-items:center; flex-wrap:wrap;">
                    <c:choose>
                        <c:when test="${review.status == 'ACTIVE'}">
                            <span class="badge-status badge-status-lg badge-status-active">ACTIVE</span>
                            <form method="post" action="/admin/reviews/${review.reviewId}/delete"
                                  onsubmit="return confirm('해당 리뷰를 삭제하시겠습니까? 작성자에게 노출되지 않습니다.');">
                                <button type="submit" class="btn-admin-danger">리뷰 삭제</button>
                            </form>
                            <span style="font-size:12px; color:var(--admin-text-secondary);">
                                삭제 시 일반 사용자에게는 노출되지 않습니다. 데이터는 보존됩니다.
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge-status badge-status-lg badge-status-withdrawn">삭제됨</span>
                            <form method="post" action="/admin/reviews/${review.reviewId}/restore"
                                  onsubmit="return confirm('해당 리뷰를 복구하시겠습니까?');">
                                <button type="submit" class="btn-admin-success">복구</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </div>
    </div>
</div>

<div id="lightbox" class="rv-lightbox" onclick="closeLightbox()">
    <img id="lightboxImg" src="" alt="">
</div>

<script>
    function openLightbox(id) {
        document.getElementById('lightboxImg').src = '/review-image/' + id;
        document.getElementById('lightbox').classList.add('is-open');
        document.body.style.overflow = 'hidden';
    }
    function closeLightbox() {
        document.getElementById('lightbox').classList.remove('is-open');
        document.getElementById('lightboxImg').src = '';
        document.body.style.overflow = '';
    }
    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') closeLightbox();
    });
</script>

</body>
</html>
