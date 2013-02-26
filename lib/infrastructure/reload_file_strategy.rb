class ReloadFileStrategy
  def reload(item)
    load(file_path_for(item))
  end
  def file_path_for(item)
    command_path = item.to_s.gsub("Booty::", "").gsub("::","/").gsub("Command", "_Command").downcase + ".rb"
    File.expand_path(File.join(File.dirname(__FILE__), '../commands', command_path))
  end
end
