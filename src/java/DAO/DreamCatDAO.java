/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Model.CartUser;
import Model.GalleryPic;
import Model.GameList;
import Model.LoginUser;
import Model.MyTeam;
import Model.OrderProducts;
import Model.ShopProduct;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;

/**
 *
 * @author Asus
 */
public class DreamCatDAO {

    public static Boolean IsMember(String username, String password) throws SQLException {
        try (Connection conn = DBContext.getConnection()) {
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery("select count(*) 'count' \n"
                    + "from Customer\n"
                    + "where username = '" + username + "' and password = '" + password + "'");
            while (rs.next()) {
                int count = rs.getInt("count");
                if (count != 0) {
                    return true;
                }
            }
        }
        return false;
    }

    public static int AddCustomer(int id, String username, String password, String name, String phone, String address, String role) throws SQLException {
        Connection conn = DBContext.getConnection();
        String sql = "insert into Customer(id ,username, password, name, phone, address, Role) values(?,?,?,?,?,?,?)";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, id);
        pst.setString(2, username);
        pst.setString(3, password);
        pst.setString(4, name);
        pst.setString(5, phone);
        pst.setString(6, address);
        pst.setString(7, role);
        return pst.executeUpdate();
    }

    public static LoginUser getProfileByUsername(String username) throws SQLException {
        try (Connection conn = DBContext.getConnection()) {
            String sql = "select id, username, password, name, phone, address, Role from Customer where username = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, username);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                LoginUser p = new LoginUser(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("Role"));
                return p;
            }
        }
        return null;
    }

    public static int UpdateProfile(String username, String password, String name, String phone, String address) throws SQLException {
        Connection conn = DBContext.getConnection();
        String sql = "update Customer set password = ?, name = ?, phone = ?, address = ? where username = ?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, password);
        pst.setString(2, name);
        pst.setString(3, phone);
        pst.setString(4, address);
        pst.setString(5, username);
        return pst.executeUpdate();
    }

    public static int CountCustomer() throws SQLException {
        try (Connection conn = DBContext.getConnection()) {
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery("select count(*) 'count' from Customer");
            while (rs.next()) {
                int count = rs.getInt("count");
                if (count != 0) {
                    return count + 1;
                } else {
                    return 0;
                }
            }
        }
        return 0;
    }

    public static Boolean CheckUsername(String username) throws SQLException {
        try (Connection conn = DBContext.getConnection()) {
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery("select count(*) 'count' \n"
                    + "from Customer\n"
                    + "where username = '" + username + "'");
            while (rs.next()) {
                int count = rs.getInt("count");
                if (count != 0) {
                    return true;
                }
            }
        }
        return false;
    }

    public static ArrayList<GalleryPic> getAllGallery() throws SQLException {
        ArrayList<GalleryPic> list;
        try (Connection conn = DBContext.getConnection()) {
            Statement statement = conn.createStatement();
            list = new ArrayList<>();
            ResultSet rs = statement.executeQuery("select id, image_file_name from gallery");
            while (rs.next()) {
                GalleryPic c = new GalleryPic(
                        rs.getInt("id"),
                        rs.getString("image_file_name"));
                list.add(c);
            }
            conn.close();
        }
        return list;
    }

    public static ArrayList<MyTeam> getTeam() throws SQLException {
        ArrayList<MyTeam> list;
        try (Connection conn = DBContext.getConnection()) {
            Statement statement = conn.createStatement();
            list = new ArrayList<>();
            ResultSet rs = statement.executeQuery("select id, name, image_file_name, job, dsc from Team");
            while (rs.next()) {
                MyTeam c = new MyTeam(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image_file_name"),
                        rs.getString("job"),
                        rs.getString("dsc"));
                list.add(c);
            }
            conn.close();
        }
        return list;
    }

    public static ArrayList<GameList> getGame() throws SQLException {
        ArrayList<GameList> list;
        try (Connection conn = DBContext.getConnection()) {
            Statement statement = conn.createStatement();
            list = new ArrayList<>();
            ResultSet rs = statement.executeQuery("select id, name, image_file_name, dsc from game");
            while (rs.next()) {
                GameList c = new GameList(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image_file_name"),
                        rs.getString("dsc"));
                list.add(c);
            }
            conn.close();
        }
        return list;
    }

    public static ArrayList<ShopProduct> getProduct() throws SQLException {
        ArrayList<ShopProduct> list;
        try (Connection conn = DBContext.getConnection()) {
            Statement statement = conn.createStatement();
            list = new ArrayList<>();
            ResultSet rs = statement.executeQuery("select id, name, image_file_name, price, stock, descrip from Product");
            while (rs.next()) {
                ShopProduct c = new ShopProduct(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image_file_name"),
                        rs.getInt("price"),
                        rs.getInt("stock"),
                        rs.getString("descrip"));
                list.add(c);
            }
            conn.close();
        }
        return list;
    }

    public static int createOrder(int id, String date) throws SQLException {
        Connection conn = DBContext.getConnection();
        String sql = "insert into Orders values(?,?,'')";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, id);
        pst.setString(2, date);
        return pst.executeUpdate();
    }

    public static ArrayList<CartUser> getUserCart(int id) throws SQLException {
        ArrayList<CartUser> list;
        try (Connection conn = DBContext.getConnection()) {
            Statement statement = conn.createStatement();
            list = new ArrayList<>();
            ResultSet rs = statement.executeQuery("select p.id, p.name, p.image_file_name, p.price, p.stock, i.qty, p.descrip from Product p join Item i on p.id = i.prod where i.ordr = '" + id + "'");
            while (rs.next()) {
                CartUser c = new CartUser(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image_file_name"),
                        rs.getInt("price"),
                        rs.getInt("stock"),
                        rs.getInt("qty"),
                        rs.getString("descrip"));
                list.add(c);
            }
            conn.close();
        }
        return list;
    }

    public static ArrayList<ShopProduct> getProductbyID(int pID) throws SQLException {
        ArrayList<ShopProduct> list;
        try (Connection conn = DBContext.getConnection()) {
            Statement statement = conn.createStatement();
            list = new ArrayList<>();
            ResultSet rs = statement.executeQuery("select id, name, image_file_name, price, stock, descrip from Product where id = '" + pID + "'");
            while (rs.next()) {
                ShopProduct s = new ShopProduct(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image_file_name"),
                        rs.getInt("price"),
                        rs.getInt("stock"),
                        rs.getString("descrip"));
                list.add(s);
            }
            conn.close();
        }
        return list;
    }

    public static int checkUserOrder(int id) throws SQLException {
        try (Connection conn = DBContext.getConnection()) {
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery("select MAX(id) as 'orderNo' from Orders where cust = '" + id + "'");
            while (rs.next()) {
                int count = rs.getInt("orderNo");
                if (count != 0) {
                    return count;
                }
            }
        }
        return 0;
    }

    public static int addItem(int orderNo, int itemNo, int qty) throws SQLException {
        Connection conn = DBContext.getConnection();
        String sql = "insert into Item values(?,?,?)";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, orderNo);
        pst.setInt(2, itemNo);
        pst.setInt(3, qty);
        return pst.executeUpdate();
    }

    public static int UpdateCart(int cartID, int prdID, int quantity) throws SQLException {
        Connection conn = DBContext.getConnection();
        String sql = "update Item set qty = ? where ordr = ? and prod = ?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, quantity);
        pst.setInt(2, cartID);
        pst.setInt(3, prdID);
        return pst.executeUpdate();
    }

    public static int checkOrderItem(int id) throws SQLException {
        try (Connection conn = DBContext.getConnection()) {
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery("select ordr as 'orderNo' from Item where ordr = '" + id + "'");
            while (rs.next()) {
                int count = rs.getInt("orderNo");
                if (count != 0) {
                    return count;
                }
            }
        }
        return 0;
    }

    public static int UpdateOrderTime(int orderNo, int id, String date) throws SQLException {
        Connection conn = DBContext.getConnection();
        String sql = "update Orders set odate = ? where id = ? and cust = ?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, date);
        pst.setInt(2, orderNo);
        pst.setInt(3, id);
        return pst.executeUpdate();
    }

    public static int deleteCart(int cartID, int prdID) throws SQLException {
        Connection conn = DBContext.getConnection();
        String sql = "delete Item where ordr = ? and prod = ?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, cartID);
        pst.setInt(2, prdID);
        return pst.executeUpdate();
    }

    public static boolean checkDuplicateItem(int orderNo, int itemNo) throws SQLException {
        try (Connection conn = DBContext.getConnection()) {
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery("select prod from Item where ordr = '" + orderNo + "' and prod = '" + itemNo + "'");
            while (rs.next()) {
                int count = rs.getInt("prod");
                if (count != 0) {
                    return true;
                }
            }
        }
        return false;
    }

    public static int getQuantity(int orderNo, int itemNo) throws SQLException {
        try (Connection conn = DBContext.getConnection()) {
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery("select qty from Item where ordr = '" + orderNo + "' and prod = '" + itemNo + "'");
            while (rs.next()) {
                int qty = rs.getInt("qty");
                if (qty != 0) {
                    return qty;
                }
            }
        }
        return 0;
    }

    public static int getStock(int itemNo) throws SQLException {
        try (Connection conn = DBContext.getConnection()) {
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery("select stock from Product where id = '" + itemNo + "'");
            while (rs.next()) {
                int qty = rs.getInt("stock");
                if (qty != 0) {
                    return qty;
                }
            }
        }
        return 0;
    }

    public static int addQuantity(int quantity, int orderNo, int itemNo) throws SQLException {
        Connection conn = DBContext.getConnection();
        String sql = "update Item set qty = ? where ordr = ? and prod = ?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, quantity);
        pst.setInt(2, orderNo);
        pst.setInt(3, itemNo);
        return pst.executeUpdate();
    }

    public static int UpdateStock(int stock, int itemNo) throws SQLException {
        Connection conn = DBContext.getConnection();
        String sql = "update Product set stock = ? where id = ?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, stock);
        pst.setInt(2, itemNo);
        return pst.executeUpdate();
    }

    public static int deleteItem(int id) throws SQLException {
        Connection conn = DBContext.getConnection();
        String sql = "delete Product where id = ?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, id);
        return pst.executeUpdate();
    }

    public static int updateShop(int id, String name, String path, int price, int quantity, String desc) throws SQLException {
        Connection conn = DBContext.getConnection();
        String sql = "update Product set name = ?, image_file_name = ?, price = ?, stock = ?, descrip = ? where id = ?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, name);
        pst.setString(2, path);
        pst.setInt(3, price);
        pst.setInt(4, quantity);
        pst.setString(5, desc);
        pst.setInt(6, id);
        return pst.executeUpdate();
    }

    public static ArrayList<LoginUser> getAllProfile() throws SQLException {
        ArrayList<LoginUser> list;
        try (Connection conn = DBContext.getConnection()) {
            Statement statement = conn.createStatement();
            list = new ArrayList<>();
            ResultSet rs = statement.executeQuery("select id, username, password, name, phone, address, Role from Customer");
            while (rs.next()) {
                LoginUser c = new LoginUser(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("Role"));
                list.add(c);
            }
            conn.close();
        }
        return list;
    }

    public static int UpdateUser(int id, String username, String password, String name, String phone, String address) throws SQLException {
        Connection conn = DBContext.getConnection();
        String sql = "update Customer set username = ?, password = ?, name = ?, phone = ?, address = ? where id = ?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, username);
        pst.setString(2, password);
        pst.setString(3, name);
        pst.setString(4, phone);
        pst.setString(5, address);
        pst.setInt(6, id);
        return pst.executeUpdate();
    }

    public static int deleteUser(int id) throws SQLException {
        Connection conn = DBContext.getConnection();
        String sql = "delete Customer where id = ?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, id);
        return pst.executeUpdate();
    }

    public static ArrayList<OrderProducts> getAllOrders() throws SQLException {
        ArrayList<OrderProducts> list;
        try (Connection conn = DBContext.getConnection()) {
            Statement statement = conn.createStatement();
            list = new ArrayList<>();
            ResultSet rs = statement.executeQuery("select o.id, o.cust, i.prod, i.qty, o.odate, o.statuss from Orders o inner join Item i on o.id = i.ordr");
            while (rs.next()) {
                OrderProducts c = new OrderProducts(
                        rs.getInt("id"),
                        rs.getString("cust"),
                        rs.getInt("prod"),
                        rs.getInt("qty"),
                        rs.getDate("odate"),
                        rs.getBoolean("statuss"));
                list.add(c);
            }
            conn.close();
        }
        return list;
    }

    public static int addProduct(String name, String path, int price, int quantity, String desc) throws SQLException {
        Connection conn = DBContext.getConnection();
        String sql = "insert into Product(name, image_file_name, price, stock, descrip) values (?,?,?,?,?)";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, name);
        pst.setString(2, path);
        pst.setInt(3, price);
        pst.setInt(4, quantity);
        pst.setString(5, desc);
        return pst.executeUpdate();
    }

    public static int UpdateOrderStatus(int curcartNo, int userID) throws SQLException {
        Connection conn = DBContext.getConnection();
        String sql = "update Orders set statuss = '1' where id = ? and cust = ?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, curcartNo);
        pst.setInt(2, userID);
        return pst.executeUpdate();
    }

}
