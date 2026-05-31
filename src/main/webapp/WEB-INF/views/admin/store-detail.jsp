<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="가맹점 상세"/>
    </jsp:include>
    <style>
        .sd-image-section {
            display: flex;
            gap: 20px;
            align-items: flex-start;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }
        .sd-image-current {
            width: 200px;
            height: 200px;
            border-radius: var(--admin-radius);
            overflow: hidden;
            background-color: var(--admin-bg);
            border: 1px solid var(--admin-border);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--admin-text-secondary);
            font-size: 48px;
        }
        .sd-image-current img { width: 100%; height: 100%; object-fit: cover; }
        .sd-status-card {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            flex-wrap: wrap;
        }
    </style>
</head>
<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/common/_admin_sidebar.jsp"/>

    <div class="admin-main">

        <jsp:include page="/WEB-INF/views/admin/common/_admin_header.jsp">
            <jsp:param name="title" value="가맹점 상세"/>
        </jsp:include>

        <div class="admin-content">

            <c:if test="${param.msg == 'updated'}">
                <div class="admin-form-success" style="margin-bottom:16px;">수정되었습니다</div>
            </c:if>
            <c:if test="${param.msg == 'error'}">
                <div class="admin-form-error" style="margin-bottom:16px;">처리 중 오류가 발생했습니다</div>
            </c:if>

            <form id="storeForm" method="post" action="/admin/stores/${store.storeId}" enctype="multipart/form-data" onsubmit="return validateForm();">

                <!-- 기본정보 (수정 가능) -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h2 class="admin-card-title">기본 정보</h2>
                        <div style="display:flex; gap:8px;">
                            <a href="/admin/stores" class="btn-admin-secondary btn-admin-sm">목록으로</a>
                            <button type="submit" class="btn-admin-primary btn-admin-sm">수정 저장</button>
                        </div>
                    </div>

                    <div class="sd-image-section">
                        <div class="sd-image-current" id="imagePreview">
                            <c:choose>
                                <c:when test="${not empty store.emoji or store.storeId != null}">
                                    <img src="/admin/stores/${store.storeId}/image" alt="가맹점 이미지"
                                         onerror="this.parentNode.innerHTML='${not empty store.emoji ? store.emoji : '🏪'}';">
                                </c:when>
                                <c:otherwise>🏪</c:otherwise>
                            </c:choose>
                        </div>
                        <div style="flex:1; min-width:200px;">
                            <label class="admin-label">이미지 변경</label>
                            <input type="file" name="image" id="image" accept="image/*" onchange="previewImage(this)">
                            <p style="margin-top:10px; font-size:12px; color:var(--admin-text-secondary);">
                                권장: 500×500px / JPG, PNG / 최대 5MB
                            </p>
                        </div>
                    </div>

                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">가맹점명 <span style="color:var(--admin-danger);">*</span></label>
                            <input type="text" name="storeName" class="admin-input" required value="${fn:escapeXml(store.storeName)}">
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">카테고리 <span style="color:var(--admin-danger);">*</span></label>
                            <select name="categoryId" class="admin-select" required>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.categoryId}" ${store.categoryId == cat.categoryId ? 'selected' : ''}>${fn:escapeXml(cat.name)}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">지역 <span style="color:var(--admin-danger);">*</span></label>
                            <select name="regionId" class="admin-select" required>
                                <c:forEach var="r" items="${regions}">
                                    <option value="${r.regionId}" ${store.regionId == r.regionId ? 'selected' : ''}>${fn:escapeXml(r.regionName)}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">대표 이모지</label>
                            <input type="text" name="emoji" class="admin-input" maxlength="4" value="${fn:escapeXml(store.emoji)}">
                        </div>
                    </div>

                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">연락처</label>
                            <input type="text" name="phone" class="admin-input" value="${fn:escapeXml(store.phone)}">
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">영업시간</label>
                            <input type="text" name="businessHours" class="admin-input" value="${fn:escapeXml(store.businessHours)}">
                        </div>
                    </div>

                    <div class="admin-form-group">
                        <label class="admin-label">소개글</label>
                        <textarea name="description" class="admin-textarea" rows="4">${fn:escapeXml(store.description)}</textarea>
                    </div>
                </div>

                <!-- 위치정보 (수정 가능) -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h2 class="admin-card-title">위치 정보</h2>
                    </div>

                    <div class="admin-form-group">
                        <label class="admin-label">주소 <span style="color:var(--admin-danger);">*</span></label>
                        <div style="display:flex; gap:8px;">
                            <input type="text" id="address" name="address" class="admin-input" readonly required style="background-color:var(--admin-bg);" value="${fn:escapeXml(store.address)}">
                            <button type="button" class="btn-admin-secondary" onclick="searchAddress()">주소 검색</button>
                        </div>
                    </div>

                    <div id="map" class="admin-map"></div>

                    <div class="admin-form-row" style="margin-top:12px;">
                        <div class="admin-form-group">
                            <label class="admin-label">위도</label>
                            <input type="text" id="latitudeDisplay" class="admin-input" readonly style="background-color:var(--admin-bg);" value="${store.latitude}">
                            <input type="hidden" id="latitude" name="latitude" value="${store.latitude}">
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">경도</label>
                            <input type="text" id="longitudeDisplay" class="admin-input" readonly style="background-color:var(--admin-bg);" value="${store.longitude}">
                            <input type="hidden" id="longitude" name="longitude" value="${store.longitude}">
                        </div>
                    </div>
                </div>

                <!-- 현황 (읽기전용) -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h2 class="admin-card-title">가맹점 현황</h2>
                    </div>
                    <table class="admin-info-list">
                        <tbody>
                            <tr>
                                <th>가맹점주 ID</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty store.adminLoginId}">${fn:escapeXml(store.adminLoginId)}</c:when>
                                        <c:otherwise><span style="color:var(--admin-text-secondary);">미할당</span></c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <th>평균 별점</th>
                                <td>★ ${store.ratingAvg}</td>
                            </tr>
                            <tr>
                                <th>등록일</th>
                                <td>${fn:replace(fn:substring(store.createdAt.toString(), 0, 16), 'T', ' ')}</td>
                            </tr>
                            <tr>
                                <th>최종 수정</th>
                                <td>${fn:replace(fn:substring(store.updatedAt.toString(), 0, 16), 'T', ' ')}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

            </form>

            <!-- 상태 관리 (ADMIN/SUPER_ADMIN만) -->
            <c:if test="${LOGIN_ADMIN.admin or LOGIN_ADMIN.superAdmin}">
                <div class="admin-card sd-status-card">
                    <div>
                        <h2 class="admin-card-title" style="margin-bottom:8px;">상태 관리</h2>
                        <c:choose>
                            <c:when test="${store.status == 'ACTIVE'}">
                                <span class="badge-status badge-status-lg badge-status-active">ACTIVE</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge-status badge-status-lg badge-status-withdrawn">INACTIVE</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div>
                        <c:choose>
                            <c:when test="${store.status == 'ACTIVE'}">
                                <form method="post" action="/admin/stores/${store.storeId}/status"
                                      onsubmit="return confirm('가맹점을 비활성화하시겠습니까?');">
                                    <input type="hidden" name="status" value="INACTIVE">
                                    <button type="submit" class="btn-admin-secondary">비활성화</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <form method="post" action="/admin/stores/${store.storeId}/status"
                                      onsubmit="return confirm('가맹점을 활성화하시겠습니까?');">
                                    <input type="hidden" name="status" value="ACTIVE">
                                    <button type="submit" class="btn-admin-success">활성화</button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:if>

        </div>
    </div>
