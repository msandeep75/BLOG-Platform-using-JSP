<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String postId = request.getParameter("id");
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String photoPath = request.getParameter("photoPath");

    try {
        // Database connection
        String jdbcURL = "jdbc:mysql://localhost:3306/blog_platform";
        String jdbcUsername = "root";
        String jdbcPassword = "";

        Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

        // Update post
        String sql = "UPDATE posts SET title = ?, content = ?, image_path = ? WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, title);
        stmt.setString(2, content);
        stmt.setString(3, photoPath);
        stmt.setString(4, postId);

        int rowsUpdated = stmt.executeUpdate();

        conn.close();

        if (rowsUpdated > 0) {
            response.sendRedirect("index.jsp");
        } else {
            out.println("<p>Failed to update post.</p>");
        }
    } catch (Exception e) {
        out.println("<p>Error updating post: " + e.getMessage() + "</p>");
    }
%>
