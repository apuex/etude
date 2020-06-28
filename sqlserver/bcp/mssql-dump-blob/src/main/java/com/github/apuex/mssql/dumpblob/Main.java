package com.github.apuex.mssql.dumpblob;

import org.apache.commons.cli.*;

import java.util.Map;

/**
 * Hello world!
 */
public class Main {
    public static void main(String[] args) throws ParseException {
        CmdLineOpts cmdLineOpts = new CmdLineOpts();
        CommandLineParser parser = new DefaultParser();
        Options options = cmdLineOpts.options();
        CommandLine cmd = parser.parse(options, args, true);

        if (cmd.hasOption("h")) {
            HelpFormatter formatter = new HelpFormatter();
            formatter.printHelp("soap-client <options>", options);
            cmdLineOpts.printOptions(cmdLineOpts.defaultOptions(), "default options are:");
        } else {
            final Map<String, String> params = cmdLineOpts.defaultOptions();
            options.getOptions().forEach(o -> {
                if (cmd.hasOption(o.getOpt())) {
                    params.put(o.getLongOpt(), cmd.getOptionValue(o.getOpt()));
                }
            });
            cmdLineOpts.printOptions(params, "current options are:");
        }
    }
}
