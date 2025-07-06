<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Eduvate</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      background-color: #F5F0E1;
      font-family: sans-serif;
    }

    /* 상단 메뉴 */
    .user-menu {
      text-align: right;
      padding: 12px 30px;
      background-color: #5D3A00;
      color: white;
    }

    .user-menu a {
      color: white;
      text-decoration: none;
      margin-left: 20px;
      font-weight: bold;
    }

    .user-menu span {
      font-weight: bold;
    }

    /* 로고 영역 */
    .logo-container {
      text-align: center;
      background-color: #F5F0E1;
      padding: 20px 0;
    }

    .logo-container img {
      max-width: 180px;
      height: auto;
    }

    /* 스터디그룹 섹션 */
    .study-group-section {
  text-align: center;
  margin: 60px auto;
  padding: 40px;
  background-color: #ffffff;
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
  border-radius: 12px;
  width: 700px;
  border: 2px solid #5D3A00; /* 갈색 테두리 추가 */
}


    .study-group-section h2 {
      color: #333;
      margin-bottom: 20px;
    }

    .study-group-section p {
      color: #666;
      margin-bottom: 30px;
      font-size: 1.1rem;
    }

    .study-group-section button {
      background-color: #D97706;
      color: white;
      padding: 12px 24px;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      font-size: 1rem;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      transition: background-color 0.3s ease;
    }

    .study-group-section button:hover {
      background-color: #A86F1D;
    }
  </style>
</head>
<body>

  <!-- 상단 유저 메뉴 -->
  <div class="user-menu">
    <c:if test="${isLoggedIn}">
      <span>${username}님</span>
      <a href="/logout">로그아웃</a>
    </c:if>
    <c:if test="${not isLoggedIn}">
      <a href="/login">로그인</a>
      <a href="/register">회원가입</a>
    </c:if>
    <a href="/myroom">내 공부방</a>
  </div>

  <!-- 로고 -->
  <div class="logo-container">
    <a href="/">
      <img src="/images/logo2.png" alt="Eduvate Logo" />
    </a>
  </div>

  <!-- 스터디그룹 안내 -->
  <div class="study-group-section">
    <h2>스터디그룹 가입하기</h2>
    <p>원하는 주제의 스터디그룹에 참여하세요!</p>
    <button onclick="window.location.href='/studygroups'">스터디그룹 찾아보기</button>
  </div>

</body>
</html>
