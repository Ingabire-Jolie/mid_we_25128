<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="rw.ac.auca.library.DatabaseConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <title>AUCA Library Management</title>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="index.jsp">AUCA Library</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav mr-auto"></ul>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#registerModal">Register</button>
            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#loginModal">Login</button>
        </div>
    </nav>

    <div class="container mt-4">
        <h1>Welcome to AUCA Library Management System</h1>
        <p>This system allows users to manage books and loans effectively.</p>

        <%
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userRole") != null) {
            String userRole = (String) session.getAttribute("userRole");

            switch (userRole) {
                case "Admin":
                    out.println("<h2>Admin Dashboard</h2>");
                    out.println("<p>You have the ability to manage users and books.</p>");
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

    <!-- Register Modal -->
    <div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="registerModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="registerModalLabel">Register</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="RegisterServlet" method="post">
                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" class="form-control" name="username" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>
                        <div class="form-group">
                            <label for="phone">Phone Number</label>
                            <input type="text" class="form-control" name="phone" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Register</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Login Modal -->
    <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="loginModalLabel">Login</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="LoginServlet" method="post">
                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" class="form-control" name="username" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>
                        <button type="submit" class="btn btn-success">Login</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
