<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>스터디 그룹 상세</title>
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

        .study-group-container h2,
        .study-group-container h3 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .study-group-info,
        .group-members,
        .back-to-list {
            margin-top: 20px;
            text-align: center;
        }

        .study-group-info p,
        .group-members p {
            color: #333;
            margin: 6px 0;
        }

        .join-button,
        .study-group-container button,
        .edit-button,
        .delete-button {
            background-color: #D97706;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.3s ease;
            margin-top: 10px;
            margin-right: 5px;
        }

        .delete-button {
            background-color: #dc3545;
        }

        .study-group-container button:hover,
        .edit-button:hover {
            background-color: #A86F1D;
        }

        .delete-button:hover {
            background-color: #c82333;
        }

        .back-to-list a {
            color: #5D3A00;
            text-decoration: none;
            font-weight: bold;
        }

        input[type="text"],
        input[type="number"],
        input[type="date"],
        textarea {
            width: 100%;
            padding: 10px;
            margin: 8px 0 16px 0;
            border-radius: 6px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        label {
            font-weight: bold;
            color: #333;
            display: block;
            margin-bottom: 5px;
        }

        .form-section {
            background-color: #fdfdfd;
            border-left: 4px solid #D97706;
            padding: 20px;
            border-radius: 8px;
            margin-top: 30px;
        }

        .form-section h4 {
            margin-top: 0;
            color: #5D3A00;
        }

        .date-filter-form {
            margin-bottom: 20px;
            padding: 20px;
            background-color: #fff9ec;
            border: 2px solid #D97706;
            border-radius: 10px;
            text-align: left;
        }

        .date-filter-form label {
            color: #5D3A00;
            font-weight: bold;
            margin-right: 10px;
        }

        .study-log-container {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-top: 15px;
        }

        .study-log-item {
            background-color: white;
            padding: 15px;
            margin-bottom: 10px;
            border-radius: 8px;
            border-left: 4px solid #D97706;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .study-log-item:last-child {
            margin-bottom: 0;
        }

        .button-wrapper {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }

        .filter-controls {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
        }

        .filter-button {
            background-color: #6c757d;
            color: white;
            padding: 5px 10px;
 			text-align: center;
    		min-width: 80px; 
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .filter-button:hover {
            background-color: #5a6268;
        }

        .log-actions {
            margin-top: 10px;
        }

        .inline-edit-form {
            margin-top: 15px;
            padding: 15px;
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            border-radius: 8px;
            display: none;
        }

        .inline-edit-form h5 {
            margin-top: 0;
            color: #5D3A00;
        }

        .form-buttons {
            display: flex;
            gap: 10px;
            margin-top: 10px;
            justify-content: center;
        }

        .cancel-button {
            background-color: #6c757d;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9rem;
        }

        .cancel-button:hover {
            background-color: #5a6268;
        }
    </style>
    <script>
        function toggleEditForm(logID, date, topic, duration) {
            // 모든 수정 폼 숨기기
            var allEditForms = document.querySelectorAll('.inline-edit-form');
            allEditForms.forEach(function(form) {
                form.style.display = 'none';
            });

            // 해당 로그의 수정 폼 토글
            var editForm = document.getElementById("editForm_" + logID);
            if (editForm.style.display === "none" || editForm.style.display === "") {
                document.getElementById("editLogID_" + logID).value = logID;
                document.getElementById("editStudyTopic_" + logID).value = topic;
                document.getElementById("editStudyDuration_" + logID).value = duration;
                document.getElementById("editStudyDate_" + logID).value = date;
                editForm.style.display = "block";
            } else {
                editForm.style.display = "none";
            }
        }

        function cancelEdit(logID) {
            document.getElementById("editForm_" + logID).style.display = "none";
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

<div class="logo-container">
    <a href="/"><img src="/images/logo2.png" alt="Eduvate Logo" /></a>
</div>

<div class="study-group-container">
    <h2>${group.groupName} 상세 정보</h2>

    <div class="study-group-info">
        <p><strong>그룹명:</strong> ${group.groupName}</p>
        <p><strong>설명:</strong> ${group.description}</p>
        <p><strong>리더:</strong> ${group.userID}</p>
    </div>

    <div class="button-wrapper">
        <c:if test="${isLeader}">
            <form method="post" action="/deleteStudyGroup/${group.groupID}" onsubmit="return confirm('정말 삭제하시겠습니까?')">
                <button type="submit" class="join-button">스터디 그룹 삭제</button>
            </form>
        </c:if>

        <c:if test="${!isLeader and isUserJoined}">
            <form method="post" action="/leaveGroup/${group.groupID}" onsubmit="return confirm('정말 탈퇴하시겠습니까?')">
                <button type="submit" class="join-button">스터디 그룹 탈퇴</button>
            </form>
        </c:if>

        <c:if test="${!isLeader and !isUserJoined}">
            <form method="post" action="/joinGroup/${group.groupID}">
                <button class="join-button" type="submit">가입하기</button>
            </form>
        </c:if>
    </div>

    <div class="group-members">
        <h3>조원 목록</h3>
        <c:if test="${not empty groupMembers}">
            <c:forEach var="member" items="${groupMembers}">
                <p>${member.userID}</p>
            </c:forEach>
        </c:if>
    </div>

    <div class="back-to-list">
        <a href="/studygroups">← 목록으로 돌아가기</a>
    </div>

    <div class="study-group-info">
        <h3>스터디 그룹 공부 내용</h3>

        <div class="date-filter-form">
            <label for="selectedDate">📅 날짜별 공부 기록 조회:</label>
            <div class="filter-controls">
                <input type="date" id="selectedDate" name="selectedDate" value="${param.selectedDate}" onchange="filterByDate(this.value)">
                <a href="/studygroup/${group.groupID}" class="filter-button">전체 보기</a>
            </div>
            <small>날짜를 선택하면 해당 날짜의 공부 기록만 표시됩니다. "전체 보기"를 클릭하면 모든 기록을 볼 수 있습니다.</small>
        </div>

        <div class="study-log-container">
            <c:set var="hasLogs" value="false" />
            <c:forEach var="log" items="${groupLogs}">
                <c:if test="${empty param.selectedDate or param.selectedDate == log.groupStudyDate}">
                    <c:set var="hasLogs" value="true" />
                    <div class="study-log-item">
                        <strong>${log.userID}</strong>님 (${log.groupStudyDate}): ${log.groupStudyDuration}시간 공부<br>
                        <strong>주제:</strong> ${log.groupTopic}
                        
                        <c:if test="${log.userID eq currentUserID}">
                            <div class="log-actions">
                                <button class="edit-button" onclick="toggleEditForm(${log.groupLogID}, '${log.groupStudyDate}', '${log.groupTopic}', ${log.groupStudyDuration})">수정하기</button>
                                <button class="delete-button" onclick="window.location.href='/deleteStudyLog/${group.groupID}/${log.groupLogID}'">삭제하기</button>
                            </div>
                        </c:if>

                        <!-- 인라인 수정 폼 -->
                        <c:if test="${log.userID eq currentUserID}">
                            <div class="inline-edit-form" id="editForm_${log.groupLogID}">
                                <h5>🛠️ 공부 내용 수정</h5>
                                <form method="post" action="/editStudyLog/${group.groupID}">
                                    <input type="hidden" name="logID" id="editLogID_${log.groupLogID}">
                                    
                                    <label>날짜:</label>
                                    <input type="date" name="studyDate" id="editStudyDate_${log.groupLogID}" required>
                                    
                                    <label>공부 시간 (시간):</label>
                                    <input type="number" name="studyDuration" id="editStudyDuration_${log.groupLogID}" required>
                                    

                                    <label>공부 내용:</label>
                                    <textarea name="studyTopic" id="editStudyTopic_${log.groupLogID}" rows="4" required></textarea>


                                    <div class="form-buttons">
                                        <button type="submit">수정 완료</button>
                                        <button type="button" class="cancel-button" onclick="cancelEdit(${log.groupLogID})">취소</button>
                                    </div>
                                </form>
                            </div>
                        </c:if>
                    </div>
                </c:if>
            </c:forEach>
            
            <c:if test="${!hasLogs}">
                <div class="study-log-item" style="text-align: center; color: #666;">
                    <c:choose>
                        <c:when test="${not empty param.selectedDate}">
                            ${param.selectedDate}에 작성된 공부 기록이 없습니다.
                        </c:when>
                        <c:otherwise>
                            아직 작성된 공부 기록이 없습니다.
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </div>

        <c:if test="${isLeader or isUserJoined}">
            <div class="form-section">
                <h4>✏️ 새 공부 내용 작성</h4>
                <form method="post" action="/writeStudyLog/${group.groupID}">
                    <label for="studyDate">공부한 날짜:</label>
                    <input type="date" id="studyDate" name="studyDate" value="${currentDate}" required>

                    <label for="studyDuration">공부 시간 (시간):</label>
                    <input type="number" id="studyDuration" name="studyDuration" required>

                    <label for="studyTopic">공부 내용:</label>
                    <textarea id="studyTopic" name="studyTopic" rows="4" required></textarea>

                    <button type="submit">작성하기</button>
                </form>
            </div>
        </c:if>
    </div>
</div>

<script>
function filterByDate(selectedDate) {
    if (selectedDate) {
        window.location.href = '/studygroup/${group.groupID}?selectedDate=' + selectedDate;
    }
}
</script>

</body>
</html>