# LiveURL will very slow in first start due to the prodiver service coldstart, please wait at least 1 min then.

> Trigger these two link to boot the server 
```bash
 https://remitano-interview-fe.onrender.com/
 https://remitano-interview.onrender.com/up
```
# Brief 

> Share video web site
Features: 
* Login/Register
* List all shared videos
* Share a youtube video 
* Realtime notifcation when other user share a video (must login)
## Highlight
* FE: cache list video && invalidate when new video come
* FE: load youtube embed faster
* Both FE/BE: Apply design pattern to distinct business logic and UI
  * BE: Request-> Controller -> Command (core logic will be here) <-> Model -> Serializer -> Response
  * FE: UI -> Store -> API Call & computing processs -> State -> UI (same paradism as redux)
* BE: unit test coverage 88%  (100% if we just care about feature logic)
* BE: Invoke google api to retrived youtube metadata (for title,description )
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
4. Google API have a quota limit, if you see any error when add video, please reach me via github issue or directly via email.
5. Topic that this project not enough time to cover 
   1. Error clearly display / Error handler
   2. Security
   3. Loading effect / animations 
   4. Code Structure (mostly in FE)
   5. Optimize docker image builder
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
RAILS_MASTER_KEY=12c32dbc4cf3afe8986885921cc3652b
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
