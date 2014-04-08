$(document).foundation({
  accordion: {
    multi_expand: true
  }
});

$(document).ready(function() {
  if (matchMedia(Foundation.media_queries['medium']).matches) {
    $('#shownotes').addClass('active')
          .parent().addClass('active');
  }

  // set up autocomplete
  $(".swiftype-search-input").swiftype({
    engineKey: "Wdx4LxrBJv86q28yDA8A"
  });

  // set up search
  $(".swiftype-search-input").swiftypeSearch({
    engineKey: "Wdx4LxrBJv86q28yDA8A",
    resultContainingElement: "#st-results-container",
    renderFunction: swiftypeRenderFunction
  });

  $(".swiftype-search-form").submit(function(event) {
    event.preventDefault();
    var query = $(".swiftype-search-input", this).val();
    window.location = "/results/#stq=" + query;
  });

  $(".search-results .swiftype-search-input").val(extractSearchQuery);

  if (location.pathname == "/results") {
    $(window).hashchange(function() {
      $(".search-results .swiftype-search-input").val(extractSearchQuery);
    });
  }

});

function extractSearchQuery() {
  // Example location:
  //   /results#stq=vim&stp=2
  return location.hash.split('&')[0].split('=')[1];
};
