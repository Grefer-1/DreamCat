<%-- 
    Document   : EditUser
    Created on : Nov 4, 2021, 7:48:38 AM
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
                border: none;
            }
        </style>
        <%
            LoginUser p = (LoginUser) request.getAttribute("user");
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
                            <a <% if (account == null) {%>
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
                                String notnull = (String) request.getAttribute("notnull");
                                String matchPassword = (String) request.getAttribute("matchPassword");
                                String cfphone = (String) request.getAttribute("cfphone");
                            %>
                            <form action="EditUser" method="post" style="height: auto; background: #e1e1e1; text-align: center; color: black">
                                <p class ="login-form-header"><strong>Profile</strong></p>
                                <table style="width: 100%; padding-left:1rem; padding-right: 1rem; padding-bottom: .5rem; border: none">
                                    <input style="margin-bottom: 1rem" value="<%= p.getId()%>" type="hidden" maxlength="32" name="idProfile" size="30"/>
                                    <tr>
                                        <td style="padding-right: 9rem; border: none;">Username</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input style="margin-bottom: .5rem" value="<%= p.getUsername()%>" placeholder="Username" type="text" maxlength="32" name="userProfile" size="30" readonly/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-right: 9rem; border: none;">Password</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input style="margin-bottom: .5rem" value="<%= p.getPassword()%>" placeholder="Password" type="text" maxlength="32" name="passProfile" size="30"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-right: 9rem; border: none;">Re-Password</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input style="margin-bottom: .5rem" value="<%= p.getPassword()%>" placeholder="Confirm Password" type="text" maxlength="32" name="cfpassProfile" size="30"/>
                                        </td>
                                    </tr>
                                    <%if (matchPassword == null || matchPassword.equals("")) {%>
                                    <%} else {%>
                                    <tr>
                                        <td>
                                            <h1 style="margin: 0; color: black; font-size: 110%">${matchPassword}</h1>
                                        </td>
                                        <%}%>
                                    </tr>
                                    <tr>
                                        <td style="padding-right: 11rem; border: none;">Name</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input style="margin-bottom: .5rem" value="<%= p.getName()%>" placeholder="Name"  type="text" maxlength="80" name="nameProfile" size="30"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-right: 11rem; border: none;">Phone</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input style="margin-bottom: .5rem" value="<%= p.getPhone()%>" placeholder="Phone"  type="text" maxlength="15" name="phoneProfile" size="30"/>
                                        </td>
                                    </tr>
                                    <%if (cfphone == null || cfphone.equals("")) {%>
                                    <%} else {%>
                                    <tr>
                                        <td>
                                            <h1 style="margin: 0; color: black; font-size: 110%">${cfphone}</h1>
                                        </td>
                                        <%}%>
                                    </tr>
                                    <tr>
                                        <td style="padding-right: 10rem; border: none;">Address</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input style="margin-bottom: .5rem" value="<%= p.getAddress()%>" placeholder="Address"  type="text" maxlength="80" name="addressProfile" size="30"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-right: 11rem; border: none;">Role</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <select id="roleProfile" name="roleProfile" style="width: 53%;">
                                                <% if (p.getRole().equals("user")) {%>
                                                <option value="user">user</option>
                                                <option value="admin">admin</option>
                                                <%} else {%>
                                                <option value="admin">admin</option>
                                                <option value="user">user</option>
                                                <%}%>
                                            </select>
                                        </td>
                                    </tr>
                                    <%if (notnull == null || notnull.equals("")) {%>
                                    <%} else {%>
                                    <tr>
                                        <td>
                                            <h1 style="margin: 0; color: black; font-size: 150%">${notnull}</h1>
                                        </td>
                                    </tr>
                                    <%}%>
                                </table>
                                <button style="margin-bottom: 1rem; font-family: OMORI_GAME; font-size: 110%">Update</button>
                            </form>
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
