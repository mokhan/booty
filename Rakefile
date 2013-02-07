namespace :generate do
  task :migration, :title do |t, args|
    filename = "lib/infrastructure/database/migrations/#{Time.now.strftime('%Y-%m-%d-%H-%M-%S-%L')}-#{args.title}.rb"
    if File.exist?(filename)
      abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
    end
    puts "Creating new migration: #{filename}"
    open(filename, 'w') do |post|
      post.puts "Sequel.migration do"
      post.puts "  change do"
      post.puts "  end"
      post.puts "end"
    end
  end
end

