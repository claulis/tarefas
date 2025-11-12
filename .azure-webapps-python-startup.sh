#!/bin/bash

# Script de inicialização para Azure App Service

# Instalar dependências
pip install -r requirements.txt

# Executar migrações
python manage.py migrate --noinput

# Coletar estáticos
python manage.py collectstatic --noinput --clear

# Iniciar Gunicorn
gunicorn config.wsgi:application --bind=0.0.0.0 --workers=4 --worker-class=sync
