module JenkinsNitro
  Options = Struct.new(:slow_build, :fast_build, :top_entries)

  module CLI
    class Options < JenkinsNitro::Options
      def initialize(arguments)
        arguments.insert(2, arguments[0]) if is_int?(arguments[2])
        fast_build_url, fast_build_no, slow_build_url, slow_build_no, top_entries = arguments

        self.fast_build = Build.new(fast_build_url, fast_build_no) if is_int?(fast_build_no)
        self.slow_build = Build.new(slow_build_url, slow_build_no) if is_int?(slow_build_no)
        self.top_entries = (top_entries || 50).to_i
      end

      def empty?
        !fast_build || !slow_build || top_entries < 1
      end

      def print_help
        puts "Usage: jenkins-nitro <jenkins-job-url> <fast-build-number> [<jenkins-job-url-for-slow-build>] <slow-build-number> [<entry-count=50>]"
        puts "  Ex.: jenkins-nitro https://jenkins.example.com/job/foo 120 158"
        puts "  Ex.: jenkins-nitro https://jenkins.example.com/job/foo 120 158 20"
        puts "  Ex.: jenkins-nitro https://jenkins.example.com/job/foo 120 https://jenkins.example.com/job/bar 178 20"
      end

      private

      def is_int?(value)
        value.to_i.to_s == value
      end
    end
  end
end
