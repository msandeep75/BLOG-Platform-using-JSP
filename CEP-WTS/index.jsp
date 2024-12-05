<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog Platform</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header>
        <h1>Blog Platform</h1>
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
        <%
            List<Map<String, String>> posts = new ArrayList<>();

            try {
                // Database connection
                String jdbcURL = "jdbc:mysql://localhost:3306/blog_platform";
                String jdbcUsername = "root";
                String jdbcPassword = "";

                Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

                // Query to fetch posts
                String sql = "SELECT title, content, image_path FROM posts ORDER BY id DESC";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    Map<String, String> post = new HashMap<>();
                    post.put("title", rs.getString("title"));
                    post.put("content", rs.getString("content"));
                    post.put("photoPath", rs.getString("image_path"));
                    posts.add(post);
                }

                conn.close();
            } catch (Exception e) {
                out.println("<p>Error fetching posts: " + e.getMessage() + "</p>");
            }

            if (posts != null && !posts.isEmpty()) {
        %>
        <h1>Latest Posts</h1>
        <ul>
        <%
            for (Map<String, String> post : posts) {
                String title = post.get("title");
                String content = post.get("content").replace("\n", "<br>");
                String photoPath = post.get("photoPath");
        %>
            <li class="postcontent">
                <h2><%= title %></h2>
                <% if (photoPath != null && !photoPath.isEmpty()) { %>
                    <img src="<%= photoPath %>" alt="Post Image" style="width: 200px; height: 100px; display: block; margin: 10px 0;">
                <% } %>
                <p><%= content.length() > 100 ? content.substring(0, 100) + "..." : content %></p>
                <a href="viewPost.jsp?title=<%= title %>">Read More</a>

                <!-- Comment Submission Form -->
                <form action="addComment.jsp" method="post">
                    <input type="hidden" name="title" value="<%= title %>">
                    <textarea name="comment" placeholder="Add a comment for this post..." required></textarea>
                    <button type="submit">Submit Comment</button>
                </form>

                <h3>Comments:</h3>
                    <ul>
                    <%
                        String fetchCommentsSQL = "SELECT comment_text, created_at FROM comment WHERE post_title = ? ORDER BY created_at DESC";
                        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/blog_platform", "root", "");
                            PreparedStatement stmt = conn.prepareStatement(fetchCommentsSQL)) {
                            stmt.setString(1, title); // Use the current post title
                            ResultSet commentsRS = stmt.executeQuery();

                            while (commentsRS.next()) {
                                String commentText = commentsRS.getString("comment_text");
                                Timestamp commentTime = commentsRS.getTimestamp("created_at");
                    %>
                        <li>
                            <p><%= commentText %></p>
                            <small>Posted on: <%= commentTime %></small>
                        </li>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<li>Error loading comments: " + e.getMessage() + "</li>");
                        }
                    %>
                    </ul>
            </li>
        <%
            }
        %>
        </ul>
        <%
            } else {
        %>
        <p>No posts available.</p>
        <%
            }
        %>
    </main>

    <footer>
        <p>&copy; 2024 Blog Platform</p>
    </footer>
</body>
</html>
