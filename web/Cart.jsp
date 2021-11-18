<%-- 
    Document   : Cart
    Created on : Sep 24, 2021, 8:35:52 PM
    Author     : Asus
--%>

<%@page import="Model.OrderProducts"%>
<%@page import="Model.LoginUser"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="Model.CartUser"%>
<%@page import="java.util.ArrayList"%>
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
            ArrayList<CartUser> cart = (ArrayList<CartUser>) request.getAttribute("cart");
            ArrayList<OrderProducts> orderProd = (ArrayList<OrderProducts>) request.getAttribute("orderProd");
            LoginUser account = (LoginUser) request.getAttribute("account");
            session.setAttribute("account", account);
            DecimalFormat format = new DecimalFormat("###,###.000 VND");
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
                            <ol class="grid-cart">
                                <%
                                    if (account != null && account.getRole().equals("user")) {
                                        for (CartUser c : cart) {
                                %>
                                <li class="pic-cart">
                                    <div class="border-cart">
                                        <div class="item-cart" style="width: 125px;">
                                            <img class="img-cart"
                                                 src="<%= c.getProductPath()%>">
                                            <span style="color: black"><%= c.getProductName()%></span>
                                        </div>
                                        <div style="width: 354px">
                                            <div class="quantity-cart">
                                                <lable style="color: black;margin: 0;margin-top: 0.5rem;margin-left: 2rem;">
                                                    Quantity:
                                                </lable>
                                                <form action="Cart" method="post" style="margin :0; float: right;">
                                                    <input type="hidden" name="username" value="${username}"/>
                                                    <input type="number" name="quantity" value="<%= c.getItemQuantity()%>"/>
                                                    <button style="margin: 0" name="id" value="<%= c.getProductID()%>">Update</button>
                                                </form>
                                            </div>
                                            <div class="description-cart">
                                                <lable>
                                                    <%= c.getDesc()%>
                                                </lable>
                                            </div>
                                            <div>
                                                <span class="total-cart">
                                                    <strong>Total: </strong><%= format.format(c.getItemQuantity() * c.getProductPrice())%>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                                <%}%>
                                <%} else if (account != null && account.getRole().equals("admin")) {%>
                                <div style="height: 100%; background: #e1e1e1; text-align: center; color: black">
                                    <table style="width: 100%;">
                                        <tr>
                                            <th>ID</th>
                                            <th>Customer</th>
                                            <th>Product</th>
                                            <th>Quantity</th>
                                            <th>Order Date</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                        <%
                                            for (OrderProducts od : orderProd) {
                                        %>
                                        <tr>
                                            <td><%= od.getId()%></td>
                                            <td><%= od.getCustomerID()%></td>
                                            <td><%= od.getProductID()%></td>
                                            <td><%= od.getQuantity()%></td>
                                            <td><%= od.getOrderDate()%></td>
                                            <td><%= od.isStatus() == true ? "Done" : "Pending"%></td>
                                            <td>
                                                <form action="ManageOrder" method="post">
                                                    <input type="hidden" name="role" value="<%= account.getRole()%>">
                                                    <button style="padding: 0px 14px 0px 13px" name="edit" value="<%= od.getId()%>">Edit</button><br>
                                                    <button name="delete" value="<%= od.getId()%>">Delete</button>
                                                </form>
                                            </td>
                                            <%      }
                                                }
                                            %>
                                        </tr>
                                    </table>
                                </div>
                                <%if (account.getRole().equals("user")) {%>
                                <li class="pic-cart-buy">
                                    <div class="border-cart">
                                        <div style="align-self: center; width:100%; margin-left: 1rem">
                                            <label style="color: black;">
                                                Total Cost (<%= cart.size()%> Products): <label style="font-size: 120%"><strong>
                                                        <%
                                                            int total = 0;
                                                            for (int i = 0; i < cart.size(); i++) {
                                                                int price = cart.get(i).getItemQuantity() * cart.get(i).getProductPrice();
                                                                total = total + price;
                                                            }
                                                        %></strong><%= format.format(total)%></label>
                                            </label>
                                            <form action="Buy" method="post" style="float: right; margin-right: 1rem;">
                                                <input type="hidden" name="username" value="${username}"/>
                                                <button name="buy" <%if (cart.size() != 0) {%>value="1"<%} else {%> value="0"<%}%> style="margin: 0">Buy</button>
                                            </form>
                                        </div>
                                    </div>
                                </li>
                                <%}%>
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
