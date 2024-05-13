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
@WebServlet(name = "ChangePassword", urlPatterns = {"/ChangePassword"})
public class ChangePassword extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String newPassword = request.getParameter("password");
        String username = request.getParameter("username");

        try {
            if (newPassword == null || username == null) {
                throw new IllegalArgumentException("Username or password cannot be null.");
            }

            Connection con = null;
            PreparedStatement pstmt = null;

            try {
                con = DBConn.connectToDatabase("jdbc:mysql://localhost:3306/newproject", "root", "");
            } catch (SQLException ex) {
                request.setAttribute("Message", "Error connecting to the database: " + ex.getMessage());
                request.getRequestDispatcher("CreateNew.jsp").forward(request, response);
                return; // Added return to stop further execution
            }

            pstmt = con.prepareStatement("UPDATE userdetials SET password = ? WHERE username = ?");
            pstmt.setString(1, newPassword);
            pstmt.setString(2, username);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                if (rowsAffected > 0) {
                    request.setAttribute("Message", "Password changed successfully Now Login");
                    request.getRequestDispatcher("Login.jsp").forward(request, response);
                } else {
                    request.setAttribute("Message", "Failed to change password");
                    request.getRequestDispatcher("CreateNew.jsp").forward(request, response);
                }

            }

            pstmt.close();
            con.close();

        } catch (ClassNotFoundException | SQLException | IllegalArgumentException ex) {
            request.setAttribute("Message", "Error: " + ex.getMessage());
            request.getRequestDispatcher("CreateNew.jsp").forward(request, response);
        }
    }

}
