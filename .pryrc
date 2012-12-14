["~/.irbrc", "~/.pryrc.local"].each do |file|
  path = File.expand_path file
  load path if File.exists?(path)
end
