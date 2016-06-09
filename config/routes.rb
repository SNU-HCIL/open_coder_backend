Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope '/api' do
    get 'prjs' => 'documentation_api#get_user_projects'
    put 'prj/new' => 'documentation_api#create_project'
  end

end
