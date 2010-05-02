# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_nanolooploop_session',
  :secret      => 'cf7efc68514cf6d695f31a63dc4bab680a69e85a8c1024c2fa4478279469004133dcff646c456ad2525db1b2f8c46f715cf6fda01ba29943ec4bd030b07a4dd7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
