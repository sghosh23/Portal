source 'https://rubygems.org'


gem 'rails', '4.2.1'

gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3.4'
gem 'react-rails', '~> 1.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'savon', '~> 2.10.0'

gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem "font-awesome-rails"
gem 'figaro'
gem 'dalli'

group :development do

  gem 'wkhtmltopdf-binary-edge'
end
group :production do
  gem 'wkhtmltopdf-heroku'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'sqlite3'
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
group :production do
  gem 'pg',             '0.17.1'
  gem 'rails_12factor', '0.0.2'
end
