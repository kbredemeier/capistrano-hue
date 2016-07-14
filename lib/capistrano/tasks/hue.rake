require 'capistrano/hue'

namespace :load do
  task :defaults do
    set :hue_enabled, false
    set :hue_bridge_ip, nil
    set :hue_user_id, nil
    set :hue_light_bulp_id, 1
    set :hue_process_name, 'capistrano-hue'
  end
end

namespace :hue do
  desc "Starts the sequence"
  task :start do
    if fetch(:hue_enabled)
      run_locally do
        options = {
          hue_bridge_ip: fetch(:hue_bridge_ip),
          user_id: fetch(:hue_user_id),
          light_bulp_id: fetch(:hue_light_bulp_id),
          process_name: fetch(:hue_process_name)
        }
        Capistrano::Hue::Sequence.start(options)
      end
    end
  end

  desc "Stops the sequence"
  task :stop do
    if fetch(:hue_enabled)
      run_locally do
        Capistrano::Hue::Sequence.stop(fetch(:hue_process_name))
      end
    end
  end
end

namespace :deploy do
  before :starting, 'hue:start'
  after :finishing, 'hue:stop'
  after :failed, 'hue:stop'
end
