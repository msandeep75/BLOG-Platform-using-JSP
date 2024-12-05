<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map, java.util.List" %>
<%@ page session="true" %>
<%
    // Retrieve the post title and comment index from the request parameters
    String postTitle = request.getParameter("postTitle");
    String commentIndexStr = request.getParameter("commentIndex");
    int commentIndex = -1;
    if (commentIndexStr != null) {
        try {
            commentIndex = Integer.parseInt(commentIndexStr); // Convert to int
        } catch (NumberFormatException e) {
            // Handle error, you can either return an error page or just skip
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid comment index");
            return;
        }
    }

    // Retrieve the comments map from application context
    Map<String, List<String>> commentsMap = (Map<String, List<String>>) application.getAttribute("commentsMap");
    List<String> comments = commentsMap != null ? commentsMap.get(postTitle) : null;

    String currentComment = null;
    if (comments != null && commentIndex >= 0 && commentIndex < comments.size()) {
        currentComment = comments.get(commentIndex); // Retrieve the comment to be edited
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Comment</title>
</head>
<body>
    <h1>Edit Comment for "<%= postTitle %>"</h1>

    <% if (currentComment != null) { %>
        <form action="updateComment.jsp" method="post">
            <input type="hidden" name="postTitle" value="<%= postTitle %>">
            <input type="hidden" name="commentIndex" value="<%= commentIndex %>">
            <textarea name="comment" rows="4" cols="50"><%= currentComment %></textarea><br>
            <button type="submit">Update Comment</button>
        </form>
    <% } else { %>
        <p>Comment not found!</p>
    <% } %>

    <a href="uindex.jsp">Back to Admin Panel</a>
</body>
</html>

