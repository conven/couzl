<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/_meta.jsp" %>
    <title>개인정보 처리방침 - Couzl</title>
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
        .doc-body table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
            margin-bottom: 8px;
        }
        .doc-body table th,
        .doc-body table td {
            border: 1px solid #dddddd;
            padding: 8px 10px;
            color: #555555;
            text-align: left;
        }
        .doc-body table th {
            background-color: #f5f5f5;
            font-weight: 600;
            color: #1A1A1A;
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
        <span class="doc-title">개인정보 처리방침</span>
    </div>

    <div class="doc-body">
        <p class="doc-updated">시행일: 2025년 1월 1일</p>

        <p>Couzl(이하 "회사")은 「개인정보 보호법」 및 관련 법령에 따라 이용자의 개인정보를 보호하고 이와 관련한 고충을 신속하게 처리할 수 있도록 다음과 같이 개인정보 처리방침을 수립·공개합니다.</p>

        <h2>제1조 (수집하는 개인정보 항목)</h2>
        <p>회사는 서비스 제공을 위해 다음의 개인정보를 수집합니다.</p>
        <table>
            <tr>
                <th>수집 목적</th>
                <th>수집 항목</th>
                <th>보유 기간</th>
            </tr>
            <tr>
                <td>회원 가입 및 관리</td>
                <td>아이디, 비밀번호, 닉네임, 이메일</td>
                <td>회원 탈퇴 시까지</td>
            </tr>
            <tr>
                <td>쿠폰 서비스 제공</td>
                <td>쿠폰 발급·사용 내역, 관심 지역</td>
                <td>회원 탈퇴 시까지</td>
            </tr>
            <tr>
                <td>서비스 이용 기록</td>
                <td>접속 IP, 접속 일시, 이용 기록</td>
                <td>3개월</td>
            </tr>
        </table>

        <h2>제2조 (개인정보 수집 방법)</h2>
        <p>회사는 다음의 방법으로 개인정보를 수집합니다.</p>
        <ul>
            <li>회원 가입 및 서비스 이용 과정에서 이용자가 직접 입력</li>
            <li>카카오, Apple 소셜 로그인을 통한 제공 (해당 시)</li>
            <li>서비스 이용 과정에서 자동 생성되는 정보</li>
        </ul>

        <h2>제3조 (개인정보의 이용 목적)</h2>
        <p>수집한 개인정보는 다음 목적 이외의 용도로는 사용하지 않으며, 이용 목적이 변경되는 경우 별도 동의를 받겠습니다.</p>
        <ul>
            <li>회원 가입 의사 확인, 회원제 서비스 제공, 본인 식별·인증</li>
            <li>지역 기반 쿠폰 발급 및 사용 서비스 제공</li>
            <li>고객 문의 응대 및 불만 처리</li>
            <li>서비스 개선 및 신규 서비스 개발을 위한 통계 분석</li>
        </ul>

        <h2>제4조 (개인정보의 제3자 제공)</h2>
        <p>회사는 원칙적으로 이용자의 개인정보를 외부에 제공하지 않습니다. 다만, 아래의 경우는 예외로 합니다.</p>
        <ul>
            <li>이용자가 사전에 동의한 경우</li>
            <li>법령의 규정에 의거하거나, 수사 목적으로 법령이 정한 절차와 방법에 따라 수사기관의 요구가 있는 경우</li>
        </ul>

        <h2>제5조 (개인정보의 보유 및 이용 기간)</h2>
        <p>이용자의 개인정보는 서비스 이용 기간 동안 보유합니다. 회원이 탈퇴하거나 개인정보 삭제를 요청한 경우, 법령에서 달리 규정하지 않는 한 즉시 파기합니다. 단, 관련 법령에 따라 일정 기간 보관이 필요한 경우 해당 기간 동안 보관 후 파기합니다.</p>

        <h2>제6조 (개인정보의 파기 절차 및 방법)</h2>
        <p>회사는 개인정보 보유 기간의 경과, 처리 목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체 없이 해당 개인정보를 파기합니다.</p>
        <ul>
            <li>전자적 파일 형태: 복원 불가능한 방법으로 영구 삭제</li>
            <li>종이 문서 형태: 분쇄기로 분쇄하거나 소각</li>
        </ul>

        <h2>제7조 (이용자의 권리와 행사 방법)</h2>
        <p>이용자는 언제든지 다음의 권리를 행사할 수 있습니다.</p>
        <ul>
            <li>개인정보 처리 현황 조회 및 열람 요청</li>
            <li>오류 정보에 대한 정정 요청</li>
            <li>삭제 요청 (단, 법령상 보관 의무가 있는 경우 제외)</li>
            <li>처리 정지 요청</li>
        </ul>
        <p>권리 행사는 앱 내 마이페이지 또는 이메일(support@couzl.com)을 통해 신청할 수 있습니다.</p>

        <h2>제8조 (개인정보 보호책임자)</h2>
        <p>회사는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 이용자의 개인정보 관련 불만처리 및 피해구제 등을 위하여 개인정보 보호책임자를 지정합니다.</p>
        <ul>
            <li>성명: Couzl 개인정보 보호팀</li>
            <li>이메일: privacy@couzl.com</li>
        </ul>

        <h2>부칙</h2>
        <p>본 방침은 2025년 1월 1일부터 시행합니다.</p>
    </div>

</div>
<script src="/static/js/common.js"></script>
</body>
</html>
