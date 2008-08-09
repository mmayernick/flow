Factory.define :category do |c|
  c.title { Factory.next :title}
  c.name { Factory.next :name }
end