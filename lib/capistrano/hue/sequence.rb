require 'hue_bridge'

module Capistrano
  module Hue
    class Sequence
      class << self
        def start(options)
          pid = get_pid(options[:process_name])

          unless pid == ''
            $stdout.puts('Process is allready running.')
            return
          end

          bulp_opts = options.slice(:hue_bridge_ip, :user_id, :light_bulp_id)
          color_opts = options.fetch(:color, false)
          light = HueBridge::LightBulp.new(bulp_opts)

          pid = Process.fork do
            $PROGRAM_NAME = options[:process_name]

            light.store_state
            light.on
            light.set_color(color_opts) if color_opts && color_opts.any?

            begin
              while true do
                light.alert
                sleep(15)
              end
            ensure
              light.restore_state
            end
          end
          $stdout.puts "Started capistrano-hue process with PID=#{pid}"
        end

        def stop(process_name)
          $stdout.puts 'Stopping deploy sequence'
					pid = get_pid(process_name)
          puts pid
          if pid == ''
            $stdout.puts "Couldn't find a process with the name #{process_name}"
            return
          end
          Process.kill('HUP', pid.to_i)
        end

        def get_pid(process_name)
          pid = `pidof #{process_name}`
          unless pid
            $stdout.puts "Couldn't find a process with the name #{process_name}"
            return
          end
          pid
        end
      end
    end
  end
end
