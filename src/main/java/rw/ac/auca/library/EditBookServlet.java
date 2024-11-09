package rw.ac.auca.library;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/editBook")
public class EditBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");

        try {
            Connection connection = DatabaseConnection.getConnection();
            String sql = "UPDATE book SET title = ?, author = ? WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, title);
            statement.setString(2, author);
            statement.setInt(4, id);
            statement.executeUpdate();
            connection.close();
            response.sendRedirect("jsp/book_management.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
