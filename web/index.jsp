<%-- 
    Document   : index.jsp
    Created on : Nov 16, 2022, 7:24:14 PM
    Author     : mbp-de-zakaria
--%>

<%@page import="java.sql.Blob"%>
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
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/style.css"/>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Condensed:ital@1&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Aladin&display=swap" rel="stylesheet">
        <title>Home - CoffeeShop </title>
    </head>
   <style>
       input[type=number] { 
    
    height:40px;
    width:33%;
    border-top-left-radius:30px;
    border-bottom-left-radius:30px;
    
}

       .quant{
          
           float:right;
           align-items:end;
           height:30px;
           position: absolute;
           right: 0px;
           padding: 10px;
           

       }
       .card {  
   position: relative;
  display: block;
  border-radius: calc(var(--curve) * 1px);
  overflow: hidden;
  text-decoration: none;
  width:fit-content;
  padding:20px;
  

}
.card__image {      
  background-repeat:no-repeat;
background-position: center center;
border-top-left-radius: 20px;
border-top-right-radius: 20px;


}
      .card {  
   position: relative;
  display: block;
  border-radius: calc(var(--curve) * 1px);
  overflow: hidden;
  text-decoration: none;
  width:fit-content;
  padding:25px;
  
  

}

       .cards {
  display: grid;
  grid-template-columns:repeat(auto-fit, minmax(300px, 1fr)); 
  gap:2%;
  margin: 4rem ;
  padding:2%;
  border-radius: calc(var(--curve) * 1px);
  background-color: #3F4E4F;
  list-style-type: none;
  list-style: none;
  overflow-x: scroll;
  
}
  *{
 margin:0;
}
table input[type="email"]{
    width:100%;
    height:30px;
    outline:none;
}
table input[type="submit"]{
    width:100%;
    height:30px;
    outline:none;
    background-color:red;
}
.overlay {
 position:absolute;
 display:none;
 top:0;
 right:0;
 bottom:0;
 left:0;
 background:rgba(0, 0, 0, 0.8);
 z-index:9999;
}

