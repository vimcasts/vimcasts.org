(function() {
  var bodyMaybeWithHighlight, titleMaybeWithHighlight;

  window.swiftypeRenderFunction = function(document_type, item) {
    return "  <div class=\"st-result\">\n    <h3 class=\"title\">\n      <a href=\"" + item['url'] + "\" class=\"st-search-result-link\">\n" + (titleMaybeWithHighlight(item)) + "\n      </a>\n    </h3>\n    " + (bodyMaybeWithHighlight(item)) + "\n  </div>";
  };

  titleMaybeWithHighlight = function(item) {
    return item['highlight']['title'] || item['title'];
  };

  bodyMaybeWithHighlight = function(item) {
    var body;
    if (body = item['highlight']['body'] || item['body']) {
      return "<p>&hellip;" + body + "&hellip;</p>";
    } else {
      return "";
    }
  };

}).call(this);
