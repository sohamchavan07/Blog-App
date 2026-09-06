# Blog-App

A robust blogging platform built with Ruby on Rails and PostgreSQL.

## Tech stack
- Ruby (>= 3.x)
- Rails (>= 8.x)
- PostgreSQL
- JavaScript (importmap / optional Node build tooling)
- TailwindCSS, Stimulus, Devise, Stripe

## Quickstart (local development)
1. Clone the repo

```bash
git clone https://github.com/sohamchavan07/Blog-App.git
cd Blog-App
```

2. Install dependencies

```bash
bundle install
bin/setup || (yarn install || npm install)
```

3. Environment

Copy example env and add required keys (Stripe keys, DB URL, secrets):

```bash
cp .env.example .env
# edit .env and add STRIPE_* and other secrets
```

4. Database

```bash
rails db:create db:migrate db:seed
```

5. Start the app

```bash
bin/dev
# or: rails server
```

Open http://localhost:3000

## Tests

Run the test suite with:

```bash
bin/rails test
# or if using RSpec: bundle exec rspec
```

## Common commands
- Install gems: `bundle install`
- Install JS deps: `yarn install` or `npm install`
- Run migrations: `rails db:migrate`
- Seed: `rails db:seed`
- Start dev server: `bin/dev` or `rails server`

## Screenshots
<img width="1343" height="617" alt="Screenshot from 2026-07-29 20-51-16" src="/screenshots/Screenshot from 2026-07-29 20-51-16.png" />
<img width="1343" height="617" alt="Screenshot from 2026-07-29 20-47-48" src="/screenshots/Screenshot from 2026-07-29 20-47-48.png" />
<img width="1343" height="617" alt="Screenshot from 2026-07-29 20-37-04" src="/screenshots/Screenshot from 2026-07-29 20-37-04.png" />

## Environment variables (examples)
- `DATABASE_URL` or standard `config/database.yml` settings
- `RAILS_MASTER_KEY` or `config/master.key`
- `STRIPE_SECRET_KEY`, `STRIPE_PUBLISHABLE_KEY`, `STRIPE_WEBHOOK_SECRET`

## Ignoring and cleaning local files
This repo ignores common local/system files in `.gitignore` (e.g. `.env`, `node_modules`, `/dist`, `log/*`, `tmp/*`, `.DS_Store`). If you have any tracked files that should be ignored, run:

```bash
git rm -r --cached node_modules dist public/packs
git rm --cached .env
git commit -m "chore: remove tracked build and env files"
```

## Contributing

Contributions are welcome — please follow the guidelines in [CONTRIBUTING.md](CONTRIBUTING.md) and run the test suite before opening a PR.

A quick workflow:
1. Fork the repo
2. Create a branch: `git checkout -b feature/your-feature`
3. Commit changes and run tests
4. Push and open a Pull Request

## Author

Soham Chavan — Portfolio: https://www.sohamchavan.site

## License

This project is licensed under the MIT License — see [LICENSE](LICENSE) for details.
