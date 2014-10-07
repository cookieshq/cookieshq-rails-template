# Version 0.1

def source_paths
  Array(super) +
    [File.join(File.expand_path(File.dirname(__FILE__)),'files')]
end

######################################
#                                    #
# Prompt the user for options        #
#                                    #
######################################
install_devise = yes?("Do you want to install Devise? [y/N]")

if install_devise
  generate_devise_user  = yes?("Do you want to create a devise user class? [y/N]")
  generate_devise_views = yes?("Do you want to generate devise views? [y/N]")
end

install_active_admin = yes?("Do you want to install Active Admin? [y/N]")
heroku_deploy        = yes?("Do you need to deploy this app on Heroku? [y/N]")

install_airbrake     = yes?("Do you want to install Airbrake? [y/N]")
say("\n\tAirbrake initializer will be set in place, you'll need to set your API_KEY in it.\n\n", "\e[33m") if install_airbrake

######################################
#                                    #
# Gemfile manipulation               #
#                                    #
######################################

# Specify Ruby version
insert_into_file 'Gemfile', "\nruby '2.1.3'", after: "source 'https://rubygems.org'\n"

# Change sqlite3 for pg
gsub_file "Gemfile", /^# Use sqlite3 as the database for Active Record$/, "# Use Postgre as the database for Active Record"
gsub_file "Gemfile", /^gem\s+["']sqlite3["'].*$/, "gem 'pg'"

uncomment_lines "Gemfile", /capistrano-rails/

gem 'devise' if install_devise
gem 'rails_12factor', group: :production if heroku_deploy

gem 'haml-rails'
gem 'bootstrap-sass'
gem 'simple_form'
gem 'airbrake' if install_airbrake

gem 'activeadmin', github: 'gregbell/active_admin' if install_active_admin
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

######################################
#                                    #
# Gem installation                   #
#                                    #
######################################
run 'bundle install'
run 'bundle exec cap install'

######################################
#                                    #
# Modification and addition of files #
#                                    #
######################################
remove_file ".gitignore"
copy_file '.gitignore'
uncomment_lines 'Capfile', /'capistrano\/rvm'/
uncomment_lines 'Capfile', /'capistrano\/bundler'/
uncomment_lines 'Capfile', /capistrano\/rails\/assets/
uncomment_lines 'Capfile', /capistrano\/rails\/migrations/

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

  inside "initializers" do
    copy_file 'airbrake.rb' if install_airbrake
  end

  inside "environments" do
    insert_into_file 'development.rb', after: "config.action_mailer.raise_delivery_errors = false\n" do
      "\n\t# Action Mailer default options\n\tconfig.action_mailer.default_url_options = { host: 'localhost', port: 3000 }\n\n\t# Letter Opener gem configuration\n\tconfig.action_mailer.delivery_method = :letter_opener\n"
    end
  end
end

######################################
#                                    #
# Running installed gems generators  #
#                                    #
######################################
if install_devise
  generate "devise:install"
  generate "devise user"  if generate_devise_user
  generate "devise:views" if generate_devise_views
end

generate "simple_form:install"

if install_active_admin
  generate "active_admin:install"
end

######################################
#                                    #
# Overriding default bundle install  #
#                                    #
######################################
def run_bundle ; end

######################################
#                                    #
# Initial commit of the app          #
#                                    #
######################################
git :init
git add: "."
git commit: "-a -m 'Initial commit'"
