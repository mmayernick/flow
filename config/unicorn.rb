require 'uuid'
# using unicorn or another forking server? you'll need the code below:

worker_processes 4 # amount of unicorn workers to spin up
timeout 30         # restarts workers that hang for 30 seconds

after_fork do |server, worker|
  UUID.generator.next_sequence
end