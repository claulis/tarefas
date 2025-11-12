FROM python:3.13-slim

# Definir diretório de trabalho
WORKDIR /app

# Definir variáveis de ambiente
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=8000

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copiar requirements.txt
COPY requirements.txt .

# Instalar dependências Python
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copiar projeto
COPY . .

# Criar diretório de dados
RUN mkdir -p /var/data

# Criar diretório para static files
RUN mkdir -p /app/staticfiles

# Coletar arquivos estáticos
RUN python manage.py collectstatic --noinput --clear || true

# Criar usuário não-root
RUN useradd -m -u 1000 appuser && \
    chown -R appuser:appuser /app /var/data

USER appuser

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/admin/').read()" || exit 1

# Executar aplicação
CMD gunicorn config.wsgi:application \
    --bind 0.0.0.0:${PORT} \
    --workers 4 \
    --worker-class sync \
    --max-requests 1000 \
    --timeout 60 \
    --access-logfile - \
    --error-logfile -
