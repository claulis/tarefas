#!/bin/bash
set -e

echo "🚀 Iniciando deploy da aplicação Django..."

# Instalar dependências
echo "📦 Instalando dependências..."
pip install --upgrade pip
pip install -r requirements.txt

# Executar migrações
echo "🗄️  Aplicando migrações..."
python manage.py migrate --noinput

# Coletar arquivos estáticos
echo "📂 Coletando arquivos estáticos..."
python manage.py collectstatic --noinput --clear

# Verificar configurações
echo "✅ Verificando configurações Django..."
python manage.py check

echo "✅ Deploy preparado com sucesso!"
