<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>

<head>
    <link rel="stylesheet" href="style.css">
</head>

<%
    String title = request.getParameter("title");
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    List<String> comments = new ArrayList<>();
    String content = "";

    try {
        // Database connection
        String jdbcURL = "jdbc:mysql://localhost:3306/blog_platform";
        String jdbcUsername = "root";
        String jdbcPassword = "";

        conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

        // Fetch post by title
        String sql = "SELECT id, title, content FROM posts WHERE title = ?";
        PreparedStatement stmt1 = conn.prepareStatement(sql);
        stmt1.setString(1, title);
        rs = stmt1.executeQuery();

        if (rs.next()) {
            content = rs.getString("content");
            int postId = rs.getInt("id");

            // Fetch comments using postId
            String commentSql = "SELECT comment FROM comments WHERE post_id = ? ORDER BY id DESC";
            PreparedStatement commentStmt = conn.prepareStatement(commentSql);
            commentStmt.setInt(1, postId);
            ResultSet commentRs = commentStmt.executeQuery();

            while (commentRs.next()) {
                comments.add(commentRs.getString("comment"));
            }
        }
    } catch (Exception e) {
        out.println("<p>Error fetching post or comments: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }

    if (!content.isEmpty()) {
%>
    <h1><%= title %></h1>
    <p><%= content %></p>
    <a href="uindex.jsp">Back to Home</a>

<%
    } else {
%>
    <p>Post not found.</p>
<%
    }
%>

