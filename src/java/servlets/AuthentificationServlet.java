/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import Database.SQLCon;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author mbp-de-zakaria
 */
@WebServlet(name = "AuthentificationServlet", urlPatterns = {"/AuthentificationServlet"})
public class AuthentificationServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
           Connection con=SQLCon.getConnection();
            HttpSession session=request.getSession();

         if(con!=null){
                 PreparedStatement pstmtUser = con.prepareStatement("select idCafe,NomComplet,Email,Permissions,idAdmin from OwnersAdminCafe where Email=? and MotDePasse=?");

                 pstmtUser.setString(1, request.getParameter("email"));
                 pstmtUser.setString(2, request.getParameter("motdepasse"));
                

                 ResultSet rs = pstmtUser.executeQuery();
                 
                 
                 if (rs.next()) {
                     int idCafOwner=rs.getInt(1);
                     int idAdmin=rs.getInt(5);
                     String NomCafe ="";
                     PreparedStatement pstCafe = con.prepareStatement("select Nom from Café where idCafe=?");
                     pstCafe.setInt(1, idCafOwner);
                     ResultSet rsC = pstCafe.executeQuery();
                     if(rsC.next()){
                         NomCafe=rsC.getString(1);
                     }
                     response.sendRedirect("Admin/Dashboard.jsp");
                     session.setAttribute("NomAdmin", rs.getString(2));
                     session.setAttribute("EmailAdmin", rs.getString(3));
                     session.setAttribute("Perm", rs.getString(4));
                     session.setAttribute("NomCafe", NomCafe);
                     session.setAttribute("idCafe", idCafOwner);
                     session.setAttribute("idAdmin", idAdmin);                     
                 }
                 else{
                    response.sendRedirect("Admin/index.jsp");
                    session.setAttribute("Status", "Email Ou Mot De Passe Incorrects");


                 }
                 
         }else{
                out.println("Erreur Connection");
            }
        }
        catch (SQLException ex) {
            Logger.getLogger(AuthentificationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        }
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
        processRequest(request, response);
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