</div>

<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMapKey}&libraries=services&autoload=false"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    var map, marker, geocoder;
    var initialLat = ${not empty store.latitude ? store.latitude : 37.4979};
    var initialLng = ${not empty store.longitude ? store.longitude : 127.0276};
    var hasInitial = ${not empty store.latitude and not empty store.longitude ? 'true' : 'false'};

    kakao.maps.load(function () {
        var container = document.getElementById('map');
        var options = {
            center: new kakao.maps.LatLng(initialLat, initialLng),
            level: 4
        };
        map = new kakao.maps.Map(container, options);
        geocoder = new kakao.maps.services.Geocoder();

        if (hasInitial) {
            marker = new kakao.maps.Marker({
                position: new kakao.maps.LatLng(initialLat, initialLng)
            });
            marker.setMap(map);
        }
    });

    function searchAddress() {
        new daum.Postcode({
            oncomplete: function (data) {
                document.getElementById('address').value = data.address;
                geocoder.addressSearch(data.address, function (result, status) {
                    if (status === kakao.maps.services.Status.OK) {
                        applyLatLng(parseFloat(result[0].y), parseFloat(result[0].x));
                    }
                });
            }
        }).open();
    }

    function applyLatLng(lat, lng) {
        document.getElementById('latitude').value = lat;
        document.getElementById('longitude').value = lng;
        document.getElementById('latitudeDisplay').value = lat;
        document.getElementById('longitudeDisplay').value = lng;

        var pos = new kakao.maps.LatLng(lat, lng);
        if (marker) marker.setMap(null);
        marker = new kakao.maps.Marker({ position: pos });
        marker.setMap(map);
        map.setCenter(pos);
    }

    function previewImage(input) {
        var file = input.files[0];
        if (!file) return;
        if (file.size > 5 * 1024 * 1024) {
            alert('이미지 크기는 5MB 이하만 가능합니다');
            input.value = '';
            return;
        }
        var reader = new FileReader();
        reader.onload = function (e) {
            document.getElementById('imagePreview').innerHTML =
                '<img src="' + e.target.result + '" alt="미리보기">';
        };
        reader.readAsDataURL(file);
    }

    function validateForm() {
        var f = document.getElementById('storeForm');
        if (!f.storeName.value.trim())  { alert('가맹점명을 입력하세요'); return false; }
        if (!f.categoryId.value)         { alert('카테고리를 선택하세요'); return false; }
        if (!f.regionId.value)           { alert('지역을 선택하세요'); return false; }
        if (!f.address.value.trim())     { alert('주소를 검색하세요'); return false; }
        if (!f.latitude.value || !f.longitude.value) {
            alert('주소 검색으로 위치를 지정하세요');
            return false;
        }
        return true;
    }
</script>

</body>
</html>
