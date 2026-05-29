<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 변경 - Couzl</title>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <link rel="stylesheet" href="/static/css/common.css">
    <link rel="stylesheet" href="/static/css/find-account.css">
</head>
<body>
<div class="wrap">

    <!-- 헤더 -->
    <div class="page-header">
        <button class="btn-back" onclick="goTo('/mypage')">‹</button>
        <span class="page-title">비밀번호 변경</span>
    </div>

    <!-- 입력 폼 -->
    <div class="form-section">

        <div class="form-group">
            <label for="currentPw">현재 비밀번호</label>
            <input type="password" id="currentPw" class="input-field" placeholder="현재 비밀번호 입력">
        </div>

        <div class="form-group">
            <label for="newPw">새 비밀번호</label>
            <input type="password" id="newPw" class="input-field" placeholder="8자 이상 입력">
        </div>

        <div class="form-group">
            <label for="newPwConfirm">새 비밀번호 확인</label>
            <input type="password" id="newPwConfirm" class="input-field" placeholder="새 비밀번호 재입력"
                   oninput="checkPasswordMatch()">
            <span id="pwMatchMsg" style="font-size:12px; color:#FF3B30; display:none;">
                비밀번호가 일치하지 않습니다
            </span>
        </div>

    </div>

    <div class="btn-actions">
        <button type="button" class="btn-primary" onclick="changePassword()">변경하기</button>
    </div>

</div>
<script src="/static/js/common.js"></script>
<script>
    function checkPasswordMatch() {
        var msg = document.getElementById('pwMatchMsg');
        var match = document.getElementById('newPw').value === document.getElementById('newPwConfirm').value;
        msg.style.display = (document.getElementById('newPwConfirm').value && !match) ? 'block' : 'none';
    }

    function changePassword() {
        var newPw = document.getElementById('newPw').value;
        var newPwConfirm = document.getElementById('newPwConfirm').value;
        if (newPw !== newPwConfirm) {
            document.getElementById('pwMatchMsg').style.display = 'block';
            return;
        }
        alert('비밀번호가 변경되었습니다!');
        goTo('/mypage');
    }
</script>
</body>
</html>
