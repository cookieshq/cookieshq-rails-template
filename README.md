The Cookies HQ Rails App Generator
==================================

On our projects we tend to use the same gems and configurations, this template is created to help us set up new projects faster.

How to use
----------

`rails new app_name -m rails-generator/template.rb`

What it does
------------

### Installs (some of them optionally):
* pg to use PostgreSQL with Active Record
* Devise
* Haml-rails
* Bootstrap-sass
* Simple_form
* Airbrake
* Active Admin
* Paperclip

On the **development** group:
* Capistrano
* Capistrano-rvm
* Capistrano-bundler
* Letter_opener

On the **test** and **development** groups:
* factory_girl_rails
* faker
* rspec
* rspec-rails
* guard-rspec

On the **test** group:
* capybara
* capybara-email
* database_cleaner
* launchy
* email_spec
* capybara-webkit
* timecop
* shoulda-matchers
* formulaic
* webmock
* vcr

### Also it:

* Sets `ruby 2.1.3` at the top of your `Gemfile`
* Generates a `.gitignore` file with some common files and folders that we add.
* Puts in an `layouts/application.html.erb` equivalent written in HAML.
* Puts in a default skeleton for JS code organization, as per told in [this post](http://cookieshq.co.uk/posts/write-maintainable-javascript-in-rails/)
* Puts in the `database.yml` file adapted to PostgreSQL.
* Edits `application.rb` to add rspec and action mailer config.
* Puts an `airbrake.rb` on initializers with only the API KEY missing.
* Capifies the project and uncomments the bundler, rvm, assets and migrations lines in capfile.
* Edits `development.rb` to add action mailer config.
* Edits `application.css(.scss)` and `application.js` to use `bootstrap`.

Working on/ TODO
================

1. [x] Make the template ask for Devise Installation instead of doing it by default
2. [x] Make the template ask for a devise default model after bundling.
3. [x] Make the template ask for generating devise views
4. [x] Make the template ask if Heroku deployment is wanted and make it [prepare the asset pipeline](https://devcenter.heroku.com/articles/rails-4-asset-pipeline) if so.
5. [x] Make the template ask if ActiveAdmin should be installed.
6. [x] Make the template run install scripts/generators after bundler for **Airbrake**
7. [x] Make the template run install scripts/generators after bundler for **RSpec**
8. [x] Make the template run install scripts/generators after bundler for **Active Admin**
9. [x] Make the template run install scripts/generators after bundler for **Simple Form**
10. [ ] Convert devise views to haml if they are generated.
11. [ ] Fix the spring binstubs call after bundling that makes git status go dirty after using the template. (Rails 4.2 will provide [how to fix this](https://github.com/rails/rails/issues/16292))
