<%-- 
    Document   : EditShop
    Created on : Nov 3, 2021, 9:59:51 AM
    Author     : Asus
--%>

<%@page import="Model.LoginUser"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="Model.ShopProduct"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Manager</title>
        <meta charset="UTF-8">  
        <link rel="stylesheet" href="CSS/page.css" type="text/css">
        <%
            ArrayList<ShopProduct> shop = (ArrayList<ShopProduct>) request.getAttribute("shop");
            LoginUser account = (LoginUser) request.getAttribute("account");
            String create = (String) request.getAttribute("create");
            session.setAttribute("account", account);
            DecimalFormat format = new DecimalFormat("#.000");
        %>
        <style>
            input:focus, textarea:focus {
                outline: none;
            }
        </style>
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
                            <ol class="grid-game">
                                <%
                                    if (account != null && create != null) {
                                %>
                                <li class="pic-game">
                                    <form action="ManageShop" method="post" class="border-shop-create">
                                        <div style="padding-left: 2rem;">
                                            <input type="file" name="itemImg" accept="image/*"><br>
                                            <a style="margin:0; font-size: 100%">Name:</a>
                                            <input class="create-shop" type="text" name="itemName" style="text-align: left;margin-bottom: 5px; font-size: 100%; width: 200px;"><br>
                                            <textarea class="create-shop" style="text-align: left; resize: none;" rows="3" cols="37" type="text" name="itemDesc"></textarea><br>
                                            <a style="margin: 0; font-size: 100%">Quantity:</a>
                                            <input class="create-shop" type="text" name="itemQuantity" style="text-align: left; margin-bottom: 5px; font-size: 100%; width: 200px"><br>
                                            <a style="margin: 0; font-size: 130%">Price:</a>
                                            <input class="create-shop" type="text" name="itemPrice" style="text-align: left; margin-bottom: 5px; font-size: 130%; width: 250px"><br>
                                            <input type="hidden" name="create" value="create">
                                            <input type="submit" value="Create">
                                        </div>
                                    </form>
                                </li> 
                                <%
                                    }
                                    if (account != null && shop != null) {
                                        for (ShopProduct s : shop) {
                                %>
                                <li class="pic-game">
                                    <form action="EditShop" method="post" class="border-game">
                                        <div class="item-game" style="width: 160px">
                                            <img class="img-game"
                                                 src="<%= s.getPath()%>">
                                            <input type="hidden" name="itemPath" value="<%= s.getPath()%>">
                                            <input class="edit-shop" type="text" name="itemName" value="<%= s.getName()%>">
                                        </div>
                                        <div style="width: 300px; margin-left: 1rem; text-align: justify; color: black;">
                                            <textarea class="edit-shop" style="text-align: left; resize: none; padding-bottom: 3.5rem;" rows="3" cols="37" type="text" name="itemDesc"><%= s.getDesc()%></textarea>
                                            <a style="margin: 0; font-size: 100%">Quantity:</a>
                                            <input class="edit-shop" type="text" name="itemQuantity" style="text-align: left; margin-bottom: 5px; font-size: 100%; width: 100px" value="<%= s.getQuantity()%>"><br>
                                            <a style="margin: 0; font-size: 130%">Price:</a>
                                            <input class="edit-shop" type="text" name="itemPrice" style="text-align: left; margin-bottom: 5px; font-size: 130%; width: 150px" value="<%= format.format(s.getPrice())%>">
                                            <input type="hidden" name="itemID" value="<%= s.getId()%>">
                                            <input type="submit" value="Update">
                                        </div>
                                    </form>
                                </li>
                                <%}
                                    }
                                %>
                            </ol>
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
