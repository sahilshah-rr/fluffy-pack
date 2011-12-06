Fluffy::Application.routes.draw do
  match 'twitter/check' => 'twitter#check'
end
