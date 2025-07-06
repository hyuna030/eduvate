<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 공부방</title>
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

        .myroom-container {
            width: 600px;
            margin: 30px auto;
            background-color: #ffffff;
            padding: 30px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            border: 2px solid #5D3A00;
        }

        .myroom-container h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        .study-form label,
        .edit-form label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }

        .study-form input,
        .study-form textarea,
        .edit-form input,
        .edit-form textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 6px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        .study-form button,
        .edit-form button,
        .study-log-item button {
            background-color: #D97706;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.3s ease;
        }

        .study-form button:hover,
        .edit-form button:hover,
        .study-log-item button:hover {
            background-color: #A86F1D;
        }

        .study-log-item {
            background-color: #FAFAFA;
            padding: 20px;
            border-radius: 10px;
            border: 1px solid #ccc;
            margin-bottom: 20px;
        }

        .study-log-item h3 {
            color: #5D3A00;
            margin-bottom: 10px;
        }

        .study-log-item p {
            color: #333;
            margin: 6px 0;
        }

        .edit-button {
            margin-top: 10px;
        }

    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            if (!window.location.search.includes('date')) {
                loadStudyLogs();
            }
        });

        function loadStudyLogs() {
            const selectedDate = document.getElementById('studyDate').value;
            window.location.href = '/myroom?date=' + selectedDate;
        }

        function showEditForm() {
            document.getElementById('existingRecord').style.display = 'none';
            document.querySelector('.edit-form').style.display = 'block';
            document.querySelector('.edit-button').style.display = 'none';
        }
    </script>
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

<!-- 로고 -->
<div class="logo-container">
    <a href="/">
        <img src="/images/logo2.png" alt="Eduvate Logo" />
    </a>
</div>

<!-- 메인 컨테이너 -->
<div class="myroom-container">
    <h2>내 공부방</h2>

    <!-- 날짜 선택 -->
    <form class="study-form" action="/study" method="post">
        <label for="studyDate">날짜:</label>
        <input type="date" id="studyDate" name="studyDate" value="${selectedDate}" onchange="loadStudyLogs()">
    </form>

    <!-- 기록이 있으면 -->
    <c:if test="${not empty studyLogs}">
        <div class="study-log-item">
            <div id="existingRecord">
                <h3><fmt:formatDate value="${studyLogs[0].studyDate}" pattern="yyyy-MM-dd" /></h3>
                <p>공부 시간: ${studyLogs[0].studyDuration} 시간</p>
                <p>공부 내용: ${studyLogs[0].topic}</p>
            </div>

            <form class="edit-form" action="/updateStudy" method="post" style="display: none;">
                <input type="hidden" name="userID" value="${studyLogs[0].userID}" />
                <input type="hidden" name="studyDate" value="${studyLogs[0].studyDate}" />

                <label for="studyDuration">공부 시간 (시간):</label>
                <input type="number" id="studyDuration" name="studyDuration" value="${studyLogs[0].studyDuration}" required>

                <label for="studyTopic">공부 내용:</label>
                <textarea id="studyTopic" name="studyTopic" rows="4" required>${studyLogs[0].topic}</textarea>

                <button type="submit">수정 완료</button>
            </form>

            <button class="edit-button" onclick="showEditForm()">수정하기</button>
        </div>
    </c:if>

    <!-- 기록이 없으면 -->
    <c:if test="${empty studyLogs}">
        <form class="study-form" action="/study" method="post">
            <input type="hidden" name="studyDate" value="${selectedDate}">

            <label for="studyDuration">공부 시간 (시간):</label>
            <input type="number" id="studyDuration" name="studyDuration" required>

            <label for="studyTopic">공부 내용:</label>
            <textarea id="studyTopic" name="studyTopic" rows="4" required></textarea>

            <button type="submit">입력하기</button>
        </form>
    </c:if>
</div>

</body>
</html>
