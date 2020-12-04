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


Author Notes:
-----------------------------------------
Any documentation and concerns or issues related to the project are addressed here in this file (e.g. copyright issues, design and code issues etc.).


Database Schema and Migrations:
-----------------------------------------
Rails uses a Model/Migration system to handle database tables and fields using sqlite3. I will be using sqlite3 for my development and test databases.
**Note:** The database development.sqlite3 is used by the rails server *whereas* test.sqlite3 is used by rails (or rake) test.

Tables:
- Users
- Products
- Baskets
- Items (Products added to the User's Basket are called Items)

To ensure that the website is populated with products and users, you can run the command "rake db:seed" in the terminal which will execute the commands in the seed.rb file.

Design Choices:
-----------------------------------------
There may be some unconventional design decisions relating to the database schema which I will attempt to explain:

**Why are the delivery details of the order assigned to the table Basket and not User or Order?**
Any customer may checkout regardless if they have an account or not. In this case, it would make sense to apply the details of the customer's delivery details to their basket session as anyone checking out will always have a basket.

**Then why not take these delivery details into the Order table?**
I wanted to encourage re-usability of the customer's details. In this case, if a customer has a User account, they will always use the same basket id. Knowing this, we can save the customer's delivery details to their own basket to checkout quickly next time. The same cannot be done with Order as each checkout is unique, and therefore would not save the customer's details for next time.

**So why not store these delivery details in the User table?**
Remember that people without User accounts can checkout/buy products as customers too! This is called a checkout as a Guest system, where a customer is not required to login to a User account to checkout. So we cannot store order details into a User account (unless we created a Guest account each time). In this case, it would make perfect sense for the customer's delivery details to live and die with their basket session as it will be used at least once per checkout (the basket id session only changes when logging in or out of accounts).


Testing and Development:
-----------------------------------------
I will be testing this Rails application under the latest released version of Ubuntu Linux 64-bit (using VMware on Windows 10) along with the latest version of the Chrome browser at the time and date of submission.


Copyright Disclaimer:
-----------------------------------------
Any third-party images, audio clips, or assets used during this project is within the Public Domain. This means items such as images are free to use even for commercial purposes. Assets can include any design aspects of the view from ruby gems to fonts to background images etc.

These will primarily affect the View aspect of the Model-View-Controller template.

However, I cannot guarantee with absolute certainty that all assets used during this production will be completely license-free at the time of submission and as such any assets that are licensed and used accidentally are for educational purposes only.
