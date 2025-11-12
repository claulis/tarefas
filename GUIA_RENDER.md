# 📚 Guia Completo Render + SQLite

## 🎯 Visão Geral

Projeto Django totalmente configurado para deploy no **Render** usando **SQLite**:
- ✅ Banco de dados local (SQLite) com persistência via disco Render
- ✅ Migrations automáticas
- ✅ Static files comprimidos com WhiteNoise
- ✅ HTTPS automático
- ✅ CI/CD via GitHub Actions
- ✅ Grátis! (free tier Render)

## 📦 Arquivos Configurados

### 1. `render.yaml` (Configuração Principal)
```yaml
services:
  - type: web
    name: tarefas
    runtime: python
    buildCommand: pip install -r requirements.txt + migrations + static files
    startCommand: gunicorn config.wsgi:application
    envVars: SECRET_KEY, DEBUG, ALLOWED_HOSTS, DB_PATH
    disk: /var/data (1GB para SQLite)
```

**O que faz**:
- Define a aplicação web Python
- Configura build automático
- Define comando de inicialização
- Provisiona disco para banco de dados

### 2. `Dockerfile` (Container)
```dockerfile
FROM python:3.13-slim
- Instala dependências Python
- Copia código do projeto
- Configura usuário não-root
- Health check ativo
- Gunicorn com 4 workers
```

**Recursos**:
- Health check a cada 30s
- Máximo 1000 requisições por worker
- Timeout 60s
- Logs automáticos

### 3. `build.sh` (Script Build)
Executado no buildCommand:
1. Pip upgrade
2. Instalar requirements.txt
3. python manage.py migrate
4. python manage.py collectstatic
5. python manage.py check

### 4. `requirements.txt` (Dependências)
```
Django>=4.1.0,<5.0.0
python-dotenv>=1.2.1
gunicorn>=21.0.0          # Web server
whitenoise>=6.6.0         # Static files
dj-database-url>=2.0.0    # URL parsing
```

### 5. `config/settings.py` (Configuração Django)
**Principais ajustes**:
```python
# SQLite configurado
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / os.getenv('DB_PATH', 'db.sqlite3'),
    }
}

# WhiteNoise para static files
MIDDLEWARE = [
    'whitenoise.middleware.WhiteNoiseMiddleware',  # Deve ser 2º
    ...
]

# Segurança Render
SECURE_SSL_REDIRECT = True  # Render = HTTPS
SECURE_HSTS_SECONDS = 31536000
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True
```

### 6. `Procfile`
```
web: gunicorn config.wsgi:application --log-file -
```
Instrução para Render iniciar a aplicação.

### 7. `.env.example`
Template para variáveis de ambiente (para desenvolvimento).

### 8. `.github/workflows/render-deploy.yml`
CI/CD que:
- Roda em cada push para `main`
- Testa build
- Executa migrations
- Coleta static files
- Valida Django

## 🚀 Processo Deploy Completo

### Pré-Deploy (Local)
```bash
# 1. Testar localmente
python manage.py runserver

# 2. Coletar static files
python manage.py collectstatic --noinput

# 3. Verificar
python manage.py check
```

### Deploy (GitHub)
```bash
# 1. Adicionar tudo
git add .

# 2. Commitar
git commit -m "Deploy Render SQLite ready"

# 3. Push
git push origin main

# ✅ GitHub Actions testa automaticamente
```

### Deploy (Render)
1. https://render.com → Sign up/login
2. Dashboard → New + → Web Service
3. Connect Repository → claulis/tarefas
4. Render lê `render.yaml` e faz setup automático
5. Aguardar build (2-3 min)
6. Acessar: `https://seu-app-name.onrender.com`

## 🗄️ SQLite + Render

### Como Funciona
```
┌─────────────────────────────────────┐
│      Render Container               │
├─────────────────────────────────────┤
│  ┌─────────────────────────────────┐│
│  │  Aplicação Django (Gunicorn)    ││
│  │  + SQLite (db.sqlite3)          ││
│  └──────────────┬──────────────────┘│
│                 │                   │
│          ┌──────▼──────┐            │
│          │ /var/data/  │  ◄─ Disco  │
│          │             │   Persist. │
│          └─────────────┘            │
└─────────────────────────────────────┘
```

### Vantagens
- ✅ Sem banco de dados externo (grátis!)
- ✅ Zero latência (banco local)
- ✅ Dados persistem (disco dedicado)
- ✅ Backup simples
- ✅ Ideal para apps pequenas/médias

### Desvantagens
- ❌ Não suporta múltiplas instâncias (scaling horizontal)
- ❌ Se app reinicia, container novo pode vir do disco
- ❌ Não há replicação automática

### Limite SQLite
- **Tamanho**: 1 GB (disco Render)
- **Limite hard do SQLite**: 2 TB
- **Prático**: ~100MB dados é confortável no free tier

