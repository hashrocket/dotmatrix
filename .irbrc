IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = "~/.irb-history"

load File.expand_path("~/.clippy.rb") if File.exist?(File.expand_path("~/.clippy.rb"))
load File.expand_path("~/.irbrc.local") if File.exist?(File.expand_path("~/.irbrc.local"))
