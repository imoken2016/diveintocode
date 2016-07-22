namespace :unicorn do
  desc "Start unicorn for production env."

  task(:start_production) {
    # config = Rails.root.join('config', 'unicorn.rb')
    sh "bundle exec unicorn_rails -c config/unicorn.rb -D -E production"
  }

  desc "Stop unicorn"
  task(:stop) { unicorn_signal :QUIT }

  desc "Restart unicorn with USR2"
  task(:restart) { unicorn_signal :USR2 }

  desc "Increment number of worker processes"
  task(:increment) { unicorn_signal :TTIN }

  desc "Decrement number of worker processes"
  task(:decrement) { unicorn_signal :TTOU }

  desc "Unicorn pstree (depends on pstree command)"
  task(:pstree) do
    sh "pstree '#{unicorn_pid}'"
  end
  namespace :unicorn do
    desc "Start unicorn for production env."

    task(:start_production) {
      # config = Rails.root.join('config', 'unicorn.rb')
      sh "bundle exec unicorn_rails -c config/unicorn.rb -D -E production"
    }

    desc "Stop unicorn"
    task(:stop) { unicorn_signal :QUIT }

    desc "Restart unicorn with USR2"
    task(:restart) { unicorn_signal :USR2 }

    desc "Increment number of worker processes"
    task(:increment) { unicorn_signal :TTIN }

    desc "Decrement number of worker processes"
    task(:decrement) { unicorn_signal :TTOU }

    desc "Unicorn pstree (depends on pstree command)"
    task(:pstree) do
      sh "pstree '#{unicorn_pid}'"
    end

