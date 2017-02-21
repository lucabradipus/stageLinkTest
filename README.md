# Stagelink test

This is an implementation of *Stagelink Backend Developer programming challenge*


https://github.com/stagelink/backend-developer-challenge


## Environment
This application uses
* ruby 2.3.3
* Rails '~> 5.0.1'
* [Bootstrap '~> 4.0.0.alpha6'](https://github.com/twbs/bootstrap-rubygem) 
* [koala ~> 2.4.0](https://github.com/arsduo/koala) 
* [omniauth-facebook '~> 4.0.0'](https://github.com/mkdynamic/omniauth-facebook)

##
## Facebook secret key app issue
The secret key for the facebook app I created to login in facebook and perform the requested
 query is deployed in this repository. This is, usually, a bad practice. 
 But I left it here because this is a test application and it is much easier to test on localhost:3000 in this way    


## Known issues
* There is no feedback in the page that the query is running or is completed. You see that is completed when
 a CSV file is downloaded
* feedback on errors is quite naive
* no more than 100 reactions and comments are downloaded for each post. During my test incrementing this number caused an error 
* The Javascript method that add input fields to the form should be improved. 
* OmniAuth throws a warning each time is uploaded. This is a [known issue](https://github.com/omniauth/omniauth/issues/872) but seems not to have impact on 
the application
##Usage

Insert in the page id field a numeric identifier (e.g. 249403588440524) or the page name (e.g. DieLochis)

In the limit field you must insert an integer between 1 and 100 

Using the "add more" button you can ask information on more pages, that are added at the csv that is produced

As the data are retrieved per page ( that is a query for each page) the number of pages requested has not 
impact on the amount retrieved by each call to the Facebook Graph API
  
## Heroku deployment
You can find an instance of this application running on 
[https://stl-test.herokuapp.com/](https://stl-test.herokuapp.com/)
As it is very slow to start being a free instance it may require to reload the page twice


