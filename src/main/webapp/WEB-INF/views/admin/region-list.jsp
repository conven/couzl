<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="지역 관리"/>
    </jsp:include>
    <style>
        .rg-modal-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background-color: rgba(15, 23, 42, 0.5);
            z-index: 200;
            align-items: center;
            justify-content: center;
        }
        .rg-modal-overlay.is-open { display: flex; }
        .rg-modal {
            width: 100%;
            max-width: 420px;
            background-color: var(--admin-surface);
            border-radius: var(--admin-radius);
            box-shadow: var(--admin-shadow-md);
            padding: 24px;
        }
        .rg-modal-title {
            margin: 0 0 18px;
            font-size: 16px;
            font-weight: 700;
        }
        .rg-actions { display:flex; gap:6px; flex-wrap:wrap; }
        .rg-actions form { margin: 0; }
        .rg-row-inactive { opacity: 0.6; }
    </style>
</head>
<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/common/_admin_sidebar.jsp"/>

    <div class="admin-main">

        <jsp:include page="/WEB-INF/views/admin/common/_admin_header.jsp">
            <jsp:param name="title" value="지역 관리"/>
        </jsp:include>

        <div class="admin-content">

            <c:if test="${param.msg == 'created'}">
                <div class="admin-form-success" style="margin-bottom:16px;">지역이 등록되었습니다</div>
            </c:if>
            <c:if test="${param.msg == 'updated'}">
                <div class="admin-form-success" style="margin-bottom:16px;">수정되었습니다</div>
            </c:if>
            <c:if test="${param.msg == 'duplicate'}">
                <div class="admin-form-warning" style="margin-bottom:16px;">이미 존재하는 지역명입니다</div>
            </c:if>
            <c:if test="${param.msg == 'has-stores'}">
                <div class="admin-form-warning" style="margin-bottom:16px;">해당 지역에 가맹점이 존재합니다. 가맹점을 먼저 처리해주세요</div>
            </c:if>
            <c:if test="${param.msg == 'error'}">
                <div class="admin-form-error" style="margin-bottom:16px;">처리 중 오류가 발생했습니다</div>
            </c:if>

            <div class="admin-card">

                <div class="admin-card-header">
                    <h2 class="admin-card-title">검색</h2>
                    <button type="button" class="btn-admin-primary btn-admin-sm" onclick="openRegisterModal()">+ 지역 등록</button>
                </div>

                <form method="get" action="/admin/regions" class="admin-filter">
                    <input type="text"
                           name="keyword"
                           class="admin-input admin-filter-search"
                           placeholder="지역명 검색"
                           value="${fn:escapeXml(keyword)}">

                    <select name="isActive" class="admin-select">
                        <option value=""  ${empty isActive ? 'selected' : ''}>전체</option>
                        <option value="1" ${isActive == 1 ? 'selected' : ''}>활성</option>
                        <option value="0" ${isActive == 0 ? 'selected' : ''}>비활성</option>
                    </select>

                    <button type="submit" class="btn-admin-primary">검색</button>
                </form>

                <p style="margin: 12px 0 16px; font-size: 13px; color: var(--admin-text-secondary);">
                    총 <strong style="color: var(--admin-text-primary);">${regions.size()}</strong>개
                </p>

                <div class="admin-table-wrap">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th style="width:60px;">No</th>
                                <th>지역명</th>
                                <th style="width:120px;">가맹점 수</th>
                                <th style="width:120px;">회원 수</th>
                                <th style="width:90px;">활성여부</th>
                                <th style="width:120px;">등록일</th>
                                <th style="width:200px;">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty regions}">
                                    <tr><td colspan="7" class="admin-empty">조회된 지역이 없습니다</td></tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="r" items="${regions}" varStatus="loop">
                                        <tr class="${r.isActive == 0 ? 'rg-row-inactive' : ''}">
                                            <td>${loop.index + 1}</td>
                                            <td><strong>${fn:escapeXml(r.regionName)}</strong></td>
                                            <td>${r.storeCount}</td>
                                            <td>${r.userCount}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${r.isActive == 1}">
                                                        <span class="badge-status badge-status-active">활성</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge-status badge-status-withdrawn">비활성</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${fn:substring(r.createdAt.toString(), 0, 10)}</td>
                                            <td>
                                                <div class="rg-actions">
                                                    <button type="button"
                                                            class="btn-admin-secondary btn-admin-sm"
                                                            onclick="openEditModal(${r.regionId}, '${fn:escapeXml(r.regionName)}')">
                                                        수정
                                                    </button>
                                                    <c:choose>
                                                        <c:when test="${r.isActive == 1}">
                                                            <form method="post" action="/admin/regions/${r.regionId}/active"
                                                                  onsubmit="return confirm('해당 지역을 비활성화하면 앱에서 선택 불가합니다. 계속하시겠습니까?');">
                                                                <input type="hidden" name="isActive" value="0">
                                                                <button type="submit" class="btn-admin-secondary btn-admin-sm">비활성화</button>
                                                            </form>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <form method="post" action="/admin/regions/${r.regionId}/active"
                                                                  onsubmit="return confirm('해당 지역을 활성화하시겠습니까?');">
                                                                <input type="hidden" name="isActive" value="1">
                                                                <button type="submit" class="btn-admin-success btn-admin-sm">활성화</button>
                                                            </form>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <p style="margin-top:12px; font-size:12px; color:var(--admin-text-secondary);">
                    ※ 활성 가맹점이 있는 지역은 비활성화할 수 없습니다.
                </p>
            </div>

        </div>
    </div>
