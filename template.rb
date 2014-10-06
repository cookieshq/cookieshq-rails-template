# Version 0.1

def source_paths
  Array(super) +
    [File.join(File.expand_path(File.dirname(__FILE__)),'files')]
end

# Specify Ruby version
insert_into_file 'Gemfile', "\nruby '2.0.0'", after: "source 'https://rubygems.org'\n"

# Change sqlite3 for pg
gsub_file "Gemfile", /^# Use sqlite3 as the database for Active Record$/, "# Use Postgre as the database for Active Record"
gsub_file "Gemfile", /^gem\s+["']sqlite3["'].*$/, "gem 'pg'"

uncomment_lines "Gemfile", /capistrano-rails/

gem 'devise'
gem 'haml-rails'
gem 'bootstrap-sass'
gem 'simple_form'
gem 'airbrake'
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'paperclip'
# gem 'validates_email_format_of'
# gem 'jquery-ui-rails' if yes?("Do you want to install jquery-ui-rails? (yes/no)")

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
    inside "javascripts" do
      insert_into_file 'application.js', "//= require services\n//= require_tree ./services\n", before: "//= require_tree ."

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
end

git :init
git add: "."
git commit: "-a -m 'Initial commit'"
