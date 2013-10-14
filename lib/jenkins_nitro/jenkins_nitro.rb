require 'jenkins_nitro/version'
require 'json'
require 'open-uri'

module JenkinsNitro
  Build = Struct.new(:url, :number) do
    def results
      TestResults.for(self)
    end
  end

  Diff = Struct.new(:duration, :duration_diff) do
    def slowdown?
      duration_diff > 0
    end

    def new_entry?
      duration == duration_diff && duration > 0
    end

    def removed?
      duration == -duration_diff
    end
  end

  class TestResults
    def initialize(build)
      parse("#{build.url}/#{build.number}/testReport/api/json")
    end

    def suite_durations
      @suite_durations ||= Hash[suites.map do |suite|
        [suite['name'], suite['duration']]
      end]
    end

    def compare_to(other, min_diff_percent = 50)
      diff = {}

      suite_durations.each do |name, duration|
        other_duration = other.suite_durations[name]
        if other_duration
          if significant_difference?(duration, other_duration, min_diff_percent)
            diff[name] = Diff.new(duration, duration - other_duration)
          end
        else
          diff[name] = Diff.new(duration, -duration)
        end
      end

      new_names = other.suite_durations.keys - suite_durations.keys
      new_names.each do |name|
        duration = other.suite_durations[name]
        diff[name] = Diff.new(duration, duration)
      end

      diff
    end

    def self.for(build)
      TestResults.new(build)
    end

    private

    def parse(build_result_url)
      @result = JSON.parse(open(build_result_url).read)
    end

    def suites
      @result["suites"]
    end

    def significant_difference?(duration, other_duration, min_diff_percent)
      (100 - (other_duration * 100 / duration)).abs > min_diff_percent
    end
  end

  def self.compare(build1, build2)
    diff = build1.results.compare_to(build2.results)
    return unless diff.any?

    diff = Hash[diff.sort_by { |_, diff| -diff.duration_diff }]
  rescue => e
    puts "Failed comparing builds: #{e}"
    exit 1
  end
end