</div>

<!-- 등록 모달 -->
<div id="registerModal" class="rg-modal-overlay" onclick="closeModal(event, 'registerModal')">
    <div class="rg-modal" onclick="event.stopPropagation();">
        <h3 class="rg-modal-title">지역 등록</h3>
        <form method="post" action="/admin/regions/new">
            <div class="admin-form-group">
                <label class="admin-label">지역명 <span style="color:var(--admin-danger);">*</span></label>
                <input type="text" name="regionName" id="newRegionName" class="admin-input" required maxlength="100" placeholder="예: 강남구">
            </div>
            <div class="admin-form-actions">
                <button type="button" class="btn-admin-secondary" onclick="closeModal(null, 'registerModal')">취소</button>
                <button type="submit" class="btn-admin-primary">등록</button>
            </div>
        </form>
    </div>
</div>

<!-- 수정 모달 -->
<div id="editModal" class="rg-modal-overlay" onclick="closeModal(event, 'editModal')">
    <div class="rg-modal" onclick="event.stopPropagation();">
        <h3 class="rg-modal-title">지역 수정</h3>
        <form id="editForm" method="post">
            <div class="admin-form-group">
                <label class="admin-label">지역명 <span style="color:var(--admin-danger);">*</span></label>
                <input type="text" name="regionName" id="editRegionName" class="admin-input" required maxlength="100">
            </div>
            <div class="admin-form-actions">
                <button type="button" class="btn-admin-secondary" onclick="closeModal(null, 'editModal')">취소</button>
                <button type="submit" class="btn-admin-primary">저장</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openRegisterModal() {
        document.getElementById('newRegionName').value = '';
        document.getElementById('registerModal').classList.add('is-open');
        setTimeout(function(){ document.getElementById('newRegionName').focus(); }, 50);
    }
    function openEditModal(id, name) {
        document.getElementById('editForm').action = '/admin/regions/' + id + '/update';
        document.getElementById('editRegionName').value = name;
        document.getElementById('editModal').classList.add('is-open');
        setTimeout(function(){ document.getElementById('editRegionName').focus(); }, 50);
    }
    function closeModal(event, id) {
        if (event && event.target !== event.currentTarget) return;
        document.getElementById(id).classList.remove('is-open');
    }
    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') {
            document.getElementById('registerModal').classList.remove('is-open');
            document.getElementById('editModal').classList.remove('is-open');
        }
    });
</script>

</body>
</html>
