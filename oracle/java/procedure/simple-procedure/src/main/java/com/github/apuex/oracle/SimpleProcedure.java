package com.github.apuex.oracle;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Hello world!
 *
 */
public class SimpleProcedure
{
    public static void insert_into_table(int ID, String Name, String Email) throws SQLException {

        Connection DB = DriverManager.getConnection("jdbc:default:connection:");

        String SQL ="INSERT INTO sampletable VALUES (?,?,?)";

        PreparedStatement cmd = DB.prepareStatement(SQL);

        cmd.setInt(1, ID);
        cmd.setString(2, Name );
        cmd.setString(3, Email );
        cmd.executeUpdate();
        cmd.close();
    }
}
