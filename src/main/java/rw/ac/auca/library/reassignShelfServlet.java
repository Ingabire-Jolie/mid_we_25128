package rw.ac.auca.library;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/reassignShelfServlet")
public class reassignShelfServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookId = request.getParameter("book_id");
        String newShelfId = request.getParameter("new_shelf_id");

        if (bookId == null || newShelfId == null || bookId.isEmpty() || newShelfId.isEmpty()) {
            response.sendRedirect("assignedShelves.jsp?error=Please select a shelf.");
            return;
        }

        try (Connection connection = DatabaseConnection.getConnection()) {
            String updateShelfSQL = "UPDATE shelf SET book_id = NULL WHERE book_id = ?";
            PreparedStatement removeBookStmt = connection.prepareStatement(updateShelfSQL);
            removeBookStmt.setString(1, bookId);
            removeBookStmt.executeUpdate();

            String assignNewShelfSQL = "UPDATE shelf SET book_id = ? WHERE shelf_id = ?";
            PreparedStatement assignNewShelfStmt = connection.prepareStatement(assignNewShelfSQL);
            assignNewShelfStmt.setString(1, bookId);
            assignNewShelfStmt.setString(2, newShelfId);
            assignNewShelfStmt.executeUpdate();

            response.sendRedirect("assignedShelves.jsp?success=Shelf reassigned successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("assignedShelves.jsp?error=An error occurred while reassigning the shelf.");
        }
    }
}