## 📊 Variáveis de Ambiente Render

```
SECRET_KEY
└─ Auto-gerada pelo Render
   Nunca commitar no git!

DEBUG = False
└─ Produção: desabilita debug mode
   (Em local deixar True)

ALLOWED_HOSTS = *.onrender.com,localhost
└─ Hosts permitidos pelo Django
   Render setup automático

PYTHON_VERSION = 3.13
└─ Versão Python especificada

DB_PATH = /var/data/db.sqlite3
└─ Localização do banco de dados
   /var/data = disco persistente Render
```

## 🔄 Ciclo de Deploy Render

```
1. Push GitHub main
    ↓
2. GitHub Actions testa (render-deploy.yml)
    ↓
3. Render detecta novo push
    ↓
4. Render executa buildCommand
    ├─ pip install requirements.txt
    ├─ python manage.py migrate
    ├─ python manage.py collectstatic
    └─ python manage.py check
    ↓
5. Render constrói Docker image
    ↓
6. Render deploya novo container
    ├─ Copia código
    ├─ Monta disco em /var/data
    ├─ Inicia health check
    └─ Começa a aceitar requisições
    ↓
7. App ao vivo! 🎉
```

## ⚠️ Free Tier Limitações

### Inatividade
- **Free web services dormem após 15 min de inatividade**
- Primeira requisição após sleep demora ~30s
- Solução: uptimeRobot para keep-alive

### Redeploy
- Se inativo > 30 dias, Render pode remover
- Push para GitHub causa redeploy automático

### Recursos
- 0.5 GB RAM
- 1 vCPU compartilhada
- 100 GB/mês de egress
- Compartilhado com outros free users

## 🛠️ Troubleshooting Completo

### 1️⃣ Erro: "Failed to build"
**Causa**: requirements.txt com erro, ou build command falha
**Solução**:
```bash
# Local
pip install -r requirements.txt
python manage.py migrate
python manage.py collectstatic

# Se der erro, consertar e fazer push novo
```

### 2️⃣ Erro: "Application failed to start"
**Causa**: Gunicorn não consegue iniciar
**Solução**:
- Verificar logs Render
- `python manage.py check` localmente
- Verificar SECRET_KEY definida

### 3️⃣ 500 Internal Server Error
**Causa**: Erro na aplicação
**Solução**:
- Render dashboard → Logs
- DEBUG=True temporariamente (não fazer em produção!)
- Verificar migrações: `python manage.py migrate --plan`

### 4️⃣ Static files não aparecem
**Causa**: WhiteNoise não coletou
**Solução**:
```bash
python manage.py collectstatic --noinput --clear
# Depois fazer push
```

### 5️⃣ Dados SQLite desapareceram
**Causa**: DB_PATH incorreta ou disco não montado
**Solução**:
- Verificar render.yaml: `DB_PATH: /var/data/db.sqlite3`
- Verificar settings.py: `NAME: BASE_DIR / os.getenv('DB_PATH')`
- Render dashboard → Disks → Confirmar montagem em /var/data

### 6️⃣ App muito lento (free tier)
**Causa**: Recursos limitados, outro usuário consumindo
**Solução**:
- Upgradar para Starter ($7/mês) se crítico
- Otimizar queries Django
- Cache em Redis (pago)

## 📈 Upgrade Plano Pago

Se precisar mais recursos:

| Feature | Free | Starter |
|---------|------|---------|
| RAM | 0.5 GB | 1 GB |
| vCPU | Compartilhada | 0.5 |
| Sleeps | Após 15 min | Nunca |
| DB Persistente | Sim (1 GB) | Sim |
| Preço | Grátis | $7/mês |

## 🔐 Segurança

### ✅ Implementado
- HTTPS automático Render
- HSTS headers (força HTTPS)
- Secure cookies (flag Secure)
- CSRF protection Django
- XSS protection (X-Frame-Options)
- SECRET_KEY nunca em git

### ❌ Não tem
- Autenticação 2FA Render
- WAF (Web Application Firewall)
- DDoS protection (fora de free tier)

### Recomendações
- Mudar superuser Django padrão
- Usar senhas fortes
- Atualizar Django regularmente
- Monitorar logs Render

## 🎯 Próximos Passos

1. **Agora**: 
   ```bash
   git push origin main
   ```

2. **No Render**:
   - Criar web service
   - Esperar deploy (2-3 min)
   - Testar app

3. **Após Deploy**:
   - Acessar `/admin/` 
   - Criar superuser (Render Shell)
   - Testar funcionalidades

4. **Manutenção**:
   - Monitorar logs
   - Atualizar dependências
   - Backup SQLite se necessário

---

**Sucesso no deploy!** 🚀
