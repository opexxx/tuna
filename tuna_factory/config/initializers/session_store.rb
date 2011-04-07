# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tuna_session',
  :secret      => '59e33f4c6e2d87c642bf88ce472a9a7eaf20689f6f1feaf5fb3a0873c60fd1449df7fe12e43eed4cafda1867bfc22cf7996a85942ea1c09a9441b517b0a00cf8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
