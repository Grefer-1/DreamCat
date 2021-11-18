<%-- 
    Document   : Profile
    Created on : Sep 30, 2021, 3:26:00 PM
    Author     : Asus
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Model.LoginUser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>DreamCat</title>
        <meta charset="UTF-8">  
        <link rel="stylesheet" href="CSS/page.css" type="text/css">
        <style>
            table, th, td {
                border: 1px solid black
            }
        </style>
        <%
            ArrayList<LoginUser> user = (ArrayList<LoginUser>) request.getAttribute("user");
            LoginUser account = (LoginUser) request.getAttribute("account");
            session.setAttribute("account", account);
        %>
    </head>
    <body class="body">
        <div class="site-root-element">
            <main class="site-main">
                <header class="site-header" style="width: 300px; text-align: center;">
                    <a href="http://localhost:8080/DreamCat/Home">
                        <img class="logo" src="Files/Logo.gif">
                    </a>
                    <div class="user-menu" style="width: 150px; height: 100px;">
                        <%
                            if (account == null) {
                        %>
                        <form action="Login" class="login-button">
                            <button class="login">Login</button>
                        </form>
                        <%} else {%>
                        <form action="Profile" method="post" class="login-button">
                            <button class="login">Profile</button>
                        </form>
                        <form action="Logout" method="post" class="logout-button">
                            <button class="logout">Logout</button>
                        </form>
                        <%}%>
                        <div class="cart-logo">
                            <a <%if (account == null) {%>
                                href="http://localhost:8080/DreamCat/Login"
                                <%} else {%>
                                href="http://localhost:8080/DreamCat/Cart"
                                <%}%>
                                class="link-cart">
                                <img src="./Files/web4.png">
                            </a>
                        </div>
                        <div class="avatar">
                            <img class="img-avatar" src="./Files/avatar.png">
                        </div>
                    </div>
                </header>
                <nav class="nav-site">
                    <form action="Team" method="post" class="navigation-first">
                        <button class="team">Team</button>
                    </form>
                    <form action="Game" method="post" class="navigation">
                        <button class="game">Game</button>
                    </form>
                    <form action="Update" method="post" class="navigation">
                        <button class="update">Update</button>
                    </form>
                    <form action="Shop" method="post" class="navigation">
                        <button class="shop">Shop</button>
                    </form>
                    <form action="Gallery" method="post" class="navigation-last">
                        <button class="gallery">Gallery</button>
                    </form>
                </nav>
                <section class="site-content">
                    <div class="team-page">
                        <button class="scrollbar-button-increment"></button>
                        <button class="scrollbar-button-decrement"></button>
                        <div class="hide-scrollbar">
                            <%
                                if (account.getRole().equals("user")) {
                                    for (LoginUser p : user) {
                            %>
                            <form action="UpdateProfile" method="post" style="height: 100%; background: #e1e1e1; text-align: center; color: black">
                                <p class ="login-form-header"><strong>Profile</strong></p>
                                <table style="width: 100%; padding-left:1rem; padding-right: 1rem; padding-bottom: .5rem; border: none">
                                    <input style="margin-bottom: 1rem" value="<%= p.getUsername()%>" type="hidden" maxlength="32" name="idProfile" size="30"/>
                                    <tr style="border:none;">
                                        <td style="padding-right: 9rem; border: none;">Username</td>
                                    </tr>
                                    <tr style="border:none;">   
                                        <td style="border:none;"><input style="margin-bottom: .5rem" value="<%= p.getUsername()%>" type="text" maxlength="32" name="userProfile" size="30" readonly/></td>
                                    </tr>
                                    <tr style="border:none;">
                                        <td style="padding-right: 9rem; border: none;">Password</td>
                                    </tr>
                                    <tr style="border:none;">
                                        <td style="border:none;">
                                            <input style="margin-bottom: .5rem" value="<%= p.getPassword()%>" type="text" maxlength="32" name="passProfile" size="30"/>
                                        </td>
                                    </tr>
                                    <tr style="border:none;">
                                        <td style="padding-right: 11rem; border: none;">Name</td>
                                    </tr>
                                    <tr style="border:none;">
                                        <td style="border:none;">
                                            <input style="margin-bottom: .5rem" value="<%= p.getName()%>"  type="text" maxlength="80" name="nameProfile" size="30"/>
                                        </td>
                                    </tr>
                                    <tr style="border:none;">
                                        <td style="padding-right: 11rem; border: none;">Phone</td>
                                    </tr>
                                    <tr style="border:none;">
                                        <td style="border:none;">
                                            <input style="margin-bottom: .5rem" value="<%= p.getPhone()%>"  type="text" maxlength="15" name="phoneProfile" size="30"/>
                                        </td>
                                    </tr>
                                    <tr style="border:none;">
                                        <td style="padding-right: 10rem; border: none;">Address</td>
                                    </tr>
                                    <tr style="border:none;">
                                        <td style="border:none;">
                                            <input style="margin-bottom: .5rem" value="<%= p.getAddress()%>"  type="text" maxlength="80" name="addressProfile" size="30"/>
                                        </td>
                                    </tr>
                                </table>
                                <%}%>
                                <button style="margin-bottom: 1rem; font-family: OMORI_GAME; font-size: 110%">Update</button>
                            </form>
                            <%} else if (account.getRole().equals("admin")) {%>
                            <div style="height: 100%; background: #e1e1e1; text-align: center; color: black">
                                <p class ="login-form-header"><strong>Profile</strong></p>
                                <table style="width: 100%;">
                                    <tr>
                                        <th>Username</th>
                                        <th>Password</th>
                                        <th>Name</th>
                                        <th>Phone</th>
                                        <th>Address</th>
                                        <th>Role</th>
                                        <th>Action</th>
                                    </tr>
                                    <% for (LoginUser p : user) {%>
                                    <tr>
                                        <td><%= p.getUsername()%></td>
                                        <td><%= p.getPassword()%></td>
                                        <td><%= p.getName()%></td>
                                        <td><%= p.getPhone()%></td>
                                        <td><%= p.getAddress()%></td>
                                        <td><%= p.getRole()%></td>
                                        <td>
                                            <form action="ManageUser" method="post">
                                                <input type="hidden" name="role" value="<%= p.getRole()%>">
                                                <%if (!p.getRole().equals("admin")) {%>
                                                <button style="padding: 0px 14px 0px 13px" name="edit" value="<%= p.getUsername()%>">Edit</button><br>
                                                <button name="delete" value="<%= p.getUsername()%>">Delete</button>
                                                <%}%>
                                            </form>
                                        </td>
                                    </tr>
                                    <%}%>
                                    <%}%>
                                </table>
                            </div>
                        </div>
                    </div>
                </section>
                <footer>
                    <div class="store-logo">
                        <a href="https://www.youtube.com/" class="link-logo-first">
                            <img class="img-logo" src="./Files/youtube.png">
                        </a>
                        <a href="https://discord.gg/aUzxgAPdBA" class="link-logo">
                            <img class="img-logo" src="./Files/discord.png">
                        </a>
                        <a href="https://www.facebook.com/in.the.rain09/" class="link-logo-last">
                            <img class="img-logo" src="./Files/facebook.png">
                        </a>
                    </div>
                    <div class="company">
                        <span class="company-name">
                            DreamCat studio. since 2021
                        </span>
                    </div>
                    <div class="gif" style="bottom: 0rem; right: -4rem;">
                        <img src="Files/Gif222.gif">
                    </div>
                    <div class="gif" style="bottom: 2rem; left: 1rem;">
                        <img src="Files/Gif111.gif">
                    </div>
                </footer>
                <div tabindex="0" class="fullsreen-overlay" style="display:none">
                    <div class="gallery-content">
                        <li class="gallery-content-list">
                            <button type="button" class="prev-sketchbook-button">
                            </button>
                            <div class="sketchbook-slide">

                            </div>
                            <button type="button" class="next-sketchbook-button">
                            </button>
                        </li>
                    </div>
                </div>
            </main>
        </div>
    </body>
</html>