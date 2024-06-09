<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .signup-container {
            width: 450px; /* 가로 넓이 조절 */
            margin: 20px auto; /* 상단 간격 조절 */
            background-color: #fff; /* 배경색 유지 */
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border: 2px solid #553830; /* 경계를 갈색으로 변경 */
        }

        .signup-container h2 {
            text-align: center;
            color: #333;
        }

        .signup-form {
            margin-top: 20px;
        }

        .signup-form label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }

        .signup-form input {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            box-sizing: border-box;
        }

        .signup-form button {
            background-color: #553830; /* 갈색으로 변경 */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            display: block; /* 블록 레벨로 변경 */
            margin: 0 auto; /* 가운데 정렬 추가 */
        }

        .login-link {
            text-align: center; /* 가운데 정렬 추가 */
            margin-top: 10px;
        }

        .login-link a {
            color: #4CAF50;
            text-decoration: none;
        }

        .logo-container {
            text-align: center;
            margin-top: 10px;
        }

        .logo-container img {
            max-width: 10%; /* 크기 증가 */
            height: auto;
            cursor: pointer;
        }
    </style>
    <title>회원가입</title>
</head>
<body>

    <div class="logo-container">
        <a href="/"><img src="/images/logo2.png" alt="logo"></a>
    </div>

    <div class="signup-container">
        <h2>회원가입</h2>

        <form class="signup-form" action="/register" method="post">
            <label for="UserID">아이디:</label>
            <input type="text" id="UserID" name="UserID" required>

            <label for="Password">비밀번호:</label>
            <input type="password" id="Password" name="Password" required>

            <label for="Username">닉네임:</label>
            <input type="text" id="Username" name="Username" required>
            
            <c:if test="${not empty error}">
    		<div style="color: red; text-align: left; margin-top: 5px;">
        		${error}
    		</div>
    		<br>
			</c:if>

            <button type="submit">가입하기</button>
        </form>

        <div class="login-link">
            <p>이미 계정이 있으신가요? <a href="/login">로그인</a></p>
        </div>
    </div>

</body>
</html>
