/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
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
@WebServlet(name = "userDeleteSupplierServlet", urlPatterns = {"/userDeleteSupplierServlet"})
public class userDeleteSupplierServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       
    }

 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
         int supplierID = Integer.parseInt(request.getParameter("SupplierID"));
        Connection con = null;
        try {
            // Establish database connection
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/newproject", "root", ""); // Replace with your DB credentials

            // Execute delete query
            PreparedStatement pstmt = con.prepareStatement("DELETE FROM Suppliers WHERE SupplierID = ?");
            pstmt.setInt(1, supplierID);
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Successful deletion
                response.sendRedirect("user_ViweSupplier.jsp");
            } else {
                // Supplier not found or deletion failed
                response.getWriter().println("Supplier not found or deletion failed.");
            }
        } catch (Exception e) {
            // Handle exceptions
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            // Close the database connection
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    

}
