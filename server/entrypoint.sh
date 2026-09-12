#!/bin/sh
python manage.py makemigrations
python manage.py migrate --no-input
python manage.py collectstatic --no-input
gunicorn --bind :8000 --workers 3 djangoproj.wsgi
