<%-- 
    Document   : Partenaires
    Created on : Nov 24, 2022, 11:47:21 PM
    Author     : mbp-de-zakaria
--%>

<%@page import="java.util.Base64"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Database.SQLCon"%>
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
        <title>Partenaires - CoffeeShop</title>
    </head>
    <style>
          .Connection{
                cursor:pointer;
                float:right
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
table input[type="email"]{
    width:100%;
    height:30px;
    outline:none;
}
       .cards {
  display: grid;
  grid-template-columns:repeat(auto-fit, minmax(300px, 1fr)); 
  gap:2rem;

  padding:5px;
  border-radius: calc(var(--curve) * 1px);
  background-color: #3F4E4F;
  list-style-type: none;
  list-style: none;
  overflow-x: scroll;
}
.card {  

  position: relative;
  display: block;
  border-radius: calc(var(--curve) * 1px);
  overflow: hidden;
  text-decoration: none;

}
    </style>
    <body >
         <nav id="NavClient">
             <li ><a href="/CoffeeShop">CoffeeShop</a></li>
             <li><a>Partenaires</a></li>
              <%if(session.getAttribute("NomClient")==null){%>

              <li class="Connection" style="float:right">Se Connecter</li>
              <%}else{
              int idClient = Integer.parseInt(String.valueOf(session.getAttribute("idClient")));
              Connection con = SQLCon.getConnection();
              PreparedStatement ps=con.prepareStatement("select count(*) from commande where idClientCom=?");
                ps.setInt(1, idClient);
                ResultSet rs = ps.executeQuery();
                while(rs.next()){%>
                <li><a href="Commandes.jsp">Commandes (<%=rs.getInt(1)%>)</a></li>
                <%}%>
            
                 <li style="float:right"> Bonjour <%=session.getAttribute("NomClient")%></li>

                 <%}%>
              <li>Contact</li>
            
        </nav>
        <%
            Connection con = SQLCon.getConnection();
            Statement stmtCat = con.createStatement();
            ResultSet rsCat = stmtCat.executeQuery("select  distinct Ville from Café ");
            while (rsCat.next()) {
            
            %>
            <h2 id="CatTitle"><%=rsCat.getString(1)%> :</h2>
            <section class="Sec">
                
            
        <section class="cards">
    
            <%
           String Ville=rsCat.getString(1);
            PreparedStatement stmt2 = con.prepareStatement("select Nom,Logo,Adresse from Café where Ville=?");
            stmt2.setString(1,Ville);
            ResultSet rst = stmt2.executeQuery();
            
        while (rst.next()) { 
            byte[] imgData =rst.getBytes(2);
             String logoCafe = Base64.getEncoder().encodeToString(imgData);
            
    %>      

            <section class="card">
              <a href="">
                  <%if(imgData!=null){ %>
                <img src="data:image/jpeg;base64,<%=Base64.getEncoder().encodeToString(imgData)%>"  class="card__image" alt="" />
                              <% }else{
                                    
                              %>
                                 <img class="card__image" src="style/assets/Coffee-Logo.jpeg" alt="alt"/>

                              <%}

                            %>
                <div class="card__overlay">
                  <div class="card__header">
                    <svg class="card__arc" xmlns="http://www.w3.org/2000/svg"><path /></svg>                 
                    <div class="card__header-text">
                        <h3 class="card__title"><%=rst.getString(1)%></h3>            
                        <span class="card__status"><%=rst.getString(3)%></span>
                    </div>
                 </div>
                    <p class="card__description"></p>
                </div>
              </a>
            </section>  
                
               <% 
                  
                
            }%>
           </section>
           </section>

<%}%>
    </body>
</html>
<div class='overlayCOnn'>
    <div class='popupConn'>
        <div class='close'>&#10006;</div>
        
         <h2>Connexion :</h2> 
         <form action="../LoginUser" method="POST">
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
<script src="../style/jquery.min.js"></script>
<script>

      $('.Connection').click(function () {
        $('.overlayCOnn').show();
      })
      $('.close').click(function () {
        $('.overlayCOnn').hide();
      })



</script>
