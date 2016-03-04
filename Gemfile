source 'https://rubygems.org'

ruby '2.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.beta3', '< 5.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '1.3.11'
# Use Puma as the app server
gem 'puma', '3.0.2'

# Authorization
gem 'cancancan', '1.13.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '8.2.2'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  #gem 'spring'
  #gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data','1.2.2', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :test do
  gem 'rspec-rails', '3.1.0'
  gem 'factory_girl_rails', '4.6.0'
end