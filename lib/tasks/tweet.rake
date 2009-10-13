namespace :tweet do
  desc 'generates a bitly link to an item and tweets it out'
  task :item => :environment do
    %w(BITLY_USER BITLY_KEY TWITTER_USER TWITTER_PASS ITEM_ID).each do |var|
      abort "Must set #{var} env var to run" unless ENV.include?(var)
    end
    
    item  = Item.find_by_id(ENV['ITEM_ID'])
    
    if item
      item.tweet
    end
  end
end