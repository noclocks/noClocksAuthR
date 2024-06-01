
if (file.exists("config.yml")) {
  the_config <- config::get()

  noClocksAuthR::set_api_key(the_config$api_key)
}


noClocksAuthR:::set_api_url(
  api_url = "https://auth-api-dev.noclocks.dev/v1"
  #api_url = "http://0.0.0.0:8080/v1"
)
