# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_redirector_session',
  :secret      => 'a696706dfadf7ef3902d6537ec6ecce9cd4a3d734c2c4711a110187c54fe18cdbee40768b9546aefed88e1ecc54764f38b551f73b8e66d8a69e2d0345adbe237'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
