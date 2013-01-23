unless Rails.env.production?
  Slim::Engine.set_default_options pretty: true, sort_attrs: true 
end