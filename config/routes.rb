require 'katello/api/mapper_extensions'

class ActionDispatch::Routing::Mapper
  include Katello::Routing::MapperExtensions
end

Katello::Engine.routes.draw do
  scope :katello, :path => '/katello' do
    namespace :api do
      scope "(:api_version)", :module => :v2, :defaults => {:api_version => 'v2'}, :api_version => /v2/, :constraints => ApiConstraints.new(:version => 2, :default => true) do
        api_resources :docker_images, :only => [:index, :show]

        api_resources :docker_tags, :only => [:index, :show] do
          collection do
            get :auto_complete_search
          end
        end

        api_resources :grouped_docker_tags, :only => [:index, :show]
      end
    end
  end
end
