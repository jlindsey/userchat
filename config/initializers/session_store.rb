# Be sure to restart your server when you modify this file.

Userchat::Application.config.session_store :cookie_store

Userchat::Application.config.session = {
  key:          '_userchat_session',
  domain:       nil,
  expire_after: 1.month,
  secure:       false,
  httponly:     true,
  secret:       '49edc42070a4b01ef07ea2395727aea926adfc3170657ad6e95d56cb5c9bb9109eb66fdeef5b9ad8593c58a6e253d3e46abf72a8b178c4c9505ec0e862f9b368'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Yatta::Application.config.session_store :active_record_store
