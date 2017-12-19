# Travel Weather Application/Service
Travel weather web service written using Ballerina language (https://ballerinalang.org)

# About this appication/service 
This travel weather application will run as a web service which is able to provide the weather details of cities inbetween the 
start location and end location. The number of cities inbetween can be passed as a query parameter for the web service.

# How to deploy
1) Go to http://www.ballerinalang.org and click Download.
2) Download the Ballerina Tools distribution and unzip it on your computer. Ballerina Tools includes the Ballerina runtime plus
the visual editor (Composer) and other tools.
3) Add the <ballerina_home>/bin directory to your $PATH environment variable so that you can run the Ballerina commands from anywhere.
4) After setting up <ballerina_home>, run: `$ ballerina run tripWeather.bal` 
5) When tripWeather.bal service is up and running use `$ curl -v "http://localhost:9090/travel/weather?start=Galle&end=Jaffna&waypoints=3"`
6) replace the query parameters of `start` with city name of the starting location , `end` with destination of trip and `waypoints` with the 
number of cities that you need weather details.