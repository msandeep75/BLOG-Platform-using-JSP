<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.IOException" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>

<%
    String commentId = request.getParameter("id");
    
    if (commentId != null && !commentId.isEmpty()) {
        try {
            // Database connection details
            String jdbcURL = "jdbc:mysql://localhost:3306/blog_platform";
            String jdbcUsername = "root";
            String jdbcPassword = "";
            
            // Establish connection
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            
            // SQL query to delete the comment by id
            String sql = "DELETE FROM comment WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, commentId);
            
            // Execute the update
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                out.println("<p>Comment deleted successfully.</p>");
            } else {
                out.println("<p>No comment found with the provided ID.</p>");
            }

            // Close the connection
            conn.close();
        } catch (SQLException e) {
            out.println("<p>SQL Error: " + e.getMessage() + "</p>");
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p>No comment ID provided.</p>");
    }
%>
