#!/bin/bash
set -e

echo "🔨 Iniciando build para Render..."

# Upgrade pip
echo "📦 Atualizando pip..."
pip install --upgrade pip

# Instalar dependências
echo "📦 Instalando dependências..."
pip install -r requirements.txt

# Executar migrações
echo "🗄️  Executando migrações..."
python manage.py migrate --noinput

# Coletar arquivos estáticos
echo "📁 Coletando arquivos estáticos..."
python manage.py collectstatic --noinput --clear

# Verificar configuração Django
echo "✅ Verificando configuração Django..."
python manage.py check

echo "✨ Build concluído com sucesso!"
