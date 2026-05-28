# Twitter Clone

A Twitter clone built with Ruby on Rails 8.1, featuring tweet threads, real-time updates via Turbo Streams, and a dark UI styled with Tailwind CSS 4.

## Tech Stack

- **Ruby** 3.4.4 / **Rails** 8.1.3
- **PostgreSQL** — primary database
- **Propshaft** — asset pipeline
- **Tailwind CSS 4** — styling
- **Hotwire** (Turbo Drive, Turbo Frames, Turbo Streams) — real-time UI updates without a full-page reload
- **Stimulus** — JavaScript controllers
- **Solid Cache / Queue / Cable** — database-backed Rails infrastructure

## Features

- Sign up, log in, log out
- Post tweets (280 character limit)
- Tweet threads — reply to any tweet, view full ancestor chain
- Like / unlike tweets (in-place update via Turbo Streams)
- Follow / unfollow users (in-place update via Turbo Streams)
- Home feed — tweets from followed users + your own
- User profiles

## Setup

```bash
# Install dependencies
bundle install

# Set up the database
bin/rails db:create db:migrate

# Start the development server (Rails + Tailwind watcher)
bin/dev
```

Visit `http://localhost:3000` to use the app.

## Development

```bash
bin/rails tailwindcss:build   # compile Tailwind CSS once
bin/rails db:seed             # seed the database (if seeds exist)
bin/rails test                # run the test suite
```