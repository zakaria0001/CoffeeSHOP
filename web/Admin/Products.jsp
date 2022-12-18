<%-- 
    Document   : Products
    Created on : Nov 16, 2022, 11:06:25 PM
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
            <li id="ActivePage"><a >Produits</a>  </li>

            <%if(session.getAttribute("Perm").equals("Tout")){%>
            <li> <a href="Admins.jsp"> Admins</a> </li>
            <li> <a href="Commandes.jsp"> Commandes</a></li>

            <%}%>
                <li id="Logoutb"><a id="Logout" href="#"><img src="../style/assets/logout.png" alt="alt"/></a></li>

            <li id="ProfileButton" > 

                <a style="color:#2C3639;" href="Contact.jsp">
                     <img id="ProfileImage" src="../style/assets/adminIcon.png" alt="alt"/>

                    <%=session.getAttribute("NomAdmin")%> | <%=session.getAttribute("NomCafe")%> </a> </li>
        </nav>
          <section id="FullSec">
              <section id="AddProd">
                <fieldset>
                    <legend>Ajouter Produit</legend>
                    <form method="POST" action="../AjouterProduit" enctype="multipart/form-data" >
                        <table id="AddPrTable">
                            <tr>
                                <td>
                                    <span>Désignation : </span>    
                                     <input type="text" name="Designation" required>   
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>Prix : </span>    
                                    <input  type="number" name ="prix" required>   
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>Quantité : </span>    
                                    <input  type="number" name ="quantite" required>   
                                </td>
                            </tr>
                            <input type="text" name="idCafe" value="<%=session.getAttribute("idCafe")%>" hidden >   
                            <tr>
                                <td>
                                    <span>Image Produit : </span>  
                                    
                                    <input  type="file" name ="image" onchange="previewFile()" required><br>
                                    <img id="prevImage" src="../style/assets/preview.png" alt="Apercu">   
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <span>Catégorie :</span>
                                   
                                    <%
                                     Statement stmtCat = con.createStatement();
                                     ResultSet rsCat = stmtCat.executeQuery("select idCat,NomCat from Categorie ");
                                     while (rsCat.next()) {
                                    %>
                                    
                                    <input type="radio" id="Cat"  name="cat" value="<%=rsCat.getInt(1)%>" required>
                                    <label for="Cat"><%=rsCat.getString(2)%></label>
                                    <%}%>
                                </td>
                                <td>
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>Description :</span>
                                    <textarea  name="Description"required></textarea>
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
               <section id="ListProd">
                  <input type="text" placeholder="Cherchez Un Produit .....">
                  <table>
                      <tr>
                          <td>ID Produit</td>
                          <td>Catégorie</td>
                          <td>Désignation</td>
                          <td>Image Produit</td>
                          <td>Prix </td>
                          <td>Quantité </td>
                          <td>Description </td>
                          <td>Actions </td>
                      </tr>
                      <%
                          PreparedStatement pstProd= con.prepareStatement("select * from Produit where idCafe=?;");
                          byte[] imgData;
                          int idCafe=Integer.parseInt(String.valueOf(session.getAttribute("idCafe")));
                          pstProd.setInt(1,idCafe);
                          ResultSet rsProd=pstProd.executeQuery();

                          while(rsProd.next()){
                               byte[] imgPro =rsProd.getBytes(6);
                               
                         
                      %>
                      
                      <tr>
                          <td><%=rsProd.getInt(1)%></td>
                           <%
                                     PreparedStatement stmtCate = con.prepareStatement("select NomCat from Categorie where idCat=?");
                                     int idCat=rsProd.getInt(7);
                                     stmtCate.setInt(1,idCat);
                                     ResultSet rsCate = stmtCate.executeQuery();
                                     if (rsCate.next()) {
                                    %>
                                    <td><%=rsCate.getString(1)%></td>
                                    <%}%>
                          <td><%=rsProd.getString(2)%></td>
                           
                          <td style="text-align:center">
                              <%if(imgPro!=null){ %>
                              <img height="50px" src="data:image/jpeg;base64,<%=Base64.getEncoder().encodeToString(imgPro)%>" alt="alt"/>
                              <%}else{
                                    if(idCat==1){
                              %>
                                 <img height="50px" src="../style/assets/Coffee-Logo.jpeg" alt="alt"/>

                              <%}else{%>
                                   <img height="50px" src="../style/assets/DefaultJuiceLogo.jpeg" alt="alt"/>
                            <%}}%>
                          </td>
                          
                          <td><%=rsProd.getInt(3)%> Dhs </td>
                          <td><%=rsProd.getInt(4)%></td>    
                          <td><%=rsProd.getString(8).substring(0, Math.min(rsProd.getString(8).length(), 20))%>...</td>
                          <td> 
                              <form method="POST" action="../SupprimerProduit">
                                  <input type="text" id="idProd" name="idProd"value="<%=rsProd.getInt(1)%>" hidden>
                                  <button type="submit" class="DelButton" name="Supprimer">Supprimer</button>

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
                                  <form method="POST" action="../" >
                                               <table id="AddPrTable">
                                                   <tr>
                                                       <td>
                                                           <span>Désignation : </span>    
                                                           <input  type="text" name="Designation" >   
                                                       </td>
                                                   </tr>
                                                   <tr>
                                                       <td>
                                                           <span>Prix : </span>    
                                                           <input  type="number" name ="prix">   
                                                       </td>
                                                   </tr>
                                                   <tr>
                                                       <td>
                                                           <span>Quantité : </span>    
                                                           <input  type="number" name ="quantite">   
                                                       </td>
                                                   </tr>
                                                   <input type="text" name="idCafe" value="<%=session.getAttribute("idCafe")%>" hidden >   
                                                   <tr>
                                                       <td>
                                                           <span>Image Produit : </span>  

                                                           <input  type="file" name ="image" onchange="previewFile()"><br>
                                                           <img id="prevImage" src="" alt="Apercu">   
                                                       </td>
                                                   </tr>

                                                   <tr>
                                                       <td>
                                                           <span>Catégorie :</span>
                                                           <select name="cat">

                                                           <%
                                                            while (rsCat.next()) {
                                                           %>
                                                           <option value="<%=rsCat.getInt(1)%>"><%=rsCat.getString(2)%></option>
                                                           <%}%>
                                                           </select>

                                                       </td>
                                                   </tr>
                                                   <tr>
                                                       <td>
                                                           <span>Description :</span>
                                                           <textarea  name="Description"></textarea>
                                                       </td>
                                                   </tr>
                                                   <tr>
                                                       <td>

                                                           <input type="submit" name="submit"value="AJOUTER">
                                                       </td>
                                                   </tr>
                                               </table>
                                    </form>
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

<script>
   function previewFile() {
        var preview = document.getElementById('prevImage');
        var file    = document.querySelector('input[type=file]').files[0];
        var reader  = new FileReader();

        reader.onloadend = function () {
          preview.src = reader.result;
        }

        if (file) {
          reader.readAsDataURL(file);
        } else {
          preview.src = "";
        }
    }
    </script>
    <script src="../style/jquery.min.js"></script>
   
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
$('.popUpBtn').click(function () {
        $('.modal').show();
      })
      $('.close').click(function () {
        $('.modal').hide();
      })
</script>