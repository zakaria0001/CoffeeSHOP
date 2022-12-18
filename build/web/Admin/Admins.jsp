<%-- 
    Document   : Admins
    Created on : Nov 24, 2022, 4:30:00 PM
    Author     : mbp-de-zakaria
--%>
<%@page import="java.util.Base64"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>   
<%@page import="Database.SQLCon"%>
<%@page import="java.sql.Connection"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <link rel="stylesheet" href="../style/style.css"/>
        <title>Admin Dashboard - CoffeeShop</title>
    </head>

    <body>
      
        <%if(session.getAttribute("NomAdmin")!=null){%> 
        <% Connection con = SQLCon.getConnection();%>
          <nav id="Navb">
            <li><a href="Dashboard.jsp">CoffeeShop</a>  </li>
               

            <%if(session.getAttribute("Perm").equals("Tout")){%>
                <li> <a href="Products.jsp"> Produits</a>   </li>
                 <li id="ActivePage"><a>Admins</a>  </li>
               <li> <a href="Commandes.jsp"> Commandes</a></li>

            <%}%>

            <li id="Logoutb" ><a id="Logout" href="#"><img src="../style/assets/logout.png" alt="alt"/></a></li>

            <li id="ProfileButton" >
                 
                <a style="color:#2C3639;" href="Contact.jsp">
                    <img id="ProfileImage" src="../style/assets/adminIcon.png" alt="alt"/>
                    <%=session.getAttribute("NomAdmin")%> | <%=session.getAttribute("NomCafe")%> </a> </li>
        </nav>
        
        <section id="FullSec">
              <section id="AddAdmin">
                <fieldset>
                    <legend>Ajouter Admin</legend>
                    <form method="GET" action="../AjouterAdmin">
                        <table id="AddPrTable">
                            
                            <tr>
                                <td>
                                    <span>Nom Complet : </span>    
                                     <input type="text" name="Nom" required>   
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>Email : </span>    
                                    <input  type="text" name ="Email" required>   
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>Mot De Passe : </span>    
                                    <input  type="password" name ="password" required>   
                                    <button id="Gen">Génerer</button>
                                </td>
                            </tr>
                            <input type="text" name="idCafe" value="<%=session.getAttribute("idCafe")%>" hidden >   
                            
                            
                            <tr>
                                <td>
                                    <span>Permissions :</span>
                                    <div style="float:right; width:70%">
                                    <label for="Perm">Tout</label>
                                    <input type="radio" name="Perm" value="Tout">
                                    
                                    <label>Ajout Produits</label>
                                    <input type="radio" name="Perm" value="Ajout">
                                    
                                    <label>Gestion Commandes</label>
                                    <input type="radio" name="Perm" value="Gestion Commandes">
                                    </div>
                                </td>
                              
                            </tr>
                            
                            <tr>
                                <td>
                                   
                                    <input type="submit"value="AJOUTER">
                                </td>
                            </tr>
                        </table>
                    </form>
                    </fieldset>
                </section>
             
                  
          </section>
                             <section id="ListAdmin" >
                  <table>
                      <tr>
                          <td>ID Admin</td>
                          <td>Nom Complet</td>
                          <td>Email</td>
                          <td>Mot De passe</td>
                          <td>Permissions </td>
                          <td>Actions </td>
                      </tr>
                      <%
                          PreparedStatement pstProd= con.prepareStatement("select * from OwnersAdminCafe where idCafe=?;");
                          
                          int idCafe=Integer.parseInt(String.valueOf(session.getAttribute("idCafe")));
                          pstProd.setInt(1,idCafe);
                          ResultSet rsProd=pstProd.executeQuery();

                          while(rsProd.next()){
                               
                         
                      %>
                      
                      <tr>
                          
                          <td><%=rsProd.getInt(1)%></td>
                           
                         
                          
                          <td><%=rsProd.getString(3)%> </td>
                          <td><%=rsProd.getString(4)%></td>    
                          <td style="-webkit-text-security: square;" ><%=rsProd.getString(5)%></td>
                          <td><%=rsProd.getString(6)%></td>
                          <td> 
                              <form method="POST" action="../SupprimerProduit">
                                  <input type="text" id="idProd" name="idProd"value="<%=rsProd.getInt(1)%>" hidden>
                                  <button class="DelButton" type="submit" name="Supprimer">Supprimer</button>

                              </form>     
                                  <button class="popUpBtn" data-modal="myModal1">Modifier</button>
                                  
                          </td>
                                                  

                        </tr>
                      <%}%>
                  </table>   
                  <section id="EditProd"> 
                            <div id="myModal1" class="modal">

                              <div class="modal-content">
                                <div class="modal-header">
                                  <span class="close">×</span>
                                  <h2>Modifier Produit</h2>
                                </div>
                                <div class="modal-body">
                                  
                                </div>
                               
                              </div>

                            </div>
                  </section>             
              </section> 
              <%}else{
 response.sendRedirect("/CoffeeShop/Admin/");
}%>
    </body>
</html>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="../style/jquery.min.js"></script>

<script>
    $("#Logout").click(function(){
        swal({
  title: "Etes Vous Sûre De Vouloir Quitter ?",
  text: "Voulez Vous Vous Deconnectez De La Session Administrateur ? ",
  icon: "warning",
  buttons: true,
  dangerMode: true,
})
.then((willDelete) => {
  if (willDelete) {
    window.location.replace("../Logout");
  }
});
})

</script>
