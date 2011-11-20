# using unicorn or another forking server? you'll need the code below:

# after_fork do |server, worker|
#   UUID.generator.next_sequence
# end