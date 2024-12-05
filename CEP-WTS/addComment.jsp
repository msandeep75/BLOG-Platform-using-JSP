<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String postTitle = request.getParameter("title");
    String commentText = request.getParameter("comment");

    if (postTitle != null && commentText != null && !postTitle.isEmpty() && !commentText.isEmpty()) {
        try {
            // Database connection
            String jdbcURL = "jdbc:mysql://localhost:3306/blog_platform";
            String jdbcUsername = "root";
            String jdbcPassword = "";

            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            // Insert comment into the database
            String sql = "INSERT INTO comment (post_title, comment_text) VALUES (?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, postTitle);
            stmt.setString(2, commentText);

            int rowsInserted = stmt.executeUpdate();

            conn.close();

            if (rowsInserted > 0) {
                response.sendRedirect("index.jsp"); // Redirect to the homepage after success
            } else {
                out.println("<p>Error adding the comment. Please try again.</p>");
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p>Invalid input. Please fill in the comment.</p>");
    }
%>
