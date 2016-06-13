## Kawaiichan

:new_moon_with_face:

## :new_moon_with_face:

:new_moon_with_face:

## Heroku deployment

Set environment variables (Change values for your app):

```
heroku config:set SLACK_CLIENT_ID=xxxxxxxxxxxxxxxxxxxx
heroku config:set SLACK_CLIENT_SECRET=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

heroku config:set SLACK_API_TOKEN=xoxp-1111111111-2222222222-33333333333-4444444444

heroku config:set ACTION_CABLE_URL=wss://kawaiichan.herokuapp.com/cable
heroku config:set ACTION_CABLE_ALLOW_ORIGIN=https://kawaiichan.herokuapp.com
```
