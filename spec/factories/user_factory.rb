Factory.define :user do |u|
  u.login { Factory.next :login }
  u.password 'sekrit'
end

Factory.define :admin, :class => User do |u|
  u.login { Factory.next :login }
  u.password 'sekrit'
  u.is_admin true
end