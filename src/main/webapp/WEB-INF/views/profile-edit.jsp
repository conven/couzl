<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로필 수정 - Couzl</title>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <link rel="stylesheet" href="/static/css/common.css">
    <link rel="stylesheet" href="/static/css/profile-edit.css">
</head>
<body>
<div class="wrap">

    <!-- 1. 상단 헤더 -->
    <div class="pe-header">
        <button class="btn-back" onclick="goTo('/mypage')">‹</button>
        <span class="page-title">프로필 수정</span>
        <button class="btn-save-top" onclick="saveProfile()">저장</button>
    </div>

    <!-- 2. 프로필 이미지 -->
    <div class="pe-profile-img-section">
        <div class="pe-profile-avatar">👤</div>
        <button class="btn-photo-change" onclick="changePhoto()">사진 변경</button>
    </div>

    <!-- 3. 입력 폼 -->
    <div class="form-section">

        <!-- 닉네임 -->
        <div class="form-group">
            <label for="nickname">닉네임</label>
            <input type="text" id="nickname" class="input-field" value="쿠즐유저">
            <span class="field-hint">2~10자 이내로 입력해주세요</span>
        </div>

        <!-- 이메일 -->
        <div class="form-group">
            <label for="email">이메일</label>
            <div class="input-wrap">
                <input type="email" id="email" class="input-field" value="user@couzl.com">
                <button type="button" class="btn-change" onclick="sendEmailChange()">변경</button>
            </div>
            <div class="verify-row" id="verifyRow">
                <input type="text" id="verifyCode" class="input-field" placeholder="인증번호 입력">
                <button type="button" class="btn-confirm" onclick="confirmEmailChange()">확인</button>
            </div>
        </div>

        <!-- 아이디 -->
        <div class="form-group">
            <label for="userId">아이디</label>
            <input type="text" id="userId" class="input-field" value="couzl" disabled>
            <span class="field-hint muted">아이디는 변경할 수 없습니다</span>
        </div>

    </div>

    <!-- 4. 저장 버튼 -->
    <div class="btn-actions">
        <button type="button" class="btn-primary" onclick="saveProfile()">저장하기</button>
    </div>

</div>
<script src="/static/js/common.js"></script>
<script src="/static/js/profile-edit.js"></script>
</body>
</html>
