# Flood Risk Front Office

[![Build Status](https://travis-ci.com/DEFRA/flood-risk-front-office.svg?branch=master)](https://travis-ci.com/DEFRA/flood-risk-front-office)
[![Maintainability](https://api.codeclimate.com/v1/badges/6429344395fd3e97f196/maintainability)](https://codeclimate.com/github/DEFRA/flood-risk-front-office/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/6429344395fd3e97f196/test_coverage)](https://codeclimate.com/github/DEFRA/flood-risk-front-office/test_coverage)
[![security](https://hakiri.io/github/DEFRA/flood-risk-front-office/master.svg)](https://hakiri.io/github/DEFRA/flood-risk-front-office/master)
[![Licence](https://img.shields.io/badge/Licence-OGLv3-blue.svg)](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3)

A Ruby on Rails application delivering the [Flood risk activity exemptions service](https://register-flood-risk-exemption.service.gov.uk).

This is a thin, host application which merely mounts and provides styling for the [flood_risk_engine](https://github.com/DEFRA/flood-risk-engine) rails engine. The engine is responsible for the service implementation.

## Prerequisites

Please make sure the following are installed:

- [Ruby 2.3.1](https://www.ruby-lang.org) installed for example via [RVM](https://rvm.io) or [Rbenv](https://github.com/sstephenson/rbenv/blob/master/README.md)
- [Bundler](http://bundler.io/)
- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Postgresql](http://www.postgresql.org/download)
- [Phantomjs](https://github.com/teampoltergeist/poltergeist#installing-phantomjs)

## Installation

Clone the repository and install its gem dependencies:

```bash
git clone https://github.com/DEFRA/flood-risk-front-office.git
cd flood-risk-front-office
bundle
```

### .env

The project uses the [dotenv](https://github.com/bkeepers/dotenv) gem to load environment variables when the app starts. **Dotenv** expects to find a `.env` file in the project root.

Duplicate `.env.example` and rename the copy as `.env`

Open it and update `SECRET_KEY_BASE` and the settings for database, email etc.

If Google analytics is required, uncomment the line `GOOGLE_TAG=ABC-DEFGHI` and replace ABC-DEFGHI with the required Google tag.

### Database

The usual rails commands can be used to manage the databases for example

```bash
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

Add `RAILS_ENV=test` to the commands when preparing the test database.

## Running the app

To start the service locally run

```bash
bundle exec rails s
```

You can then access the web site at http://localhost:3000

## Email

### Intercepting email in development

You can use [Mailcatcher](https://mailcatcher.me/) to intercept emails sent out during development.

Make sure you have the following in your `.env` or `.env.development` file:

    EMAIL_USERNAME=''
    EMAIL_PASSWORD=''
    EMAIL_APP_DOMAIN=''
    EMAIL_HOST='localhost'
    EMAIL_PORT='1025'

Install **Mailcatcher** (`gem install mailcatcher`) and run it by just calling `mailcatcher`

Then navigate to [http://127.0.0.1:1080](http://127.0.0.1:1080) in your browser.

> Note that [mail_safe](https://github.com/myronmarston/mail_safe) maybe also be running in which case any development email will seem to be sent to your global git config email address.

## Tests

We use [RSpec](http://rspec.info/) and focus on feature tests in this project that go through the journey for each organisation type (unit testing is done in [flood _risk_engine](https://github.com/DEFRA/flood-risk-engine) and acceptance tests in [Flood risk acceptance tests](https://github.com/DEFRA/flood-risk-acceptance-tests)).

To run [Rubocop](https://github.com/bbatsov/rubocop) and the test suite

```bash
bundle exec rake
```

To run just the tests

```bash
bundle exec rake spec
```

## Quality and conventions

The project is linked to [Travis CI](https://travis-ci.org/DEFRA/flood-risk-front-office) and all pushes to the **GitHub** are automatically checked.

The checks include running all tests plus **Rubocop**, but also tools like [HTLMHint](https://github.com/yaniswang/HTMLHint) and [i18n-tasks](https://github.com/glebm/i18n-tasks). Check the `.travis.yml` for full details, specifically the `before_script:` section.

It is left to each developer to setup their environment such that these checks all pass before presenting their code for review and merging.

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
