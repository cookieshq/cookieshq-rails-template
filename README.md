The Cookies HQ Rails App Template
=================================

On our projects we tend to use the same gems and configurations, this template is created to help us set up new projects faster.

Requirements
------------

1. Have **Ruby** installed. Preferabily `2.1.3`, but works with `2.0.0` also.
2. Have **Rails** installed. This template was created for and tested with version `4.1.6`.

How to use
----------

Assuming that you have Ruby and Rails installed, you'll need to checkout the repo:

```
git clone git@github.com:cookieshq/cookieshq-rails-template.git
```

And then run the rails app generator passing the template:

```
rails new app_name -m cookieshq-rails-template/template.rb
```

It will ask you if you want to install certain gems and install them for you, along with other ones. In the end, it will ask you if you want your database to be created and migrated.

What to do after
----------------

* Init your git repo. Until we figure out how to perform actions after the binstub call is performed, we don't want to init a repo and do a first commit, then leave you with a dirty status repo. Hopefully we'll be able to fix it when Rails 4.2 is out. See [this](https://github.com/rails/rails/issues/16292) for details.


List of gems installed
----------------------

Does not include dependencies of the gems listed!

* pg to use PostgreSQL with Active Record
* Devise (*optional*)
* Haml-rails
* Bootstrap-sass
* Simple_form
* Airbrake (*optional*)
* Active Admin (*optional, if you choose to install devise*)
* Paperclip (*optional*)
* Roadie 2.4.3

On the **production** group:
* Heroku's rails_12factor gem (*optional*)

On the **development** group:
* Capistrano (*if you won't use Heroku*)
* Capistrano-rvm (*if you won't use Heroku*)
* Capistrano-bundler (*if you won't use Heroku*)
* Mailcatcher

On the **test** and **development** groups:
* factory_girl_rails
* faker
* rspec
* rspec-rails
* guard-rspec (*optional*)

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
* vcr (*optional*)

### Also it:

* Sets your current ruby at the top of your `Gemfile`.
* Warns you if you are using an outdated version of Ruby.
* Generates a `.gitignore` file with some common files and folders that we add.
* Puts in an `layouts/application.html.erb` equivalent written in HAML with some nice additions (viewport, etc)
* Puts in a default skeleton for JS code organization, as per told in [this post](http://cookieshq.co.uk/posts/write-maintainable-javascript-in-rails/)
* Puts in an email template and style as per told in [this post](http://cookieshq.co.uk/posts/how-to-style-emails-with-rails-and-roadie/)
* Puts in the `database.yml` file adapted to PostgreSQL.
* Edits `application.rb` to add rspec and action mailer config.
* If you won't use Heroku, capifies the project and uncomments the bundler, rvm, assets and migrations lines in `Capfile`.
* Edits `development.rb` to add action mailer config.
* Edits `application.css(.scss)` and `application.js` to use `bootstrap`.
* Creates a stylesheet skeletong that is [SMAC compliant](https://smacss.com/book/categorizing).
* Adds the require lines for gems to the rails_helper created on installation.
* Does a basic configuration of RSpec.


Future improvements
====================

* Create first capybara test that visits your root_path and expects success, so you get your first red test, and take it on from there.
* Create a version that can be run from the raw link on github (i.e.: embedding all files on the template).
* Create a tmuxinator file to automate the project.
* Manage secrets with dotenv.
