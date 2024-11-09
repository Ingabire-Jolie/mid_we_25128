package rw.ac.auca.library;
import java.io.IOException;
import org.mindrot.BCrypt;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String phoneNumber = request.getParameter("phoneNumber");
        String password = request.getParameter("password");
        String membership = request.getParameter("membership");

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        User user = new User();
        user.setName(name);
        user.setPhoneNumber(phoneNumber);
        user.setHashedPassword(hashedPassword);
        user.setMembership(membership);

        try {
            Connection connection = DatabaseConnection.getConnection();
            String sql = "INSERT INTO users (name, phoneNumber, hashedPassword, membership) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, user.getName());
            statement.setString(2, user.getPhoneNumber());
            statement.setString(3, user.getHashedPassword());
            statement.setString(4, user.getMembership());
            statement.executeUpdate();
            connection.close();
            response.sendRedirect("success.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}