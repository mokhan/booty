source ~/.bashrc
cd .

bundle install
bundle exec rake ci --trace
