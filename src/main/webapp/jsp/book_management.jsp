<%@ page import="rw.ac.auca.library.DatabaseConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Book Management</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-5">
    <h2>Book Management</h2>
    <button class="btn btn-primary mb-3" data-toggle="modal" data-target="#addBookModal">Add Book</button>

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Title</th>
                <th>Author</th>
                <th>Publication Date</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection connection = DatabaseConnection.getConnection();
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery("SELECT * FROM book");
                while (resultSet.next()) {
            %>
            <tr>
                <td><%= resultSet.getString("title") %></td>
                <td><%= resultSet.getString("author") %></td>
                <td><%= resultSet.getDate("publication_date") %></td>
                <td><%= resultSet.getString("status") %></td>
                <td>
                    <button class="btn btn-warning btn-sm" data-toggle="modal" data-target="#editBookModal<%= resultSet.getString("book_id") %>">Edit</button>
                    <button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteBookModal<%= resultSet.getString("book_id") %>">Delete</button>
                    <button class="btn btn-info btn-sm" data-toggle="modal" data-target="#assignShelfModal<%= resultSet.getString("book_id") %>">Assign Shelf</button>
                </td>
            </tr>

            <!-- Assign Shelf Modal -->
            <div class="modal fade" id="assignShelfModal<%= resultSet.getString("book_id") %>" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <form action="assignShelfServlet" method="post">
                            <div class="modal-header">
                                <h5 class="modal-title">Assign Shelf</h5>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="book_id" value="<%= resultSet.getString("book_id") %>">
                                <div class="form-group">
                                    <label for="shelf">Shelf</label>
                                    <select name="shelf" class="form-control" required>
                                        <option value="">Select Shelf</option>
                                        <%
                                            // Fetch available shelves from the database
                                            Statement shelfStatement = connection.createStatement();
                                            ResultSet shelves = shelfStatement.executeQuery("SELECT * FROM shelf");
                                            while (shelves.next()) {
                                        %>
                                        <option value="<%= shelves.getString("shelf_id") %>"><%= shelves.getString("shelf_name") %></option>
                                        <% } %>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">Assign Shelf</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Edit Book Modal -->
            <div class="modal fade" id="editBookModal<%= resultSet.getString("book_id") %>" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <form action="editBookServlet" method="post">
                            <div class="modal-header">
                                <h5 class="modal-title">Edit Book</h5>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="book_id" value="<%= resultSet.getString("book_id") %>">
                                <div class="form-group">
                                    <label>Title</label>
                                    <input type="text" name="title" class="form-control" value="<%= resultSet.getString("title") %>">
                                </div>
                                <div class="form-group">
                                    <label>Author</label>
                                    <input type="text" name="author" class="form-control" value="<%= resultSet.getString("author") %>">
                                </div>
                                <div class="form-group">
                                    <label>Publication Date</label>
                                    <input type="date" name="publication_date" class="form-control" value="<%= resultSet.getDate("publication_date") %>">
                                </div>
                                <div class="form-group">
                                    <label>Status</label>
                                    <select name="status" class="form-control">
                                        <option value="AVAILABLE" <%= resultSet.getString("status").equals("AVAILABLE") ? "selected" : "" %>>Available</option>
                                        <option value="BORROWED" <%= resultSet.getString("status").equals("BORROWED") ? "selected" : "" %>>Borrowed</option>
                                        <option value="RESERVED" <%= resultSet.getString("status").equals("RESERVED") ? "selected" : "" %>>Reserved</option>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">Save changes</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Delete Book Modal -->
            <div class="modal fade" id="deleteBookModal<%= resultSet.getString("book_id") %>" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <form action="deleteBook" method="post">
                            <div class="modal-header">
                                <h5 class="modal-title">Delete Book</h5>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <div class="modal-body">
                                <p>Are you sure you want to delete this book?</p>
                                <input type="hidden" name="book_id" value="<%= resultSet.getString("book_id") %>">
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-danger">Delete</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <% } %>
        </tbody>
    </table>
</div>

<!-- Add Book Modal -->
<div class="modal fade" id="addBookModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="addBookServlet" method="post">
                <div class="modal-header">
                    <h5 class="modal-title">Add Book</h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Title</label>
                        <input type="text" name="title" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Author</label>
                        <input type="text" name="author" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Publication Date</label>
                        <input type="date" name="publication_date" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Status</label>
                        <select name="status" class="form-control">
                            <option value="AVAILABLE">Available</option>
                            <option value="BORROWED">Borrowed</option>
                            <option value="RESERVED">Reserved</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Add Book</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
