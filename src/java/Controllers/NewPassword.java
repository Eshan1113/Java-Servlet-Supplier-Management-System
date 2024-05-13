package Controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/newPassword")
public class NewPassword extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String newPassword = request.getParameter("password");
    String confPassword = request.getParameter("confPassword");
    RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");

    if (newPassword != null && confPassword != null && newPassword.equals(confPassword)) {
        Connection con = null;
        PreparedStatement pst = null;

        try {
            // Establish database connection
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/newproject", "root", "");

            // Prepare and execute SQL update statement
            HttpSession session = request.getSession();
            String email = (String) session.getAttribute("email");
            pst = con.prepareStatement("UPDATE userdetials SET password = ? WHERE email = ?");
            pst.setString(1, newPassword);
            pst.setString(2, email);

            int rowCount = pst.executeUpdate();

          if (rowCount > 0) {
    // Password update successful
    request.setAttribute("Message", "Password reset successfully.");
} else {
    // Password update failed
    request.setAttribute("Message", "Error: Password reset failed.");
}

        } catch (SQLException | ClassNotFoundException e) {
            // Log specific exception details
            e.printStackTrace();
            // Redirect to an error page or handle the error appropriately
            // For simplicity, I'm forwarding to Login.jsp with an error status
            request.setAttribute("status", "resetFailed");
            request.setAttribute("errorMessage", "An error occurred while updating your password. Please try again later.");
            System.err.println("Error updating password: " + e.getMessage());
        } finally {
            // Clean up resources
            try {
                if (pst != null) {
                    pst.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        // Passwords don't match
        request.setAttribute("status", "resetFailed");
        request.setAttribute("errorMessage", "Passwords do not match. Please make sure your passwords match.");
    }

    // Forward request and response to appropriate page
    dispatcher.forward(request, response);
}

}
