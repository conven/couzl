<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/_meta.jsp" %>
    <title>아이디 찾기 - Couzl</title>
    <link rel="stylesheet" href="/static/css/find-account.css">
</head>
<body>
<div class="wrap">

    <!-- 페이지 헤더 -->
    <div class="page-header">
        <button class="btn-back" onclick="goTo('/login')">‹</button>
        <span class="page-title">아이디 찾기</span>
    </div>

    <!-- 입력 폼 -->
    <div class="form-section">

        <!-- 이메일 + 인증번호 발송 -->
        <div class="form-group">
            <label for="email">이메일</label>
            <div class="input-wrap">
                <input type="email" id="email" class="input-field" placeholder="가입 시 등록한 이메일 입력">
                <button type="button" class="btn-verify" onclick="sendVerifyCode()">인증번호 발송</button>
            </div>
        </div>

        <!-- 인증번호 확인 -->
        <div class="form-group">
            <label for="verifyCode">인증번호</label>
            <div class="verify-row">
                <input type="text" id="verifyCode" class="input-field" placeholder="인증번호 입력">
                <button type="button" class="btn-confirm" onclick="confirmVerifyCode()">확인</button>
            </div>
        </div>

        <!-- 결과 영역 -->
        <div id="resultArea" class="result-area">
            회원님의 아이디는 <strong>cou***l</strong> 입니다.
        </div>

    </div>

    <!-- 하단 버튼 -->
    <div class="btn-actions">
        <button type="button" class="btn-primary" onclick="goTo('/login')">로그인하기</button>
        <button type="button" class="btn-secondary" onclick="goTo('/find-pw')">비밀번호 찾기</button>
    </div>

</div>
<script src="/static/js/common.js"></script>
<script src="/static/js/find-account.js"></script>
<jsp:include page="/WEB-INF/views/common/_tab_bar.jsp"/>
</body>
</html>
