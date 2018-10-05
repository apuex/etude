require(['jquery', 'mxgraph-client'], function($, mx){
  var container = document.getElementById('graphContainer');
  // Fixes ignored clipping if foreignObject used in Webkit
  mxClient.NO_FO = mxClient.NO_FO || mxClient.IS_SF || mxClient.IS_GC;
  // Creates the graph inside the given container
  var graph = new mxGraph(container);
  graph.setTooltips(true);
  graph.htmlLabels = true;
  graph.vertexLabelsMovable = true;
  new mxRubberband(graph);
  new mxKeyHandler(graph);
  // Do not allow removing labels from parents
  graph.graphHandler.removeCellsFromParent = false;
  // Autosize labels on insert where autosize=1
  graph.autoSizeCellsOnAdd = true;
  // Allows moving of relative cells
  graph.isCellLocked = function(cell)
  {
    return this.isCellsLocked();
  };
  graph.isCellResizable = function(cell)
  {
    var geo = this.model.getGeometry(cell);

    return geo == null || !geo.relative;
  };
  // Truncates the label to the size of the vertex
  graph.getLabel = function(cell)
  {
    var label = (this.labelsVisible) ? this.convertValueToString(cell) : '';
    var geometry = this.model.getGeometry(cell);
    if (!this.model.isCollapsed(cell) && geometry != null && (geometry.offset == null ||
      (geometry.offset.x == 0 && geometry.offset.y == 0)) && this.model.isVertex(cell) &&
      geometry.width >= 2)
    {
      var style = this.getCellStyle(cell);
      var fontSize = style[mxConstants.STYLE_FONTSIZE] || mxConstants.DEFAULT_FONTSIZE;
      var max = geometry.width / (fontSize * 0.625);

      if (max < label.length)
      {
        return label.substring(0, max) + '...';
      }
    }
    return label;
  };
  // Enables wrapping for vertex labels
  graph.isWrapping = function(cell)
  {
    return this.model.isCollapsed(cell);
  };
  // Enables clipping of vertex labels if no offset is defined
  graph.isLabelClipped = function(cell)
  {
    var geometry = this.model.getGeometry(cell);
    return geometry != null && !geometry.relative && (geometry.offset == null ||
      (geometry.offset.x == 0 && geometry.offset.y == 0));
  };
  // Gets the default parent for inserting new cells. This
  // is normally the first child of the root (ie. layer 0).
  var parent = graph.getDefaultParent();
  // Adds cells to the model in a single step
  graph.getModel().beginUpdate();
  try
  {
    var v1 = graph.insertVertex(parent, null, 'vertexLabelsMovable', 20, 20, 80, 30);
    // Places sublabels inside the vertex
    var label11 = graph.insertVertex(v1, null, 'Label1', 0.5, 1, 0, 0, null, true);
    var label12 = graph.insertVertex(v1, null, 'Label2', 0.5, 0, 0, 0, null, true);

    var v2 = graph.insertVertex(parent, null, 'Wrapping and clipping is enabled only if the cell is collapsed, otherwise the label is truncated if there is no manual offset.', 200, 150, 80, 30);
    v2.geometry.alternateBounds = new mxRectangle(0, 0, 80, 30);
    var e1 = graph.insertEdge(parent, null, 'edgeLabelsMovable', v1, v2);

    // Places sublabels inside the vertex
    var label21 = graph.insertVertex(v2, null, 'Label1', 0.5, 1, 0, 0, null, true);
    var label22 = graph.insertVertex(v2, null, 'Label2', 0.5, 0, 0, 0, null, true);
  }
  finally
  {
    // Updates the display
    graph.getModel().endUpdate();
  }
});