require 'yaml'
Dir.glob('build/**/*.rake').each { |r| import r }

task :default => :spec
task :spec => 'spec:all'
task :run => 'run:development'
task :ci => ['spec:unit', 'spec:integration']
