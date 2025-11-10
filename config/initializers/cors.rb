# config/initializers/cors.rb

# This configuration allows React frontend (on port 3001)
# to make requests to Rails backend API (on port 3000)
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3000', 'http://localhost:3001'

    resource '*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
