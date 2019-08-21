Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  scope '/admin', controller: 'admin/user_approval', :format => false do
    get '/user-approval' => :dashboard
  end
end
