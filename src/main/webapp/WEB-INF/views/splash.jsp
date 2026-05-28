<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Couzl</title>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <link rel="stylesheet" href="/static/css/common.css">
    <link rel="stylesheet" href="/static/css/splash.css">
</head>
<body>
<div class="wrap">
    <div class="splash-content">
        <div class="splash-logo">
            <jsp:include page="/WEB-INF/views/common/_logo.jsp">
                <jsp:param name="bgColor"    value="white"/>
                <jsp:param name="inkColor"   value="#FFD60A"/>
                <jsp:param name="notchColor" value="#FFD60A"/>
            </jsp:include>
            <h1 class="logo-title">Couzl</h1>
            <p class="logo-sub">쿠즐</p>
            <div class="logo-divider"></div>
            <div class="loading-dots">
                <span></span><span></span><span></span>
            </div>
        </div>
    </div>
    <div class="splash-footer">
        <p class="footer-tagline">즐거움을 나누는 로컬 쿠폰 플랫폼</p>
        <p class="footer-version">v0.0.2</p>
    </div>
</div>
<script src="/static/js/common.js"></script>
<script src="/static/js/splash.js"></script>
</body>
</html>
