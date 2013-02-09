source ~/.bashrc
cd .

bundle install
BOOTY_ENV=test bundle exec rake spec --trace
