<%@ page language="java" %>
<%
    String bgColor    = request.getParameter("bgColor")    != null ? request.getParameter("bgColor")    : "#FFD60A";
    String inkColor   = request.getParameter("inkColor")   != null ? request.getParameter("inkColor")   : "white";
    String notchColor = request.getParameter("notchColor") != null ? request.getParameter("notchColor") : "white";
%>
<svg xmlns="http://www.w3.org/2000/svg" viewBox="-60 -60 120 120" width="110" height="110">
  <!-- 쿠폰 티켓 배경 -->
  <rect x="-52" y="-52" width="104" height="104" rx="14" fill="<%= bgColor %>"/>
  <!-- 왼쪽 노치 -->
  <circle cx="-52" cy="0" r="11" fill="<%= notchColor %>"/>
  <!-- 오른쪽 노치 -->
  <circle cx="52" cy="0" r="11" fill="<%= notchColor %>"/>
  <!-- 점선 구분선 -->
  <line id="dash-line" x1="-41" y1="0" x2="41" y2="0"
        stroke="<%= inkColor %>" stroke-width="1.5"
        stroke-dasharray="4,3" opacity="0.5"/>
  <!-- C 글자 -->
  <text x="0" y="-10"
        font-family="sans-serif" font-size="36"
        font-weight="900" fill="<%= inkColor %>"
        text-anchor="middle" dominant-baseline="middle">C</text>
  <!-- 스파크 -->
  <text id="spark" x="24" y="-28"
        font-family="sans-serif" font-size="13"
        fill="<%= inkColor %>" opacity="0.9">&#10022;</text>
  <!-- COUZL 텍스트 -->
  <text id="couzl-text" x="0" y="22"
        font-family="sans-serif" font-size="9"
        font-weight="700" fill="<%= inkColor %>"
        text-anchor="middle" letter-spacing="3">COUZL</text>
</svg>
