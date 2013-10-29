module JenkinsNitro
  module CLI
    SLOWDOWN_FLAG   = '✖'
    SPEEDUP_FLAG    = '✓'
    REMOVED_FLAG    = '-'
    NEW_ENTRY_FLAG  = '+'

    class Formatter
      class << self
        def print(diffs, options)
          print_header(options)
          print_diffs(diffs, options)
          print_footer(diffs, options)
        end

        def print_header(options)
          # puts "Comparing #{options.fast_build} vs. #{options.slow_build}"
          # puts

          flags_header = "#{SLOWDOWN_FLAG} slowdown, #{SPEEDUP_FLAG} speedup, " +
                         "#{NEW_ENTRY_FLAG} new entry, #{REMOVED_FLAG} removed"
          puts "  Slowdown     Duration     #{flags_header}"
          puts "============ ============ =================================================="
        end

        def print_diffs(diffs, options)
          diffs.keys[0...top_entries(diffs, options)].each do |name|
            diff = diffs[name]

            flag = SPEEDUP_FLAG
            flag = SLOWDOWN_FLAG if diff.slowdown?
            flag = REMOVED_FLAG if diff.removed?
            flag = NEW_ENTRY_FLAG if diff.new_entry?

            slowdown = sprintf('%10.4f s', diff.duration_diff) unless diff.removed? || diff.new_entry?
            duration = sprintf('%10.4f s', diff.duration) unless diff.removed?

            puts format_line(slowdown, duration, flag, name)
          end
        end

        def format_line(slowdown, duration, flag, name)
          sprintf("%12s %12s   %s %s", slowdown, duration, flag, name)
        end

        def print_footer(diffs, options)
          top_entries      = top_entries(diffs, options)
          total_diff       = Diff.total(diffs, options)
          diff_orientation = total_diff > 0 ? 'slowdown' : 'speedup'

          puts
          puts "Total #{diff_orientation} from top #{top_entries} changes"
          puts "============"
          puts format_footer_diff(total_diff)
        end

        def top_entries(diffs, options)
          [options.top_entries, diffs.size].min
        end

        def format_footer_diff(total_diff)
          sprintf("%10.4f s", total_diff)
        end
      end
    end
  end
end
