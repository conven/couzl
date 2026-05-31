<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/_meta.jsp" %>
    <title>회원 탈퇴 - Couzl</title>
    <link rel="stylesheet" href="/static/css/withdraw.css">
</head>
<body>
<div class="wrap">

    <!-- 1. 상단 헤더 -->
    <div class="page-header">
        <button class="btn-back" onclick="goTo('/mypage')">‹</button>
        <span class="page-title">회원 탈퇴</span>
    </div>

    <!-- 2. 경고 아이콘 + 텍스트 -->
    <div class="wd-warning-section">
        <span class="wd-warning-icon">⚠️</span>
        <p class="wd-warning-title">정말 탈퇴하시겠어요?</p>
        <p class="wd-warning-sub">탈퇴 시 아래 정보가 모두 삭제됩니다</p>
    </div>

    <!-- 3. 삭제 정보 카드 -->
    <div class="wd-delete-card">
        <div class="wd-delete-item">
            <span class="wd-delete-item-icon">❌</span>
            <span>보유 쿠폰 전체 삭제</span>
        </div>
        <div class="wd-delete-item">
            <span class="wd-delete-item-icon">❌</span>
            <span>쿠폰 사용 내역 삭제</span>
        </div>
        <div class="wd-delete-item">
            <span class="wd-delete-item-icon">❌</span>
            <span>작성한 리뷰 삭제</span>
        </div>
        <div class="wd-delete-item">
            <span class="wd-delete-item-icon">❌</span>
            <span>회원 정보 삭제</span>
        </div>
        <p class="wd-delete-caution">탈퇴 후 재가입해도 복구되지 않습니다</p>
    </div>

    <!-- 4. 동의 체크박스 -->
    <label class="wd-agree-row">
        <input type="checkbox" id="agreeCheck" onchange="toggleAgree(this)">
        <span class="wd-agree-label">위 내용을 확인했으며 탈퇴에 동의합니다</span>
    </label>

    <!-- 5. 버튼 -->
    <div class="wd-btn-actions">
        <button type="button" id="btnWithdraw" class="btn-withdraw" onclick="doWithdraw()">탈퇴하기</button>
        <button type="button" class="btn-back-outline" onclick="goTo('/mypage')">돌아가기</button>
    </div>

</div>
<script src="/static/js/common.js"></script>
<script src="/static/js/withdraw.js"></script>
</body>
</html>
