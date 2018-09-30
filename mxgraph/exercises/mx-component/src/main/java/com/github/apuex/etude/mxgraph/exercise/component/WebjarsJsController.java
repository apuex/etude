package com.github.apuex.etude.mxgraph.exercise.component;

import static org.webjars.RequireJS.generateSetupJavaScript;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.webjars.WebJarAssetLocator;

@RestController
public class WebjarsJsController {
	private final static Logger logger = LoggerFactory.getLogger(WebjarsJsController.class);

	@ResponseBody
	@RequestMapping(value = "/webjarsjs", produces = "application/javascript")
	public String webjarjs(HttpServletRequest r) {
		Map<String, String> webJars = new WebJarAssetLocator().getWebJars();
		webJars.forEach((k, v) -> logger.info("{} => {}", k, v));
		List<String> prefixes = new LinkedList<>();
		String prefix = String.format("%s/webjars/", r.getContextPath());
		prefixes.add(prefix);
		String mxBasePath = String.format("var mxBasePath = \"%smxgraph-client/3.9.8\";", prefix);
		String baseUri = String.format(   "var BASE_URI   = \"%s\";", r.getContextPath());
		return String.format("%s\n%s\n%s\n", generateSetupJavaScript(prefixes, webJars), mxBasePath, baseUri);
	}
}
