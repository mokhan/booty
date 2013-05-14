namespace :generate do
  task :migration, :title do |t, args|
    filename = "build/db/migrations/#{Time.now.strftime('%Y%m%d%H%M%S%L')}_#{args.title}.rb"
    puts "Creating new migration: #{filename}"
    open(filename, 'w') do |post|
      post.puts "Sequel.migration do"
      post.puts "  change do"
      post.puts "  end"
      post.puts "end"
    end
  end
end
