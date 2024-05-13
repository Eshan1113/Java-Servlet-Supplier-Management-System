/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Model.DBConn;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
@WebServlet(name = "UserManagement", urlPatterns = {"/UserManagement"})
public class UserManagement extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

   @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    try {
        PreparedStatement pst;
        Connection con = null;
        String Username = request.getParameter("name");
        String Email = request.getParameter("email");
        String Address = request.getParameter("address");
        String Mobile = request.getParameter("mobile");
        String Role = request.getParameter("role");

        con = DBConn.connectToDatabase("jdbc:mysql://localhost:3306/newproject", "root", "");
        
        // Check if the username already exists
        PreparedStatement checkStmt = con.prepareStatement("SELECT COUNT(*) FROM userdetials WHERE username = ?");
        checkStmt.setString(1, Username);
        ResultSet resultSet = checkStmt.executeQuery();
        resultSet.next();
        int count = resultSet.getInt(1);
        
        if (count > 0) {
            // Username already exists, handle this situation (e.g., show an error message)
            request.setAttribute("errorMessage", "Username already exists. Please choose a different one.");

            // Forward the request to UserDetails servlet or JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("userMangemets.jsp"); // Assuming UserDetails is mapped to appropriate URL
            dispatcher.forward(request, response);
            return; // Exit the method
        }
        
        pst = con.prepareStatement("INSERT INTO userdetials(username, email, address, mobile, role, password) VALUES (?, ?, ?, ?, ?,123)");

        pst.setString(1, Username);
        pst.setString(2, Email);
        pst.setString(3, Address);
        pst.setString(4, Mobile);
        pst.setString(5, Role);

        pst.execute();

        request.setAttribute("successMessage", "User added successfully.");

        // Forward the request to UserDetails servlet or JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("userMangemets.jsp"); // Assuming UserDetails is mapped to appropriate URL
        dispatcher.forward(request, response);
    } catch (Exception e) {
        // Set error message as request attribute
        request.setAttribute("errorMessage", "An error occurred while adding user.");

        // Forward the request to UserDetails servlet or JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("userMangemets.jsp"); // Assuming UserDetails is mapped to appropriate URL
        dispatcher.forward(request, response);
    }
}

}
