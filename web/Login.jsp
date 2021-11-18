<%-- 
    Document   : Login
    Created on : Sep 24, 2021, 8:35:11 PM
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>DreamCat</title>
        <meta charset="UTF-8">  
        <link rel="stylesheet" href="CSS/page.css" type="text/css">
    </head>
    <body class="body">
        <div class="site-root-element">
            <main class="site-main">
                <header class="site-header" style="width: 300px; text-align: center;">
                    <a href="http://localhost:8080/DreamCat/Home">
                        <img class="logo" src="Files/Logo.gif">
                    </a>
                    <div class="user-menu" style="width: 150px; height: 100px;">
                        <form action="Login" class="login-button">
                            <button class="login">Login</button>
                        </form>
                        <div class="cart-logo">
                            <a href="http://localhost:8080/DreamCat/Login" class="link-cart">
                                <img src="./Files/web4.png">
                            </a>
                        </div>
                        <div class="avatar">
                            <img class="img-avatar" src="./Files/avatar.png">
                        </div>
                    </div>
                </header>
                <nav class="nav-site">
                    <form action="Team" class="navigation-first">
                        <button class="team">Team</button>
                    </form>
                    <form action="Game" class="navigation">
                        <button class="game">Game</button>
                    </form>
                    <form action="Update" class="navigation">
                        <button class="update">Update</button>
                    </form>
                    <form action="Shop" class="navigation">
                        <button class="shop">Shop</button>
                    </form>
                    <form action="Gallery" class="navigation-last">
                        <button class="gallery">Gallery</button>
                    </form>
                </nav>
                <section class="site-content">
                    <div class="team-page">
                        <button class="scrollbar-button-increment"></button>
                        <button class="scrollbar-button-decrement"></button>
                        <div class="hide-scrollbar">
                            <form action="Login" method="post" style="height: 50%; background: #e1e1e1; text-align: center">
                                <p class ="login-form-header">Login</p>
                                <input style="margin-bottom: 1rem" placeholder="Username" type="text" maxlength="24" name="username" size="30"/><br>
                                <input style="margin-bottom: 1rem" placeholder="Password" type="password" maxlength="24" name="password" size="30"/><br>
                                <button style="margin-bottom: 1rem; font-family: OMORI_GAME; font-size: 110%">Login</button>
                                <div>
                                    <div class="login-seperate">
                                        <div class="login-seperate-left"></div>
                                        <span class="login-seperate-middle" style="color: black">OR</span>
                                        <div class="login-seperate-right"></div>
                                    </div>
                                </div>
                            </form>
                            <%
                                String notnull = (String) request.getAttribute("notnull");
                                String matchUsername = (String) request.getAttribute("matchUsername");
                                String matchPassword = (String) request.getAttribute("matchPassword");
                                String cfphone = (String) request.getAttribute("cfphone");
                            %>
                            <form action="Register" method="post" style=" height: 92%;
                                  background: #e1e1e1; text-align: center; padding-top: 1rem">
                                <p class ="register-form-header">Register</p>
                                <input style="margin-bottom: 1rem" placeholder="Username" type="text" maxlength="24" name="username" size="30"/>
                                <%if (matchUsername == null || matchUsername.equals("")) {%>
                                <%} else {%>
                                <h1 style="margin: 0; color: black; font-size: 110%">${matchUsername}</h1>
                                <%}%>
                                <br>
                                <input style="margin-bottom: 1rem" placeholder="Password" type="password" maxlength="24" name="password" size="30"/>
                                <br>
                                <input style="margin-bottom: 1rem" placeholder="Confirm Password" type="password" maxlength="24" name="cfpassword" size="30"/>
                                <%if (matchPassword == null || matchPassword.equals("")) {%>
                                <%} else {%>
                                <h1 style="margin: 0; color: black; font-size: 110%">${matchPassword}</h1>
                                <%}%>
                                <br>
                                <input style="margin-bottom: 1rem" placeholder="Name" type="text" maxlength="80" name="name" size="30"/>
                                <br>
                                <input style="margin-bottom: 1rem" placeholder="Phone" value="" type="text" maxlength="15" name="phone" size="30"/>
                                <%if (cfphone == null || cfphone.equals("")) {%>
                                <%} else {%>
                                <h1 style="margin: 0; color: black; font-size: 110%">${cfphone}</h1>
                                <%}%>
                                <br>
                                <input style="margin-bottom: 1rem" placeholder="Address" type="text" maxlength="80" name="address" size="30"/>
                                <%if (notnull == null || notnull.equals("")) {%>
                                <%} else {%>
                                <h1 style="margin: 0; color: black; font-size: 150%">${notnull}</h1>
                                <%}%>
                                <br>
                                <button style="margin-bottom: 1rem; font-family: OMORI_GAME; font-size: 110%">Register</button>
                            </form>
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
