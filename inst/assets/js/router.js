"use strict";

// force page reload after browser back and forward buttons are clicked
(function () {
  // get the noClocksAuthR page from the "page" query parameter
  var getnoclocksauthr_page = function getnoclocksauthr_page() {
    var queryString = window.location.search;
    var urlParams = new URLSearchParams(queryString);
    return urlParams.get('page');
  }; // get the initial noClocksAuthR page


  var noclocksauthr_page_prev = getnoclocksauthr_page(); // the following onpopstate event handler allows users to use forward and back buttons to navigate between
  // noClocksAuthR admin panel, the shiny app, and other shiny apps within the same noClocksAuthR app (e.g. payments) using
  // the forward and back buttons.  It also checks the query string to only refresh the app if the user is in fact
  // navigating between noClocksAuthR apps and not doing something like changing the url hash or query parameters.

  window.onpopstate = function (event) {
    var query_string = window.location.search;
    var url_params = new URLSearchParams(query_string);
    var noclocksauthr_page = url_params.get('page');

    if (noclocksauthr_page !== null || noclocksauthr_page_prev !== null && noclocksauthr_page === null) {
      window.location.reload(true);
      noclocksauthr_page_prev = noclocksauthr_page;
    }
  };
})();