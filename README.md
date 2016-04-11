# Flood Risk Exemptions Service

[![Build Status](https://travis-ci.org/EnvironmentAgency/flood-risk-front-office.svg?branch=develop)](https://travis-ci.org/EnvironmentAgency/flood-risk-front-office) [![security](https://hakiri.io/github/EnvironmentAgency/flood-risk-front-office/develop.svg)](https://hakiri.io/github/EnvironmentAgency/flood-risk-front-office/develop)


## Development Environment

## Install global system dependencies

The following system dependencies are required, regardless of how you install the development environment.

* [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* [git-flow](https://github.com/nvie/gitflow/wiki/Installation)

### Obtain the source code

Clone the repository, copying the project into a working directory:

    git clone https://github.com/EnvironmentAgency/flood-risk-front-office.git
    cd flood-risk-front-office

We use "git flow" to manage development and features branches.
To initialise git flow for the project, you need to run:

    git checkout -t origin/master
    git flow init # choose the defaults
    git checkout develop


### Local Installation

#### Local system dependencies

* [Ruby 2.2.x](https://www.ruby-lang.org) (e.g. via [RVM](https://rvm.io) or [Rbenv](https://github.com/sstephenson/rbenv/blob/master/README.md))
* [Postgresql](http://www.postgresql.org/download)
* [Phantomjs](https://github.com/teampoltergeist/poltergeist#installing-phantomjs) (test specs)

#### Application gems _(local)_

Run the following to download the app dependencies ([rubygems](https://www.ruby-lang.org/en/libraries/))

    cd <flood-risk-front-office-project-directory>
    gem install bundler
    bundle install

#### Databases _(local)_

There are several databases per environment, therefore, ensure you run the following:

    bundle exec rake db:create:all
    bundle exec rake db:migrate db:seed

#### .env configuration file

The project uses the [dotenv](https://github.com/bkeepers/dotenv) gem which allows enviroment variables to be loaded from a ```.env``` configuration file in the project root.

Duplicate ```./env.example``` and rename the copy as ```./env```. Open it and update SECRET_KEY_BASE and settings for database, email etc.

#### Start the service _(local)_

To start the service locally simply run:

    bundle exec rails server

You can then access the web site at http://localhost:3000

#### Intercepting email in development

You can use mailcatcher to trap and view outgoing email.

Make sure you have the following in your `.env` or `.env.development` file:

    EMAIL_USERNAME=''
    EMAIL_PASSWORD=''
    EMAIL_APP_DOMAIN=''
    EMAIL_HOST='localhost'
    EMAIL_PORT='1025'

Start mailcatcher with `$ mailcatcher` and navigate to
[http://127.0.0.1:1080](http://127.0.0.1:1080) in your browser.

Note that [mail_safe](https://github.com/myronmarston/mail_safe) maybe also be running in which
case any development email will seem to be sent to your global git config email address.


## Quality

We use tools like [rubocop](https://github.com/bbatsov/rubocop), [brakeman](https://github.com/presidentbeef/brakeman), and [i18n-tasks](https://github.com/glebm/i18n-tasks) to help maintain quality, reusable code. Rather than running them manually we automate it via a git pre-commit hook, utilizing the [overcommit](https://github.com/brigade/overcommit) gem.

    gem install overcommit
    overcommit --install

The first time the hooks run you may get a message that pre-commit plugins have been changed and that you should verify and sign the changes. To resolve this simply enter the following.

    overcommit --sign pre-commit

The tests will run whenever you call `git commit`. If the tests fail the commit itself will not proceed,
so you can fix the issue and then retry. Please note **overcommit** comes with a set of default hooks, some of which are also run alongside those we have added.
Check out the [overcommit _default.yml_](https://github.com/brigade/overcommit/blob/master/config/default.yml) for details.

You can run the tests at anytime using the following.

    overcommit --run

### Potential Gotcha

We found an issue in some cases. When run ad-hoc via ```overcommit --run``` it uses your local/rvm ruby. When it runs via the actual git pre-commit hook, it may pick up your system Ruby first.

If this is an issue you may need to ensure the gem is installed in both your [rvm](https://rvm.io/) ruby and system ruby.

## Tests

We use [RSpec](http://rspec.info/) for unit testing, and intend to use [Cucumber](https://github.com/cucumber/cucumber-rails) for our acceptance testing.

### Test database seeding

Before executing the tests for the first time, you will need to seed the database:

    bundle exec rake db:seed RAILS_ENV=test

To execute the unit tests simply enter:

    rspec

As this point we have no acceptance tests but when we do they can be executed using:

    cucumber

## Contributing to this project

If you have an idea you'd like to contribute please log an issue.

All contributions should be submitted via a pull request.

## License

THIS INFORMATION IS LICENSED UNDER THE CONDITIONS OF THE OPEN GOVERNMENT LICENCE found at:

http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3

The following attribution statement MUST be cited in your products and applications when using this information.

> Contains public sector information licensed under the Open Government license v3

### About the license

The Open Government Licence (OGL) was developed by the Controller of Her Majesty's Stationery Office (HMSO) to enable information providers in the public sector to license the use and re-use of their information under a common open licence.

It is designed to encourage use and re-use of information freely and flexibly, with only a few conditions.
