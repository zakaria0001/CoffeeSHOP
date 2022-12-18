<%-- 
    Document   : Login
    Created on : Nov 17, 2022, 12:04:20 PM
    Author     : mbp-de-zakaria
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../style/style.css"/>
        <title>Admin Login </title>
    </head>
    <body>
        <section id="LoginBox">
            <h3>Login Admin : </h3>
             <form method="POST" action="../AuthentificationServlet">
                 <table>
                     <tr>
                         <td> <label>Email :</label></td>
                         <td><input type="text" name="email"  required ></td>
                     </tr>
                     <tr>
                         <td><label>Mot De Passe :</label></td>
                         <td> <input type="password" name="motdepasse"  required ></td>
                     </tr>
                     <tr>
                         <td> <input type="submit" value="Se Connecter"></td>
                     </tr>
                     
                    </table>
                 
        </form>
            <%if(session.getAttribute("Status")!=null){%>
                        <center id="message"><%=session.getAttribute("Status")%></center>
            <%}%>           
        </section>
        
    </body>

</html>
<script src="../style/script.js" ></script>