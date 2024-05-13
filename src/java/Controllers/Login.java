import Model.DBConn;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet checkResult = null;

            con = DBConn.connectToDatabase("jdbc:mysql://localhost:3306/newproject", "root", "");
            pst = con.prepareStatement("SELECT * FROM userdetials WHERE username = ?");
            pst.setString(1, username);

            checkResult = pst.executeQuery();

            if (checkResult.next()) {
                String role = checkResult.getString("role");
                String storedPassword = checkResult.getString("password");

                // Log the login attempt
                auditLogin(username, password, "Attempt", storedPassword.equals(password), role);

                if ("123".equals(password)) {
                    // Check if the password has been changed before
                    boolean passwordChanged = hasPasswordChanged(username);

                    if (passwordChanged) {
                        // Password has been changed before, do not allow to change password again
                        request.setAttribute("Message", "You have already changed your password. Please log in.");
                        request.getRequestDispatcher("Login.jsp").forward(request, response);
                    } else {
                        // Redirect to password change page if the password is "123" and it hasn't been changed before
                        response.sendRedirect("CreateNew.jsp?username=" + username);
                    }
                } else if (password.equals(storedPassword)) {
                    // Proceed with login process
                    HttpSession session = request.getSession(true);
                    session.setAttribute("UN", username);
                    request.setAttribute("Message", "Hello " + username);

                    if ("admin".equals(role)) {
                        response.sendRedirect("home.jsp");
                    } else if ("user".equals(role)) {
                        response.sendRedirect("userdashboard.jsp");
                    }
                } else {
                    // Incorrect password
                    request.setAttribute("Message", "Password is incorrect");
                    request.getRequestDispatcher("Login.jsp").forward(request, response);
                }
            } else {
                // User not found
                request.setAttribute("Message", "User not found");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }

        } catch (ClassNotFoundException | SQLException ex) {
            // Error handling
            request.setAttribute("Message", "Error: " + ex.getMessage());
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }

    // Method to log login attempts into the audit table
    private void auditLogin(String username, String password, String action, boolean success, String role) {
        try (Connection conn = DBConn.connectToDatabase("jdbc:mysql://localhost:3306/newproject", "root", "")) {
            String insertSql = "INSERT INTO userAudit (username, password, action, success, role) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pst = conn.prepareStatement(insertSql);
            pst.setString(1, username);
            pst.setString(2, password);
            pst.setString(3, action);
            pst.setBoolean(4, success);
            pst.setString(5, role);
            pst.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace(); // You might want to log this exception
        }
    }

    // Method to check if the password has been changed before
    private boolean hasPasswordChanged(String username) {
        try (Connection conn = DBConn.connectToDatabase("jdbc:mysql://localhost:3306/newproject", "root", "")) {
            String query = "SELECT password_changed FROM userdetails WHERE username = ?";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, username);
            ResultSet resultSet = pst.executeQuery();

            if (resultSet.next()) {
                return resultSet.getBoolean("password_changed");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace(); // You might want to log this exception
        }
        return false;
    }
}
