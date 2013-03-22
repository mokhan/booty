require 'yaml'
Dir.glob('build/**/*.rake').each { |r| import r }

task :default => :spec
task :spec => 'spec:all'
task :run => 'run:development'
task :ci => ['db:create:test', 'spec:unit', 'spec:integration']
