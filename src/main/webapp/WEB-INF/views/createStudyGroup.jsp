<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>스터디 그룹 생성</title>
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

    /* 로고 */
    .logo-container {
      text-align: center;
      padding: 20px 0;
      background-color: #F5F0E1;
    }

    .logo-container img {
      max-width: 180px;
      height: auto;
    }

    /* 폼 컨테이너 */
    .create-group-container {
      width: 600px;
      margin: 40px auto;
      background-color: #ffffff;
      padding: 30px;
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
      border-radius: 12px;
      border: 2px solid #5D3A00;
    }

    .create-group-container h2 {
      text-align: center;
      color: #333;
      margin-bottom: 30px;
    }

    .create-group-form label {
      display: block;
      margin-bottom: 8px;
      color: #333;
      font-weight: bold;
      text-align: left;
    }

    .create-group-form input,
    .create-group-form textarea {
      width: 100%;
      padding: 10px;
      margin-bottom: 20px;
      border: 1px solid #ccc;
      border-radius: 6px;
      box-sizing: border-box;
      font-size: 1rem;
    }

    .create-group-form button {
      background-color: #D97706;
      color: white;
      padding: 12px 24px;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      font-size: 1rem;
      display: block;
      margin: 0 auto;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      transition: background-color 0.3s ease;
    }

    .create-group-form button:hover {
      background-color: #A86F1D;
    }
  </style>
</head>
<body>

<!-- 상단 메뉴 -->
<div class="user-menu">
    <c:if test="${not empty sessionScope.user}">
        <span>${sessionScope.user.username}님</span>
        <a href="/logout">로그아웃</a>
    </c:if>
    <c:if test="${empty sessionScope.user}">
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

<!-- 그룹 생성 폼 -->
<div class="create-group-container">
  <h2>스터디 그룹 생성</h2>

  <form class="create-group-form" action="/createStudyGroup" method="post" enctype="multipart/form-data">
    <label for="groupName">그룹 이름</label>
    <input type="text" id="groupName" name="groupName" required>

    <label for="description">그룹 설명</label>
    <textarea id="description" name="description" rows="4" required></textarea>

    <button type="submit">그룹 생성</button>
  </form>
</div>

</body>
</html>
