<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/_meta.jsp" %>
    <title>로그인 - Couzl</title>
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

    <!-- 비인가 접근 메시지 -->
    <c:if test="${param.msg == 'unauthorized'}">
        <p class="login-error-msg login-unauthorized-msg">정상적인 접근이 아닙니다. 로그인 후 이용해주세요</p>
    </c:if>

    <!-- 회원가입 완료 메시지 -->
    <c:if test="${param.msg == 'registered'}">
        <p class="login-error-msg" style="color:#1ec773;background:#e8fbf2;">회원가입이 완료되었습니다. 로그인해주세요!</p>
    </c:if>

    <!-- 에러 메시지 -->
    <% if (request.getAttribute("errorMsg") != null) { %>
    <p class="login-error-msg"><%= request.getAttribute("errorMsg") %></p>
    <% } %>

    <!-- 입력 폼 -->
    <form class="login-form" action="/login" method="POST">
        <input type="text"     name="loginId"  class="input-field ${not empty errorMsg ? 'error' : ''}" placeholder="아이디">
        <input type="password" name="password" class="input-field ${not empty errorMsg ? 'error' : ''}" placeholder="비밀번호">
        <button type="submit" class="btn-login">로그인</button>
    </form>

    <!-- 하단 링크 -->
    <div class="login-links">
        <span onclick="goTo('/find-id')" style="cursor:pointer;">아이디 찾기</span>
        <span class="divider">·</span>
        <span onclick="goTo('/find-pw')" style="cursor:pointer;">비밀번호 찾기</span>
        <span class="divider">·</span>
        <span onclick="goTo('/register')" style="cursor:pointer;">회원가입</span>
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
</body>
</html>
