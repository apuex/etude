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
            saveBlob(rs);
        }
        conn.close();
    }

    private void saveBlob(ResultSet rs) throws Exception {
        int blobId = rs.getInt("blob_id");
        String blobName = rs.getString("blob_name");
        InputStream blobContent = rs.getBinaryStream("blob_content");
        if(blobContent != null) {
            String fileName = String.format("%d-%s.blob", blobId, blobName);
            Files.copy(blobContent, new File(fileName).toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
    }
}
