<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String postId = request.getParameter("id");

    try {
        // Database connection
        String jdbcURL = "jdbc:mysql://localhost:3306/blog_platform";
        String jdbcUsername = "root";
        String jdbcPassword = "";

        Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

        // Delete post
        String sql = "DELETE FROM posts WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, postId);

        int rowsDeleted = stmt.executeUpdate();

        conn.close();

        if (rowsDeleted > 0) {
            response.sendRedirect("index.jsp");
        } else {
            out.println("<p>Failed to delete post.</p>");
        }
    } catch (Exception e) {
        out.println("<p>Error deleting post: " + e.getMessage() + "</p>");
    }
%>
