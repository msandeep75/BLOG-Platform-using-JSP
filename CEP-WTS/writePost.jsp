<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Write a Post</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header>
        <h1>Write a New Blog Post</h1>
        <nav>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="about.jsp">About</a></li>
                <li><a href="writePost.jsp">Write a Post</a></li>
                <li><a href="login.jsp">Login</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <form action="submitPostServlet" method="post" enctype="multipart/form-data">
            <label for="title">Post Title:</label>
            <input type="text" id="title" name="title" placeholder="Enter the title" required>
            
            <label for="photo">Upload Photo (200px × 100px):</label>
            <input type="file" id="photo" name="photo" accept="image/*" required>

            <label for="content">Content:</label>
            <textarea id="content" name="content" placeholder="Write your blog post here..." required></textarea>

            <button type="submit">Publish</button>
        </form>
    </main>

    <footer>
        <p>&copy; 2024 Blog Platform</p>
    </footer>
</body>
</html>
