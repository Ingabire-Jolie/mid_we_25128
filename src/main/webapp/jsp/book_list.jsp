<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="rw.ac.auca.library.BookServlet" %>
<html>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>Book Management</title>
</head>
<body>
<div class="container">
    <h2 class="mt-5">Book List</h2>
    <table class="table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Author</th>
                <th>Category</th>
                <th>Available</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="book" items="${books}">
                <tr>
                    <td>${book.id}</td>
                    <td>${book.title}</td>
                    <td>${book.author}</td>
                    <td>${book.category}</td>
                    <td>${book.available ? 'Yes' : 'No'}</td>
                    <td>
                        <a href="#" data-toggle="modal" data-target="#editModal" data-id="${book.id}" 
                           data-title="${book.title}" data-author="${book.author}" data-category="${book.category}">
                           Edit
                        </a>
                        <a href="BookServlet?action=delete&id=${book.id}" class="text-danger">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <!-- Button trigger for Add Book Modal -->
    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addModal">Add Book</button>
</div>

<!-- Add Book Modal -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addBookLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="BookServlet" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="addBookLabel">Add Book</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="add">
                    <div class="form-group">
                        <label for="title">Title</label>
                        <input type="text" class="form-control" name="title" required>
                    </div>
                    <div class="form-group">
                        <label for="author">Author</label>
                        <input type="text" class="form-control" name="author" required>
                    </div>
                    <div class="form-group">
                        <label for="category">Category</label>
                        <input type="text" class="form-control" name="category" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Add Book</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Book Modal -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editBookLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="BookServlet" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="editBookLabel">Edit Book</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="id" id="edit-id">
                    <div class="form-group">
                        <label for="edit-title">Title</label>
                        <input type="text" class="form-control" name="title" id="edit-title" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-author">Author</label>
                        <input type="text" class="form-control" name="author" id="edit-author" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-category">Category</label>
                        <input type="text" class="form-control" name="category" id="edit-category" required>
                    </div>
               
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="rw.ac.auca.library.BookServlet" %>
<html>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>Book Management</title>
</head>
<body>

<%@ include file="menu.jsp" %> <!-- Include the navigation menu -->

<div class="container">
    <h2 class="mt-5">Book List</h2>
    <table class="table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Author</th>
                <th>Category</th>
                <th>Available</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="book" items="${books}">
                <tr>
                    <td>${book.id}</td>
                    <td>${book.title}</td>
                    <td>${book.author}</td>
                    <td>${book.category}</td>
                    <td>${book.available ? 'Yes' : 'No'}</td>
                    <td>
                        <a href="#" data-toggle="modal" data-target="#editModal" data-id="${book.id}" 
                           data-title="${book.title}" data-author="${book.author}" data-category="${book.category}">
                           Edit
                        </a>
                        <a href="BookServlet?action=delete&id=${book.id}" class="text-danger">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <!-- Button trigger for Add Book Modal -->
    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addModal">Add Book</button>
</div>

<!-- Add Book Modal -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addBookLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="BookServlet" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="addBookLabel">Add Book</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="add">
                    <div class="form-group">
                        <label for="title">Title</label>
                        <input type="text" class="form-control" name="title" required>
                    </div>
                    <div class="form-group">
                        <label for="author">Author</label>
                        <input type="text" class="form-control" name="author" required>
                    </div>
                    <div class="form-group">
                        <label for="category">Category</label>
                        <input type="text" class="form-control" name="category" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Add Book</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Book Modal -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editBookLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="BookServlet" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="editBookLabel">Edit Book</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="id" id="edit-id">
                    <div class="form-group">
                        <label for="edit-title">Title</label>
                        <input type="text" class="form-control" name="title" id="edit-title" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-author">Author</label>
                        <input type="text" class="form-control" name="author" id="edit-author" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-category">Category</label>
                        <input type="text" class="form-control" name="category" id="edit-category" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    $('#editModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var id = button.data('id');
        var title = button.data('title');
        var author = button.data('author');
        var category = button.data('category');

        var modal = $(this);
        modal.find('#edit-id').val(id);
        modal.find('#edit-title').val(title);
        modal.find('#edit-author').val(author);
        modal.find('#edit-category').val(category);
    });
</script>

</body>
</html>
