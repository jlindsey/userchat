require 'spec_helper'

describe User do
  before(:each) do
    @blank_user = User.new
  end
  
  it { should have_many(:services) }

  it "defines the #is_role? method" do
    @blank_user.should respond_to(:is_role?)
  end

  it "overloads respond_to? to allow for role? methods" do
    User::Roles.each do |role|
      @blank_user.should respond_to("#{role}?".to_sym)
    end

    # Sanity check, make sure it's not just responding to everything
    @blank_user.should_not respond_to(:foo)
    @blank_user.should_not respond_to(:qux?)
  end
end
