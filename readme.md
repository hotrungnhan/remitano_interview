# Brief 
> Share video web site
Features: 
* Login/Register
* List all shared videos
* Share a youtube video 
* Realtime notifcation when other user share a video (must login)
# Requirement 
## Local 
```bash
docker 4.28.0+ 
nodejs 20+ (require for dev local)
rails 3.2.3 (require run Rspec/ dev local)
postgres 16+ (require for dev local)
redis 7+ (require for dev local)
```
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
## BE

```bash
# install packge
bundle install 

# setup database
bundle exec rails db:drop && bundle exec rails db:create && bundle exec rails db:migrate && bundle exec rails db:seed

# run rspec
bundle exec rspec
```

## FE
```bash
# enable pnpm 
corepack enable

# install package
pnpm install 

# run 
pnpm dev
```
## Docker
```bash
cd /path_to_project

docker compose up

# access web site http://localhost:3001
```
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
# Note
1. You should open two tab to check the notification.
2. Don't forget to run db initilizer
3. Login/register can sometime raise error in production due to network.