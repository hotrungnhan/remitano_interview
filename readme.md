# LiveURL Initialization

**Note:** The LiveURL service may experience a slow start due to the provider's cold start. Please trigger the following URLs and wait at least 1 minute.

Trigger these links to initialize the server:
```bash
https://remitano-interview-fe.onrender.com/
https://remitano-interview.onrender.com/up
```

## Project Overview

**Share Video Website**

### Features:
- User Authentication (Login/Register)
- Display all shared videos
- Share YouTube videos
- Real-time notifications for newly shared videos (login required)

### Highlights:
- **Frontend (FE):** 
  - Caches video list and invalidates cache when a new video is shared
  - Loads YouTube embeds faster
- **Backend (BE):**
  - Employs design patterns to separate business logic from the UI
  - Workflow: Request -> Controller -> Command (core logic) <-> Model -> Serializer -> Response
- **Frontend Workflow:**
  - UI -> Store -> API Call & Processing -> State -> UI (similar to Redux pattern)
- **Backend Testing:**
  - Unit test coverage of 88% (100% for feature logic)
- **YouTube Metadata Retrieval:**
  - Uses Google API to fetch YouTube video metadata (title, description)

## Usage

### Authentication
1. Enter any email/password and click `login/register`.

### Share a Movie
1. Click the `Share a movie` button.
2. Paste the YouTube link (supported URLs below):
   ```bash
   https://www.youtube.com/watch?v=fkEgtf3FxnI
   https://www.youtube.com/shorts/PTQxgUe4pyw
   ```
3. Click the `Submit` button.
4. Expect 2 notifications to appear. Expect 1 notification on a different account.
5. Click the `Home` button to view the results.

## Notes
1. Open two tabs to check the notification feature.
2. Ensure the database initializer is run.
3. Login/register might raise errors in production due to network issues.
4. Google API has a quota limit. If errors occur when adding a video, please report via GitHub issue or email directly.
5. Topics not covered due to time constraints:
   - Clear error display / Error handling
   - Security enhancements
   - Loading effects / Animations
   - Frontend code structure
   - Optimizing Docker image build process

## Requirements

### Local Setup
```bash
Docker 4.28.0+ 
Node.js 20+ (for local development)
Rails 3.2.3 (for running RSpec / local development)
PostgreSQL 16+ (for local development)
Redis 7+ (for local development)
```

## Setup

### Environment Variables

#### Backend
Create a `.env` file in the `backend` directory with the following content:
```bash
DB_HOST=localhost
DB_USERNAME=postgres
DB_PASSWORD=postgres
DB_NAME=remitano_interview
REDIS_URL=redis://localhost:6379/1

ACCESS_KEY=anvyx

GOOGLE_API_KEY=AIzaSyASTMQck-jttF8qy9rtEnt1HyEYw5AmhE8
RAILS_MASTER_KEY=12c32dbc4cf3afe8986885921cc3652b
```

#### Frontend
Create a `.env` file in the `frontend` directory with the following content:
```bash
VITE_BASE_URL=http://localhost:3000
VITE_BASE_WS_URL=ws://localhost:3000
```

## Backend Guide

```bash
# Install packages
bundle install 

# Setup database
bundle exec rails db:drop && bundle exec rails db:create && bundle exec rails db:migrate && bundle exec rails db:seed

# Run tests
bundle exec rspec
```

## Frontend Guide

```bash
# Enable pnpm
corepack enable

# Install packages
pnpm install 

# Start development server
pnpm dev
```

## Docker Guide

```bash
cd /path_to_project

docker compose up

# Access the website at http://localhost:3001
```
