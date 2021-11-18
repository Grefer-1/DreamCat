/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.DreamCatDAO;
import Model.CartUser;
import Model.LoginUser;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
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
public class Buy extends HttpServlet {

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
            if (account == null) {
                request.getRequestDispatcher("Login.jsp").forward(request, response);
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
        try {
            HttpSession session = request.getSession();
            LoginUser account = (LoginUser) session.getAttribute("account");
            request.setAttribute("account", account);
            int buy = Integer.parseInt(request.getParameter("buy"));
            if (account == null) {
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            } else {
                int userID = DreamCatDAO.getProfileByUsername(account.getUsername()).getId();
                int cartID = DreamCatDAO.checkUserOrder(userID);
                if (buy != 0) {
                    double total = 0, tax = 0.1;
                    DecimalFormat format = new DecimalFormat("###,###.000 VND");
                    ArrayList<CartUser> bill = DreamCatDAO.getUserCart(cartID);
                    for (int i = 0; i < bill.size(); i++) {
                        int qty = bill.get(i).getItemQuantity();
                        int stock = DreamCatDAO.getStock(bill.get(i).getProductID());
                        DreamCatDAO.UpdateStock(stock - qty, bill.get(i).getProductID());
                    }
                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                    LocalDateTime localDate = LocalDateTime.now();
                    String date = dtf.format(localDate);
                    try (PrintWriter pw = new PrintWriter(new FileOutputStream("C:\\Users\\Asus\\Documents\\NetBeansProjects\\DreamCat\\bill.txt"))) {
                        pw.write("           CASH RECEIPT           \n");
                        pw.write(DreamCatDAO.getProfileByUsername(account.getUsername()).getName() + " - " + DreamCatDAO.getProfileByUsername(account.getUsername()).getPhone() + "\n");
                        pw.write(DreamCatDAO.getProfileByUsername(account.getUsername()).getAddress() + "\n");
                        pw.write("----------------------------------\n");
                        for (CartUser c : bill) {
                            pw.write(c.getProductName() + " * " + c.getItemQuantity() + "   " + format.format(c.getProductPrice() * c.getItemQuantity()) + "\n");
                            total = total + c.getProductPrice() * c.getItemQuantity();
                        }
                        total = total + total * tax;
                        pw.write("----------------------------------\n");
                        pw.write("TOTAL: " + format.format(total) + "\n");
                        pw.write("----------------------------------\n");
                        pw.write("Tax                          10.00\n");
                        pw.write("                          DreamCat\n");
                        pw.write(date + "               \n");
                        pw.write("             THANK YOU             ");
                        pw.close();
                    }
                }
                if (buy != 0) {
                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    LocalDate localDate = LocalDate.now();
                    String date = dtf.format(localDate);
                    int curcartNo = DreamCatDAO.checkUserOrder(userID);
                    DreamCatDAO.UpdateOrderStatus(curcartNo, userID);
                    DreamCatDAO.createOrder(userID, date);
                    int cartNo = DreamCatDAO.checkUserOrder(userID);
                    cart = DreamCatDAO.getUserCart(cartNo);
                    request.setAttribute("cart", cart);
                    request.getRequestDispatcher("Cart.jsp").forward(request, response);
                } else {
                    cart = DreamCatDAO.getUserCart(cartID);
                    request.setAttribute("cart", cart);
                    request.getRequestDispatcher("Cart.jsp").forward(request, response);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Buy.class.getName()).log(Level.SEVERE, null, ex);
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
