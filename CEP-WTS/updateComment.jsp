<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map, java.util.List" %>
<%@ page session="true" %>
<%
    // Retrieve the parameters for the post title, comment index, and the edited comment
    String postTitle = request.getParameter("postTitle");
    String commentIndexStr = request.getParameter("commentIndex");
    String updatedComment = request.getParameter("comment");

    int commentIndex = -1;
    if (commentIndexStr != null) {
        try {
            commentIndex = Integer.parseInt(commentIndexStr); // Convert to int
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid comment index");
            return;
        }
    }

    // Retrieve the comments map from application context
    Map<String, List<String>> commentsMap = (Map<String, List<String>>) application.getAttribute("commentsMap");
    List<String> comments = commentsMap != null ? commentsMap.get(postTitle) : null;

    if (comments != null && commentIndex >= 0 && commentIndex < comments.size()) {
        comments.set(commentIndex, updatedComment); // Update the comment
        application.setAttribute("commentsMap", commentsMap); // Save the updated map back
        response.sendRedirect("uindex.jsp"); // Redirect back to the admin panel
    } else {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Comment index out of bounds");
    }
%>
