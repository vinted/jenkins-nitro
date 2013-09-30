require 'jenkins_nitro/version'
require 'json'
require 'open-uri'

module JenkinsNitro

  class TestResults
    def initialize(build_url, build_number)
      @result_url = "#{build_url}/#{build_number}/testReport/api/json"
      parse
    end

    def parse
      @result = JSON.parse(open(@result_url).read)
    end

    def suites
      @result["suites"]
    end

    def suite_durations
      @suite_durations ||= Hash[suites.map { |suite| [suite['name'], suite['duration']] }]
    end

    def compare_to(other, precision_percent = 50)
      diff = {}

      suite_durations.each do |name, duration|
        other_duration = other.suite_durations[name]
        if other_duration
          if (100 - (other_duration * 100 / duration)).abs > precision_percent
            diff[name] = (duration - other_duration)
          end
        else
          diff[name] = -duration
        end
      end

      new_names = other.suite_durations.keys - suite_durations.keys

      new_names.each do |name|
        diff[name] = other.suite_durations[name]
      end

      diff
    end
  end

  def self.compare(build_url, build1, build2)
    results1 = TestResults.new(build_url, build1)
    results2 = TestResults.new(build_url, build2)

    diff = results1.compare_to(results2)

    diff = Hash[diff.sort_by { |_, value| -value }]
  rescue => e
    puts "Failed comparing builds: #{e}"
    exit 1
  end
end
