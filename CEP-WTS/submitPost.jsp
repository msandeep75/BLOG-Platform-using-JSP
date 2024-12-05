<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.nio.file.Paths" %>

<%
    String title = request.getParameter("title");
    String content = null;
    String photoPath = null;

    try {
        // Handle multipart form data
        for (Part part : request.getParts()) {
            if (part.getName().equals("content")) {
                content = request.getParameter("content");
            } else if (part.getName().equals("photo") && part.getSize() > 0) {
                // Save the uploaded file to the server
                String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String uploadPath = application.getRealPath("/") + "uploads/";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                photoPath = "uploads/" + fileName;
                part.write(uploadPath + fileName);
            }
        }

        // Store the post details
        if (application.getAttribute("posts") == null) {
            application.setAttribute("posts", new ArrayList<Map<String, String>>());
        }

        List<Map<String, String>> posts = (List<Map<String, String>>) application.getAttribute("posts");
        Map<String, String> post = new HashMap<>();
        post.put("title", title);
        post.put("content", content);
        post.put("photoPath", photoPath != null ? photoPath : ""); // Handle cases with no photo
        posts.add(post);

        application.setAttribute("posts", posts);

        response.sendRedirect("index.jsp");
    } catch (Exception e) {
        out.println("<p>Error occurred: " + e.getMessage() + "</p>");
    }
%>
