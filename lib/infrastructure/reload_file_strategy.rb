class ReloadFileStrategy
  def initialize(map = Nasty::IdentityMap.new)
    @identity_map = map
  end

  def reload(item)
    load(build_path_to(item))
  end

  def file_path_for(item)
    command_path = item.to_s.gsub("Booty::", "").gsub("::","/").gsub("Command", "_Command").downcase + ".rb"
    File.expand_path(File.join(File.dirname(__FILE__), '../commands', command_path))
  end

  private

  def build_path_to(item)
    unless @identity_map.has_item_for?(item)
      @identity_map.add(OpenStruct.new(:id => item, :path => file_path_for(item)))
    end
    @identity_map.item_for(item).path
  end
end
