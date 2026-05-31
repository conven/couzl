<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/_meta.jsp" %>
    <title>비밀번호 찾기 - Couzl</title>
    <link rel="stylesheet" href="/static/css/find-account.css">
</head>
<body>
<div class="wrap">

    <!-- 페이지 헤더 -->
    <div class="page-header">
        <button class="btn-back" onclick="goTo('/login')">‹</button>
        <span class="page-title">비밀번호 찾기</span>
    </div>

    <!-- 입력 폼 -->
    <div class="form-section">

        <!-- 아이디 -->
        <div class="form-group">
            <label for="userId">아이디</label>
            <input type="text" id="userId" class="input-field" placeholder="아이디 입력">
        </div>

        <!-- 이메일 + 인증번호 발송 -->
        <div class="form-group">
            <label for="email">이메일</label>
            <div class="input-wrap">
                <input type="email" id="email" class="input-field" placeholder="가입 시 등록한 이메일 입력">
                <button type="button" class="btn-verify" onclick="sendVerifyCodePw()">인증번호 발송</button>
            </div>
        </div>

        <!-- 인증번호 확인 -->
        <div class="form-group">
            <label for="verifyCode">인증번호</label>
            <div class="verify-row">
                <input type="text" id="verifyCode" class="input-field" placeholder="인증번호 입력">
                <button type="button" class="btn-confirm" onclick="confirmVerifyCodePw()">확인</button>
            </div>
        </div>

        <!-- 새 비밀번호 입력 영역 (인증 후 노출) -->
        <div id="newPwArea" class="new-pw-area">
            <div class="form-group" style="width:100%;">
                <label for="newPassword">새 비밀번호</label>
                <input type="password" id="newPassword" class="input-field" placeholder="새 비밀번호 입력 (8자 이상)">
            </div>
            <div class="form-group" style="width:100%;">
                <label for="confirmPassword">새 비밀번호 확인</label>
                <input type="password" id="confirmPassword" class="input-field" placeholder="새 비밀번호 재입력">
            </div>
        </div>

    </div>

    <!-- 비밀번호 변경하기 버튼 -->
    <div class="btn-actions">
        <button type="button" class="btn-primary" onclick="changePassword()">비밀번호 변경하기</button>
    </div>

</div>
<script src="/static/js/common.js"></script>
<script src="/static/js/find-account.js"></script>
</body>
</html>
