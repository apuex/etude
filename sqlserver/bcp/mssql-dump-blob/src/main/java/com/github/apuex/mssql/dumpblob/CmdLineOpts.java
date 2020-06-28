package com.github.apuex.mssql.dumpblob;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.Options;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import static java.lang.System.out;

public class CmdLineOpts {
    public Options options() {
        return (new Options())
                .addOption(new Option("S", "server", true, "server name/ip address"))
                .addOption(new Option("p", "port", true, "server port"))
                .addOption(new Option("D", "database", true, "database name"))
                .addOption(new Option("U", "username", true, "user name"))
                .addOption(new Option("P", "password", true, "password"))
                .addOption(new Option("q", "query", true, "SQL query statement"))
                .addOption(new Option("h", "help", false, "print help message"));
    }

    public Map<String, String> defaultOptions() {
        return new HashMap<String, String>() {{
            put("server", "localhost");
            put("port", "1433");
            put("database", "master");
            put("username", "sa");
            put("password", "sa-Passw0rd");
            put("query", "select o.location_name as blob_name, u.UIWindow as blob_content from realdata_location_name o, CLogObjUI u where o.location_id = u.LogObjID");
        }};
    }

    void printOptions(Map<String, String> options, String desc) {
        if (!options.isEmpty()) {
            System.out.println(desc);
            Optional<Integer> maxLength = options.entrySet().stream()
                    .map(x -> x.getKey().length())
                    .max(Integer::compare);
            options.entrySet().forEach(e -> out.printf("  %s = %s\n", paddingRight(e.getKey(), maxLength.orElse(0)), e.getValue()));
        }
    }

    String paddingRight(String s, int maxWidth) {
        int length = s.length();
        StringBuilder sb = new StringBuilder();
        sb.append(s);
        if (length < maxWidth) {
            int i = length;
            while (
                    i < maxWidth
            ) {
                sb.append(' ');
                i += 1;
            }
        }
        return sb.toString();
    }

    void printHelp(CommandLine cmd, Options options, Map<String, String> defaultOptions) {
        HelpFormatter formatter = new HelpFormatter();
        formatter.printHelp("tools-app <options>", options);
        printOptions(defaultOptions, "default options are:");
    }
}
