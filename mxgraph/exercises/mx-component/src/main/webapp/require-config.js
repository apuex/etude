var webjars = {
    versions: {"github-com-novaeye-jquery-easyui-bower":"1.5.0.1","mxgraph-client":"3.9.8","mxgraph-editor":"3.9.8","uuid.js":"3.6.1","jquery-i18n-properties":"1.2.7","requirejs":"2.3.5","jquery":"3.1.1"},
    path: function(webJarId, path) {
        console.error('The webjars.path() method of getting a WebJar path has been deprecated.  The RequireJS config in the ' + webJarId + ' WebJar may need to be updated.  Please file an issue: http://github.com/webjars/' + webJarId + '/issues/new');
        return ['/mx-component/webjars/' + webJarId + '/' + webjars.versions[webJarId] + '/' + path];
    }
};

var require = {
    callback: function() {
        // Deprecated WebJars RequireJS plugin loader
        define('webjars', function() {
            return {
                load: function(name, req, onload, config) {
                    if (name.indexOf('.js') >= 0) {
                        console.warn('Detected a legacy file name (' + name + ') as the thing to load.  Loading via file name is no longer supported so the .js will be dropped in an effort to resolve the module name instead.');
                        name = name.replace('.js', '');
                    }
                    console.error('The webjars plugin loader (e.g. webjars!' + name + ') has been deprecated.  The RequireJS config in the ' + name + ' WebJar may need to be updated.  Please file an issue: http://github.com/webjars/webjars/issues/new');
                    req([name], function() {
                        onload();
                    });
                }
            }
        });

        // All of the WebJar configs


requirejs.config({"paths":{"jquery-easyui":["/mx-component/webjars/github-com-novaeye-jquery-easyui-bower/1.5.0.1/jquery.easyui.min"]}});
requirejs.config({"paths":{"mxgraph-client":["/mx-component/webjars/mxgraph-client/3.9.8/mxClient","mxClient"],"mxgraph-client-min":["/mx-component/webjars/mxgraph-client/3.9.8/mxClient.min","mxClient.min"]},"packages":[]});
requirejs.config({"paths":{"mxgraph-editor":["/mx-component/webjars/mxgraph-editor/3.9.8/mxGraphEditor","mxGraphEditor"],"mxgraph-editor-min":["/mx-component/webjars/mxgraph-editor/3.9.8/mxGraphEditor.min","mxGraphEditor.min"],"mxgraph-viewer":["/mx-component/webjars/mxgraph-editor/3.9.8/mxGraphViewer","mxGraphViewer"],"mxgraph-viewer-min":["/mx-component/webjars/mxgraph-editor/3.9.8/mxGraphViewer.min","mxGraphViewer.min"]},"packages":[]});
requirejs.config({"paths":{"uuid-js":["/mx-component/webjars/uuid.js/3.6.1/src/uuid"]}});
requirejs.config({"paths":{"jquery-i18n-properties":["/mx-component/webjars/jquery-i18n-properties/1.2.7/jquery.i18n.properties"]}});
requirejs.config({"paths":{},"packages":[]});
requirejs.config({"paths":{"jquery":["/mx-component/webjars/jquery/3.1.1/dist/jquery"]}});    }
};

var mxBasePath = "/mx-component/webjars/mxgraph-client/3.9.8";
var BASE_URI   = "/mx-component";
