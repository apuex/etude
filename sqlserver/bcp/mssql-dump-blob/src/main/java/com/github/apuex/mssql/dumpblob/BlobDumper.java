package com.github.apuex.mssql.dumpblob;

import com.microsoft.sqlserver.jdbc.SQLServerDriver;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;
import java.util.Properties;

public class BlobDumper {
    private Map<String, String> params;
    public BlobDumper(Map<String, String> params) {
        this.params = params;
    }
    public void dump() throws Exception {
        SQLServerDriver driver = new SQLServerDriver();
        Properties props = new Properties(){{
            put("user", params.get("username"));
            put("password", params.get("password"));
        }};
        String url = String.format("jdbc:sqlserver://%s:%s;databaseName=%s"
                , params.get("server")
                , params.get("port")
                , params.get("database"));
        Connection conn = driver.connect(url, props);

        PreparedStatement stmt = conn.prepareStatement(params.get("query"));
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            saveBlob(rs.getString("blob_name"), rs.getBinaryStream("blob_content"));
        }
        conn.close();
    }

    private void saveBlob(String blobName, InputStream blobContent) throws Exception {
        if(blobContent != null) {
            OutputStream os = new FileOutputStream(String.format("%s.blob", blobName));

            Files.copy(blobContent, new File(String.format("%s.blob", blobName)).toPath(), StandardCopyOption.REPLACE_EXISTING);

            os.close();
        }
    }
}
