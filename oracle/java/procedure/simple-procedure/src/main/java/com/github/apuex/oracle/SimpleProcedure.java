package com.github.apuex.oracle;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Hello world!
 */
public class SimpleProcedure {
    static int count = 0;

    public static void insert_into_table(int id, String name, String email) throws SQLException {

        Connection DB = DriverManager.getConnection("jdbc:default:connection:");

        String SQL = "INSERT INTO sampletable VALUES (?,?,?)";

        PreparedStatement cmd = DB.prepareStatement(SQL);

        count += 1;
        cmd.setInt(1, (id == 0 ? count : id));
        cmd.setString(2, name);
        cmd.setString(3, email);

        cmd.executeUpdate();
        cmd.close();

    }

    public static void update_from_table(int id, String name, String email) throws SQLException {

        Connection DB = DriverManager.getConnection("jdbc:default:connection:");

        String SQL = "UPDATE sampletable SET name = ?, email = ? WHERE id = ?";

        PreparedStatement cmd = DB.prepareStatement(SQL);

        count += 1;
        cmd.setString(1, name);
        cmd.setString(2, email);
        cmd.setInt(3, id);

        cmd.executeUpdate();
        cmd.close();

    }
}
