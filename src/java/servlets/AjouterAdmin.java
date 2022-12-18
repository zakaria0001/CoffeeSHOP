
package servlets;

import Database.SQLCon;

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
 * @author mbp-de-zakaria
 */
@WebServlet(name = "AjouterAdmin", urlPatterns = {"/AjouterAdmin"})
public class AjouterAdmin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            Connection con = SQLCon.getConnection();
            if(con!=null){
                PreparedStatement psInsertAd = con.prepareStatement("insert into OwnersAdminCafe(idCafe,NomComplet,Email,MotDePasse,Permissions) values (?,?,?,?,?);");
                psInsertAd.setInt(1,Integer.parseInt(request.getParameter("idCafe")));
                psInsertAd.setString(2,request.getParameter("Nom"));
                psInsertAd.setString(3,request.getParameter("Email"));
                psInsertAd.setString(4,request.getParameter("password"));
                psInsertAd.setString(5,request.getParameter("Perm"));
                int rsInsertAd = psInsertAd.executeUpdate();
                if(rsInsertAd>=1){
                   response.sendRedirect("Admin/Admins.jsp");
                }else{
                   out.println("Erreur Insertion");
                }
            
            }else{
                out.println("Erreur Connection !");
            }
        }catch (SQLException ex) {
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
