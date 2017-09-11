# Stock sample app

Dummy playground for Vue and Rails 5.1.

## Install

Assuming you already have:
  * postgres up and running (fill in database.yml with valid credentials)
  * foreman Gem installed

then:

```
bundle install
yarn install
spring rake db:create
spring rake db:migrate
spring rake populate
```

And finally...

```
foreman start
```
