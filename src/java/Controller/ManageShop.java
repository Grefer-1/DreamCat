/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.DreamCatDAO;
import Model.LoginUser;
import Model.ShopProduct;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Asus
 */
public class ManageShop extends HttpServlet {

    ArrayList<ShopProduct> shop = new ArrayList<ShopProduct>();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = request.getSession();
            LoginUser account = (LoginUser) session.getAttribute("account");
            request.setAttribute("account", account);
            shop = DreamCatDAO.getProduct();
            request.setAttribute("shop", shop);
            if (account != null && account.getRole().equals("admin")) {
                request.getRequestDispatcher("ManageShop.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ManageShop.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            LoginUser account = (LoginUser) session.getAttribute("account");
            request.setAttribute("account", account);
            String edit = request.getParameter("edit");
            String delete = request.getParameter("delete");
            String create = request.getParameter("create");
            if (edit != null) {
                shop = DreamCatDAO.getProductbyID(Integer.parseInt(edit));
                request.setAttribute("shop", shop);
                request.getRequestDispatcher("EditShop.jsp").forward(request, response);
            }
            if (delete != null) {
                DreamCatDAO.deleteItem(Integer.parseInt(delete));
                shop = DreamCatDAO.getProduct();
                request.setAttribute("shop", shop);
                request.getRequestDispatcher("Shop.jsp").forward(request, response);
            }
            if (create != null) {
                String name = request.getParameter("itemName");
                String path = "./Files/Shop/" + request.getParameter("itemImg");
                int price = Integer.parseInt(request.getParameter("itemPrice"));
                int quantity = Integer.parseInt(request.getParameter("itemQuantity"));
                String desc = request.getParameter("itemDesc");
                DreamCatDAO.addProduct(name, path, price, quantity, desc);
                shop = DreamCatDAO.getProduct();
                request.setAttribute("shop", shop);
                request.getRequestDispatcher("Shop.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageShop.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
