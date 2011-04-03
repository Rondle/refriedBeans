ActionController::Routing::Routes.named_routes.routes.each do |name, route|
  puts "%20s: %s" % [name, route]
end
