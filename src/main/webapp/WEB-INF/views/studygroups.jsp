<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            height: auto;
            cursor: pointer;
        }

        .study-group-container {
            width: 600px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border: 2px solid #553830;
        }

        .study-group-container h2 {
            text-align: center;
            color: #333;
        }

        .study-group-item {
            border: 1px solid #ddd;
            padding: 10px;
            margin-bottom: 10px;
            background-color: #f9f9f9;
        }

        .study-group-item h3 {
            color: #553830;
        }

        .study-group-item p {
            color: #333;
        }
    </style>
    <title>스터디그룹 목록</title>
</head>
<body>

    <div class="logo-container">
        <a href="/"><img src="/images/logo2.png" alt="logo"></a>
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
        
        <button onclick="window.location.href='/createStudyGroup'">+ 스터디 그룹 생성하기</button>
    </div>

</body>
</html>