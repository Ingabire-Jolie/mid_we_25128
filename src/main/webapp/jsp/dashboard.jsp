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
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="index.jsp">AUCA Library</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav mr-auto"></ul>
            <%
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("username") != null) {
                String username = (String) session.getAttribute("username");
                out.println("<span class='navbar-text'>Welcome, " + username + "</span>");
                out.println("<form action='LogoutServlet' method='post'><button type='submit' class='btn btn-danger ml-2'>Logout</button></form>");
            } else {
                out.println("<a class='btn btn-primary' href='#' data-toggle='modal' data-target='#loginModal'>Login</a>");
            }
            %>
        </div>
    </nav>

    <div class="container mt-4">
        <%
        if (session != null && session.getAttribute("userRole") != null) {
            String userRole = (String) session.getAttribute("userRole");

            switch (userRole) {
                case "Admin":
                    out.println("<h2>Admin Dashboard</h2>");
                    out.println("<p>You can manage users and books.</p>");
                    break;
                case "User":
                    out.println("<h2>User Dashboard</h2>");
                    out.println("<p>You can view your loan history and request new books.</p>");
                    break;
                case "Staff":
                    out.println("<h2>Staff Dashboard</h2>");
                    out.println("<p>You can manage loans and view requests from users.</p>");
                    break;
                default:
                    out.println("<h2>Dashboard</h2>");
                    out.println("<p>Welcome! Please log in to access your account.</p>");
            }
        } else {
            out.println("<h2>Dashboard</h2>");
            out.println("<p>Welcome! Please register or log in to access your account.</p>");
        }
        %>
    </div>
</div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
