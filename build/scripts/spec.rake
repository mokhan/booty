namespace :spec do
  task :all => [:unit, :integration, :acceptance]

  task :unit => 'db:migrate:test' do
    sh 'rspec spec/specs'
  end

  task :integration => 'db:migrate:test' do
    sh 'rspec spec/integration'
  end

  task :acceptance => 'db:migrate:test' do
    sh 'rspec spec/acceptance'
  end
end
