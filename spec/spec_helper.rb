begin
  require 'codeclimate-test-reporter'
rescue LoadError
else
  CodeClimate::TestReporter.start
end

# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end


RSpec::Matchers.define :print_on_stdout do |check|

  @captured = nil

  match do |block|
    begin
      real_stdout = $stdout
      $stdout = StringIO.new
      block.call
    ensure
      @captured = $stdout
      $stdout = real_stdout
    end
    case check
    when String
      @captured.string == check
    when Regexp
      @captured.string.match(check)
    else
      false
    end
  end

  failure_message_for_should do
    "expected #{description}"
  end

  failure_message_for_should_not do
    "expected not #{description}"
  end

  description do
    "\n#{check}\non STDOUT but got\n#{@captured.string}\n"
  end
end

RSpec::Matchers.define :be_multiline do
  match do |actual|
    case actual
    when String
      !actual.empty? && actual.split(/\n/).count > 1
    else
      false
    end
  end

  description do
    'be more than one line'
  end
end
