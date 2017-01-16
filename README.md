# README

Reasoning: 

After reading the spec, it made the most sense to create this as an API only application.

`rails new timekeeper-api --api`

Again, based on the spec it made most sense to create 2 models as suggested.
There was no documentation pertaining towards `total_hours` so I figured I had to options here with the simplest being adding a field called `total_hours` on the time_card model. The other way is the way through a helper method but I thought it would be nice to include it in the JSON output.

I then created 2 controllers which inhert from `ApplicationController`, which in turn inherits from `ActionController::API`. The standard rails routing for conventional routing was used to enable the controller methods. The routes were also namespaced according to the spec.

All of the controller methods are based on standard RESTful routing and can be queried using basic cURL commands. Here is an example of the cURL command to create a time_card object:

`curl -H "Content-Type: application/json" -X POST -d '{"username":"Mike","occurrence":"2017-01-15"}' http://localhost:3000/api/v1/time_cards`

The models are designed with simple validation on the fields to check for `presence: true`, associations and the time_entry model has 3 helper methods which will be discussed further.

1. `check_time_entry_card_count`

This method is called after the time_entry is saved. This method checks to see if `time_card.time_entries.count` is greater than or equal to 2. If true, the method then calls the calculate_total_hours method which we will discuss next.

2. The `calculate_total_hours` method takes the last time_entry associated with the time_card and subtracts it from the first instance and rounds to the nearest 2 digit decimal hour. For example: 1.75 hours would equate to 1hr45mins.

3. The final method is: `set_total_hours_to_nil`. It is called in an `after_delete` allowing it to set the total_hours field on the time_card object to nil.

All in all, the application runs to spec.

To have some data to play with I added a simple seed.

run `rake db:seed` or `rails db:seed` to seed the database.


Trade-offs:

1. Lack of security (i.e. no authentication)
2. Lack of serializers. If this were to plug into a front-end it would make sense to have serialization.
3. I would have added in testing to ensure it functions correctly, even though it does! :)






