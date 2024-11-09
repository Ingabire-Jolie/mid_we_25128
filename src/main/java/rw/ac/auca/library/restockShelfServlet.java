package rw.ac.auca.library;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/restockShelfServlet")
public class restockShelfServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String shelfId = request.getParameter("shelf_id");
        String stockIncrease = request.getParameter("stock_increase");

        if (shelfId == null || stockIncrease == null || shelfId.isEmpty() || stockIncrease.isEmpty()) {
            response.sendRedirect("shelves.jsp?error=Please provide the stock increment.");
            return;
        }

        try (Connection connection = DatabaseConnection.getConnection()) {
            String updateStockSQL = "UPDATE shelf SET available_stock = available_stock + ? WHERE shelf_id = ?";
            PreparedStatement stmt = connection.prepareStatement(updateStockSQL);
            stmt.setInt(1, Integer.parseInt(stockIncrease));
            stmt.setString(2, shelfId);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("assignedshelves.jsp?success=Stock restocked successfully.");
            } else {
                response.sendRedirect("assignedshelves.jsp?error=Shelf not found.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("assignedshelves.jsp?error=An error occurred while restocking.");
        }
    }
}

