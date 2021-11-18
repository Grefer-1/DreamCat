/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.DreamCatDAO;
import Model.CartUser;
import Model.LoginUser;
import Model.ShopProduct;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
public class ShopAdd extends HttpServlet {

    ArrayList<ShopProduct> shop = new ArrayList<ShopProduct>();
    ArrayList<CartUser> cart = new ArrayList<CartUser>();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = request.getSession();
            LoginUser account = (LoginUser) session.getAttribute("account");
            if (account != null && account.getRole().equals("admin")) {
                request.getRequestDispatcher("ShopAdd.jsp").forward(request, response);
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
        processRequest(request, response);
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
        HttpSession session = request.getSession();
        LoginUser account = (LoginUser) session.getAttribute("account");
        request.setAttribute("account", account);
        if (account == null) {
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } else {
            try {
                int id = DreamCatDAO.getProfileByUsername(account.getUsername()).getId();
                if (DreamCatDAO.checkUserOrder(id) == 0) {
                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    LocalDate localDate = LocalDate.now();
                    String date = dtf.format(localDate);
                    DreamCatDAO.createOrder(id, date);
                    int orderNo = DreamCatDAO.checkUserOrder(id);
                    int itemNo = (int) request.getAttribute("item");
                    DreamCatDAO.addItem(orderNo, itemNo, 1);
                    shop = DreamCatDAO.getProduct();
                    request.setAttribute("shop", shop);
                    request.getRequestDispatcher("Shop.jsp").forward(request, response);
                } else {
                    if (DreamCatDAO.checkOrderItem(DreamCatDAO.checkUserOrder(id)) == 0) {
                        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                        LocalDate localDate = LocalDate.now();
                        String date = dtf.format(localDate);
                        int orderNo = DreamCatDAO.checkUserOrder(id);
                        DreamCatDAO.UpdateOrderTime(orderNo, id, date);
                    }
                    int orderNo = DreamCatDAO.checkUserOrder(id);
                    int itemNo = Integer.parseInt(request.getParameter("item"));
                    if (DreamCatDAO.checkDuplicateItem(orderNo, itemNo) == true) {
                        int qty = DreamCatDAO.getQuantity(orderNo, itemNo);
                        int stock = DreamCatDAO.getStock(itemNo);
                        if (qty < stock) {
                            DreamCatDAO.addQuantity(qty + 1, orderNo, itemNo);
                        } else if (qty == stock) {
                        }
                    } else {
                        DreamCatDAO.addItem(orderNo, itemNo, 1);
                    }
                    shop = DreamCatDAO.getProduct();
                    request.setAttribute("shop", shop);
                    request.getRequestDispatcher("Shop.jsp").forward(request, response);
                }
            } catch (SQLException ex) {
                Logger.getLogger(ShopAdd.class.getName()).log(Level.SEVERE, null, ex);
            }
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
