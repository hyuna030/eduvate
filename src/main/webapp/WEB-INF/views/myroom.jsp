<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .myroom-container {
            width: 600px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border: 2px solid #553830;
        }

        .myroom-container h2 {
            text-align: center;
            color: #333;
        }

        .study-form {
            margin-top: 20px;
            text-align: center;
        }

        .study-form label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }

        .study-form input, .study-form textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            box-sizing: border-box;
        }

        .study-form button {
            background-color: #553830;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            display: block;
            margin: 0 auto;
        }

        .study-log {
            margin-top: 20px;
        }

        .study-log-item {
            border: 1px solid #ddd;
            padding: 10px;
            margin-bottom: 10px;
            background-color: #f9f9f9;
        }

        .study-log-item h3 {
            color: #553830;
        }

        .study-log-item p {
            color: #333;
        }

        .study-log-item button {
            background-color: #553830;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            margin-left: 5px;
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

        .date-picker {
            margin-top: 10px;
            text-align: center;
        }

        .study-form input[type="date"] {
            width: auto;
        }

        .edit-form {
            margin-top: 20px;
            text-align: center;
        }

        .edit-form button {
            background-color: #553830;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            margin-left: 5px;
        }
    </style>
    <script>
    document.addEventListener('DOMContentLoaded', function () {
        // URL에 'date' 매개변수가 없으면 스터디 로그를 로드합니다.
        if (!window.location.search.includes('date')) {
            loadStudyLogs();
        }
    });

    // 날짜가 변경되면 해당 날짜의 기록을 불러오는 함수
    function loadStudyLogs() {
        const selectedDate = document.getElementById('studyDate').value;
        window.location.href = '/myroom?date=' + selectedDate;
    }

    function showEditForm() {
        // 기존 기록 숨기고, 수정 폼 표시
        document.getElementById('existingRecord').style.display = 'none';
        document.querySelector('.edit-form').style.display = 'block';
        document.querySelector('.edit-button').style.display = 'none';
    }
</script>
    <title>내 공부방</title>
</head>
<body>

    <div class="logo-container">
        <a href="/"><img src="/images/logo2.png" alt="logo"></a>
    </div>

    <div class="myroom-container">
        <h2>내 공부방</h2>

        <!-- 날짜 선택 폼 -->
        <form class="study-form" action="/study" method="post">
            <label for="studyDate">날짜:</label>
            <input type="date" id="studyDate" name="studyDate" value="${selectedDate}" onchange="loadStudyLogs()">
        </form>

        <!-- 기록이 있으면 기록 표시 -->
<c:if test="${not empty studyLogs}">
    <div class="study-log-item">
        <!-- 기존 기록 -->
        <div id="existingRecord">
            <h3><fmt:formatDate value="${studyLogs[0].studyDate}" pattern="yyyy-MM-dd" /></h3>
            <p>공부 시간: ${studyLogs[0].studyDuration} 시간</p>
            <p>공부 내용: ${studyLogs[0].topic}</p>
        </div>
        
        <!-- 수정 폼 -->
        <form class="edit-form" action="/updateStudy" method="post" style="display: none;">
            <input type="hidden" name="userID" value="${studyLogs[0].userID}" />
            <input type="hidden" name="studyDate" value="${studyLogs[0].studyDate}" />
            <label for="studyDuration">공부 시간 (시간):</label>
            <input type="number" id="studyDuration" name="studyDuration" value="${studyLogs[0].studyDuration}" required>
            <br>
            <br>
            <label for="studyTopic">공부 내용:</label>
            <textarea id="studyTopic" name="studyTopic" rows="4" required>${studyLogs[0].topic}</textarea>
            <br>
            <br>

            <button type="submit">수정 완료</button>
        </form>

        <!-- 수정 버튼 추가 -->
        <button class="edit-button" onclick="showEditForm()">수정하기</button>
    </div>
</c:if>

<!-- 기록이 없으면 입력 폼 표시 -->
<c:if test="${empty studyLogs}">
    <form class="study-form" action="/study" method="post">
    <!-- Hidden Input 추가 -->
    <input type="hidden" name="studyDate" value="${selectedDate}">
    
    <!-- 나머지 폼 요소들 추가 -->
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
