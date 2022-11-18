Rails.application.routes.draw do
  namespace 'api'do
      resources :sudoku
  end
end
