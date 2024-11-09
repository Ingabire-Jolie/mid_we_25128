
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class ReturnBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String borrowerId = request.getParameter("borrowerId");
        int fine = 0;

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library_db", "username", "password")) {
            String query = "SELECT b.borrow_date, mt.fee_per_day FROM borrower b " +
                           "JOIN user u ON b.user_id = u.user_id " +
                           "JOIN membership m ON u.user_id = m.user_id " +
                           "JOIN membership_type mt ON m.membership_type_id = mt.membership_type_id " +
                           "WHERE b.borrower_id = ?";

            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, borrowerId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Date borrowDate = rs.getDate("borrow_date");
                int feePerDay = rs.getInt("fee_per_day");

                Date dueDate = new Date(borrowDate.getTime() + (14L * 24 * 60 * 60 * 1000));
                long lateDays = (System.currentTimeMillis() - dueDate.getTime()) / (24 * 60 * 60 * 1000);

                if (lateDays > 0) {
                    fine = (int) lateDays * feePerDay;
                }

                String updateFineQuery = "UPDATE borrower SET fine = ? WHERE borrower_id = ?";
                PreparedStatement updatePs = conn.prepareStatement(updateFineQuery);
                updatePs.setInt(1, fine);
                updatePs.setString(2, borrowerId);
                updatePs.executeUpdate();
            }

            response.sendRedirect("ReturnBook.jsp?borrowerId=" + borrowerId + "&fine=" + fine);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error while calculating fine.");
        }
    }
}