# Version 0.1

def source_paths
  Array(super) +
    [File.join(File.expand_path(File.dirname(__FILE__)),'files')]
end

# Specify Ruby version
insert_into_file 'Gemfile', "\nruby '2.1.0'", after: "source 'https://rubygems.org'\n"

# Change sqlite3 for pg
gsub_file "Gemfile", /^# Use sqlite3 as the database for Active Record$/, "# Use Postgre as the database for Active Record"
gsub_file "Gemfile", /^gem\s+["']sqlite3["'].*$/, "gem 'pg'"

uncomment_lines "Gemfile", /capistrano-rails/

install_devise = yes?("Do you want to install Devise? [y/N]")
gem 'devise' if install_devise

heroku_deploy = yes?("Do you need to deploy this app in Heroku? [y/N]")
gem 'rails_12factor', group: :production if heroku_deploy

gem 'haml-rails'
gem 'bootstrap-sass'
gem 'simple_form'
gem 'airbrake'
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'paperclip'

gem_group :development do
  gem 'capistrano'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'letter_opener'
end

gem_group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'guard-rspec'
end

gem_group :test do
  gem 'capybara'
  gem 'capybara-email'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'email_spec'
  gem 'capybara-webkit'
  gem 'timecop'
  gem 'shoulda-matchers'
  gem 'formulaic'
  gem 'webmock'
  gem 'vcr'
end

remove_file ".gitignore"
copy_file '.gitignore'

inside "app" do
  inside "assets" do
    inside "stylesheets" do
      remove_file "application.css"
      copy_file "application.css.scss"
    end

    inside "javascripts" do
      insert_into_file 'application.js', after: "//= require turbolinks\n" do
        "//= require bootstrap\n//= require services\n//= require_tree ./services\n"
      end

      copy_file "services.js.coffee"
      inside "services" do
        copy_file "forms.js.coffee"
        copy_file "utils.js.coffee"
      end
    end
  end

  inside "views" do
    inside "layouts" do
      remove_file "application.html.erb"
      copy_file "application.html.haml"
    end
  end
end

inside "config" do
  remove_file "database.yml"
  template "database.yml.example"
  run "cp database.yml.example database.yml"
  insert_into_file 'application.rb', after: "# config.i18n.default_locale = :de\n" do
    "\n\t\tconfig.assets.precompile += %w( .svg .eot .woff .ttf email.css bootstrap.css )
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')\n"
  end
end

inside app_name do
  run 'bundle install'
end

if install_devise
  generate "devise:install"

  generate_devise_user = yes?("Do you want to create a devise user class? [y/N]")
  generate "devise user" if generate_devise_user
end

def run_bundle ; end

git :init
git add: "."
git commit: "-a -m 'Initial commit'"
