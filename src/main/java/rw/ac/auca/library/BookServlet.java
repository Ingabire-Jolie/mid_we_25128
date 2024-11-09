package rw.ac.auca.library;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

@WebServlet("/BookServlet")
public class BookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            // Code for adding a book
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String category = request.getParameter("category");

            try {
                Connection connection = DatabaseConnection.getConnection();
                String sql = "INSERT INTO books (title, author, category, available) VALUES (?, ?, ?, true)";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setString(1, title);
                statement.setString(2, author);
                statement.setString(3, category);
                statement.executeUpdate();
                connection.close();
                response.sendRedirect("dashboard.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("dashboard.jsp?error=Failed to add book!");
            }
        } else if ("list".equals(action)) {
            // Code for listing books
            ArrayList<book> books = new ArrayList<>();
            try {
                Connection connection = DatabaseConnection.getConnection();
                String sql = "SELECT * FROM books";
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    books.add(new book(resultSet.getInt("id"), resultSet.getString("title"),
                            resultSet.getString("author"), resultSet.getString("category"),
                            resultSet.getBoolean("available")));
                }
                request.setAttribute("books", books);
                request.getRequestDispatcher("book_list.jsp").forward(request, response);
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("dashboard.jsp?error=Failed to load books!");
            }
        } else if ("edit".equals(action)) {
            // Code for editing a book
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String category = request.getParameter("category");

            try {
                Connection connection = DatabaseConnection.getConnection();
                String sql = "UPDATE books SET title = ?, author = ?, category = ? WHERE id = ?";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setString(1, title);
                statement.setString(2, author);
                statement.setString(3, category);
                statement.setInt(4, id);
                statement.executeUpdate();
                connection.close();
                response.sendRedirect("dashboard.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("dashboard.jsp?error=Failed to edit book!");
            }
        } else if ("delete".equals(action)) {
            // Code for deleting a book
            int id = Integer.parseInt(request.getParameter("id"));

            try {
                Connection connection = DatabaseConnection.getConnection();
                String sql = "DELETE FROM books WHERE id = ?";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setInt(1, id);
                statement.executeUpdate();
                connection.close();
                response.sendRedirect("dashboard.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("dashboard.jsp?error=Failed to delete book!");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
