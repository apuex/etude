package com.github.apuex.mssql.dumpblob;

import com.microsoft.sqlserver.jdbc.SQLServerDriver;
import com.wincom.mstar.pe.console.ConsoleDoc;
import com.wincom.mstar.pe.console.Util;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;
import java.util.Properties;

import static java.lang.System.out;

public class BlobDumper {
    private Map<String, String> params;
    public BlobDumper(Map<String, String> params) {
        this.params = params;
    }
    public void dump() throws Exception {
        decode = !("false".equalsIgnoreCase(params.get("decode")));
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
            if(decode) {
                decodeBlob(rs);
            } else {
                saveBlob(rs);
            }
        }
        conn.close();
    }

    private void decodeBlob(ResultSet rs) throws Exception {
        int blobId = rs.getInt("blob_id");
        String blobName = rs.getString("blob_name");
        byte[] input = rs.getBytes("blob_content");
        if(input != null) {
            Util.runtimeClass.clear();
            ConsoleDoc doc = new ConsoleDoc();
            ByteBuffer buffer = ByteBuffer.wrap(input);
            buffer.order(ByteOrder.LITTLE_ENDIAN);
            try {
                doc.load(buffer);
                // out.printf("[id: %s] length = %s position = %s\n", blobId, buffer.capacity(), buffer.position());
            } catch (Throwable t) {
                out.printf("[id: %s] length = %s position = %s, %s\n", blobId, buffer.capacity(), buffer.position(), t.getMessage());
                t.printStackTrace();
            }
        }
    }

    private void saveBlob(ResultSet rs) throws Exception {
        int blobId = rs.getInt("blob_id");
        String blobName = rs.getString("blob_name");
        InputStream blobContent = rs.getBinaryStream("blob_content");
        if(blobContent != null) {
            String fileName = String.format("%d-%s.blob", blobId, blobName);
            Files.copy(blobContent, new File(fileName).toPath(), StandardCopyOption.REPLACE_EXISTING);
            blobContent.close();
        }
    }

    private boolean decode = false;
}
