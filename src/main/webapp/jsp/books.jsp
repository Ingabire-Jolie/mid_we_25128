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
    <h2 class="text-center">Available Books</h2>

    <!-- Display any success or error messages -->
    <c:if test="${not empty message}">
        <div class="alert alert-info">${message}</div>
    </c:if>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>Title</th>
                <th>Author</th>
                <th>Publication Date</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>

        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/auca_library_db", "root", "");

                String sql = "SELECT * FROM book WHERE status = 'AVAILABLE'";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    String bookId = rs.getString("book_id");
                    String title = rs.getString("title");
                    String author = rs.getString("author");
                    String publicationDate = rs.getString("publication_date");
                    String status = rs.getString("status");
        %>
                    <tr>
                        <td><%= title %></td>
                        <td><%= author %></td>
                        <td><%= publicationDate %></td>
                        <td><%= status %></td>
                        <td>
                            <form action="BorrowBookServlet" method="post">
                                <input type="hidden" name="book_id" value="<%= bookId %>">
                                <input type="hidden" name="user_id" value="<%= session.getAttribute("user_id") %>">
                                <button type="submit" class="btn btn-primary">Borrow</button>
                            </form>
                        </td>
                    </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>

        </tbody>
    </table>
</div>

</body>
</html>