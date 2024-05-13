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
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author - AI -
 */
@WebServlet(name = "addproduct", urlPatterns = {"/addproduct"})
public class addproduct extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    }



   @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    Connection con = null;
    PreparedStatement pst = null;

    try {
        String pdname = request.getParameter("product_name");
        String price = request.getParameter("price");
        String de = request.getParameter("product_description");
        
        // Check if any of the fields are empty
        if (pdname.isEmpty() || price.isEmpty() || de.isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all the fields.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("addproduct.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        // Convert Java Date to Timestamp
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());

        try {
            con = DBConn.connectToDatabase("jdbc:mysql://localhost:3306/newproject", "root", "");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(addproduct.class.getName()).log(Level.SEVERE, null, ex);
        }
        pst = con.prepareStatement("INSERT INTO products(product_name, price, product_description, product_added_date) VALUES (?, ?, ?, ?)");

        pst.setString(1, pdname);
        pst.setString(2, price);
        pst.setString(3, de);
        pst.setTimestamp(4, timestamp); // Use setTimestamp to insert timestamp

        pst.executeUpdate();

        request.setAttribute("successMessage", "Product added successfully.");

        // Forward the request to the appropriate JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("addproduct.jsp");
        dispatcher.forward(request, response);
    } catch (SQLException e) {
        e.printStackTrace(); // Log the exception for debugging purposes
        
        request.setAttribute("errorMessage", "An error occurred while adding product: " + e.getMessage());

        // Forward the request to the appropriate JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("addproduct.jsp");
        dispatcher.forward(request, response);
    } finally {
        // Close PreparedStatement and Connection
        try {
            if (pst != null) {
                pst.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
    }
}



}


