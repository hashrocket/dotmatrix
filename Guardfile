require 'guard/rspec'
extensions = ["Guard::RSpec"]

module ::Guard
  class Schema < ::Guard::Guard
    def run_on_change(_)
      UI.info "Purging your demons..."
      `rake db:test:prepare`
      UI.info "Done!"
    end
  end

  class Routes < ::Guard::Guard
    def run_on_change(_)
      UI.info "Raking your routes"
      puts `rake routes`
    end
  end
end

# Remove annoying message from guard-rspec
::Guard::RSpec.class_eval do
  def start; end
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
  watch('spec/spec_helper.rb')                       { "spec" }
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^app/(.+)\.rb})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb})  { |m| "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb" }
end

begin
  guard 'cucumber', :all_on_start => false, :all_after_pass => false do
    watch(%r{^features/.+\.feature$})
  end
  extensions << "Guard::Cucumber"
rescue
  @nocukes = true
end

guard 'schema' { watch('db/schema.rb') }
guard 'routes' { watch('config/routes.rb') }

::Guard::UI.clear
::Guard::UI.debug "Using Guard with extensions: #{extensions.join(', ')}"
::Guard::UI.info "Running without cucumber. If you need this, install guard-cucumber." if @nocukes
