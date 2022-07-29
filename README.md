### Task

- [junior](task_junior.md)
- [regular/senior](task_regular_senior.md)

### Requirements

- Ruby 3.0.0
- Bundler 2
- Redis

### Setup steps

- Clone repo `https://github.com/ShoiraTa/ticket-payment.git`
- Run `bundle install`·
- Setup database `rails db:setup`
- Run server `rails s`
- Project is using Sidekiq to run scheduled jobs, steps to setup:
  - Running sidekiq requires Redis, if you don't have it installed run `brew install redis` for mac, `sudo apt-get install redis` for Linux
  - To start Redis server run `redis-server`
  - To start Sidekiq run `bundle exec sidekiq`

### Endpoints

GET Events list => `GET`:`http://localhost:3000/events`
<br/>
GET Ticket for Event => `GET`:`http://localhost:3000/tickets`

```
Params:
 {
   "event_id": "1"
 }
```

POST Reservation => `POST`:`http://localhost:3000/tickets/reserve`

```
Params:
 {
    "event_id": "1",
    "user_id": "1",
    "tickets_count":"1"
 }
```

POST Buy => `POST`:`http://localhost:3000/tickets/buy`

```
Params:
 {
    "user_id":"2",
    "token": "token"
    "event_id": "6",
 }
```

### Tests

- Run `rspec` to execute all tests
<br/>
<img width="528" alt="Screenshot 2022-07-29 at 14 40 05" src="https://user-images.githubusercontent.com/77038610/181742482-8020dc23-945a-4edf-8911-5dc87886c4d8.png">
=======

### Setup steps

- Clone repo `git clone <link to repo>`
- Run `bundle install`·
- Setup database `rails db:setup`
- Run server `rails s`

### Task

- [junior](task_junior.md)
- [regular/senior](task_regular_senior.md)

