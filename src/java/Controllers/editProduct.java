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
@WebServlet(name = "editProduct", urlPatterns = {"/editProduct"})
public class editProduct extends HttpServlet {

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
        processRequest(request, response);
        
        String id = request.getParameter("product_id");
        String name = request.getParameter("product_name");
        String price = request.getParameter("price");
        String description = request.getParameter("product_description");
        String addedDate = request.getParameter("product_added_date");

        Connection con = null;
        try {
            con = DBConn.connectToDatabase("jdbc:mysql://localhost:3306/newproject", "root", "");
            
            PreparedStatement pst = con.prepareStatement("UPDATE products SET product_name = ?, price = ?, product_description = ?, product_added_date = ? WHERE product_id = ?");
            pst.setString(1, name);
            pst.setString(2, price);
            pst.setString(3, description);
            pst.setString(4, addedDate);
            pst.setString(5, id);
            
            int rowsAffected = pst.executeUpdate();
            if (rowsAffected > 0) {
                request.setAttribute("successMessage", "Product details updated successfully.");
            } else {
                request.setAttribute("errorMessage", "Failed to update product details.");
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(editProduct.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("errorMessage", "An error occurred while updating product details: " + ex.getMessage());
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(editProduct.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        // Forward the request back to the update form
        request.getRequestDispatcher("editProduct.jsp").forward(request, response);
    }
}

   

