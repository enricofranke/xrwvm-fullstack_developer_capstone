# Stage 1: build the React frontend
FROM node:20-bookworm-slim AS frontend
WORKDIR /frontend
COPY frontend/package.json frontend/package-lock.json ./
RUN npm ci --no-audit --no-fund
COPY frontend/ ./
RUN CI=false npm run build

# Stage 2: Django application
FROM python:3.12-slim-bookworm

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV APP=/app

WORKDIR $APP

COPY requirements.txt $APP
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . $APP
COPY --from=frontend /frontend/build $APP/frontend/build

EXPOSE 8000

RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/bin/bash", "/app/entrypoint.sh"]
