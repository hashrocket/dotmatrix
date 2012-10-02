class GitConfigurationHandler

  LocalGitConfigCopiedMessage = "\nGeneric Hashrocket Git credentials \
have been configured in ~/.gitconfig.local.\nReplace this with your \
own info if this is a personal machine.\n\n"

  UnsupportedGitVersionMessage = "\nYour Git version does not support \
local configuration files. We highly recommend updating to the latest \
version.\n\n"

  def initialize(home)
    @home = home
    if system_git_version_supports_local_config?
      apply_local_gitconfig unless local_git_config_present?
    else
      puts UnsupportedGitVersionMessage
    end
  end

  def target_git_version
   Gem::Version.new('1.7.10')
  end

  def system_git_version
   Gem::Version.new(extracted_version_number)
  end

  def extracted_version_number
   `git --version`.scan(/\d+/).join('.')
  end

  def system_git_version_supports_local_config?
    system_git_version >= target_git_version
  end

  def local_git_config_present?
    File.exist?(@home + '/.gitconfig.local')
  end

  def apply_local_gitconfig
    FileUtils.cp '.gitconfig.local', @home + '/.gitconfig.local'
    puts LocalGitConfigCopiedMessage
  end
end
