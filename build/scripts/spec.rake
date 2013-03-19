namespace :spec do
  task :all => [:unit, :integration, :acceptance]

  task :unit => 'db:migrate:test' do
    sh 'rspec spec/specs --profile'
  end

  task :integration => 'db:migrate:test' do
    sh 'rspec spec/integration --profile'
  end

  task :acceptance => 'db:migrate:test' do
    sh 'rspec spec/acceptance --profile'
  end
end
