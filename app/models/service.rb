class Service < ActiveRecord::Base
  CurrentProviders = %w(twitter google yahoo myopenid)

  belongs_to :user
end
