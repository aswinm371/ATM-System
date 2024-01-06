import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CheckBalanceServlet")
public class CheckBalanceServlet extends HttpServlet {

    private static final String SELECT_BALANCE_QUERY = "SELECT BALANCE FROM USER_DETAILS WHERE USERID=?";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userid = req.getParameter("userid");

        try (Connection con = DriverManager.getConnection("jdbc:mysql:///firsttable", "root", "");
             PreparedStatement ps = con.prepareStatement(SELECT_BALANCE_QUERY)) {

            ps.setString(1, userid);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Retrieve the balance from the result set
                double balance = rs.getDouble("BALANCE");

                // Send the balance as the response
                resp.getWriter().write(Double.toString(balance));
            } else {
                // Handle the case where user not found
                resp.getWriter().write("User not found");
            }

        } catch (SQLException se) {
            resp.getWriter().write("Error retrieving balance: " + se.getMessage());
            se.printStackTrace();
        }
    }
}
