<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

        .study-group-info {
            margin-top: 20px;
            text-align: center;
        }

        .study-group-info p {
            margin-bottom: 10px;
            color: #333;
        }

        .join-button {
            background-color: #553830;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            display: block;
            margin: 0 auto;
        }

        .back-to-list {
            text-align: center;
            margin-top: 20px;
        }

        .back-to-list a {
            color: #553830;
            text-decoration: none;
        }

        .group-members {
            margin-top: 20px;
            text-align: center;
        }

        .group-members p {
            color: #333;
        }
    </style>
    <script>
    function toggleEditForm(logID, date, topic, duration) {
        var editForm = document.getElementById("editForm");
        var editLogID = document.getElementById("editLogID");
        var editStudyTopic = document.getElementById("editStudyTopic");
        var editStudyDuration = document.getElementById("editStudyDuration");
        var editStudyDate = document.getElementById("editStudyDate");

        // 기존 내용 채우기
        editLogID.value = logID;
        editStudyTopic.value = topic;
        editStudyDuration.value = duration;
        editStudyDate.value = date;

        if (editForm.style.display === "none") {
            editForm.style.display = "block";
        } else {
            editForm.style.display = "none";
        }
    }
</script>
    <title>Study Group Detail</title>
</head>
<body>

    <div class="logo-container">
        <a href="/"><img src="/images/logo2.png" alt="logo"></a>
    </div>

    <div class="study-group-container">
        <h2>${group.groupName} 상세 정보</h2>

        <div class="study-group-info">
            <p><strong>그룹명:</strong> ${group.groupName}</p>
            <p><strong>설명:</strong> ${group.description}</p>
            <p><strong>리더:</strong> ${group.userID}</p>
        </div>

        <!-- 조원 목록 출력 -->
        <div class="group-members">
            <h3>조원 목록</h3>
            <c:if test="${not empty groupMembers}">
                <c:forEach var="member" items="${groupMembers}">
                    <p>${member.userID}</p>
                </c:forEach>
            </c:if>
        </div>

        <!-- 가입 버튼 폼 추가 -->
        <c:if test="${!isUserJoined}">
            <form method="post" action="/joinGroup/${group.groupID}">
                <button class="join-button" type="submit">가입하기</button>
            </form>
        </c:if>

        <!-- 목록으로 돌아가는 링크 추가 -->
        <div class="back-to-list">
            <a href="/studygroups">목록으로 돌아가기</a>
        </div>
        
        <!-- GroupStudyLog 출력 부분 추가 -->
        <div class="study-group-info">
            <h3>스터디 그룹 공부 내용</h3>

            <!-- 날짜 선택 폼 추가 -->
            <form method="get" action="/studygroup/${group.groupID}">
                <label for="selectedDate">날짜 선택:</label>
                <input type="date" name="selectedDate" value="${empty param.selectedDate ? currentDate : param.selectedDate}" onchange="this.form.submit()">
            </form>

            <!-- 선택한 날짜에 대한 기존 로그 출력 -->
            <c:forEach var="log" items="${groupLogs}">
                <c:if test="${empty param.selectedDate or param.selectedDate == log.groupStudyDate}">
                    <p><strong>${log.userID}</strong>님 (${log.groupStudyDate}): ${log.groupStudyDuration}시간 공부, 주제: ${log.groupTopic}</p>

                    <!-- 현재 사용자의 로그인한 사용자의 스터디 로그인 경우에만 수정하기 버튼 표시 -->
                    <c:if test="${log.userID eq currentUserID}">
                        <button onclick="toggleEditForm(${log.groupLogID}, '${log.groupStudyDate}', '${log.groupTopic}', ${log.groupStudyDuration})">수정하기</button>
                    </c:if>
                </c:if>
            </c:forEach>

            <!-- 입력 폼 표시 -->
            <c:if test="${isUserJoined}">
                <form method="post" action="/writeStudyLog/${group.groupID}">
                    <label for="studyDate">날짜:</label>
                    <input type="date" id="studyDate" name="studyDate" value="${currentDate}" required>
                    <br>
                    <label for="studyDuration">공부 시간 (시간):</label>
                    <input type="number" id="studyDuration" name="studyDuration" required>
                    <br>
                    <label for="studyTopic">공부 내용:</label>
                    <textarea id="studyTopic" name="studyTopic" rows="4" required></textarea>
                    <br>
                    <button type="submit">작성하기</button>
                </form>
            </c:if>
        </div>

        <!-- 수정하기 폼 추가 -->
        <c:if test="${isUserJoined}">
            <div id="editForm" style="display: none;">
                <form method="post" action="/editStudyLog/${group.groupID}">
                    <input type="hidden" name="logID" id="editLogID">
                    <label>공부 내용:</label>
                    <textarea name="studyTopic" id="editStudyTopic"></textarea>
                    <br>
                    <label>공부 시간 (시간):</label>
                    <input type="number" name="studyDuration" id="editStudyDuration" required>
                    <br>
                    <label>날짜:</label>
                    <input type="date" name="studyDate" id="editStudyDate" required>
                    <button type="submit">입력</button>
                </form>
            </div>
        </c:if>

    </div>

</body>
</html>
