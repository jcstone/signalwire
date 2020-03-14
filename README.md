# README

## Dev enviroment

Application is configured to run in a docker container. To build dev environment, start the server, and setup the DB:

'''
docker-compose build
docker-compose up
'''

In another terminal run:
'''
docker-compose run web rake db:create
'''

## Testing
To run tests:

'''
docker-compose run web rails test
'''
