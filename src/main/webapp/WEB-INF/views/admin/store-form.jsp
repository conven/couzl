<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="가맹점 등록"/>
    </jsp:include>
</head>
<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/common/_admin_sidebar.jsp"/>

    <div class="admin-main">

        <jsp:include page="/WEB-INF/views/admin/common/_admin_header.jsp">
            <jsp:param name="title" value="가맹점 등록"/>
        </jsp:include>

        <div class="admin-content">

            <c:if test="${param.msg == 'error'}">
                <div class="admin-form-error" style="margin-bottom:16px;">처리 중 오류가 발생했습니다</div>
            </c:if>

            <form id="storeForm" method="post" action="/admin/stores/new" enctype="multipart/form-data" onsubmit="return validateForm();">

                <!-- 기본정보 -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h2 class="admin-card-title">기본 정보</h2>
                    </div>

                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">가맹점명 <span style="color:var(--admin-danger);">*</span></label>
                            <input type="text" name="storeName" class="admin-input" required>
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">카테고리 <span style="color:var(--admin-danger);">*</span></label>
                            <select name="categoryId" class="admin-select" required>
                                <option value="">선택</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.categoryId}">${fn:escapeXml(cat.name)}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">지역 <span style="color:var(--admin-danger);">*</span></label>
                            <select name="regionId" class="admin-select" required>
                                <option value="">선택</option>
                                <c:forEach var="r" items="${regions}">
                                    <option value="${r.regionId}">${fn:escapeXml(r.regionName)}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">대표 이모지</label>
                            <input type="text" name="emoji" class="admin-input" placeholder="🏪" maxlength="4">
                        </div>
                    </div>

                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">연락처</label>
                            <input type="text" name="phone" class="admin-input" placeholder="02-1234-5678">
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">영업시간</label>
                            <input type="text" name="businessHours" class="admin-input" placeholder="09:00 - 22:00">
                        </div>
                    </div>

                    <div class="admin-form-group">
                        <label class="admin-label">소개글</label>
                        <textarea name="description" class="admin-textarea" rows="4" placeholder="가맹점 소개"></textarea>
                    </div>
                </div>

                <!-- 위치정보 -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h2 class="admin-card-title">위치 정보</h2>
                    </div>

                    <div class="admin-form-group">
                        <label class="admin-label">주소 <span style="color:var(--admin-danger);">*</span></label>
                        <div style="display:flex; gap:8px;">
                            <input type="text" id="address" name="address" class="admin-input" readonly required style="background-color:var(--admin-bg);">
                            <button type="button" class="btn-admin-secondary" onclick="searchAddress()">주소 검색</button>
                        </div>
                    </div>

                    <div id="map" class="admin-map"></div>

                    <div class="admin-form-row" style="margin-top:12px;">
                        <div class="admin-form-group">
                            <label class="admin-label">위도</label>
                            <input type="text" id="latitudeDisplay" class="admin-input" readonly style="background-color:var(--admin-bg);">
                            <input type="hidden" id="latitude" name="latitude">
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">경도</label>
                            <input type="text" id="longitudeDisplay" class="admin-input" readonly style="background-color:var(--admin-bg);">
                            <input type="hidden" id="longitude" name="longitude">
                        </div>
                    </div>
                </div>

                <!-- 대표 이미지 -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h2 class="admin-card-title">대표 이미지</h2>
                    </div>

                    <div style="display:flex; gap:20px; align-items:flex-start; flex-wrap:wrap;">
                        <div id="imagePreview" class="admin-image-preview">미리보기</div>
                        <div style="flex:1; min-width:200px;">
                            <input type="file" name="image" id="image" accept="image/*" onchange="previewImage(this)">
                            <p style="margin-top:10px; font-size:12px; color:var(--admin-text-secondary);">
                                권장 크기: 500×500px / JPG, PNG / 최대 5MB
                            </p>
                        </div>
                    </div>
                </div>

                <!-- 가맹점주 계정 -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h2 class="admin-card-title">가맹점주 계정</h2>
                    </div>

                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">아이디 <span style="color:var(--admin-danger);">*</span></label>
                            <input type="text" name="adminLoginId" id="adminLoginId" class="admin-input" required minlength="4">
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">비밀번호 <span style="color:var(--admin-danger);">*</span></label>
                            <input type="password" name="adminPassword" id="adminPassword" class="admin-input" required minlength="6" oninput="checkPasswordMatch()">
                        </div>
                    </div>

                    <div class="admin-form-group">
                        <label class="admin-label">비밀번호 확인 <span style="color:var(--admin-danger);">*</span></label>
                        <input type="password" id="adminPasswordConfirm" class="admin-input" required oninput="checkPasswordMatch()">
                        <span id="pwMatchMsg" style="display:none; margin-top:6px; font-size:12px; color:var(--admin-danger);">
                            비밀번호가 일치하지 않습니다
                        </span>
                    </div>
                </div>

                <div class="admin-form-actions">
                    <a href="/admin/stores" class="btn-admin-secondary">취소</a>
                    <button type="submit" class="btn-admin-primary">등록</button>
                </div>

            </form>
        </div>
    </div>
</div>

<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMapKey}&libraries=services&autoload=false"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    var map, marker, geocoder;

    kakao.maps.load(function () {
        var container = document.getElementById('map');
        var options = {
            center: new kakao.maps.LatLng(37.4979, 127.0276),
            level: 4
        };
        map = new kakao.maps.Map(container, options);
        geocoder = new kakao.maps.services.Geocoder();
    });

    function searchAddress() {
        new daum.Postcode({
            oncomplete: function (data) {
                document.getElementById('address').value = data.address;
                geocoder.addressSearch(data.address, function (result, status) {
                    if (status === kakao.maps.services.Status.OK) {
                        var lat = parseFloat(result[0].y);
                        var lng = parseFloat(result[0].x);
                        applyLatLng(lat, lng);
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

    function checkPasswordMatch() {
        var pw = document.getElementById('adminPassword').value;
        var pwc = document.getElementById('adminPasswordConfirm').value;
        var msg = document.getElementById('pwMatchMsg');
        msg.style.display = (pwc && pw !== pwc) ? 'block' : 'none';
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
        if (!f.adminLoginId.value.trim()) { alert('가맹점주 아이디를 입력하세요'); return false; }
        if (!f.adminPassword.value)       { alert('비밀번호를 입력하세요'); return false; }
        if (f.adminPassword.value !== document.getElementById('adminPasswordConfirm').value) {
            alert('비밀번호가 일치하지 않습니다');
            return false;
        }
        return true;
    }
</script>

</body>
</html>
