<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="어드민 계정 등록"/>
    </jsp:include>
</head>
<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/common/_admin_sidebar.jsp"/>

    <div class="admin-main">

        <jsp:include page="/WEB-INF/views/admin/common/_admin_header.jsp">
            <jsp:param name="title" value="어드민 계정 등록"/>
        </jsp:include>

        <div class="admin-content">

            <c:if test="${param.msg == 'duplicate'}">
                <div class="admin-form-warning" style="margin-bottom:16px;">이미 사용 중인 아이디입니다</div>
            </c:if>
            <c:if test="${param.msg == 'pw-mismatch'}">
                <div class="admin-form-warning" style="margin-bottom:16px;">비밀번호가 일치하지 않습니다</div>
            </c:if>
            <c:if test="${param.msg == 'error'}">
                <div class="admin-form-error" style="margin-bottom:16px;">처리 중 오류가 발생했습니다</div>
            </c:if>

            <form id="accountForm" method="post" action="/admin/accounts/new" onsubmit="return validateForm();">

                <div class="admin-card">
                    <div class="admin-card-header">
                        <h2 class="admin-card-title">계정 정보</h2>
                        <div style="display:flex; gap:8px;">
                            <a href="/admin/accounts" class="btn-admin-secondary btn-admin-sm">취소</a>
                            <button type="submit" class="btn-admin-primary btn-admin-sm">등록</button>
                        </div>
                    </div>

                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">아이디 <span style="color:var(--admin-danger);">*</span></label>
                            <input type="text" name="loginId" id="loginId" class="admin-input"
                                   required minlength="4" maxlength="20" pattern="[A-Za-z0-9]{4,20}">
                            <p style="margin-top:6px; font-size:12px; color:var(--admin-text-secondary);">
                                영문/숫자 4~20자
                            </p>
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">이름 <span style="color:var(--admin-danger);">*</span></label>
                            <input type="text" name="name" id="name" class="admin-input" required maxlength="50">
                        </div>
                    </div>

                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">역할 <span style="color:var(--admin-danger);">*</span></label>
                            <select name="role" id="role" class="admin-select" required onchange="toggleStore()">
                                <option value="">선택</option>
                                <option value="SUPER_ADMIN">슈퍼관리자 (SUPER_ADMIN)</option>
                                <option value="ADMIN">일반관리자 (ADMIN)</option>
                                <option value="STORE_OWNER">가맹점주 (STORE_OWNER)</option>
                            </select>
                        </div>
                        <div class="admin-form-group" id="storeGroup" style="display:none;">
                            <label class="admin-label">가맹점 <span style="color:var(--admin-danger);">*</span></label>
                            <select name="storeId" id="storeId" class="admin-select">
                                <option value="">선택</option>
                                <c:forEach var="s" items="${activeStores}">
                                    <option value="${s.storeId}">${fn:escapeXml(s.storeName)}<c:if test="${not empty s.regionName}"> (${fn:escapeXml(s.regionName)})</c:if></option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">비밀번호 <span style="color:var(--admin-danger);">*</span></label>
                            <input type="password" name="password" id="password" class="admin-input" required minlength="8" oninput="checkPwMatch()">
                            <p style="margin-top:6px; font-size:12px; color:var(--admin-text-secondary);">8자 이상</p>
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">비밀번호 확인 <span style="color:var(--admin-danger);">*</span></label>
                            <input type="password" name="passwordConfirm" id="passwordConfirm" class="admin-input" required oninput="checkPwMatch()">
                            <p id="pwMatchMsg" style="display:none; margin-top:6px; font-size:12px; color:var(--admin-danger);">비밀번호가 일치하지 않습니다</p>
                        </div>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>

<script>
    function toggleStore() {
        var role = document.getElementById('role').value;
        var grp = document.getElementById('storeGroup');
        var sel = document.getElementById('storeId');
        if (role === 'STORE_OWNER') {
            grp.style.display = '';
            sel.required = true;
        } else {
            grp.style.display = 'none';
            sel.required = false;
            sel.value = '';
        }
    }

    function checkPwMatch() {
        var pw = document.getElementById('password').value;
        var pwc = document.getElementById('passwordConfirm').value;
        var msg = document.getElementById('pwMatchMsg');
        msg.style.display = (pwc && pw !== pwc) ? 'block' : 'none';
    }

    function validateForm() {
        var f = document.getElementById('accountForm');
        if (!f.loginId.value.trim()) { alert('아이디를 입력하세요'); return false; }
        if (!/^[A-Za-z0-9]{4,20}$/.test(f.loginId.value)) {
            alert('아이디는 영문/숫자 4~20자여야 합니다');
            return false;
        }
        if (!f.name.value.trim())   { alert('이름을 입력하세요'); return false; }
        if (!f.role.value)          { alert('역할을 선택하세요'); return false; }
        if (f.role.value === 'STORE_OWNER' && !f.storeId.value) {
            alert('가맹점을 선택하세요'); return false;
        }
        if (f.password.value.length < 8) { alert('비밀번호는 8자 이상이어야 합니다'); return false; }
        if (f.password.value !== f.passwordConfirm.value) {
            alert('비밀번호가 일치하지 않습니다'); return false;
        }
        return true;
    }
</script>

</body>
</html>