.overlayCOnn {
    
 position:fixed;
 display:none;
 top:0;
 right:0;
 bottom:0;
 left:0;
 background:rgba(0, 0, 0, 0.8);
 z-index:9999;
  
  
}
.close {
 position:absolute;
 top:-40px;
 right:-5px;
 z-index:99;
 width:25px;
 height:25px;
 cursor:pointer;
 color: #fff;
 display: inline-block;
}
.popup {
 position:absolute;
 width:50%;
 height:50%;
 top:25%;
 left:25%;
 text-align:center;
 border-radius: 10px;
 background:white;
 color:black;
 box-shadow: 0px 0px 10px 0px black;
}
.popup h2 {
 font-size:15px;
 height:50px;
 line-height:50px;
 color:#fff;
 background:#3F4E4F;
 border-radius:10px 10px 0px 0px;
}
.popupConn {
 position:absolute;
 width:50%;
 height:50%;
 top:25%;
 left:25%;
 text-align:center;
 border-radius: 10px;
 background:black;
 box-shadow: 0px 0px 10px 0px black;
}
.popupConn table {
 position:absolute;
 width:50%;
 height:50%;
 top:25%;
 left:25%;
 text-align:center;
 border-radius: 10px;
 background:black;
 box-shadow: 0px 0px 10px 0px black;
}
.popupConn h2 {
 font-size:15px;
 height:50px;
 line-height:50px;
 color:#fff;
 background:#3F4E4F;
 border-radius:10px 10px 0px 0px;
}


    </style>
    <style>
        
            body{
                font-family: 'Roboto Condensed', sans-serif;
                font-size:17px;
            }
            nav li:nth-child(1) , h2{
                font-family: 'Aladin', cursive;

            }
            #CatTitle{
                font-size: 45px
            }
            .OrderButton{
                background-color:#3F4E4F;
                float:right;
                padding:15px;
                color:#DCD7C9;
                font-size:15px;
                margin-left:50%;
                font-weight:bold;
                border-left-top-radius:20px;
                border-left-bottom-radius:20px;
                cursor:pointer;
                position: absolute;
                right: 0px;
                bottom:35px;

            }
            .Connection{
                cursor:pointer;
                float:right
            }
                

    </style>
    <body>
        
        <nav id="NavClient">
            <li href="/">CoffeeShop</li>
             <li><a href="Layouts/Partenaires.jsp">Partenaires</a></li>
             <%if(session.getAttribute("NomClient")==null){%>
             <style>
                 .quant{
                     display:none;
                 }
             </style>
              <li class="Connection">Se Connecter</li>
              <%}else{
                  int idClient = Integer.parseInt(String.valueOf(session.getAttribute("idClient")));
              Connection con = SQLCon.getConnection();
              PreparedStatement ps=con.prepareStatement("select count(*) from commande where idClientCom=?");
                ps.setInt(1, idClient);
                ResultSet rs = ps.executeQuery();
                while(rs.next()){%>
                <li><a href="Layouts/Commandes.jsp">Commandes (<%=rs.getInt(1)%>)</a></li>
                <%}%>
               <li style="float:right"> <a id="Logout"href="#"> Bonjour <%=session.getAttribute("NomClient")%> |</a></li>
                 
              <%}%>
                <li> <a id="" href="#">Contact</a></li>

            
        </nav>
               <%
            Connection con = SQLCon.getConnection();
            Statement stmtCat = con.createStatement();
            ResultSet rsCat = stmtCat.executeQuery("select idCat,NomCat from Categorie ");
            while (rsCat.next()) {
           
            %>
            <h2 id="CatTitle"><%=rsCat.getString(2)%> :</h2>
        
        <section class="cards">
    
            <%
           
            int idCat=rsCat.getInt(1);
            PreparedStatement stmt2 = con.prepareStatement("select Designation,Prix,Description,imageProduit,idCafe,idProduit from Produit where idCategorie=? LIMIT 4 ");
            stmt2.setInt(1,idCat);
            ResultSet rst = stmt2.executeQuery();
            
        while (rst.next()) { 
            byte[] imgData =rst.getBytes(4);
            
            
            int idCafe = rst.getInt(5);
            int idProduit = rst.getInt(6);
            PreparedStatement stmtCafe = con.prepareStatement("select Logo from Café where idCafe=? ");
            stmtCafe.setInt(1,idCafe);
            ResultSet rsCafe = stmtCafe.executeQuery();
            
            if (rsCafe.next()) { 
             byte[] imgD =rsCafe.getBytes(1);
             String logoCafe = Base64.getEncoder().encodeToString(imgD);
            
    %>      

            <section class="card">
              <a>
                  <%if(imgData!=null){ %>
                                <img src="data:image/jpeg;base64,<%=Base64.getEncoder().encodeToString(imgData)%>"  class="card__image" alt="" />
                              <% }else{
                                    if(idCat==1){
                              %>
                                 <img class="card__image" src="style/assets/Coffee-Logo.jpeg" alt="alt"/>

                              <%}else{%>
                                   <img class="card__image" src="style/assets/DefaultJuiceLogo.jpeg" alt="alt"/>
                            <%}}

                            %>
                <div class="card__overlay">
                  <div class="card__header">
                    <svg class="card__arc" xmlns="http://www.w3.org/2000/svg"><path /></svg>     
                    
                    <form action="AjouterCommande" method="post" >
                        
                 
                    <input type="text" hidden  class="idClient"name="idClientCom" value="<%=session.getAttribute("idClient")%>">
                    
                    <input type="number"  min="1" max="5" class="quant" name="Quantity" required ">
                   
                    <input type="text"  class="idCafe" hidden name="idCafeCom"  value="<%=idCafe%>">
                    <input type="text" class="idProduit" hidden name="idProdCom"  value="<%=idProduit%>">
                    <img class="card__thumb" src="data:image/jpeg;base64,<%=logoCafe %>" alt="" />
                    <div class="card__header-text">
                        <h3 class="card__title"><%=rst.getString(1)%></h3>            
                        <span class="card__status"><%=rst.getInt(2)%> DHS</span>
                    </div>
                    <button type="submit"class="OrderButton">Commander</button>  
                    </form>
                 
                  </div>
                    <p class="card__description"><%=rst.getString(3).substring(0, Math.min(rst.getString(3).length(), 120))%>...</p>
                </div>
              </a>
               

            </section>  
                 

         
               <%    
                }
               }%>
           </section>
           

<%}%>
    </body>
    
</html>


<div class='overlayCOnn'>
    <div class='popupConn'>
        <div class='close'>&#10006;</div>
        
         <h2>Connexion :</h2> 
         <form action="LoginUser" method="POST">
             <table>
                     <tr>
                         <td> <label>Email :</label></td>
                         <td><input type="email"name="email"  required ></td>
                     </tr>
                     <tr>
                         <td><label>Mot De Passe :</label></td>
                         <td> <input type="password" name="motdepasse"  required ></td>
                     </tr>
                     <tr>
                         <td><button type="submit">Se Connecter</button></td>
                     </tr>
         </form>
        
    </div>
</div>
             <script>
                
             </script>

<script src="style/jquery.min.js"></script>
<script>
                                

       $('.OrderButton').click(function () {
          var QuantProd=$("#Quant").val(); 
          $(this).prop('disabled', true);
          var idC= $(".idClient" ).val();
          
          if(idC==="null"){
              $('.overlayCOnn').show();
             
            }
            else{
                if(QuantProd!='null'){
                    $(this).prop('disabled', false);
                }
               else{
                   alert("Select Quantity")
               }
                       

          }
        
      })
      
      
      $('.close').click(function () {
          
        $('.overlay').hide();
        
        $('.idProdCom').val("")
      })
      
      
      $('.Connection').click(function () {
        $('.overlayCOnn').show();
      })
      $('.close').click(function () {
        $('.overlayCOnn').hide();
      })



</script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
    $("#Logout").click(function(){
        swal({
  title: "Etes Vous Sûre De Vouloir Quitter ?",
  text: "Voulez Vous Vous Deconnectez  ? ",
  icon: "warning",
  buttons: true,
  dangerMode: true,
})
.then((willDelete) => {
  if (willDelete) {
    window.location.replace("Logout");
  } 
});
})
</script>