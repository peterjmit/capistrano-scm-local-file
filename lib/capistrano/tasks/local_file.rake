namespace :local_file do
  def strategy
    @strategy ||= Capistrano::LocalFile.new(
      self,
      fetch(:local_file_strategy, Capistrano::LocalFile::DefaultStrategy))
  end

  desc 'Check if the path to save the local_file has been created'
  task :check do
    on release_roles :all do
      info "running local_file:check"
      strategy.check
    end
  end

  desc 'Create the path for the local_file if it does not exist'
  task clone: :'local_file:check' do
    on release_roles :all do
      if strategy.test
        info t(:mirror_exists, at: repo_path)
      else
        within deploy_path do
          debug "We're not cloning anything, just creating #{repo_path}"
          strategy.clone
        end
      end
    end
  end

  desc 'Upload the local_file'
  task update: :'local_file:clone' do
    on release_roles :all do
      strategy.update
    end
  end

  desc 'Copy repo to releases'
  task create_release: :'local_file:update' do
    on release_roles :all do
      info 'running task local_file:create_release'
      within repo_path do
        execute :mkdir, '-p', release_path
        strategy.release
      end
    end
  end

  desc 'Determine the revision that will be deployed'
  task :set_current_revision do
    on release_roles :all do
      within repo_path do
        set :current_revision, strategy.fetch_revision
      end
    end
  end
end
