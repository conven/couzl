<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="어드민 계정 상세"/>
    </jsp:include>
</head>
<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/common/_admin_sidebar.jsp"/>

    <div class="admin-main">

        <jsp:include page="/WEB-INF/views/admin/common/_admin_header.jsp">
            <jsp:param name="title" value="어드민 계정 상세"/>
        </jsp:include>

        <div class="admin-content">

            <c:if test="${param.msg == 'updated'}">
                <div class="admin-form-success" style="margin-bottom:16px;">수정되었습니다</div>
            </c:if>
            <c:if test="${param.msg == 'pw-updated'}">
                <div class="admin-form-success" style="margin-bottom:16px;">비밀번호가 초기화되었습니다</div>
            </c:if>
            <c:if test="${param.msg == 'pw-mismatch'}">
                <div class="admin-form-warning" style="margin-bottom:16px;">비밀번호가 일치하지 않습니다</div>
            </c:if>
            <c:if test="${param.msg == 'self-deactivate'}">
                <div class="admin-form-warning" style="margin-bottom:16px;">본인 계정은 비활성화할 수 없습니다</div>
            </c:if>
            <c:if test="${param.msg == 'error'}">
                <div class="admin-form-error" style="margin-bottom:16px;">처리 중 오류가 발생했습니다</div>
            </c:if>

            <c:set var="isSelf" value="${LOGIN_ADMIN.adminId == admin.adminId}"/>

            <!-- 기본 정보 -->
            <form method="post" action="/admin/accounts/${admin.adminId}/info" onsubmit="return validateInfo();">
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h2 class="admin-card-title">계정 정보</h2>
                        <div style="display:flex; gap:8px;">
                            <a href="/admin/accounts" class="btn-admin-secondary btn-admin-sm">목록으로</a>
                            <button type="submit" class="btn-admin-primary btn-admin-sm">정보 수정</button>
                        </div>
                    </div>

                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">아이디</label>
                            <input type="text" class="admin-input" readonly value="${fn:escapeXml(admin.loginId)}"
                                   style="background-color:var(--admin-bg);">
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">이름 <span style="color:var(--admin-danger);">*</span></label>
                            <input type="text" name="name" id="name" class="admin-input" required maxlength="50"
                                   value="${fn:escapeXml(admin.name)}">
                        </div>
                    </div>

                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">역할 <span style="color:var(--admin-danger);">*</span></label>
                            <c:choose>
                                <c:when test="${admin.role == 'SUPER_ADMIN'}"><span class="admin-badge badge-super-admin" style="margin-bottom:6px; display:inline-flex;">슈퍼관리자</span></c:when>
                                <c:when test="${admin.role == 'ADMIN'}"><span class="admin-badge badge-admin" style="margin-bottom:6px; display:inline-flex;">일반관리자</span></c:when>
                                <c:when test="${admin.role == 'STORE_OWNER'}"><span class="admin-badge badge-store-owner" style="margin-bottom:6px; display:inline-flex;">가맹점주</span></c:when>
                            </c:choose>
                            <select name="role" id="role" class="admin-select" required onchange="toggleStore()">
                                <option value="SUPER_ADMIN" ${admin.role == 'SUPER_ADMIN' ? 'selected' : ''}>슈퍼관리자 (SUPER_ADMIN)</option>
                                <option value="ADMIN"       ${admin.role == 'ADMIN'       ? 'selected' : ''}>일반관리자 (ADMIN)</option>
                                <option value="STORE_OWNER" ${admin.role == 'STORE_OWNER' ? 'selected' : ''}>가맹점주 (STORE_OWNER)</option>
                            </select>
                        </div>
                        <div class="admin-form-group" id="storeGroup" style="${admin.role == 'STORE_OWNER' ? '' : 'display:none;'}">
                            <label class="admin-label">가맹점 <span style="color:var(--admin-danger);">*</span></label>
                            <select name="storeId" id="storeId" class="admin-select">
                                <option value="">선택</option>
                                <c:forEach var="s" items="${activeStores}">
                                    <option value="${s.storeId}" ${admin.storeId == s.storeId ? 'selected' : ''}>${fn:escapeXml(s.storeName)}<c:if test="${not empty s.regionName}"> (${fn:escapeXml(s.regionName)})</c:if></option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
            </form>

            <!-- 비밀번호 초기화 -->
            <form method="post" action="/admin/accounts/${admin.adminId}/password"
                  onsubmit="return validatePassword();">
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h2 class="admin-card-title">비밀번호 초기화</h2>
                    </div>

                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">새 비밀번호 <span style="color:var(--admin-danger);">*</span></label>
                            <input type="password" name="newPassword" id="newPassword" class="admin-input" required minlength="8" oninput="checkPwMatch()">
                            <p style="margin-top:6px; font-size:12px; color:var(--admin-text-secondary);">8자 이상</p>
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">새 비밀번호 확인 <span style="color:var(--admin-danger);">*</span></label>
                            <input type="password" name="newPasswordConfirm" id="newPasswordConfirm" class="admin-input" required oninput="checkPwMatch()">
                            <p id="pwMatchMsg" style="display:none; margin-top:6px; font-size:12px; color:var(--admin-danger);">비밀번호가 일치하지 않습니다</p>
                        </div>
                    </div>

                    <div class="admin-form-actions">
                        <button type="submit" class="btn-admin-primary">비밀번호 초기화</button>
                    </div>
                </div>
            </form>

            <!-- 계정 상태 -->
            <div class="admin-card">
                <div class="admin-card-header">
                    <h2 class="admin-card-title">계정 상태</h2>
                </div>

                <table class="admin-info-list">
                    <tbody>
                        <tr>
                            <th>현재 상태</th>
                            <td>
                                <c:choose>
                                    <c:when test="${admin.status == 'ACTIVE'}">
                                        <span class="badge-status badge-status-active">ACTIVE</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-status badge-status-withdrawn">INACTIVE</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>마지막 로그인</th>
                            <td>
                                <c:choose>
                                    <c:when test="${empty admin.lastLoginAt}">
                                        <span style="color:var(--admin-text-secondary);">미로그인</span>
                                    </c:when>
                                    <c:otherwise>
                                        ${fn:replace(fn:substring(admin.lastLoginAt.toString(), 0, 16), 'T', ' ')}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>등록일</th>
                            <td>${fn:replace(fn:substring(admin.createdAt.toString(), 0, 16), 'T', ' ')}</td>
                        </tr>
                    </tbody>
                </table>

                <div style="display:flex; gap:12px; align-items:center; flex-wrap:wrap; margin-top:16px;">
                    <c:choose>
                        <c:when test="${isSelf and admin.status == 'ACTIVE'}">
                            <p style="margin:0; color:var(--admin-text-secondary); font-size:13px;">
                                본인 계정은 비활성화할 수 없습니다
                            </p>
                        </c:when>
                        <c:when test="${admin.status == 'ACTIVE'}">
                            <form method="post" action="/admin/accounts/${admin.adminId}/status"
                                  onsubmit="return confirm('해당 계정을 비활성화하시겠습니까?');">
                                <input type="hidden" name="status" value="INACTIVE">
                                <button type="submit" class="btn-admin-secondary">비활성화</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <form method="post" action="/admin/accounts/${admin.adminId}/status"
                                  onsubmit="return confirm('해당 계정을 활성화하시겠습니까?');">
                                <input type="hidden" name="status" value="ACTIVE">
                                <button type="submit" class="btn-admin-success">활성화</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

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
        }
    }

    function checkPwMatch() {
        var pw = document.getElementById('newPassword').value;
        var pwc = document.getElementById('newPasswordConfirm').value;
        var msg = document.getElementById('pwMatchMsg');
        msg.style.display = (pwc && pw !== pwc) ? 'block' : 'none';
    }

    function validateInfo() {
        var name = document.getElementById('name').value.trim();
        if (!name) { alert('이름을 입력하세요'); return false; }
        var role = document.getElementById('role').value;
        if (!role) { alert('역할을 선택하세요'); return false; }
        if (role === 'STORE_OWNER' && !document.getElementById('storeId').value) {
            alert('가맹점을 선택하세요'); return false;
        }
        return true;
    }

    function validatePassword() {
        var pw = document.getElementById('newPassword').value;
        var pwc = document.getElementById('newPasswordConfirm').value;
        if (pw.length < 8) { alert('비밀번호는 8자 이상이어야 합니다'); return false; }
        if (pw !== pwc) { alert('비밀번호가 일치하지 않습니다'); return false; }
        return confirm('비밀번호를 초기화하시겠습니까?');
    }
</script>

</body>
</html>
