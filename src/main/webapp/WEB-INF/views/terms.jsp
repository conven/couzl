<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이용약관 - Couzl</title>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <link rel="stylesheet" href="/static/css/common.css">
    <style>
        .doc-wrap {
            max-width: 430px;
            margin: 0 auto;
            padding: 0 24px 48px;
            background-color: #ffffff;
            min-height: 100vh;
        }
        .doc-header {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 16px 0 12px;
            border-bottom: 1px solid #eeeeee;
            margin-bottom: 24px;
        }
        .btn-back {
            background: none;
            border: none;
            font-size: 22px;
            cursor: pointer;
            padding: 0;
            color: #1A1A1A;
            line-height: 1;
        }
        .doc-title {
            font-size: 17px;
            font-weight: 700;
            color: #1A1A1A;
        }
        .doc-body h2 {
            font-size: 15px;
            font-weight: 700;
            color: #1A1A1A;
            margin: 24px 0 8px;
        }
        .doc-body p {
            font-size: 14px;
            color: #555555;
            line-height: 1.7;
            margin: 0 0 8px;
        }
        .doc-body ul {
            padding-left: 18px;
            margin: 0 0 8px;
        }
        .doc-body ul li {
            font-size: 14px;
            color: #555555;
            line-height: 1.7;
        }
        .doc-updated {
            font-size: 13px;
            color: #999999;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="doc-wrap">

    <div class="doc-header">
        <button class="btn-back" onclick="history.back()">‹</button>
        <span class="doc-title">이용약관</span>
    </div>

    <div class="doc-body">
        <p class="doc-updated">시행일: 2025년 1월 1일</p>

        <h2>제1조 (목적)</h2>
        <p>본 약관은 Couzl(이하 "서비스")을 운영하는 회사(이하 "회사")가 제공하는 서비스의 이용 조건 및 절차, 회사와 회원 간의 권리·의무 및 책임사항을 규정함을 목적으로 합니다.</p>

        <h2>제2조 (정의)</h2>
        <p>본 약관에서 사용하는 주요 용어의 정의는 다음과 같습니다.</p>
        <ul>
            <li>"서비스"란 회사가 제공하는 지역 기반 쿠폰 서비스 및 관련 제반 서비스를 의미합니다.</li>
            <li>"회원"이란 본 약관에 동의하고 회원 가입을 완료한 자를 의미합니다.</li>
            <li>"쿠폰"이란 회사 또는 제휴 업체가 발행한 할인·혜택 티켓을 의미합니다.</li>
        </ul>

        <h2>제3조 (약관의 효력 및 변경)</h2>
        <p>본 약관은 서비스 화면에 게시하거나 기타 방법으로 회원에게 공지함으로써 효력이 발생합니다. 회사는 필요한 경우 약관을 변경할 수 있으며, 변경된 약관은 서비스 내 공지사항을 통해 사전 공지합니다.</p>

        <h2>제4조 (회원 가입)</h2>
        <p>회원 가입은 서비스 가입 신청 양식에 필요한 정보를 기재한 후 본 약관에 동의함으로써 완료됩니다. 회사는 다음 각 호의 경우 가입 신청을 거절할 수 있습니다.</p>
        <ul>
            <li>실명이 아니거나 타인의 정보를 도용한 경우</li>
            <li>허위 정보를 기재하거나 회사가 요청하는 정보를 기재하지 않은 경우</li>
            <li>만 14세 미만인 경우</li>
        </ul>

        <h2>제5조 (서비스 이용)</h2>
        <p>서비스는 연중무휴 24시간 제공함을 원칙으로 합니다. 단, 회사는 시스템 점검·증설 및 교체, 설비 장애 등의 사유로 서비스 제공을 일시 중단할 수 있습니다.</p>

        <h2>제6조 (쿠폰 사용)</h2>
        <p>쿠폰은 발행 조건에 명시된 유효 기간 내에만 사용 가능합니다. 유효 기간이 경과한 쿠폰은 자동 소멸되며, 재발행 및 환불이 불가합니다. 쿠폰은 타인에게 양도할 수 없습니다.</p>

        <h2>제7조 (회원 탈퇴 및 자격 상실)</h2>
        <p>회원은 언제든지 탈퇴를 요청할 수 있으며, 회사는 즉시 처리합니다. 탈퇴 시 보유 쿠폰, 사용 내역, 작성한 리뷰 등 모든 데이터는 복구 불가능하게 삭제됩니다.</p>

        <h2>제8조 (면책 조항)</h2>
        <p>회사는 천재지변, 전쟁, 기간통신 사업자의 서비스 중지 등 불가항력으로 인해 서비스를 제공할 수 없는 경우 서비스 제공에 대한 책임이 면제됩니다. 회원의 귀책 사유로 발생한 손해에 대해서는 회사가 책임을 지지 않습니다.</p>

        <h2>제9조 (분쟁 해결)</h2>
        <p>서비스 이용과 관련하여 회사와 회원 사이에 분쟁이 발생한 경우, 회사는 분쟁의 해결을 위해 성실히 협의합니다. 협의가 이루어지지 않을 경우 관련 법령에 따른 분쟁조정기관에 조정을 신청할 수 있습니다.</p>

        <h2>부칙</h2>
        <p>본 약관은 2025년 1월 1일부터 시행합니다.</p>
    </div>

</div>
<script src="/static/js/common.js"></script>
</body>
</html>
