"use strict";

var auth_main = function auth_main(ns_prefix, cookie_expires) {
  var cookie_options = {
    expires: cookie_expires
  };

  if (location.protocol === 'https:') {
    // add cookie options that browsers are starting to require to allow you to
    // use cookies within iframes. Only works when app is running on https.
    cookie_options.sameSite = 'none';
    cookie_options.secure = true;
  }

  var sign_in = function sign_in(email, password) {
    var noclocksauthr_cookie = "p" + Math.random();
    Cookies.set('noClocksAuthR', noclocksauthr_cookie, cookie_options);
    Shiny.setInputValue("".concat(ns_prefix, "check_jwt"), {
      email: email,
      password: password,
      cookie: noclocksauthr_cookie
    }, {
      event: "priority"
    });
  };

  $(document).on("click", "#".concat(ns_prefix, "register_submit"), function () {
    var email = $("#".concat(ns_prefix, "register_email")).val().toLowerCase();
    var password = $("#".concat(ns_prefix, "register_password")).val();
    var password_2 = $("#".concat(ns_prefix, "register_password_verify")).val();

    if (password !== password_2) {
      // Event to reset Register loading button from loading state back to ready state
      loadingButtons.resetLoading("".concat(ns_prefix, "register_submit"));
      toastr.error("The passwords do not match", null, toast_options);
      console.log("the passwords do not match");
      return;
    } else if (password == "" && password_2 == "") {
      // Event to reset Register loading button from loading state back to ready state
      loadingButtons.resetLoading("".concat(ns_prefix, "register_submit"));
      toastr.error("Invalid password", null, toast_options);
      console.log("invalid password");
      return;
    }

    var noclocksauthr_cookie = "p" + Math.random();
    Cookies.set('noClocksAuthR', noclocksauthr_cookie, {
      expires: cookie_expires
    });
    Shiny.setInputValue("".concat(ns_prefix, "register_js"), {
      email: email,
      password: password,
      cookie: noclocksauthr_cookie
    }, {
      event: "priority"
    });
  });
  $(document).on("click", "#".concat(ns_prefix, "sign_in_submit"), function () {
    var email = $("#".concat(ns_prefix, "sign_in_email")).val().toLowerCase();
    var password = $("#".concat(ns_prefix, "sign_in_password")).val();
    sign_in(email, password);
  });
};