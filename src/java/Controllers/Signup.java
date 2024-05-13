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

/**
 *
 * @author - AI -
 */
@WebServlet(name = "Signup", urlPatterns = {"/Signup"})
public class Signup extends HttpServlet {

     @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    String Username = request.getParameter("username");
    String Email = request.getParameter("email");
    String Address = request.getParameter("address");
    String Mobile = request.getParameter("mobile");
    String Password = request.getParameter("password");

    // Check if any required field is empty
    if (Username.isEmpty() || Email.isEmpty() || Address.isEmpty() || Mobile.isEmpty() || Password.isEmpty()) {
        // Set error message
        request.setAttribute("Message", "Please fill in all the fields.");
        // Forward back to signup page
        request.getRequestDispatcher("Signup.jsp").forward(request, response);
        return;
    }

    try {
        PreparedStatement pst;
        Connection con = null;

        con = DBConn.connectToDatabase("jdbc:mysql://localhost:3306/newproject", "root", "");
        
        // Check if email already exists
        pst = con.prepareStatement("SELECT * FROM userdetials WHERE email = ?");
        pst.setString(1, Email);
        ResultSet rs = pst.executeQuery();
        if (rs.next()) {
            // Email already exists, handle this case
            request.setAttribute("Message", "Email address already exists. Please use a different one.");
            request.getRequestDispatcher("Signup.jsp").forward(request, response);
            return; // Stop further execution
        }

        // Check if username already exists
        pst = con.prepareStatement("SELECT * FROM userdetials WHERE username = ?");
        pst.setString(1, Username);
        rs = pst.executeQuery();
        if (rs.next()) {
            // Username already exists, handle this case
            request.setAttribute("Message", "Username already exists. Please choose a different one.");
            request.getRequestDispatcher("Signup.jsp").forward(request, response);
            return; // Stop further execution
        }

        // Insert new user details
        pst = con.prepareStatement("INSERT INTO userdetials(username, email, address, mobile, password, role) VALUES (?, ?, ?, ?, ?, 'user')");
        pst.setString(1, Username);
        pst.setString(2, Email);
        pst.setString(3, Address);
        pst.setString(4, Mobile);
        pst.setString(5, Password);
        pst.execute();

        request.setAttribute("Message", "Hello " + Username + " Account created successfully. Now login to your account.");
        request.getRequestDispatcher("Login.jsp").forward(request, response);
    } catch (ClassNotFoundException ex) {
        ex.printStackTrace();
    } catch (SQLException ex) {
        Logger.getLogger(Signup.class.getName()).log(Level.SEVERE, null, ex);
    }
}


}