module KatelloDocker
  # Inherit from the Rails module of the parent app (Katello), not the plugin.
  # Thus, inherits from ::Rails::Engine and not from Rails::Engine
  class Engine < ::Rails::Engine
    engine_name 'katello_docker'

    initializer 'katello_docker.register_plugin', :after => :finisher_hook do
      Foreman::Plugin.register :katello_docker do
        requires_foreman '> 1.4'

        menu :top_menu,
          :docker_tags,
          :parent => :content_menu,
          :caption => N_('Docker Tags'),
          :url => '/docker_tags',
          :url_hash => {:controller => 'katello/api/v2/docker_tags',
                        :action => 'index'},
                        :turbolinks => false
      end
    end

    rake_tasks do
      load "#{KatelloDocker::Engine.root}/lib/katello_docker/tasks/test.rake"
    end
  end
end
