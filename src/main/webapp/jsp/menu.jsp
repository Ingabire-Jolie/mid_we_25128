<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.HashMap" %>
<% 
    HttpSession session = request.getSession();
    String role = (String) session.getAttribute("userRole");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Menu</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEJ5b4iY5VvQIuR+POkHgxYHnZLrtprDPXUtrct+Jf3b6l2ql9rD8uMzIRHK1" crossorigin="anonymous">
    <style>
        .navbar-custom {
            background-color: #0056b3;
        }
        .navbar-custom a {
            color: white !important;
        }
        .navbar-custom a:hover {
            color: #ffd700 !important;
        }
        .nav-link {
            margin-right: 15px;
        }
        .container {
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Library System</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <% 
                    if (role != null) {
                        switch (role) {
                            case "LIBRARIAN":
                    %>
                        <li class="nav-item"><a class="nav-link" href="book_management.jsp">Manage Books</a></li>
                        <li class="nav-item"><a class="nav-link" href="approveMembership.jsp">Approve Membership</a></li>
                        <li class="nav-item"><a class="nav-link" href="assignShelfRoom.jsp">Assign Shelf to Room</a></li>
                        <li class="nav-item"><a class="nav-link" href="shelfstock.jsp">Check Room Inventory</a></li>
                        <li class="nav-item"><a class="nav-link" href="viewBorrowers.jsp">View Borrowers</a></li>
                    <% 
                        break;
                        case "STUDENT":
                        case "TEACHER":
                    %>
                        <li class="nav-item"><a class="nav-link" href="register.jsp">Register Membership</a></li>
                        <li class="nav-item"><a class="nav-link" href="borrowBook.jsp">Borrow Book</a></li>
                        <li class="nav-item"><a class="nav-link" href="mybooks.jsp">My Borrowed Books</a></li>
                    <% 
                        break;
                        case "MANAGER":
                        case "DEAN":
                        case "HOD":
                    %>
                        <li class="nav-item"><a class="nav-link" href="dashboard.jsp">View Library Dashboard</a></li>
                        <li class="nav-item"><a class="nav-link" href="book_list.jsp">View All Books</a></li>
                    <% 
                        break;
                        default:
                    %>
                        <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                    <% 
                        break;
                        }
                    } else {
                    %>
                        <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                    <% 
                    }
                    %>
                </ul>
            </div>
        </div>
    </nav>


    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz4fnFO9gyb2fF6vh3yXjDo1sF1hbfXbYyfAQF2ftk8vY/7FbbKjRSKNNp0" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-pzjw8f+ua7Kw1TIq0W4g9K5W5D1t5A4uAz0gq8kF5ldX5XHk7cvnF4tF5Eyl5cTm" crossorigin="anonymous"></script>
