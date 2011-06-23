require 'guard/rspec'
extensions = ["Guard::RSpec", "Guard::Schema", "Guard::Routes"]

module ::Guard
  class Schema < ::Guard::Guard
    def run_on_change(_)
      UI.info "Clearing the way"
      `rake db:test:prepare`
      UI.clear
      UI.info "Ready to lead the charge!"
    end

    def stop
      UI.clear
      UI.info "The battle is ended...\n"
      UI.info "Listing the wounded:"
      system('git status -s -b')
    end
  end

  class Routes < ::Guard::Guard
    def run_on_change(_)
      UI.info "Leading the way down new paths..."
      system 'rake routes'
    end
  end
end

# Remove annoying message from guard-rspec
::Guard::RSpec.class_eval do
  def start; end
  def run_all
    UI.info "Charging valiantly in to battle"
    system "rake spec"
  end
end

# Add support for focus tags -- Remove once hooks are implemented...
# https://github.com/guard/guard/issues/42
::Guard::RSpec::Runner.class_eval do
  class << self
    alias original_command rspec_command
    def rspec_command(paths, options={})
      command = original_command(paths, options)
      has_focus = paths.any? do |file|
        File.read(file) =~ /^\s*(describe|context|it).*?focus(:)?( =>)? true/
      end
      command += " -t focus" if has_focus
      command
    end
  end
end

guard 'rspec', :all_on_start => false, :cli => "--color -f nested --drb" do
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^app/(.+)\.rb})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb})  { |m| "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb" }
end

begin
  require 'guard/cucumber'
  ::Guard::Cucumber::Runner.class_eval do
    class << self
      alias original_command cucumber_command
      def cucumber_command(paths, options={})
        command = original_command(paths, options)
        has_focus = paths.any? do |file|
          File.read(file) =~ /^\s*@focus/
        end
        command += " --tags @focus:4" if has_focus
        command
      end
    end
  end

  ::Guard::Cucumber.class_eval do
    def run_all
      UI.info "Preparing to accept the battle's outcome"
      system "rake cucumber"
    end
  end

  guard 'cucumber', :all_on_start => false, :all_after_pass => false, :cli => "-f pretty" do
    watch(%r{^features/.+\.feature$})
  end
  extensions << "Guard::Cucumber"
rescue LoadError
  @nocukes = true
end

guard('schema') { watch('db/schema.rb') }
guard('routes') { watch('config/routes.rb') }

::Guard::UI.clear
::Guard::UI.info "\e[34mThe Vangaurd marches forth with the following troops:\n \e[32m#{extensions.join("\n ")}"
::Guard::UI.info "\e[33mRunning without cucumber. If you need this, install guard-cucumber." if @nocukes
