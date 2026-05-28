<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 - Couzl</title>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <link rel="stylesheet" href="/static/css/common.css">
    <link rel="stylesheet" href="/static/css/login.css">
</head>
<body>
<div class="wrap">

    <!-- 로고 영역 -->
    <div class="login-logo">
        <jsp:include page="/WEB-INF/views/common/_logo.jsp">
            <jsp:param name="bgColor"    value="#FFD60A"/>
            <jsp:param name="inkColor"   value="white"/>
            <jsp:param name="notchColor" value="white"/>
        </jsp:include>
        <h1 class="logo-title">Couzl</h1>
        <p class="logo-sub">로그인하고 혜택을 받아보세요</p>
    </div>

    <!-- 입력 폼 -->
    <div class="login-form">
        <input type="text" id="username" class="input-field" placeholder="아이디" value="couzl">
        <input type="password" id="password" class="input-field" placeholder="비밀번호" value="couzl">
        <button type="button" class="btn-login" onclick="doLogin()">로그인</button>
    </div>

    <!-- 하단 링크 -->
    <div class="login-links">
        <span>아이디 찾기</span>
        <span class="divider">·</span>
        <span>비밀번호 찾기</span>
        <span class="divider">·</span>
        <span>회원가입</span>
    </div>

    <!-- 소셜 로그인 -->
    <div class="social-section">
        <div class="social-divider">
            <span>간편 로그인</span>
        </div>
        <button type="button" class="btn-social btn-kakao" onclick="showAlert('준비 중입니다')">
            카카오 로그인
        </button>
        <button type="button" class="btn-social btn-apple" onclick="showAlert('준비 중입니다')">
            Apple로 로그인
        </button>
    </div>

</div>
<script src="/static/js/common.js"></script>
<script src="/static/js/login.js"></script>
</body>
</html>
