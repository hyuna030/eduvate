<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

        .create-group-container {
            width: 600px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border: 2px solid #553830;
        }

        .create-group-container h2 {
            text-align: center;
            color: #333;
        }

        .create-group-form {
            margin-top: 20px;
            text-align: center;
        }

        .create-group-form label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }

        .create-group-form input, .create-group-form textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            box-sizing: border-box;
        }

        .create-group-form button {
            background-color: #553830;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            display: block;
            margin: 0 auto;
        }
    </style>
    <title>스터디 그룹 생성</title>
</head>
<body>

<div class="create-group-container">
    <h2>스터디 그룹 생성</h2>

    <!-- 스터디 그룹 생성 폼 -->
    <form class="create-group-form" action="/createStudyGroup" method="post" enctype="multipart/form-data">
        <label for="groupName">그룹 이름:</label>
        <input type="text" id="groupName" name="groupName" required>

        <label for="description">그룹 설명:</label>
        <textarea id="description" name="description" rows="4" required></textarea>

        <button type="submit">그룹 생성</button>
    </form>
</div>

</body>
</html>
