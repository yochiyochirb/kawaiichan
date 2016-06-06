## Kawaiichan

:new_moon_with_face:

## :new_moon_with_face:

:new_moon_with_face:

```
$ npm install
$ bundle install
```

## Heroku deployment

Add buildpacks:

```
$ heroku buildpacks:add --index 1 heroku/nodejs
$ heroku buildpacks:add --index 2 heroku/ruby
```

Set environment variables (Change values for your app):

```
heroku config:set SLACK_CLIENT_ID=xxxxxxxxxxxxxxxxxxxx
heroku config:set SLACK_CLIENT_SECRET=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
heroku config:set ACTION_CABLE_URL=wss://kawaiichan.herokuapp.com/cable
heroku config:set ACTION_CABLE_ALLOW_ORIGIN=https://kawaiichan.herokuapp.com
```
