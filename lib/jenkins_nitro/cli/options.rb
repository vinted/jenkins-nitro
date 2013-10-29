require 'optparse'
require 'jenkins_nitro/options'

module JenkinsNitro
  module CLI
    class Options < JenkinsNitro::Options
      attr_accessor :color_output

      def initialize(arguments)
        initialize_default_options
        parse_additional_options(arguments)

        arguments.insert(2, arguments[0]) if is_build_number?(arguments[2])
        fast_build_url, fast_build_no, slow_build_url, slow_build_no, top_entries = arguments

        self.fast_build = Build.new(fast_build_url, fast_build_no) if is_build_number?(fast_build_no)
        self.slow_build = Build.new(slow_build_url, slow_build_no) if is_build_number?(slow_build_no)
        self.top_entries = (top_entries || 50).to_i
      end

      def initialize_default_options
        self.color_output = true
      end

      def parse_additional_options(arguments)
        @option_parser = OptionParser.new do |opts|
          opts.banner = "Usage: jenkins-nitro [options] <jenkins-job-url> <fast-build-number> [<jenkins-job-url-for-slow-build>] <slow-build-number> [<entry-count=50>]"

          opts.separator ""
          opts.separator "  'stable' build number means automatically fetch last stable build."
          opts.separator ""
          opts.separator "  Ex.: jenkins-nitro https://jenkins.example.com/job/foo 120 158"
          opts.separator "  Ex.: jenkins-nitro https://jenkins.example.com/job/foo 120 stable"
          opts.separator "  Ex.: jenkins-nitro https://jenkins.example.com/job/foo 120 158 20"
          opts.separator "  Ex.: jenkins-nitro https://jenkins.example.com/job/foo 120 https://jenkins.example.com/job/bar 178 20"
          opts.separator "  Ex.: jenkins-nitro https://jenkins.example.com/job/foo stable https://jenkins.example.com/job/bar stable 20"
          opts.separator ""
          opts.separator "Specific options:"

          opts.on("-c", "--[no-]color", "Color output") do |c|
            self.color_output = c
          end
        end

        @option_parser.parse!(arguments)
      end

      def empty?
        !fast_build || !slow_build || top_entries < 1
      end

      def print_help
        puts @option_parser
      end

      private

      def is_build_number?(value)
        value.to_i.to_s == value || value == 'stable'
      end
    end
  end
end
