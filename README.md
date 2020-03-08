# Challenge - Rate Limiter

Implement rate limiting on a route. Limit it such that a requester can only make:

100 requests per hour.

After the limit has been reached
 -> return a 429 with the text

 "Rate limit exceeded. Try again in #{n} seconds".

## Redis server

redis://127.0.0.1:6379

Server url is currently hardcoded in config/environments/development.rb

## Run tests

Run `guard`

press [enter]

## Run locally

With httpie

`http GET localhost:3000/`

In bash to make 100 requests

```
for i in {1..100}
do
   http GET localhost:3000/
done
```
