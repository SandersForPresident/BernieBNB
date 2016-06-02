[![Stories in Ready](https://badge.waffle.io/SandersForPresident/BernieBNB.png?label=ready&title=Ready)](https://waffle.io/SandersForPresident/BernieBNB)

![Bernie BNB](app/assets/images/bernie-bnb-logo.png)

## Goal
We want to build an app to allow supporters to share their homes with others from out
of town and to help supporters on the road find lodging.

## How We're Doing It
* Rails 4.2.5
* Devise/ Omniauth for authentication with Facebook and google
* Geocoder gem to search by zipcode, using Bing geocoding API.
* Bower for front end asset management

## Contributing
We have a channel on slack. Please e-mail buddhistsforbernie@gmail.com for an invite.
We would love your help.

[![](http://img.shields.io/gittip/berniebnbinfo.svg)](https://www.gittip.com/berniebnbinfo/)

### Steps
  1. Set up Facebook Developer account at https://developers.facebook.com
     then get your FACEBOOK_KEY and FACEBOOK_SECRET.
    * Here is a good How-To article:
      * https://goldplugins.com/documentation/wp-social-pro-documentation/how-to-get-an-app-id-and-secret-key-from-facebook/
  2. Set up Google Developer account at https://developers.google.com/
     and get your GOOGLE_CLIENT_ID and GOOGLE_CLIENT_SECRET.
    * Here are two good How-To articles:
      * https://richonrails.com/articles/google-authentication-in-ruby-on-rails/
      * http://wlowry88.github.io/blog/2014/08/02/google-contacts-api-with-oauth-in-rails/
  3. Create Bing Maps key (BING_GEOCODE_ID) at
     https://msdn.microsoft.com/en-us/library/ff428642.aspx
  4. Based on figaro gem, create a config/application.yml file and set values.

> USERNAME: "TBD" # Used in config/database.yml file.

> PASSWORD: "TBD" # Used in config/database.yml file.

> IP: "http://localhost:3000/"

> MAILER_URL: "localhost:3000/"

> FACEBOOK_KEY: "TBD" # Used in config/initializers/omniauth.rb file.

> FACEBOOK_SECRET: "TBD" # Used in config/initializers/omniauth.rb file.

> GOOGLE_CLIENT_ID: "TBD" # Used in config/initializers/omniauth.rb file.

> GOOGLE_CLIENT_SECRET: "TBD" # Used in config/initializers/omniauth.rb file.

> BING_GEOCODE_ID: "TBD" # Used in config/initializers/geocoder.rb file.

* Only for:

> development:

> MAILGUN_API_KEY:       "TBD"

> MAILGUN_DOMAIN:        "TBD

> MAILGUN_PUBLIC_KEY:    "TBD"

> MAILGUN_SMTP_LOGIN:    "TBD"

> MAILGUN_SMTP_PASSWORD: "TBD"

> MAILGUN_SMTP_PORT:     "587"

> MAILGUN_SMTP_SERVER:   "smtp.mailgun.org"

  4. To set up development environment, do the following:
    * Fork the repo at https://github.com/SandersForPresident/BernieBNB
    * Cloned it locally.
    * Setup environment to use ruby 2.3.1
    * Do above steps 1-3.
    * Run "bundle"
    * Run "rake db:create".
    * Run "rake db:migrate".
    * Run "rake db:setup".
    * Run "rake" to run the tests.
    * Run "git remote add upstream https://github.com/SandersForPresident/BernieBNB.git" so you can keep in sync with original project by running "git pull upstream master".
