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
          light = HueBridge::LightBulp.new(bulp_opts)
          pid = Process.fork do
            $PROGRAM_NAME = options[:process_name]

            begin
              while true do
                Thread.new do
                  light.toggle
                end
                sleep(2)
              end
            ensure
              light.off
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
