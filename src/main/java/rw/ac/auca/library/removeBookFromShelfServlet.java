package rw.ac.auca.library;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/removeBookFromShelfServlet")
public class removeBookFromShelfServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookId = request.getParameter("book_id");

        if (bookId == null || bookId.isEmpty()) {
            response.sendRedirect("assignedShelves.jsp?error=Please provide a book ID.");
            return;
        }

        try (Connection connection = DatabaseConnection.getConnection()) {
            String updateShelfSQL = "UPDATE shelf SET book_id = NULL, available_stock = available_stock + 1 WHERE book_id = ?";
            PreparedStatement stmt = connection.prepareStatement(updateShelfSQL);
            stmt.setString(1, bookId);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("assignedShelves.jsp?success=Book removed from shelf.");
            } else {
                response.sendRedirect("assignedShelves.jsp?error=Book not found on any shelf.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("assignedShelves.jsp?error=An error occurred while removing the book.");
        }
    }
}
