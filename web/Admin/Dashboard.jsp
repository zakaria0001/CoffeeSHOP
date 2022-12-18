<%-- 
    Document   : Dashboard
    Created on : Nov 27, 2022, 12:23:36 AM
    Author     : mbp-de-zakaria
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Database.SQLCon"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard - CoffeShop</title>
    <link rel="stylesheet" href="../style/style.css"/>
    </head>
    <body>
         <%if(session.getAttribute("NomAdmin")!=null){%>
        <nav id="Navb">
            <li><a href="Dashboard.jsp">CoffeeShop</a>  </li>
            <li><a href="Products.jsp"> Produits</a> </li>
            <%if(session.getAttribute("Perm").equals("Tout")){%>
            <li> <a href="Admins.jsp"> Admins</a></li>
            <li> <a href="Commandes.jsp"> Commandes</a></li>
            <%}%>
            <li  id="Logoutb"style=" "><a id="Logout" href="#"><img src="../style/assets/logout.png" alt="alt"/></a></li>
            <li id="ProfileButton" > 

                <a style="color:#2C3639;" href="Contact.jsp">
                     <img id="ProfileImage" src="../style/assets/adminIcon.png" alt="alt"/>

                    <%=session.getAttribute("NomAdmin")%> | <%=session.getAttribute("NomCafe")%> </a> </li>
            
        </nav>
                    <% Connection con = SQLCon.getConnection(); %>
                    
                    <h2 id="titleDash">Bonjour <%=session.getAttribute("NomAdmin")%></h2>
                    <section id="Dash">
                         
                        <section id="DataRes">
                            <a href="Products.jsp">
                             <div class="TotalProd">
                                <h3>Nombre De Produits :</h3>   
                                <%
                                    PreparedStatement psNbProd = con.prepareStatement("select count(*) from Produit Where idCafe=?; ");
                                    int idCafe=Integer.parseInt(String.valueOf(session.getAttribute("idCafe")));
                                    psNbProd.setInt(1,idCafe);
                                    ResultSet nbProd = psNbProd.executeQuery();
                                    if(nbProd.next()){
                                %>
                                <h1><%=nbProd.getInt(1)%></h1>
                                <%}%>
                            </div>
                            </a>
                            <div class="TotalProd">
                                <h3>Nombre D'administrateurs :</h3> 
                                 <%
                                    PreparedStatement psNbAdm = con.prepareStatement("select count(*) from OwnersAdminCafe Where idCafe=?; ");
                                    psNbAdm.setInt(1,idCafe);
                                    ResultSet nbAdm = psNbAdm.executeQuery();
                                    if(nbAdm.next()){
                                %>
                                <h1><%=nbAdm.getInt(1)%></h1>
                                <%}%>
                            </div>
                            <div class="TotalProd">
                                <h3>Nombre De Commandes :</h3> 
                                  <%
                                    PreparedStatement psNbComm = con.prepareStatement("select count(*) from Commande Where idCafeCom=?; ");
                                    psNbComm.setInt(1,idCafe);
                                    ResultSet nbComm = psNbComm.executeQuery();
                                    if(nbComm.next()){
                                %>
                                <h1><%=nbComm.getInt(1)%></h1>
                                <%}%>
                            </div>
                           
                            
                            
                            

                        </section>
                        <section id="SchemasSection">
                            <div class="Schemas">
                                <h3>Meilleurs Produits :</h3>     
                            </div>
              
                            <div class="Schemas">
                                <h3>Nouvelles Commandes :</h3>
                            </div>
                            </section>
                        <div class="Notes">
                                <span>Notes :</span>
                                
                                <button id="popup">+</button>
                                
                                <section id="allNotes">
                                    <form action="../AjouterNote" method="GET">
                                   <input type="text" name="Contenu" id="TypeNote" required>
                                   <input name="idAdmin"value="<%=session.getAttribute("idAdmin")%>" hidden>
                                   <input id="btn" type="submit" value="Add">
                                   </form>
                                    <% PreparedStatement pStNotes = con.prepareStatement("select * from note where idAdmin=? order by DateN DESC");
                                        pStNotes.setInt(1,Integer.parseInt(String.valueOf(session.getAttribute("idAdmin"))));
                                        ResultSet rsNotes = pStNotes.executeQuery();
                                        
                                        while(rsNotes.next()){ 
                                        int idNote=rsNotes.getInt(1);
                                        
                                    %>
                                    <span><input type="checkbox"><%=rsNotes.getString(2)%> <a href="../SupprimerNote?idNote=<%=idNote%>"><button class="delButton"><img src="../style/assets/delete.png" alt="alt"/></button></a>
                                   <br>
                                   <label><%=rsNotes.getString(3)%></label>
                                    </span>
                                    <%}%>
                                </section>
                                
                        </div>
                        
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


    $("#popup").click(function(){
        
        $("#TypeNote").toggle();
        $("#btn").toggle();
})

</script>
