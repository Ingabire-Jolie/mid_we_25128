<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="rw.ac.auca.library.DatabaseConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assigned Shelves</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<%@ include file="menu.jsp" %>

<div class="container mt-5">
    <h2 class="text-center">Assigned Shelves for Books</h2>
    <table class="table table-bordered table-striped">
        <thead class="thead-dark">
            <tr>
                <th>Book Title</th>
                <th>Author</th>
                <th>Shelf ID</th>
                <th>Category</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection connection = DatabaseConnection.getConnection();
                String query = "SELECT b.title, b.author, s.shelf_id, s.book_category FROM book b JOIN shelf s ON b.book_id = s.book_id";
                PreparedStatement stmt = connection.prepareStatement(query);
                ResultSet resultSet = stmt.executeQuery();
                while (resultSet.next()) {
            %>
            <tr>
                <td><%= resultSet.getString("title") %></td>
                <td><%= resultSet.getString("author") %></td>
                <td><%= resultSet.getString("shelf_id") %></td>
                <td><%= resultSet.getString("book_category") %></td>
            </tr>
            <% 
                }
                resultSet.close();
                stmt.close();
                connection.close();
            %>
        </tbody>
    </table>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
