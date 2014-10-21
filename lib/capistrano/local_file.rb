load File.expand_path('../tasks/local_file.rake', __FILE__)

require 'capistrano/scm'

# Local file/archive (.tar.gz) as SCM for Capistrano
#
# @author Pete Mitchell <peterjmit@gmail.com>
#
class Capistrano::LocalFile < Capistrano::SCM
  module DefaultStrategy
    def test
      test! " [ -d #{deploy_path}/local_file ] "
    end

    def check
      true
    end

    def clone
      context.execute :mkdir, '-p', "#{deploy_path}/local_file"

      true
    end

    # Upload a local file to the server
    def update
      context.execute :rm, '-rf', "#{deploy_path}/local_file/*"
      context.upload! fetch(:repo_url), "#{deploy_path}/local_file/#{fetch(:repo_url)}"
    end

    # Unpack and rsync the contents into release path
    def release
      context.execute :tar, '-xvzf', "#{deploy_path}/local_file/#{fetch(:repo_url)}"
      context.execute :rsync, "-a", "--exclude=#{fetch(:repo_url)}", "#{deploy_path}/local_file/*", release_path
    end

    # TODO: SHA of archive, or variable or something to set the revision number?
    def fetch_revision
    end
  end
end
