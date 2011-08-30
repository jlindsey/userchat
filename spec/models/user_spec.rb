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

  it "overloads method_missing to allow for role? methods" do
    @blank_user.role = "manager"

    lambda { @blank_user.manager? }.should_not raise_exception(NoMethodError)
    lambda { @blank_user.qux? }.should raise_exception(NoMethodError)

    @blank_user.manager?.should == true
    @blank_user.operator?.should == false
    @blank_user.owner?.should == false
  end
end
