<%-- 
    Document   : Contact.jsp
    Created on : Nov 21, 2022, 10:04:53 AM
    Author     : mbp-de-zakaria
--%>

<%@page import="java.util.Base64"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Database.SQLCon"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contact - CoffeeShop</title>
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
            <li id="Logoutb"><a id="Logout" href="#"><img src="../style/assets/logout.png" alt="alt"/></a></li>

            
            
        </nav>
            
       <section id="FullBoxes">
            <section id="CoffeeBox">
            <table>
            <form action="action">
                <% Connection con = SQLCon.getConnection();
                    Statement psCoffeeData = con.createStatement();
                    ResultSet rs= psCoffeeData.executeQuery("Select c.* from Café c join OwnersAdminCafe oac where c.idCafe=oac.idCafe");
                    if(rs.next()){
                     byte[] LogoCafe =rs.getBytes(6);%>
                     <tr>
                         <td style="text-align:center">
                              <%if(LogoCafe!=null){ %>
                              <img height="50px" src="data:image/jpeg;base64,<%=Base64.getEncoder().encodeToString(LogoCafe)%>" alt="alt"/>
                              <%}else{
                                    
                              %>
                                 <img height="50px" src="../style/assets/Coffee-Logo.jpeg" alt="alt"/>

                              <%}%>
                          </td>
                    </tr>
                    <%if(session.getAttribute("Perm").equals("Tout")){%>
                    <tr>
                        <td> <span>ID : </span>
                            <input type="text" value="<%=rs.getInt(1)%>" disabled>
                           
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span>Nom Café : </span>
                            <input type="text" value="<%=rs.getString(2)%>">   
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span>Adresse :</span>
                            <input type="text" value="<%=rs.getString(3)%>">
                        </td>                        
                    </tr>
                    <tr>
                         <td>
                            <span>Numéro Télephone :</span>
                            <input type="text" value="0<%=rs.getInt(5)%>">
                         </td>
                    </tr>
                    <%}else{%>
                    <tr>
                        <td> <span>ID : </span>
                            <input type="text" value="<%=rs.getInt(1)%>" disabled>
                           
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span>Nom Café : </span>
                            <input type="text" value="<%=rs.getString(2)%>"disabled>   
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span>Adresse :</span>
                            <input type="text" value="<%=rs.getString(3)%>"disabled>
                        </td>                        
                    </tr>
                    <tr>
                         <td>
                            <span>Numéro Télephone :</span>
                            <input type="text" value="0<%=rs.getInt(5)%>"disabled>
                         </td>
                    </tr>
                        
                <%}}%>
                    </form>
                            </table>
            </section>  
            <section id="AdminBox">
             <table>
            <form action="action">
                <% 
                    int idAdmin=Integer.parseInt(String.valueOf(session.getAttribute("idAdmin")));
                    PreparedStatement psAdminData = con.prepareStatement("select * from OwnersAdminCafe where idAdmin=?");
                    psAdminData.setInt(1,idAdmin);
                    ResultSet rsAdmin= psAdminData.executeQuery();
                    if(rsAdmin.next()){
                    %>
                     <tr>
                         <td style="text-align:center">
                             <img src="../style/assets/adminIcon.png" alt="admin"/>
                          </td>
                    </tr>
                    <tr>
                        <td> <span>ID : </span>
                            <input type="text" value="<%=rsAdmin.getInt(1)%>" disabled>
                           
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span>Nom Complet : </span>
                            <input type="text" value="<%=rsAdmin.getString(3)%>">   
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span>Email :</span>
                            <input type="text" value="<%=rsAdmin.getString(4)%>">
                        </td>                        
                    </tr>

                    <tr>
                         <td>
                            <span>Mot De Passe :</span>
                            <input type="password" value="<%=rsAdmin.getInt(5)%>">
                         </td>
                    </tr>
                    <tr>
                         <td style="text-align:center">
                            <span>Permissions :</span>
                            <input type="text" value="<%=rsAdmin.getString(6)%>">
                            
                         </td>
                    </tr>
                    </table>    
                    </form>
                            
                         <%}%>
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