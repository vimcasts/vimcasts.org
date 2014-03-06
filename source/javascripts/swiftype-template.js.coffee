window.swiftypeRenderFunction = (document_type, item) ->
  """
  <div class="st-result">
    <h3 class="title">
      <a href="#{item['url']}" class="st-search-result-link">
	#{titleMaybeWithHighlight(item)}
      </a>
    </h3>
    #{bodyMaybeWithHighlight(item)}
  </div>
  """

titleMaybeWithHighlight = (item) ->
  item['highlight']['title'] || item['title']

bodyMaybeWithHighlight = (item) ->
  if body = item['highlight']['body'] || item['body']
    "<p>&hellip;#{body}&hellip;</p>"
  else
    ""
