<%-- 
    Document   : Commandes
    Created on : Dec 16, 2022, 9:16:00 PM
    Author     : mbp-de-zakaria
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Base64"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Database.SQLCon"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta content="width=device-width, initial-scale=1" name="viewport" />

        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/style.css"/>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Condensed:ital@1&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Aladin&display=swap" rel="stylesheet">
        <title> Commandes - CoffeeShop</title>

    </head>
    <style>
#ListCommandes{
    background-color:#3F4E4F;
    margin:2%;
    padding:2%;
    height:fit-content;
    border-radius:20px;
}
#ListCommandes h3{
    margin-bottom:2%;
    font-size:40px;
    
}
.Commandes{
    background-color: white;
    color:black;
    margin-bottom:1%;
    padding:1%;
    width:100%;
   display:inline-flex;
    border-radius:20px;
}
.ImageCOm{
    width:200px;
    height:200px;
}
.DetailCommande{
    width:100%;
    margin-left:2%;
    height:200px;
}
.DetailCommande h1{
    font-size:30px;
}
@media only screen and (max-width: 600px) {
  body {
    background-color: lightblue;
  }
}


    </style>
    <body>
            <% int idClient = Integer.parseInt(String.valueOf(session.getAttribute("idClient")));              
                Connection con = SQLCon.getConnection();%>
        <nav id="NavClient">
             <li ><a href="/CoffeeShop">CoffeeShop</a></li>
             <li><a href="Partenaires.jsp">Partenaires</a></li>
             
              <%if(session.getAttribute("NomClient")==null){%>

              <li class="Connection">Se Connecter</li>
              <%}else{
              PreparedStatement ps=con.prepareStatement("select count(*) from commande where idClientCom=?");
                ps.setInt(1, idClient);
                ResultSet rs = ps.executeQuery();
                while(rs.next()){%>
                <li>Commandes (<%=rs.getInt(1)%>)</li>
                <%}%>
               <li style="float:right"> <a id="Logout"href="#"> Bonjour <%=session.getAttribute("NomClient")%> |</a></li>
              <%}%>
              <li>Contact</li>
            
        </nav>
              <section id="ListCommandes">
                  <form action="action">
                       <button  style="float:right;padding:1%;margin:1%;border-radius:30px;background-color:red;border:none;"type="submit">Supprimer Tout</button>
                  </form>
                  <h3>Historique Des Commandes : </h3>
                    
                
                 
                  <%
                PreparedStatement psListeCom=con.prepareStatement("select * from commande where idClientCom=? order by DateTempsCommande DESC");
                psListeCom.setInt(1, idClient);
                ResultSet rsListeCom = psListeCom.executeQuery();
                
                while(rsListeCom.next()){
                    int idCommande= rsListeCom.getInt(1);
                    int idCafe= rsListeCom.getInt(3);
                    int QuantiteProduit=  rsListeCom.getInt(5);
                    String dt = rsListeCom.getString(6);
                    PreparedStatement psInfoCafe = con.prepareStatement("select * from Café where idCafe=?");
                    psInfoCafe.setInt(1,idCafe);
                    ResultSet rsListecafe = psInfoCafe.executeQuery();
                while(rsListecafe.next()){
                    String  NomCafe = rsListecafe.getString(2);
                    int idProduit= rsListeCom.getInt(4);

                    PreparedStatement psInfoProd = con.prepareStatement("select * from Produit where idProduit=?");
                    psInfoProd.setInt(1,idProduit);
                    ResultSet rsListeProd = psInfoProd.executeQuery();
                while(rsListeProd.next()){
                    String  NomProd =rsListeProd.getString(2);
                    int PrixUni = rsListeProd.getInt(3);
                    int PrixTotal =PrixUni*QuantiteProduit;
                    byte[] imgData =rsListeProd.getBytes(6);
                  %>
                  <section class="Commandes">
                      <img src="data:image/jpeg;base64,<%=Base64.getEncoder().encodeToString(imgData)%>"  class="ImageCOm" alt="" />
                      <div class="DetailCommande">
                      <h1><%=NomProd%></h1>
                      <h2><%=NomCafe%></h2>
                      <h2 style="float:right;margin-right:0.5%"><%=PrixTotal%> DHS</h2>
                      <h4>Quantité : <%=QuantiteProduit%></h4>
                      <label><%=dt%></label>

                      </div>
                      <form action="action">
                          <input  hidden type="text" value="<%=idCommande%>">
                          <button style="float:right;height:100%;background-color:red;border-radius:20px;border:none">Del</button>
                      </form>

                  </section>
                  <%    }
                            } 
                      }
                  %>
              </section>
    </body>
</html>
<script src="../style/jquery.min.js"></script>

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
    window.location.replace("../Logout");
  } 
});
})
</script>