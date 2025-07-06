<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>스터디그룹 목록</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #F5F0E1;
            font-family: sans-serif;
        }
        
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

        .logo-container {
            text-align: center;
            padding: 20px 0;
        }

        .logo-container img {
            max-width: 180px;
            height: auto;
        }

        .study-group-container {
            width: 700px;
            margin: 30px auto;
            background-color: #ffffff;
            padding: 30px;
            border: 2px solid #5D3A00;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }

        .study-group-container h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .study-group-item {
            border: 1px solid #ddd;
            padding: 20px;
            margin-bottom: 15px;
            background-color: #f9f9f9;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }

        .study-group-item:hover {
            background-color: #f1ece4;
        }

        .study-group-item h2 {
            color: #5D3A00;
            margin-bottom: 10px;
        }

        .study-group-item p {
            color: #333;
            margin: 0;
        }

        .create-button {
            display: block;
            margin: 30px auto 0;
            background-color: #D97706;
            color: white;
            padding: 12px 24px;
            font-size: 1rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .create-button:hover {
            background-color: #A86F1D;
        }
    </style>
</head>
<body>

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

    <div class="logo-container">
        <a href="/"><img src="/images/logo2.png" alt="Eduvate Logo"></a>
    </div>

    <div class="study-group-container">
        <h2>스터디그룹 목록</h2>

        <c:if test="${not empty studyGroups}">
            <c:forEach var="group" items="${studyGroups}">
                <div class="study-group-item" onclick="location.href='/studygroup/${group.groupID}'">
                    <h2>${group.groupName}</h2>
                    <p>${group.description}</p>
                </div>
            </c:forEach>
        </c:if>

        <button class="create-button" onclick="window.location.href='/createStudyGroup'">
            + 스터디 그룹 생성하기
        </button>
    </div>

</body>
</html>
