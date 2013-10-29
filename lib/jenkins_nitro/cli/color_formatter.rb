require 'jenkins_nitro/cli/formatter'

module JenkinsNitro
  module CLI
    COLORS = {
      SLOWDOWN_FLAG   => '1;31',
      SPEEDUP_FLAG    => '1;32',
      REMOVED_FLAG    => '0;32',
      NEW_ENTRY_FLAG  => '0;31',
    }

    class ColorFormatter < Formatter
      class << self
        def format_line(slowdown, duration, flag, name)
          colorize(super, COLORS[flag])
        end

        def format_footer_diff(total_diff)
          colorize(super, total_diff > 0 ? COLORS[SLOWDOWN_FLAG] : COLORS[SPEEDUP_FLAG])
        end

        def colorize(line, color)
          "\e[#{color}m#{line}\e[0m"
        end
      end
    end
  end
end
