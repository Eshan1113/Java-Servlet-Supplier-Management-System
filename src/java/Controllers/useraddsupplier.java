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
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "useraddsupplier", urlPatterns = {"/useraddsupplier"})
public class useraddsupplier extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       
    }

    
 

    
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    processRequest(request, response);
    Connection con = null;
    PreparedStatement pst = null;

    try {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String contactPerson = request.getParameter("contactPerson");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String postalCode = request.getParameter("postalCode");
        String country = request.getParameter("country");
        String notes = request.getParameter("notes");

        // Check if any required field is empty
        if (name.isEmpty() || email.isEmpty() || address.isEmpty() || phone.isEmpty() || contactPerson.isEmpty() ||
                city.isEmpty() || state.isEmpty() || postalCode.isEmpty() || country.isEmpty() || notes.isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all the fields.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("user_addsupplier.jsp");
            dispatcher.forward(request, response);
            return;
        }

        con = DBConn.connectToDatabase("jdbc:mysql://localhost:3306/newproject", "root", "");

        // Check if the email address already exists
        PreparedStatement pstEmailCheck = con.prepareStatement("SELECT * FROM suppliers WHERE Email = ?");
        pstEmailCheck.setString(1, email);
        ResultSet rsEmailCheck = pstEmailCheck.executeQuery();
        if (rsEmailCheck.next()) {
            request.setAttribute("errorMessage", "Email address already exists. Please use a different one.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("user_addsupplier.jsp");
            dispatcher.forward(request, response);
            return;
        }

        pst = con.prepareStatement("INSERT INTO suppliers(Name, ContactPerson, Email, Phone, Address, City, State, PostalCode, Country, Notes) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

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

        pst.executeUpdate();

        request.setAttribute("successMessage", "Supplier added successfully.");

        // Forward the request to the appropriate JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("user_addsupplier.jsp");
        dispatcher.forward(request, response);
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace(); // Log the exception for debugging purposes
        
        request.setAttribute("errorMessage", "An error occurred while adding supplier: " + e.getMessage());

        // Forward the request to the appropriate JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("user_addsupplier.jsp");
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

