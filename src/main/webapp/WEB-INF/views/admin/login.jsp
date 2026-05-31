<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="로그인"/>
    </jsp:include>
    <style>
        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
        }
        .admin-login-card {
            width: 100%;
            max-width: 400px;
            background-color: var(--admin-surface);
            border: 1px solid var(--admin-border);
            border-radius: var(--admin-radius);
            box-shadow: var(--admin-shadow-md);
            padding: 36px 32px;
        }
        .admin-login-brand {
            text-align: center;
            margin-bottom: 28px;
        }
        .admin-login-brand-logo {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 56px;
            height: 56px;
            border-radius: 14px;
            background-color: #1e293b;
            color: var(--admin-accent);
            font-weight: 900;
            font-size: 30px;
            margin-bottom: 14px;
        }
        .admin-login-title {
            margin: 0;
            font-size: 20px;
            font-weight: 700;
            color: var(--admin-text-primary);
        }
        .admin-login-title strong {
            color: #0f172a;
            border-bottom: 3px solid var(--admin-accent);
            padding-bottom: 2px;
        }
        .admin-login-sub {
            margin: 6px 0 0;
            font-size: 13px;
            color: var(--admin-text-secondary);
        }
        .admin-login-form .admin-form-group:first-of-type {
            margin-top: 0;
        }
        .admin-login-submit {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<form class="admin-login-card admin-login-form" method="post" action="/admin/login">
    <div class="admin-login-brand">
        <div class="admin-login-brand-logo">C</div>
        <h1 class="admin-login-title">Couzl <strong>BO</strong></h1>
        <p class="admin-login-sub">관리자 로그인</p>
    </div>

    <div class="admin-form-group">
        <label class="admin-label" for="loginId">아이디</label>
        <input type="text" id="loginId" name="loginId" class="admin-input"
               placeholder="아이디 입력" autocomplete="username" required autofocus>
    </div>

    <div class="admin-form-group">
        <label class="admin-label" for="password">비밀번호</label>
        <input type="password" id="password" name="password" class="admin-input"
               placeholder="비밀번호 입력" autocomplete="current-password" required>
    </div>

    <%
        String msg = request.getParameter("msg");
        String errorText = null;
        if ("error".equals(msg)) {
            errorText = "아이디 또는 비밀번호가 올바르지 않습니다";
        } else if ("unauthorized".equals(msg)) {
            errorText = "로그인이 필요합니다";
        } else if ("inactive".equals(msg)) {
            errorText = "비활성화된 계정입니다. 관리자에게 문의하세요";
        }
        if (errorText != null) {
    %>
    <div class="admin-form-error"><%= errorText %></div>
    <% } %>

    <button type="submit" class="btn-admin-primary btn-admin-block admin-login-submit">
        로그인
    </button>
</form>

</body>
</html>
