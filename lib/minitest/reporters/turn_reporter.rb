require "ansi/code"
require "minitest/reporters"

module Minitest
  module Reporters

    # Turn-like reporter that reads like a spec.
    #
    # Based upon TwP's turn (MIT License) and paydro's monkey-patch.
    #
    # @see https://github.com/TwP/turn turn
    # @see https://gist.github.com/356945 paydro's monkey-patch
    class TurnReporter < ::Minitest::Reporters::BaseReporter
      include ANSI::Code
      include ::Minitest::RelativePosition

      def start
        super
        puts "Run Options: #{options[:args]}"
        puts
      end

      def report
        super
        puts "Finished in %.5fs" % total_time
        print "\e[37m%d tests\e[0m" % count
        print ", "
        print_with_color :green, "%d passed", passes
        print ", "
        print_with_color :red, "%d failures", failures
        print ", "
        print_with_color :yellow, "%d errors", errors
        print ", "
        print_with_color :cyan, "%d skips", skips
        print ", "
        print "%d assertions" % assertions
        puts
      end

      def record(test)
        super
        print "    "
        print_colored_status(test)
        print(" (%.2fs) " % test.time)
        print test.name.gsub(/^test_: /, "")
        puts
        if !test.skipped? && test.failure
          print_info(test.failure)
          puts
        end
      end

      def print_colored_status(test)
        if test.passed?
          print(green { pad_mark( result(test).to_s.upcase ) })
        elsif test.skipped?
          print(cyan { pad_mark( result(test).to_s.upcase ) })
        elsif test.error?
          print(yellow { pad_mark( result(test).to_s.upcase ) })
        else
          print(red { pad_mark( result(test).to_s.upcase ) })
        end
      end

    protected

      def passes
        count - (failures + errors + skips)
      end

      def print_with_color(color, message, count)
        message = message % count
        message = send(color) { message } unless count.zero?
        print message
      end

      def before_suite(suite)
        puts "\e[4m#{suite}\e[0m"
      end

      def after_suite(suite)
        puts
        puts
        puts "To run the test suite again with the same options use:"
        puts
        puts "  rake test TESTOPTS=\"#{options[:args]}\""
        puts
      end

    end
  end
end
