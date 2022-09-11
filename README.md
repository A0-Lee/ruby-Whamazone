Author Brief Notes:
-----------------------------------------
<b>About:</b> This project is an example of a modern day e-commerce application which includes user interactions such as creating an account, writing a review, buying products, and etc. in a full-stack MVC architecture.

Any documentation and concerns or issues related to the project are addressed here in this text file (e.g. copyright issues, design and code issues etc).

<b>Bundler:</b> [Ruby Version Manager (RVM)](https://rvm.io) is used to handle and install any ruby gem packages as well as the Ruby and Rails framework for this project.

<b>Testing and Development:</b> Manual testing and assessment of the functionality and performance of this project was performed under the latest released version of Ubuntu Linux 64-bit (via VMware on Windows 10) along with the latest version of the Chrome browser at the time and date of submission (as of December 2020).

<b>Note:</b> This project was migrated from my university GitLab account and was used for the submission of one of my web development modules. As a result, property of this project belongs to the University of Surrey.

Package Versions:
-----------------------------------------
<b>Main Packages*</b>:
- Ruby - 2.7.0
- Rails - 5.2.4.4

*See the Gemfile for all main and miscellaneous Ruby gems/packages versions required for this project.

Set-up Instructions:
-----------------------------------------
Ensure that you have correctly installed all the necessary Ruby gem packages for this project using the terminal command "bundle install" in the same project directory. Details of specific gem versions and packages are located in the Gemfile file.

You can check if the required ruby gems have been successfully installed for this project using the terminal command "bundle list".


Instructions:
-----------------------------------------
This project is developed using the Ruby on Rails framework, most of the manual setup is written and done for you already which includes examples of dummy accounts and products. 

<b>Run Server:</b> You only need to start the website using the terminal command "rails [s/server]" in the same project directory. Afterwards, head to http://localhost:3000/ to see and interact with the website application.

<b>[OPTIONAL]</b>: Please note that if you wish to view certain indexes that are normally inaccessible by a regular user, there is a special administrative account created with a user_id of 0 for this purpose:

- email: Admin@Whamazone.com
- password: WHAM

This allows you to see all the current User's baskets and transaction orders using their respective index page when logged in this account as a demonstration of customer service overview.


<b>Reset Database:</b> In the rare case that there are any database issues or if databases are missing certain elements, run the following ruby commands in the same terminal as the project directory:
- rake db:drop
- rake db:create
- rake db:migrate
- rake db:seed

This should fix any related database issues caused by the database files.


Database Schema and Migrations:
-----------------------------------------
Rails uses a Model/Migration system to handle in-built database tables and fields using sqlite3 for development. It is important to distinguish the database development.sqlite3 is used by the rails server as production development whereas test.sqlite3 is used by "[rails/rake] test" during server testing.

I have attached a .pdf file named "COM2025 DB Schema" which provides a detailed database schema diagram of all the tables/models used in this project to explain the relationship between tables. This diagram includes the table names, attributes, primary/foreign keys, and associations/relationships between all unique tables to help you understand the website layout and its models.

<b>Database (All Unique Tables)</b>:
- User
- Product
- Basket
- Item (Products added to the User's Basket are called Items)
- CustomerInfo
- Order
- Review

<b>Manual Seeding</b>: To ensure that the website is populated with products and users, you can run the command "rake db:seed" in the terminal which will execute the SQL commands in the seeds.rb file. However, all intended records to be used for this project should be ready by default.

If you wish to view all the existing records in their respective table at any point, you can do so by:
- Writing "rails c" or "rails console" in the terminal
- Followed by [Table Name].all
- For example, User.all would show all the existing records in the User table
- Write "quit" to exit the rails console


Copyright Disclaimer:
-----------------------------------------
Any third-party images, audio clips, or assets used during this project is within the Public Domain. This means items such as images are free to use even for commercial purposes. Assets can include any design aspects of the web pages from ruby gems, to fonts, to product images etc.

Direct assets (such as the bootstrap review stars) that are borrowed and used for this project are credited where appropriate.

These will primarily affect the View aspect of the Model-View-Controller template.

However, I cannot guarantee with absolute certainty that all assets used during this project's development will be completely license-free at the time of submission and as such, any assets that are licensed and used accidentally are for educational purposes only.
