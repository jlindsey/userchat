Rails.application.config.middleware.use OmniAuth::Builder do
  # Social Networks
  provider :twitter, 'WiISndrWdkS8f8KSmeanw', 'lA0LgnqxiD5bxOyO3MwFBgpeKLcTtPtyGo6vzBCmYM'

  # OpenIDs
  require 'openid/store/filesystem'

  provider :openid, OpenID::Store::Filesystem.new('./tmp'), 
    :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :openid, OpenID::Store::Filesystem.new('./tmp'),
    :name => 'yahoo', :identifier => 'yahoo.com'
  provider :openid, OpenID::Store::Filesystem.new('./tmp'),
    :name => 'myopenid', :identifier => 'myopenid.com'
end

