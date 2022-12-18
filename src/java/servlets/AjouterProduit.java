/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import Database.SQLCon;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author mbp-de-zakaria
 */
@WebServlet("/AjouterProduit")
@MultipartConfig
public class AjouterProduit extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        
        try ( PrintWriter out = response.getWriter()) {
             Connection con=SQLCon.getConnection();
            HttpSession session=request.getSession();

         if(con!=null){
                 Part part = request.getPart("image");
                 PreparedStatement pstmtAddP = con.prepareStatement("insert into Produit (Designation,Prix,Quantité,idCafe,idCategorie,Description,imageProduit) values (?,?,?,?,?,?,?);");

                 pstmtAddP.setString(1, request.getParameter("Designation"));
                 pstmtAddP.setInt(2, Integer.parseInt(request.getParameter("prix")));
                 pstmtAddP.setInt(3, Integer.parseInt(request.getParameter("quantite")));
                 pstmtAddP.setInt(4, Integer.parseInt(request.getParameter("idCafe")));
                 pstmtAddP.setInt(5, Integer.parseInt(request.getParameter("cat")));
                 pstmtAddP.setString(6, request.getParameter("Description"));
                 InputStream is = part.getInputStream();
                 pstmtAddP.setBlob(7, is);

                 int rsAddPr = pstmtAddP.executeUpdate();
                 if(rsAddPr>=1){
                   
                    response.sendRedirect("Admin/Products.jsp");

                 }
                 else{
                     out.println("Error Adding ");
                 }

            
        }
         
    } catch (SQLException ex) {
            Logger.getLogger(AuthentificationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
    
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(AjouterProduit.class.getName()).log(Level.SEVERE, null, ex);
        }
       
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(AjouterProduit.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
