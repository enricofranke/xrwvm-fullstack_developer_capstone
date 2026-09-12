# Best Cars Dealership – Full-Stack Developer Capstone

**Project name:** Best Cars Dealership Review Portal

Capstone project for the IBM Full-Stack Software Developer Professional Certificate.
The application lets customers browse all branches of the national car retailer *Best Cars Dealership*,
read reviews for each dealership and, once logged in, post their own review. Reviews are
analysed with a sentiment analyzer microservice and shown with a positive / neutral / negative icon.

## Architecture

| Component | Technology | Location |
|-----------|------------|----------|
| Web application, user management, car make/model catalogue | Django 6 + SQLite | `server/` |
| Frontend (SPA) | React 18, react-router | `server/frontend/` |
| Dealership & review API | Node.js / Express + MongoDB (Mongoose) | `server/database/` |
| Sentiment analyzer | Flask + NLTK (VADER) | `server/djangoapp/microservices/` |
| CI | GitHub Actions (flake8, jshint) | `.github/workflows/main.yml` |
| Deployment | Docker, Kubernetes manifest | `server/Dockerfile`, `server/deployment.yaml` |

## Running locally

```bash
# 1. Dealership / review API (MongoDB + Express)
cd server/database
docker compose up -d --build

# 2. Sentiment analyzer
cd server/djangoapp/microservices
docker build -t senti_analyzer .
docker run -d -p 5050:5000 senti_analyzer

# 3. Django application
cd server
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
(cd frontend && npm install && npm run build)
python manage.py makemigrations && python manage.py migrate
python manage.py runserver
```

Open http://localhost:8000.

## API endpoints (Django proxy)

| Endpoint | Description |
|----------|-------------|
| `POST /djangoapp/login` | Log in (`{"userName": ..., "password": ...}`) |
| `GET /djangoapp/logout` | Log out |
| `POST /djangoapp/register` | Register a new user |
| `GET /djangoapp/get_cars` | All car makes and models |
| `GET /djangoapp/get_dealers` | All dealers |
| `GET /djangoapp/get_dealers/<state>` | Dealers in a state |
| `GET /djangoapp/dealer/<id>` | Dealer details |
| `GET /djangoapp/reviews/dealer/<id>` | Reviews for a dealer incl. sentiment |
| `POST /djangoapp/add_review` | Post a review (login required) |
