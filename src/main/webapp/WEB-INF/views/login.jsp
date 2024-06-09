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

        .login-container {
            width: 450px; 
            margin: 20px auto;
            background-color: #fff; 
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border: 2px solid #553830; 
        }

        .login-container h2 {
            text-align: center;
            color: #333;
        }

        .login-form {
            margin-top: 20px;
        }

        .login-form label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }

        .login-form input {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            box-sizing: border-box;
        }

        .login-form button {
            background-color: #553830; 
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 0 auto;
            display: block; 
        }

        .signup-link {
            text-align: center;
            margin-top: 20px;
        }

        .signup-link a {
            color: #4CAF50;
            text-decoration: none;
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
    </style>
    <title>로그인</title>
</head>
<body>

    <div class="logo-container">
        <a href="/"><img src="/images/logo2.png" alt="logo"></a>
    </div>

    <div class="login-container">
    <h2>로그인</h2>
    <form class="login-form" action="/login" method="post">
        <label for="UserID">아이디:</label>
        <input type="text" id="UserID" name="UserID" required>


        <label for="Password">비밀번호:</label>
        <input type="password" id="Password" name="Password" required>
        <c:if test="${not empty error}">
    		<div style="color: red; text-align: left; margin-top: 5px;">
        		${error}
    		</div>
    		<br>
		</c:if>

        <button type="submit">로그인</button>
    </form>

    <div class="signup-link">
        <p>계정이 없으신가요? <a href="/register">가입하기</a></p>
    </div>
</div>



</body>
</html>




