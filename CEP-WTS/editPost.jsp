<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String postId = request.getParameter("id");
    String title = "", content = "", photoPath = "";

    try {
        // Database connection
        String jdbcURL = "jdbc:mysql://localhost:3306/blog_platform";
        String jdbcUsername = "root";
        String jdbcPassword = "";

        Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

        // Fetch post details
        String sql = "SELECT title, content, image_path FROM posts WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, postId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
            content = rs.getString("content");
            photoPath = rs.getString("image_path");
        }

        conn.close();
    } catch (Exception e) {
        out.println("<p>Error fetching post: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Post</title>
    
</head>
<body>
    <h1>Edit Post</h1>
    <form action="updatePost.jsp" method="post">
        <input type="hidden" name="id" value="<%= postId %>">
        <label>Title: <input type="text" name="title" value="<%= title %>" required></label><br>
        <label>Content:</label><br>
        <textarea name="content" rows="5" cols="40" required><%= content %></textarea><br>
        <label>Image Path: <input type="text" name="photoPath" value="<%= photoPath %>"></label><br>
        <button type="submit">Update</button>
    </form>
</body>
</html>

