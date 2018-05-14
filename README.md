# Airtasker coding challenge

Challenge - Rate Limiter

## instruction
The challenge is to implement rate limiting on this route. Limit it such that a requester can only make:

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

## Notes

This took a bit longer than expected, because working locally, sometimes my keys would disappear from redis before they were due to expire.

Pretty sure this was caused by using the same redis database for test & dev environments. - Running the tests clears all the keys.

## Further reading

I would like to look into these articles more

https://stripe.com/blog/rate-limiters

https://konghq.com/blog/how-to-design-a-scalable-rate-limiting-algorithm/
