require 'jenkins_nitro/version'
require 'json'
require 'open-uri'

module JenkinsNitro
  Build = Struct.new(:url, :number) do
    def results
      TestResults.for(self)
    end

    def number
      self[:number].to_s.empty? || self[:number] == 'stable' ? last_stable_number : self[:number]
    end

    def last_stable_number
      ApiClient::job(url)['lastStableBuild']['number']
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

    def self.total(diffs, options)
      top_entries = [options.top_entries, diffs.size].min
      diffs.values[0...top_entries].map(&:duration_diff).reduce(:+).round(4)
    end
  end

  class TestResults
    def initialize(build)
      parse(build)
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

    def parse(build)
      @result = ApiClient::test_report(build.url, build.number)
    end

    def suites
      @result["suites"]
    end

    def significant_difference?(duration, other_duration, min_diff_percent)
      (100 - (other_duration * 100 / duration)).abs > min_diff_percent
    end
  end

  class ApiClient
    def self.test_report(url, build_number)
      fetch("#{url}/#{build_number}/testReport/api/json")
    end

    def self.job(url)
      fetch("#{url}/api/json")
    end

    def self.fetch(url)
      JSON.parse(open(url).read)
    end
  end

  def self.compare(build1, build2)
    diff = build2.results.compare_to(build1.results)
    return unless diff.any?

    diff = Hash[diff.sort_by { |_, diff| -diff.duration_diff }]
  rescue => e
    puts "Failed comparing builds: #{e}"
    exit 1
  end
end
