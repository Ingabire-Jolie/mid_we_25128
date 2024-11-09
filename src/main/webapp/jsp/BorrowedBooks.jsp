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
    <h2 class="text-center">My Borrowed Books</h2>

    <c:if test="${not empty message}">
        <div class="alert alert-info">${message}</div>
    </c:if>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>Title</th>
                <th>Author</th>
                <th>Borrow Date</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>

        <%

            String userId = (String) session.getAttribute("user_id");

            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {

                conn = DatabaseConnection.getConnection();
                String sql = "SELECT b.title, b.author, br.borrow_date, br.book_id " +
                             "FROM book b " +
                             "JOIN borrower br ON b.book_id = br.book_id " +
                             "WHERE br.user_id = ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, userId);
                rs = ps.executeQuery();

                while (rs.next()) {
                    String bookId = rs.getString("book_id");
                    String title = rs.getString("title");
                    String author = rs.getString("author");
                    String borrowDate = rs.getString("borrow_date");
        %>
                    <tr>
                        <td><%= title %></td>
                        <td><%= author %></td>
                        <td><%= borrowDate %></td>
                        <td>
                            <form action="rw/ac/auca/library/ReturnBookServlet" method="post">
                                <input type="hidden" name="book_id" value="<%= bookId %>">
                                <input type="hidden" name="user_id" value="<%= userId %>">
                                <button type="submit" class="btn btn-warning">Return</button>
                            </form>
                        </td>
                    </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            }
        %>

        </tbody>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
