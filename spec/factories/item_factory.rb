Factory.define :item do |item|
  item.title { Factory.next :title }
  item.name { Factory.next :name }
  item.content %q(<a href="http://icanhascheezburger.com">invisble link!</a>)
end