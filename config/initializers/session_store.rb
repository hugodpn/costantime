# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_costantime_session',
  :secret      => '4a272ba32da1a3b406ecb7c660a94fa8d301f2de81a6070e04d4427fa828a4efc76bf66d17f5ff26fa19e83bde6b9ba7f3edef5a3f3489f61207bcb6806925dc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
