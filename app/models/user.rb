class User < ActiveRecord::Base
  Roles = %w(owner manager operator)

  has_many :services

  validates_inclusion_of :role, :in => Roles

  def method_missing(sym, *args)
    if sym =~ /\?$/ and Roles.include?(sym.to_s.sub '?', '')
      self.is_role? sym.to_s.sub('?', '')
    else
      super
    end
  end

  def respond_to? sym
    if sym =~ /\?$/ and Roles.include?(sym.to_s.sub '?', '')
      true
    else
      super
    end
  end

  def is_role? role
    self.role == role
  end
end
