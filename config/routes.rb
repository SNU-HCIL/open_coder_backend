Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope '/api' do
    get 'prjs' => 'documentation_api#get_user_projects'
    get 'prj' => 'documentation_api#get_project_detail'
    put 'prj/new' => 'documentation_api#create_project'
    put 'doc/new' => 'documentation_api#create_document'
    get 'doc'=> 'documentation_api#get_document_detail'
    delete 'doc/rm' => 'documentation_api#remove_document'
  end

end
