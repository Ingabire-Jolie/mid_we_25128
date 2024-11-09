package rw.ac.auca.library;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.UUID;

@WebServlet("/addBook")
public class AddBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publicationDate = request.getParameter("publication_date");

        String sql = "INSERT INTO book (book_id, title, author, publication_date) VALUES (?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, UUID.randomUUID().toString());
            ps.setString(2, title);
            ps.setString(3, author);
            ps.setString(4, publicationDate);
            ps.executeUpdate();
            response.getWriter().println("Book added successfully");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error adding book");
        }
    }
}
