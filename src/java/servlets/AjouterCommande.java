/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import Database.SQLCon;
import java.io.IOException;
import java.io.PrintWriter;
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author mbp-de-zakaria
 */
@WebServlet(name = "AjouterCommande", urlPatterns = {"/AjouterCommande"})
public class AjouterCommande extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
             HttpSession session=request.getSession();
            Connection con = SQLCon.getConnection();
            if(con!=null){
                out.println(request.getParameter("Quantity"));
            out.println(request.getParameter("idClientCom"));
            out.println(request.getParameter("idCafeCom"));
            out.println(request.getParameter("idProdCom"));
            
            PreparedStatement psInsertCommande = con.prepareStatement("insert into Commande(idClientCom,idCafeCom,idProdCom,QuantitéCom)values(?,?,?,?);");
            psInsertCommande.setInt(1,Integer.parseInt(request.getParameter("idClientCom")));
            psInsertCommande.setInt(2,Integer.parseInt(request.getParameter("idCafeCom")));
            psInsertCommande.setInt(3,Integer.parseInt(request.getParameter("idProdCom")));
            psInsertCommande.setInt(4,Integer.parseInt(request.getParameter("Quantity")));
            
            int rsInsert = psInsertCommande.executeUpdate();
            if(rsInsert>0){
                
                response.sendRedirect("/CoffeeShop");
                session.setAttribute("MessageSuccesful","Ajouté Avec Succès");

            }else{
                out.println("Erreur Lors De L'insertion De La Commande");
            }
            
            
            }else{
                out.println("Erreur Connection");
            }
            
             
        } catch (SQLException ex) {
            Logger.getLogger(AjouterCommande.class.getName()).log(Level.SEVERE, null, ex);
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
