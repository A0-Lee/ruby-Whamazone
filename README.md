# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions


Main Versions*:
-----------------------------------------
Ruby - 2.7.0
Rails - 5.2.4.4

*See Gemfile for detailed versions of manually chosen and installed ruby gems


Testing and Development:
-----------------------------------------
I will be testing this Rails application under the latest released version of Ubuntu Linux 64-bit (using VMware on Windows 10) along with the latest version of the Chrome browser at the time and date of submission.


Author Notes:
-----------------------------------------
Any documentation and concerns or issues related to the project are addressed here in this file (e.g. copyright issues, design and code issues etc.).

I also used [Ruby Version Manager (RVM)](https://rvm.io) to handle and install any ruby gem packages as well as Ruby and Rails for this project.


Set-up Instructions:
-----------------------------------------
Ensure that you have correctly installed all the necessary ruby gem packages for this project using the terminal command "bundle install" in the same project directory, these gems are located in the Gemfile file.

You can check if the required ruby gems have been successfully installed for this project using the terminal command "bundle list".


Instructions:
-----------------------------------------
This project is developed using Ruby on Rails, most of the setup is written and done for you already which includes dummy accounts and products. You only need to start the website using the terminal command "rails s" or "rails server" in the same project directory.

Head to http://localhost:3000/ to see and interact with the website application.

Please note that if you wish to view certain indexes that are normally inaccessible by a regular user, there is a special account created for this purpose:
- email: Admin@Whamazone.com
- password: WHAM

This allows you to see all the User's baskets and orders using their respective index page when logged in this account. It is a unique account as it has a user_id of 0, which isn't possible to create when using the website conventionally.


In the rare case that there are any database issues or if databases are missing certain elements, run the following ruby commands in the same terminal as the project directory:
- rake db:drop
- rake db:create
- rake db:migrate
- rake db:seed

This should fix any related database issues caused by the database files.


Database Schema and Migrations:
-----------------------------------------
Rails uses a Model/Migration system to handle database tables and fields using sqlite3. I will be using sqlite3 for my development and test databases.

**Note:** The database development.sqlite3 is used by the rails server *whereas* test.sqlite3 is used by rails/rake test.

Tables:
- User
- Product
- Basket
- Item (Products added to the User's Basket are called Items)
- CustomerInfo
- Order

To ensure that the website is populated with products and users, you can run the command "rake db:seed" in the terminal which will execute the SQL commands in the seeds.rb file. However, all intended records to be used for this project should be ready by default.

If you wish to view all the existing records in their respective table at any point, you can do so by:
- Writing "rails c" or "rails console" in the terminal
- Followed by [Table Name].all
- For example, User.all would show all the existing records in the User table
- Write "quit" to exit the rails console


Copyright Disclaimer:
-----------------------------------------
Any third-party images, audio clips, or assets used during this project is within the Public Domain. This means items such as images are free to use even for commercial purposes. Assets can include any design aspects of the web pages from ruby gems, to fonts, to product images etc.

These will primarily affect the View aspect of the Model-View-Controller template.

However, I cannot guarantee with absolute certainty that all assets used during this project's development will be completely license-free at the time of submission and as such, any assets that are licensed and used accidentally are for educational purposes only.
