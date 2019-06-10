-A command line interface for Wikihow. Browse by main category

user type Wikihow

Show main categories

user selects category

  1. Arts & Crafts
  2. Sports
  3. ...

Show topics within category

  1. How to throw a baseball
  2. How to pretend you care about football
  3. ...

User selects topic

Show Methods

  1. Playing catch with a friend
  2. Learning by yourself
  3. ...

User selects Method

Show steps to user
  1. Get a baseball
  2. Find a backstop or fence to throw against
  3. ...

What is a category
  has many topics
  has a URL

What is a topic
  has at least 1 method
  has a url

What is a Method
  has many steps

What is a step
  has text
  has a picture


## Project Meeting Notes

What website will you be scraping? wikihow.com
What will you need to do with the data you return from scraping? create category instances (should I create topic classes right away or after user selection?)
What classes will you be using? Scraper class (separate scraper classes for main page, category page, and topic page?), cli class, category class, topic class
What will be the flow of displaying data for your application. ex How will your CLI portion work. Ask user to select a category. Scrape category page for how-to topics, ask user to select topic. Scrape topic page for methods. Ask user to select method. Show Method steps to user.
How will you display data one level deep to the user?
What will need to be in your README file? An explanation of how to use the program?
