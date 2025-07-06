<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
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

        /* 로고 */
        .logo-container {
            text-align: center;
            padding: 20px 0;
        }

        .logo-container img {
            max-width: 180px;
            height: auto;
        }

        /* 회원가입 박스 */
        .signup-container {
            width: 450px;
            margin: 40px auto;
            background-color: #ffffff;
            padding: 30px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            border: 2px solid #5D3A00;
        }

        .signup-container h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        .signup-form label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }

        .signup-form input {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 6px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        .signup-form button {
            background-color: #D97706;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            font-size: 1rem;
            transition: background-color 0.3s ease;
        }

        .signup-form button:hover {
            background-color: #A86F1D;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            font-size: 0.95rem;
        }

        .login-link a {
            color: #5D3A00;
            font-weight: bold;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            text-align: left;
            margin-bottom: 10px;
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

    <!-- 로고 -->
    <div class="logo-container">
        <a href="/">
            <img src="/images/logo2.png" alt="Eduvate Logo" />
        </a>
    </div>

    <!-- 회원가입 폼 -->
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
                <div class="error-message">${error}</div>
            </c:if>

            <button type="submit">가입하기</button>
        </form>

        <div class="login-link">
            <p>이미 계정이 있으신가요? <a href="/login">로그인</a></p>
        </div>
    </div>

</body>
</html>
