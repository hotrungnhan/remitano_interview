# Setup
## ENV 
### backend
```bash
#backend/.env
DB_HOST=localhost
DB_USERNAME=postgres
DB_PASSWORD=postgres
DB_NAME=remitano_interview
REDIS_URL=redis://localhost:6379/1

ACCESS_KEY=anvyx

GOOGLE_API_KEY=AIzaSyASTMQck-jttF8qy9rtEnt1HyEYw5AmhE8
```
### frontend

```bash
#frontend/.env
VITE_BASE_URL=http://localhost:3000
VITE_BASE_WS_URL=ws://localhost:3000
```


bundle exec 
# Guide
1. Run test suit  (for BE only)
> bundle exec rspec
2. create/migrate/seed 
>  bundle exec rails db:drop && bundle exec rails db:create && bundle exec rails db:migrate && bundle exec rails db:seed
3. docker deployment (path = ~/Remitano Interview)
> docker compose up 
# Usage 
## Authenticate 
1. type any to email/password then click `login/register`
## Share a Movie
1. click on `Share a movie` button 
2. paste the link of youtube (supported url like below).
```bash
https://www.youtube.com/watch?v=fkEgtf3FxnI
https://www.youtube.com/shorts/PTQxgUe4pyw
```
3. hit `Submit` button
4. expect 2 notification appear, expect 1 notification on other account.
5. click on home button to check the result

# Q&A
1. You should open two tab to check the notification.
2. Don't forget to run db initilizer
