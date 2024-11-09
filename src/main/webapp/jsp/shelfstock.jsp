<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, rw.ac.auca.library.DatabaseConnection" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Borrowed Books</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<%@ include file="menu.jsp" %>

<div class="container mt-5">
<div class="container mt-5">
    <h2>Available Stock by Shelf</h2>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Shelf ID</th>
                <th>Available Stock</th>
                <th>Book Category</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection connection = DatabaseConnection.getConnection();
                String query = "SELECT shelf_id, available_stock, book_category FROM shelf";
                PreparedStatement stmt = connection.prepareStatement(query);
                ResultSet resultSet = stmt.executeQuery();
                while (resultSet.next()) {
            %>
            <tr>
                <td><%= resultSet.getString("shelf_id") %></td>
                <td><%= resultSet.getInt("available_stock") %></td>
                <td><%= resultSet.getString("book_category") %></td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>
</div>
</body>
</html>
