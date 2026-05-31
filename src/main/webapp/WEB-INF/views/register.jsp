<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/_meta.jsp" %>
    <title>회원가입 - Couzl</title>
    <link rel="stylesheet" href="/static/css/register.css">
</head>
<body>
<div class="wrap">

    <!-- 페이지 헤더 (뒤로가기 + 타이틀) -->
    <div class="page-header" style="display:flex;align-items:center;width:100%;padding:16px 0 8px;gap:8px;">
        <button onclick="goTo('/login')" style="background:none;border:none;font-size:20px;cursor:pointer;padding:0;color:var(--color-text);">‹</button>
        <span style="font-size:17px;font-weight:700;color:var(--color-text);">회원가입</span>
    </div>

    <!-- 로고 -->
    <div class="register-logo">
        <jsp:include page="/WEB-INF/views/common/_logo.jsp">
            <jsp:param name="bgColor"    value="#FFD60A"/>
            <jsp:param name="inkColor"   value="white"/>
            <jsp:param name="notchColor" value="white"/>
        </jsp:include>
    </div>

    <!-- 입력 폼 -->
    <div class="register-form">

        <!-- 아이디 -->
        <div class="form-group">
            <label for="userId">아이디</label>
            <div class="input-wrap">
                <input type="text" id="userId" class="input-field" placeholder="영문/숫자 6~20자" oninput="onUserIdChange()">
                <button type="button" class="btn-inline" onclick="checkDuplicate()">중복확인</button>
            </div>
        </div>

        <!-- 비밀번호 -->
        <div class="form-group">
            <label for="password">비밀번호</label>
            <div class="input-wrap">
                <div class="input-pw-wrap">
                    <input type="password" id="password" class="input-field" placeholder="8자 이상" oninput="checkPwMatch()">
                    <button type="button" class="btn-eye" onclick="togglePw('password', this)">👁</button>
                </div>
            </div>
        </div>

        <!-- 비밀번호 확인 -->
        <div class="form-group">
            <label for="passwordConfirm">비밀번호 확인</label>
            <div class="input-wrap">
                <div class="input-pw-wrap">
                    <input type="password" id="passwordConfirm" class="input-field" placeholder="비밀번호 재입력" oninput="checkPwMatch()">
                    <button type="button" class="btn-eye" onclick="togglePw('passwordConfirm', this)">👁</button>
                </div>
            </div>
            <span id="pwMatchError" class="error-text">비밀번호가 일치하지 않습니다</span>
        </div>

        <!-- 닉네임 -->
        <div class="form-group">
            <label for="nickname">닉네임</label>
            <input type="text" id="nickname" class="input-field" placeholder="2~10자">
        </div>

        <!-- 이메일 -->
        <div class="form-group">
            <label for="email">이메일</label>
            <div class="input-wrap">
                <input type="email" id="email" class="input-field" placeholder="이메일 입력">
                <button type="button" class="btn-inline" onclick="sendVerifyCode()">인증번호 발송</button>
            </div>
            <div id="verifyWrap" class="verify-wrap">
                <input type="text" id="verifyCode" class="input-field" placeholder="인증번호 입력">
                <button type="button" class="btn-inline" onclick="confirmVerifyCode()">확인</button>
            </div>
            <div id="verifyTimer" style="display:none;margin-top:6px;font-size:13px;color:#B8A000;font-weight:600;"></div>
        </div>

    </div>

    <!-- 약관 동의 -->
    <div class="terms-section" style="margin-top:16px;">
        <div class="terms-row">
            <div class="terms-row-left">
                <input type="checkbox" id="termAll" class="custom-checkbox" onclick="toggleAllTerms(this)">
                <label for="termAll" class="terms-label bold">전체 동의</label>
            </div>
        </div>
        <div class="terms-divider"></div>
        <div class="terms-row">
            <div class="terms-row-left">
                <input type="checkbox" id="term1" class="custom-checkbox term-item" onchange="syncAllTerms()">
                <label for="term1" class="terms-label">이용약관 동의 <span class="terms-badge">(필수)</span></label>
            </div>
            <span class="terms-link" onclick="goTo('/terms')">보기</span>
        </div>
        <div class="terms-row">
            <div class="terms-row-left">
                <input type="checkbox" id="term2" class="custom-checkbox term-item" onchange="syncAllTerms()">
                <label for="term2" class="terms-label">개인정보 처리방침 동의 <span class="terms-badge">(필수)</span></label>
            </div>
            <span class="terms-link" onclick="goTo('/privacy')">보기</span>
        </div>
        <div class="terms-row">
            <div class="terms-row-left">
                <input type="checkbox" id="term3" class="custom-checkbox term-item" onchange="syncAllTerms()">
                <label for="term3" class="terms-label">마케팅 수신 동의 <span class="terms-badge">(선택)</span></label>
            </div>
        </div>
    </div>

    <!-- 가입하기 버튼 -->
    <button type="button" class="btn-register" onclick="doRegister()">가입하기</button>

</div>
<script src="/static/js/common.js"></script>
<script src="/static/js/register.js"></script>
<%@ include file="/WEB-INF/views/common/_footer.jsp" %>
</body>
</html>
