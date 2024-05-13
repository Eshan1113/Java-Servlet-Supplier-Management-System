/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

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

/**
 *
 * @author - AI -
 */
@WebServlet(name = "SupplierEdit", urlPatterns = {"/SupplierEdit"})
public class SupplierEdit extends HttpServlet {

  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
      
    }

 
  @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    processRequest(request, response);
    try {
        // Retrieve form data
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String contactPerson = request.getParameter("contactPerson");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String postalCode = request.getParameter("postalCode");
        String country = request.getParameter("country");
        String notes = request.getParameter("notes");

        // Check if the updated email already exists for another supplier
        if (emailExistsForAnotherSupplier(id, email)) {
            request.setAttribute("errorMessage", "Email address is already used by another supplier. Please use a different one.");
            request.getRequestDispatcher("editsupplier.jsp").forward(request, response);
            return;
        }

        // Update supplier in database
        try (Connection conn = DBConn.connectToDatabase("jdbc:mysql://localhost:3306/newproject", "root", "")) {
            String updateSql = "UPDATE Suppliers SET Name=?, ContactPerson=?, Email=?, Phone=?, Address=?, City=?, State=?, PostalCode=?, Country=?, Notes=? WHERE SupplierID=?";
            PreparedStatement pst = conn.prepareStatement(updateSql);
            pst.setString(1, name);
            pst.setString(2, contactPerson);
            pst.setString(3, email);
            pst.setString(4, phone);
            pst.setString(5, address);
            pst.setString(6, city);
            pst.setString(7, state);
            pst.setString(8, postalCode);
            pst.setString(9, country);
            pst.setString(10, notes);
            pst.setString(11, id);
            int rowsAffected = pst.executeUpdate();

            if (rowsAffected > 0) {
                // Success message
                request.setAttribute("successMessage", "Supplier details updated successfully.");
            } else {
                // Error message if no rows affected
                request.setAttribute("errorMessage", "Failed to update supplier details.");
            }
        } catch (SQLException e) {
            // SQL error handling
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
        }
    } catch (Exception e) {
        // General error handling
        e.printStackTrace();
        request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
    }
    // Redirect back to the form page
    request.getRequestDispatcher("editsupplier.jsp").forward(request, response);
}

// Method to check if the updated email already exists for another supplier
private boolean emailExistsForAnotherSupplier(String supplierId, String email) throws SQLException, ClassNotFoundException {
    try (Connection con = DBConn.connectToDatabase("jdbc:mysql://localhost:3306/newproject", "root", "");
         PreparedStatement pst = con.prepareStatement("SELECT * FROM Suppliers WHERE Email = ? AND SupplierID != ?")) {
        pst.setString(1, email);
        pst.setString(2, supplierId);
        try (ResultSet rs = pst.executeQuery()) {
            return rs.next(); // If result set has next, email exists for another supplier
        }
    }
}


}
