import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/addComment")
public class AddComment extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database credentials
    private static final String DB_URL = "jdbc:mysql://localhost:3306/blog_platform";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form parameters
        String title = request.getParameter("title");
        String comment = request.getParameter("comment");

        if (title == null || title.isEmpty() || comment == null || comment.isEmpty()) {
            response.getWriter().println("Title and comment are required.");
            return;
        }

        // Insert the comment into the database
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // SQL query to insert the comment
            String sql = "INSERT INTO comments (post_title, comment_text) VALUES (?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, title);
                stmt.setString(2, comment);
                stmt.executeUpdate();
            }

            // Redirect back to the main page after successful comment submission
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            // Handle errors
            response.getWriter().println("Error adding comment: " + e.getMessage());
        }
    }
}
