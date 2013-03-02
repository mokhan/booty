source ~/.bashrc
cd .

bundle install
cp build/db/configuration.yml.template build/db/configuration.yml
bundle exec rake ci --trace
