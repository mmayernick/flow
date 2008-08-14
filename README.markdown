NewsFlow
========
_Developed by Peter Cooper - 2008_

All code developed by Peter Cooper within this project is in the public domain.
Plugins, Rails, and derivative code is licensed as it was originally (mostly MIT).

This code is entirely unsupported, lacks tests, and could well make your machine
explode. If you use it, you understand this and accept all the risks.


Getting Started
---------------
I have not tested these instructions, but from memory..

1. Rename config/database.yml.dist to database.yml and make the appropriate
configuration changes.

2. Run rake db:migrate to set up your database.
 
3. Set up your site configuration, a default configuration file is found in config/newsflow.yml

Advanced Multi-Site Usage
-------------------------
It is possible to create multiple configuration .yml files and then change the first line of config/environment.rb to switch between them.