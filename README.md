# Airtasker coding challenge

## Challenge - Rate Limiter

Create a new controller, perhaps called "home", with an index method. This should return only the text string "ok".

The challenge is to implement rate limiting on this route. Limit it such that a requester can only make:

100 requests per hour.

After the limit has been reached
 -> return a 429 with the text

 "Rate limit exceeded. Try again in #{n} seconds".

##  How you do this is up to you.

Think about how easy your rate limiter will be to maintain and control. Write what you consider to be

When you've finished, send us the link to your repo on github. Good luck!
