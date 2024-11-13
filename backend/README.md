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

* ...

> rake parallel:drop && rake parallel:setup
> rake parallel:drop && rake parallel:setup
> rails db:drop && rails db:setup

# 
 Request -> Params Validator -> Command -> Database Validator -> Database -> Serializer -> Response
 
# Validation 
* Params Level
  * Params Validator 
  * Self-Coded Validator
* Database Level 
  * Relation Validator
  * Valid Attribute Validator
  * Self-Coded Validator
