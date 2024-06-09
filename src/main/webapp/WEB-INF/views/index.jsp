<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body {
      margin: 0;
      padding: 0;
      background-color: #f4f4f4;
    }

    .logo-container {
      text-align: center;
      margin-top: 10px;
    }

    .logo-container img {
      max-width: 10%;
      height: 10%;
    }

    .user-menu {
      text-align: right;
      padding: 10px;
      background-color: #553830;
      color: white;
    }

    .user-menu a {
      color: white;
      text-decoration: none;
      margin: 0 15px;
    }

    .study-group-section {
      text-align: center;
      margin: 30px;
      padding: 20px;
      background-color: #fff;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .study-group-section h2 {
      color: #333;
    }

    .study-group-section button {
      background-color: #4CAF50;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }
  </style>
  <title>Eduvate</title>
</head>
<body>

  <!-- 상단 로고 -->
  <div class="logo-container">
  	<a href="/" class="button">
    	<img src="/images/logo2.png" alt="logo" />
    </a>
  </div>

  <!-- 로그인, 회원가입, 내 공부방 메뉴 -->
  <div class="user-menu">
        <c:if test="${isLoggedIn}">
            <a>${username}님, 안녕하세요!</a>
            <a href="/logout">로그아웃</a>
        </c:if>
        <c:if test="${not isLoggedIn}">
            <a href="/login">로그인</a>
            <a href="/register">회원가입</a>
        </c:if>
        <a href="/myroom">내 공부방</a>
    </div>

  <div class="study-group-section">
    <h2>스터디그룹 가입하기</h2>
    <p>원하는 주제의 스터디그룹에 참여하세요!</p>
    <button onclick="window.location.href='/studygroups'">스터디그룹 찾아보기</button>
  </div>

</body>
</html>




