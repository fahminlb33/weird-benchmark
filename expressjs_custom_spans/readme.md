# Custom Span in Elastic APM

This is an example on how to create custom span to manually instrument your code to track
them in Elastic APM. This trick can be applied to any other APM tools like DataDog too.

The recommended way to run this app is by using Docker Compose. Navigate to the root of
this repo and then run `docker-compose up`.

Open up Kibana at http://localhost:5601 and try to call the API using Postman. I believe
you guys know how to create the required database from the code :D
