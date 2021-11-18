<%-- 
    Document   : ShopAdmin
    Created on : Nov 10, 2021, 2:19:38 PM
    Author     : Asus
--%>

<%@page import="Model.LoginUser"%>
<%@page import="java.text.DecimalFormat" %>
<%@page import="Model.ShopProduct"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>DreamCat</title>
        <meta charset="UTF-8">  
        <link rel="stylesheet" href="CSS/page.css" type="text/css">
        <%
            ArrayList<ShopProduct> shop = (ArrayList<ShopProduct>) request.getAttribute("shop");
            LoginUser account = (LoginUser) request.getAttribute("account");
            session.setAttribute("account", account);
            DecimalFormat format = new DecimalFormat("#0.000VND");
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
                            <div style="height: 100%; background: #e1e1e1; text-align: center; color: black">
                                <p class ="login-form-header"><strong>Profile</strong></p>
                                <table style="width: 100%;">
                                    <tr>
                                        <th>Name</th>
                                        <th>Description</th>
                                        <th>Quantity</th>
                                        <th>Price</th>
                                        <th>Action</th>
                                    </tr>
                                    <% for (ShopProduct s : shop) {%>
                                    <tr>
                                        <td><%= s.getName()%></td>
                                        <td><%= s.getDesc()%></td>
                                        <td><%= s.getQuantity()%></td>
                                        <td><%= format.format(s.getPrice())%></td>
                                        <td>
                                        <form action="ManageShop" method="post" class="shop-button">
                                            <button name="edit" value="<%= s.getId()%>" class="shop-button-buy">Edit</button>
                                            <button name="delete" value="<%= s.getId()%>" class="shop-button-buy">Delete</button>
                                        </form>
                                        </td>
                                    </tr>
                                    <%}%>
                                </table>
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
