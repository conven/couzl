<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="카테고리 관리"/>
    </jsp:include>
    <style>
        .cat-modal-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background-color: rgba(15, 23, 42, 0.5);
            z-index: 200;
            align-items: center;
            justify-content: center;
        }
        .cat-modal-overlay.is-open {
            display: flex;
        }
        .cat-modal {
            width: 100%;
            max-width: 460px;
            background-color: var(--admin-surface);
            border-radius: var(--admin-radius);
            box-shadow: var(--admin-shadow-md);
            padding: 24px;
        }
        .cat-modal-title {
            margin: 0 0 18px;
            font-size: 16px;
            font-weight: 700;
        }
        .cat-row-inactive { opacity: 0.55; }
        .cat-icon-cell { font-size: 20px; }
    </style>
</head>
<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/common/_admin_sidebar.jsp"/>

    <div class="admin-main">

        <jsp:include page="/WEB-INF/views/admin/common/_admin_header.jsp">
            <jsp:param name="title" value="카테고리 관리"/>
        </jsp:include>

        <div class="admin-content">

            <c:if test="${param.msg == 'created'}">
                <div class="admin-form-success" style="margin-bottom:16px;">카테고리가 추가되었습니다</div>
            </c:if>
            <c:if test="${param.msg == 'updated'}">
                <div class="admin-form-success" style="margin-bottom:16px;">변경되었습니다</div>
            </c:if>
            <c:if test="${param.msg == 'error'}">
                <div class="admin-form-error" style="margin-bottom:16px;">
                    <c:choose>
                        <c:when test="${not empty param.reason}">${fn:escapeXml(param.reason)}</c:when>
                        <c:otherwise>처리 중 오류가 발생했습니다</c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <!-- 신규 등록 -->
            <div class="admin-card">
                <div class="admin-card-header">
                    <h2 class="admin-card-title">카테고리 추가</h2>
                </div>

                <form method="post" action="/admin/categories/new">
                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">코드 <span style="color:var(--admin-danger);">*</span></label>
                            <input type="text" name="code" class="admin-input" required
                                   placeholder="예: PET" maxlength="20"
                                   style="text-transform:uppercase;">
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">이름 <span style="color:var(--admin-danger);">*</span></label>
                            <input type="text" name="name" class="admin-input" required maxlength="50" placeholder="예: 반려동물">
                        </div>
                    </div>
                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">아이콘 (이모지)</label>
                            <input type="text" name="icon" class="admin-input" maxlength="4" placeholder="🐶">
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">정렬 순서</label>
                            <input type="number" name="sortOrder" class="admin-input" value="0">
                        </div>
                    </div>
                    <div class="admin-form-actions">
                        <button type="submit" class="btn-admin-primary">+ 카테고리 추가</button>
                    </div>
                </form>
            </div>

            <!-- 목록 -->
            <div class="admin-card">
                <div class="admin-card-header">
                    <h2 class="admin-card-title">카테고리 목록 (${categories.size()}개)</h2>
                </div>

                <div class="admin-table-wrap">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th style="width:50px;">순서</th>
                                <th style="width:60px;">아이콘</th>
                                <th>코드</th>
                                <th>이름</th>
                                <th style="width:90px;">사용 가맹점</th>
                                <th style="width:90px;">상태</th>
                                <th style="width:180px;">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty categories}">
                                    <tr><td colspan="7" class="admin-empty">카테고리가 없습니다</td></tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="cat" items="${categories}">
                                        <tr class="${cat.isActive == 0 ? 'cat-row-inactive' : ''}">
                                            <td>${cat.sortOrder}</td>
                                            <td class="cat-icon-cell">${cat.icon}</td>
                                            <td><code>${fn:escapeXml(cat.code)}</code></td>
                                            <td><strong>${fn:escapeXml(cat.name)}</strong></td>
                                            <td>${cat.storeCount}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${cat.isActive == 1}">
                                                        <span class="badge-status badge-status-active">활성</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge-status badge-status-withdrawn">비활성</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <button type="button"
                                                        class="btn-admin-secondary btn-admin-sm"
                                                        onclick="openEdit(${cat.categoryId}, '${fn:escapeXml(cat.code)}', '${fn:escapeXml(cat.name)}', '${fn:escapeXml(cat.icon)}', ${cat.sortOrder}, ${cat.isActive})">
                                                    수정
                                                </button>
                                                <form method="post"
                                                      action="/admin/categories/${cat.categoryId}/toggle"
                                                      style="display:inline;"
                                                      onsubmit="return confirm('${cat.isActive == 1 ? '비활성화' : '활성화'}하시겠습니까?');">
                                                    <button type="submit"
                                                            class="${cat.isActive == 1 ? 'btn-admin-secondary' : 'btn-admin-success'} btn-admin-sm">
                                                        ${cat.isActive == 1 ? '비활성화' : '활성화'}
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <p style="margin-top:12px; font-size:12px; color:var(--admin-text-secondary);">
                    ※ 가맹점이 사용 중인 카테고리는 비활성화할 수 없습니다.
                </p>
            </div>

        </div>
    </div>
</div>

<!-- 수정 모달 -->
<div id="editModal" class="cat-modal-overlay" onclick="closeEdit(event)">
    <div class="cat-modal" onclick="event.stopPropagation();">
        <h3 class="cat-modal-title">카테고리 수정</h3>
        <form id="editForm" method="post">
            <div class="admin-form-row">
                <div class="admin-form-group">
                    <label class="admin-label">코드 <span style="color:var(--admin-danger);">*</span></label>
                    <input type="text" name="code" id="editCode" class="admin-input" required maxlength="20" style="text-transform:uppercase;">
                </div>
                <div class="admin-form-group">
                    <label class="admin-label">이름 <span style="color:var(--admin-danger);">*</span></label>
                    <input type="text" name="name" id="editName" class="admin-input" required maxlength="50">
                </div>
            </div>
            <div class="admin-form-row">
                <div class="admin-form-group">
                    <label class="admin-label">아이콘</label>
                    <input type="text" name="icon" id="editIcon" class="admin-input" maxlength="4">
                </div>
                <div class="admin-form-group">
                    <label class="admin-label">정렬 순서</label>
                    <input type="number" name="sortOrder" id="editSortOrder" class="admin-input">
                </div>
            </div>
            <div class="admin-form-group">
                <label class="admin-label">활성 상태</label>
                <select name="isActive" id="editIsActive" class="admin-select">
                    <option value="1">활성</option>
                    <option value="0">비활성</option>
                </select>
            </div>
            <div class="admin-form-actions">
                <button type="button" class="btn-admin-secondary" onclick="closeEdit()">취소</button>
                <button type="submit" class="btn-admin-primary">저장</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openEdit(id, code, name, icon, sortOrder, isActive) {
        document.getElementById('editForm').action = '/admin/categories/' + id;
        document.getElementById('editCode').value = code;
        document.getElementById('editName').value = name;
        document.getElementById('editIcon').value = icon || '';
        document.getElementById('editSortOrder').value = sortOrder;
        document.getElementById('editIsActive').value = isActive;
        document.getElementById('editModal').classList.add('is-open');
    }
    function closeEdit(event) {
        if (event && event.target !== event.currentTarget) return;
        document.getElementById('editModal').classList.remove('is-open');
    }
</script>

</body>
</html>
