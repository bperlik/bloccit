## Bloccit: a Reddit replic to teach the fundamentals of web development and Rails

Made with my mentor at [Bloc](http://bloc.io).

# [Bloccit]((https://bperlik-bloccit.herokuapp.com/ "Bloccit")

Bloccit is a Ruby on Rails application that allows users to create topics and posts. Users are able to up/down vote posts as well as favorite them. All aspects for this app were custom built, including authentication and authorization, in order to gain a thorough understanding of their functionality.

The app is deployed on Heroku: https://bperlik-bloccit.herokuapp.com

The source code is here on GitHub: https://github.com/bperlik/Bloccit

This app was created as part of the [Bloc](www.bloc.io) Full Stack Web Development course.

# Features

+ Users can create a standard account in order to create and edit topics and posts.
+ Users can up/down vote any post. A list of their posts is displayed on their profile with their vote score.
+ Users can favorite posts, which are then saved on their user profile for easy tracking.


# Setup and Configuration

**Languages and Frameworks**: Ruby on Rails and Bootstrap

**Ruby version 2.43

**Databases**: SQLite (Test, Development), PostgreSQL (Production)

**Development Tools and Gems include**:

+ BCrypt for secure passwords
+ SendGrid for email confirmation
+ FactoryGirl for test suite success

**Setup:**

+ Environment variables were set using Figaro and are stored in config/applicatio.yml (ignored by git).

+ The config/application.example.yml file illustrates how environment variables should be stored.

**To run Bloccit locally:**

+ Clone the repository
+ Run bundle install
+ Create and migrate the SQLite database with `rake db:create` and `rake db:migrate`
+ Start the server using `rails server`
+ Run the app on `localhost:3000`
