<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="style.css">
    
</head>
<body>
    <header>
        <h1>Login Blog Platform</h1>
        <nav>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="about.jsp">About</a></li>
                <li><a href="writePost.jsp">Write a Post</a></li>
                <li><a href="login.jsp">Login</a></li>
            </ul>
        </nav>
    </header>
    <%
        String error = request.getParameter("error");
        if (error != null && error.equals("1")) {
    %>
        <p style="color: red;">Invalid username or password. Please try again.</p>
    <%
        }
    %>
    <form action="validateLogin.jsp" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>
        <button type="submit">Login</button>
    </form>
    <footer>
        <p>&copy; 2024 Blog Platform</p>
    </footer>
</body>
</html>
