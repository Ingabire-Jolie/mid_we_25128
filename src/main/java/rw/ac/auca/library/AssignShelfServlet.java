package rw.ac.auca.library;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/assignShelfServlet")
public class AssignShelfServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookId = request.getParameter("book_id");
        String shelfId = request.getParameter("shelf");

        if (bookId == null || shelfId == null || bookId.isEmpty() || shelfId.isEmpty()) {
            response.sendRedirect("books.jsp?error=Please select a shelf.");
            return;
        }

        try {
            Connection connection = DatabaseConnection.getConnection();

            // Update the shelf_id for the specific book in the database
            String sql = "UPDATE book SET shelf_id = ? WHERE book_id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, shelfId);
            preparedStatement.setString(2, bookId);

            int rowsUpdated = preparedStatement.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("books.jsp?success=Shelf assigned successfully.");
            } else {
                response.sendRedirect("books.jsp?error=Failed to assign shelf.");
            }

            preparedStatement.close();
            connection.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("books.jsp?error=An error occurred while assigning the shelf.");
        }
    }
}
