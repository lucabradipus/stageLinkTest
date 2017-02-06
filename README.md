# Stagelink test

This is an implementation of *Stagelink Backend Developer programming challenge*


https://github.com/stagelink/backend-developer-challenge


## environment
This application uses
* ruby 2.3.3
* Rails '~> 5.0.1'
* [Bootstrap '~> 4.0.0.alpha6'](https://github.com/twbs/bootstrap-rubygem) 
* [koala ~> 2.4.0](https://github.com/arsduo/koala) 
* [omniauth-facebook '~> 4.0.0'](https://github.com/mkdynamic/omniauth-facebook)

##
## facebook secret key app issue
The secret key for the facebook app I created to login in facebook and perform the requested
 query is deployed in this repository. This is, usually, a bad practice. 
 But I left it here because this is a test application and it is much easier to test on localhost:3000 in this way    


## know issue
* There is no feedback in the page that the query is running or is completed. You see that is completed when
 a CSV file is downloaded
* feedback on errors is quite naive
* no more than 100 reactions and comments are downloaded for each post. During my test incrementing this number caused an error 
* The Javascript method that add input fields to the form should be improved. 


## Heroku deployment
You can find an instance of this application running on 
[https://stl-test.herokuapp.com/](https://stl-test.herokuapp.com/)
As it is very slow to start being a free instance it may require to reload the page twice


