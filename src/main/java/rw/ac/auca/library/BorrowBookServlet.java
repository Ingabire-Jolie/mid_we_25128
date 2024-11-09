package rw.ac.auca.library;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BorrowBookServlet")
public class BorrowBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookId = request.getParameter("book_id");
        String userId = request.getParameter("user_id");
        String borrowDate = java.time.LocalDate.now().toString();

        Connection conn = null;
        PreparedStatement psUpdateBook = null;
        PreparedStatement psInsertBorrower = null;

        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/auca_library_db", "root", "");
            String updateBookSql = "UPDATE book SET status = 'BORROWED' WHERE book_id = ?";
            psUpdateBook = conn.prepareStatement(updateBookSql);
            psUpdateBook.setString(1, bookId);
            psUpdateBook.executeUpdate();
            String insertBorrowerSql = "INSERT INTO borrower (borrower_id, book_id, user_id, borrow_date) VALUES (UUID(), ?, ?, ?)";
            psInsertBorrower = conn.prepareStatement(insertBorrowerSql);
            psInsertBorrower.setString(1, bookId);
            psInsertBorrower.setString(2, userId);
            psInsertBorrower.setString(3, borrowDate);
            psInsertBorrower.executeUpdate();

            request.getSession().setAttribute("message", "Book borrowed successfully!");
            response.sendRedirect("books.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Error borrowing the book.");
            response.sendRedirect("books.jsp");

        } finally {
            try {
                if (psUpdateBook != null) psUpdateBook.close();
                if (psInsertBorrower != null) psInsertBorrower.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
