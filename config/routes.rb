Rails.application.routes.draw do
  root 'info#home'
  get 'people_names.json' => 'info#people_names'
  get 'path_between/:name1/:name2.json' => 'info#path_between'

  get 'episodes/:base64_guid' => 'episodes#show', as: :episodes_show
  get 'people/:name' => 'people#show', as: :person_show
end
