const auth = firebase.auth()


const auth_firebase = (ns_prefix, cookie_expires) => {

  let cookie_options = {expires: cookie_expires}
  if (location.protocol === 'https:') {
    // add cookie options that browsers are starting to require to allow you to
    // use cookies within iframes.  Only works when app is running on https.
    cookie_options.sameSite = 'none'
    cookie_options.secure = true
  }

  const send_token_to_shiny = (user) => {

    return user.getIdToken(true).then(firebase_token => {

      const noclocksauthr_cookie = "p" + Math.random()


      Cookies.set(
        'noClocksAuthR',
        noclocksauthr_cookie,
        cookie_options
      )

      Shiny.setInputValue(`${ns_prefix}check_jwt`, {
        jwt: firebase_token,
        cookie: noclocksauthr_cookie
      }, {
        event: "priority"
      });
    })
  }


  // Google Sign In
  const provider_google = new firebase.auth.GoogleAuthProvider();

  $(document).on("click", `#${ns_prefix}sign_in_with_google`, () => {
    auth.signInWithPopup(provider_google).then(function(result) {

      return send_token_to_shiny(result.user)
    }).catch(function(err) {

      console.log(err)

      toastr.error(`Sign in Error: ${err.message}`, null, toast_options)
    })
  })

  // Microsoft Sign In
  var provider_microsoft = new firebase.auth.OAuthProvider('microsoft.com');
  $(document).on("click", `#${ns_prefix}sign_in_with_microsoft`, () => {
    auth.signInWithPopup(provider_microsoft).then(function(result) {

      return send_token_to_shiny(result.user)
    }).catch(err => {

      console.log(err)

      toastr.error(`Sign in Error: ${err.message}`, null, toast_options)
    })
  })

  // Facebook Sign In
  var provider_facebook = new firebase.auth.FacebookAuthProvider();
  $(document).on("click", `#${ns_prefix}sign_in_with_facebook`, () => {
    auth.signInWithPopup(provider_facebook).then(function(result) {

      return send_token_to_shiny(result.user)
    }).catch(err => {

      console.log(err)

      toastr.error(`Sign in Error: ${err.message}`, null, toast_options)
    })
  })

}

