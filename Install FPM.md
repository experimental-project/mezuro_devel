Install FPM

dependencies:
apt-get install ruby-dev gcc
yum install ruby-devel gcc

gem install fpm

Converting gem to deb

Create a Gemfile with the gems you want to convert to .deb
bundle package
find vendor/cache -name '*.gem' | xargs -n1 fpm -s gem -t deb
sudo dpkg -i *.deb


p.s: If you have any trouble installing the follow gems, please install the follow packages
 gem pg -- sudo apt-get install libpq-dev
 sqlite3 -- ﻿sudo apt-get install libsqlite3-dev
