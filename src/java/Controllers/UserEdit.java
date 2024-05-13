package Controllers;

import Model.DBConn;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UserEdit", urlPatterns = {"/UserEdit"})
public class UserEdit extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }
@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    processRequest(request, response);

    String id = request.getParameter("id");
    String Name = request.getParameter("username");
    String Email = request.getParameter("email");
    String Address = request.getParameter("address");
    String Mobile = request.getParameter("mobile");
    String Role = request.getParameter("role");

    try {
        Connection con = DBConn.connectToDatabase("jdbc:mysql://localhost:3306/newproject", "root", "");

        // Check if the new username is already in use by another user
        PreparedStatement pstUsernameCheck = con.prepareStatement("SELECT * FROM userdetials WHERE username = ? AND id != ?");
        pstUsernameCheck.setString(1, Name);
        pstUsernameCheck.setString(2, id);
        ResultSet rsUsernameCheck = pstUsernameCheck.executeQuery();
        if (rsUsernameCheck.next()) {
            request.setAttribute("errorMessage", "Username already exists. Please choose a different one.");
            con.close();
            request.getRequestDispatcher("editUser.jsp").forward(request, response);
            return;
        }

        // Check if the new email is already in use by another user
        PreparedStatement pstEmailCheck = con.prepareStatement("SELECT * FROM userdetials WHERE email = ? AND id != ?");
        pstEmailCheck.setString(1, Email);
        pstEmailCheck.setString(2, id);
        ResultSet rsEmailCheck = pstEmailCheck.executeQuery();
        if (rsEmailCheck.next()) {
            request.setAttribute("errorMessage", "Email address already exists. Please use a different one.");
            con.close();
            request.getRequestDispatcher("editUser.jsp").forward(request, response);
            return;
        }

        // Retrieve old values from userdetails table
        PreparedStatement pstOldValues = con.prepareStatement("SELECT * FROM userdetials WHERE id = ?");
        pstOldValues.setString(1, id);
        ResultSet rsOldValues = pstOldValues.executeQuery();
        String oldName = "";
        String oldEmail = "";
        String oldMobile = "";
        String oldAddress = "";
        String oldRole = "";
        if (rsOldValues.next()) {
            oldName = rsOldValues.getString("username");
            oldEmail = rsOldValues.getString("email");
            oldMobile = rsOldValues.getString("mobile");
            oldAddress = rsOldValues.getString("address");
            oldRole = rsOldValues.getString("role");
        }

        // Update user details
        PreparedStatement pst = con.prepareStatement(
                "UPDATE userdetials SET username = ?, email = ?, address = ?, mobile = ?, role = ? WHERE id = ?");
        pst.setString(1, Name);
        pst.setString(2, Email);
        pst.setString(3, Address);
        pst.setString(4, Mobile);
        pst.setString(5, Role);
        pst.setString(6, id);

        int rowsAffected = pst.executeUpdate();
        if (rowsAffected > 0) {
            // Log the action along with old and new values to the audit trail table
            logAction(con, Integer.parseInt(id), "Updated user details for user with ID: " + id, oldName, oldEmail,
                    oldMobile, oldAddress, oldRole, Name, Email, Mobile, Address, Role);
            request.setAttribute("successMessage", "User details updated successfully.");
        } else {
            request.setAttribute("errorMessage", "Failed to update user details.");
        }

        con.close();
    } catch (SQLException ex) {
        request.setAttribute("errorMessage", "Error: " + ex.getMessage());
    } catch (ClassNotFoundException ex) {
        request.setAttribute("errorMessage", "Error: " + ex.getMessage());
    }

    request.getRequestDispatcher("editUser.jsp").forward(request, response);
}

// Method to log actions along with old and new values to the audit trail table
private void logAction(Connection con, int userId, String action, String oldName, String oldEmail,
        String oldMobile, String oldAddress, String oldRole, String newName, String newEmail,
        String newMobile, String newAddress, String newRole) throws SQLException {
    String query = "INSERT INTO audit_trail (user_id, action, old_username, old_email, old_mobile, old_address, old_role, new_username, new_email, new_mobile, new_address, new_role) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement pst = con.prepareStatement(query);
    pst.setInt(1, userId);
    pst.setString(2, action);
    pst.setString(3, oldName);
    pst.setString(4, oldEmail);
    pst.setString(5, oldMobile);
    pst.setString(6, oldAddress);
    pst.setString(7, oldRole);
    pst.setString(8, newName);
    pst.setString(9, newEmail);
    pst.setString(10, newMobile);
    pst.setString(11, newAddress);
    pst.setString(12, newRole);
    pst.executeUpdate();
}

}
