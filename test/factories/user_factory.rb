Factory.define :user do |u|
  u.login { Factory.next :login }
  u.password 'sekrit'
  u.password_confirmation 'sekrit'
end

Factory.define :admin, :class => User do |u|
  u.login { Factory.next :login }
  u.password 'sekrit'
  u.password_confirmation 'sekrit'
  u.admin 1
end