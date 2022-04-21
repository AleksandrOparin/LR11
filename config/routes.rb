Rails.application.routes.draw do
  resources :palindromes

  root 'palindromes#new'
end
