<%-- 
    Document   : Commandes
    Created on : Dec 17, 2022, 5:53:25 PM
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

        <title>Admin Dashboard - CoffeeShop </title>
    </head>
    <body>
        <%if(session.getAttribute("NomAdmin")!=null){%> 
        <% Connection con = SQLCon.getConnection();%>
          <nav id="Navb">
            <li><a href="Dashboard.jsp">CoffeeShop</a>  </li>
            <li ><a href="Products.jsp" >Produits</a>  </li>

            <%if(session.getAttribute("Perm").equals("Tout")){%>
            <li> <a href="Admins.jsp"> Admins</a> </li>
            <li id="ActivePage"> <a> Commandes</a></li>

            <%}%>
                <li id="Logoutb"><a id="Logout" href="#"><img src="../style/assets/logout.png" alt="alt"/></a></li>

            <li id="ProfileButton" > 

                <a style="color:#2C3639;" href="Contact.jsp">
                     <img id="ProfileImage" src="../style/assets/adminIcon.png" alt="alt"/>

                    <%=session.getAttribute("NomAdmin")%> | <%=session.getAttribute("NomCafe")%> </a> </li>
        </nav>
         
               <section id="ListProd">
                  <input type="text" style="width:92%;margin:4%;height:45px;" placeholder="Cherchez Une Commande .....">
                  <table>
                      <tr>
                          <td>ID Commande</td>
                          <td>Client </td>
                          <td>Produit</td>
                          <td>Quantité</td>
                          <td>Date | Temps  Commande </td>
                          <td>Totale</td>
                          <td>Actions </td>
                      </tr>
                      <%
                          PreparedStatement pstCommande= con.prepareStatement("select * from Commande where idCafeCom=? order by DateTempsCommande DESC;");
                          byte[] imgData;
                          int idCafe=Integer.parseInt(String.valueOf(session.getAttribute("idCafe")));
                          pstCommande.setInt(1,idCafe);
                          ResultSet rsCommande=pstCommande.executeQuery();

                          while(rsCommande.next()){
                           
                               
                         
                      %>
                      
                      <tr>
                          <td><%=rsCommande.getInt(1)%></td>
                                    <%
                                     PreparedStatement pstmtClient = con.prepareStatement("select NomComplet from Client where idClient=?");
                                     int idCl=rsCommande.getInt(2);
                                     pstmtClient.setInt(1,idCl);
                                     ResultSet rsClient = pstmtClient.executeQuery();
                                     if (rsClient.next()) {
                                    %>
                                    <td><%=rsClient.getString(1)%></td>
                                    <%}%>
                                    <%
                                     PreparedStatement psProduct = con.prepareStatement("select Designation,Prix from Produit where idProduit=?");
                                     int idProd=rsCommande.getInt(4);
                                     
                                     psProduct.setInt(1,idProd);
                                     ResultSet rsProd = psProduct.executeQuery();
                                     if (rsProd.next()) {
                                     int prixUni =rsProd.getInt(2);
                                     int Quant=rsCommande.getInt(5);
                                     int totale=prixUni*Quant;
                                    %>
                                     <td><%=rsProd.getString(1)%></td>                                
                                     <td><%=rsCommande.getInt(5)%> </td>
                                    <td><%=rsCommande.getString(6)%></td>  
                                     <td><%=totale%> DHS</td>
                                    <%}%>
                                    <td> 
                                        <form method="POST" action="../SupprimerCommande">
                                            <input type="text" id="idProd" name="idProd"value="<%=rsCommande.getInt(1)%>" hidden>
                                            <button type="submit" class="DelButton" name="Supprimer">Supprimer</button>

                                        </form>     

                                    </td>
                                                  

                        </tr>
                      <%}%>
                  </table> 
                  <%}else{
 response.sendRedirect("/CoffeeShop/Admin/");
}%>
    </body>
</html>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="../style/jquery.min.js"></script>
<script>
                                

       $('.DelButton').click(function () {
          
          $(this).prop('disabled', true);
           swal({
  title: "Etes Vous Sûre De Vouloir Quitter ?",
  text: "Voulez Vous Supprimer Cette Commande ? ",
  icon: "warning",
  buttons: true,
  dangerMode: true,
})
.then((willDelete) => {
  if (willDelete) {
              $(this).prop('disabled', true);

  } else{
      $(this).prop('disabled', true);
  }
});
        
      })
</script>
