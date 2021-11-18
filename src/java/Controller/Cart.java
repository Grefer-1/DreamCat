/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.DreamCatDAO;
import Model.CartUser;
import Model.LoginUser;
import Model.OrderProducts;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Asus
 */
public class Cart extends HttpServlet {

    ArrayList<CartUser> cart = new ArrayList<CartUser>();
    ArrayList<OrderProducts> orderProd = new ArrayList<OrderProducts>();
    
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
            if (account == null) {
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }else if (account.getRole().equals("admin")){
                orderProd = DreamCatDAO.getAllOrders();
                request.setAttribute("orderProd", orderProd);
                request.getRequestDispatcher("Cart.jsp").forward(request, response);
            }else {
                int userID = DreamCatDAO.getProfileByUsername(account.getUsername()).getId();
                int orderNo = DreamCatDAO.checkUserOrder(userID);
                cart = DreamCatDAO.getUserCart(orderNo);
                request.setAttribute("cart", cart);
                request.getRequestDispatcher("Cart.jsp").forward(request, response);
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
            Logger.getLogger(Cart.class.getName()).log(Level.SEVERE, null, ex);
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
            String quantity = request.getParameter("quantity");
            String itemNo = request.getParameter("id");
            int userID = DreamCatDAO.getProfileByUsername(account.getUsername()).getId();
            int orderNo = DreamCatDAO.checkUserOrder(userID);
            if (account == null) {
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            } else if (quantity == null || quantity.equals("") && itemNo == null || itemNo.equals("")) {
                cart = DreamCatDAO.getUserCart(orderNo);
                request.setAttribute("cart", cart);
                request.getRequestDispatcher("Cart.jsp").forward(request, response);
            } else if (Integer.parseInt(quantity) == 0) {
                DreamCatDAO.deleteCart(orderNo, Integer.parseInt(itemNo));
                cart = DreamCatDAO.getUserCart(orderNo);
                request.setAttribute("cart", cart);
                request.getRequestDispatcher("Cart.jsp").forward(request, response);
            } else if (Integer.parseInt(quantity) >= DreamCatDAO.getStock(Integer.parseInt(itemNo))) {
                DreamCatDAO.addQuantity(DreamCatDAO.getStock(Integer.parseInt(itemNo)), orderNo, Integer.parseInt(itemNo));
                cart = DreamCatDAO.getUserCart(orderNo);
                request.setAttribute("cart", cart);
                request.getRequestDispatcher("Cart.jsp").forward(request, response);
            } else {
                DreamCatDAO.UpdateCart(orderNo, Integer.parseInt(itemNo), Integer.parseInt(quantity));
                cart = DreamCatDAO.getUserCart(orderNo);
                request.setAttribute("cart", cart);
                request.getRequestDispatcher("Cart.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Cart.class.getName()).log(Level.SEVERE, null, ex);
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
