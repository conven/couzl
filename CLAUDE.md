# Couzl 프로젝트 개발 가이드

## 공통 컴포넌트
모든 JSP 화면은 반드시 아래 include 사용:
- 상단 헤더: <%@ include file="/WEB-INF/views/common/_header.jsp" %>
- 하단 탭바: <%@ include file="/WEB-INF/views/common/_tab_bar.jsp" %>
- 로고: <%@ include file="/WEB-INF/views/common/_logo.jsp" %>

## CSS/JS 공통
- common.css 항상 link
- common.js 항상 script
- 페이지별 css/js 추가

## 브랜드
- 메인 컬러: #FFD60A
- max-width: 430px
- 폰트: sans-serif

## 기술 스택
- Spring Boot 3.x, Java 17
- JSP + JSTL, Gradle
- MariaDB, MyBatis
