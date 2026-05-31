<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/_meta.jsp" %>
    <title>프로필 수정 - Couzl</title>
    <link rel="stylesheet" href="/static/css/profile-edit.css">
</head>
<body>
<div class="wrap">

    <!-- 상단 헤더 -->
    <div class="pe-header">
        <button class="btn-back" onclick="goTo('/mypage')">‹</button>
        <span class="page-title">프로필 수정</span>
        <span></span>
    </div>

    <form id="profileForm" action="/profile-edit" method="post" enctype="multipart/form-data">

        <!-- 프로필 이미지 -->
        <div class="pe-profile-img-section">
            <div class="pe-profile-avatar" id="avatarPreview">
                <c:choose>
                    <c:when test="${not empty profileImageBase64}">
                        <img src="data:image/jpeg;base64,${profileImageBase64}" alt="프로필 이미지">
                    </c:when>
                    <c:otherwise>
                        <span class="avatar-initial">${fn:substring(user.nickname, 0, 1)}</span>
                    </c:otherwise>
                </c:choose>
            </div>
            <input type="file" id="profileImageInput" name="profileImage" accept="image/*" style="display:none">
            <button type="button" class="btn-photo-change" onclick="document.getElementById('profileImageInput').click()">사진 변경</button>
        </div>

        <!-- 오류 메시지 -->
        <c:if test="${not empty errorMsg}">
            <div class="pe-error-msg">${errorMsg}</div>
        </c:if>

        <!-- 입력 폼 -->
        <div class="form-section">

            <!-- 닉네임 -->
            <div class="form-group">
                <label for="nickname">닉네임</label>
                <input type="text" id="nickname" name="nickname" class="input-field"
                       value="${fn:escapeXml(user.nickname)}" maxlength="10">
                <span class="field-hint">2~10자 이내로 입력해주세요</span>
            </div>

            <!-- 이메일 (변경 불가) -->
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" class="input-field"
                       value="${fn:escapeXml(user.email)}" disabled>
                <span class="field-hint muted">이메일은 변경할 수 없습니다</span>
            </div>

            <!-- 아이디 (변경 불가) -->
            <div class="form-group">
                <label for="loginId">아이디</label>
                <input type="text" id="loginId" class="input-field"
                       value="${fn:escapeXml(user.loginId)}" disabled>
                <span class="field-hint muted">아이디는 변경할 수 없습니다</span>
            </div>

        </div>

        <!-- 저장 버튼 -->
        <div class="btn-actions">
            <button type="submit" class="btn-primary">저장하기</button>
        </div>

    </form>

</div>
<script src="/static/js/common.js"></script>
<script>
    document.getElementById('profileImageInput').addEventListener('change', function () {
        var file = this.files[0];
        if (!file) return;
        if (file.size > 10 * 1024 * 1024) {
            alert('10MB 이하 파일만 업로드 가능합니다');
            this.value = '';
            return;
        }
        var reader = new FileReader();
        reader.onload = function (e) {
            document.getElementById('avatarPreview').innerHTML =
                '<img src="' + e.target.result + '" alt="프로필 이미지">';
        };
        reader.readAsDataURL(file);
    });
</script>
</body>
</html>
