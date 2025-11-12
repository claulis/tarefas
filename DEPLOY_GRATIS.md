# 🚀 Guia de Deploy Gratuito - Tarefas Django

Seu projeto agora está configurado para CI/CD sem custos! Escolha uma das opções abaixo:

---

## 📋 Comparação de Opções Gratuitas

| Plataforma | Custo | Facilidade | Nota |
|-----------|-------|-----------|------|
| **Railway** ⭐ | $5/mês crédito | ⭐⭐⭐ | **RECOMENDADO** |
| **Render** | Grátis (limitado) | ⭐⭐⭐ | Bom para desenvolvimento |
| **Heroku** | Pago | ⭐⭐⭐ | Plano grátis descontinuado |
| **PythonAnywhere** | $5/mês+ | ⭐⭐ | Simples, mas limitado |
| **Replit** | Grátis | ⭐⭐⭐ | Ótimo para prototipagem |

---

## ⭐ Opção 1: RAILWAY (RECOMENDADO)

### Vantagens:
- ✅ $5/mês em créditos grátis
- ✅ Deploy automático via Git
- ✅ Interface intuitiva
- ✅ Suporta PostgreSQL, Redis, etc
- ✅ Melhor custo-benefício

### Passos:

#### 1️⃣ Criar conta e conectar GitHub
- Acesse https://railway.app
- Clique em "Sign up with GitHub"
- Autorize o acesso ao seu repositório

#### 2️⃣ Criar novo projeto
- Clique em "New Project"
- Selecione "Deploy from GitHub repo"
- Escolha o repositório `tarefas`
- Selecione branch `main`

#### 3️⃣ Configurar variáveis de ambiente
- No painel do Railway, acesse "Variables"
- Adicione as variáveis:

```env
SECRET_KEY=sua-chave-django-secreta
DEBUG=False
PYTHON_VERSION=3.13
```

#### 4️⃣ Configurar build
- No painel, acesse "Settings"
- Build Command: `pip install -r requirements.txt && python manage.py migrate && python manage.py collectstatic --noinput`
- Start Command: `gunicorn config.wsgi`

#### 5️⃣ Deploy automático
- Cada push em `main` faz deploy automático! 🎉

---

## 🎨 Opção 2: RENDER

### Vantagens:
- ✅ Plano grátis disponível
- ✅ Deploy automático via Git
- ✅ HTTPS incluído
- ✅ Suporta PostgreSQL grátis

### Passos:

#### 1️⃣ Criar conta
- Acesse https://render.com
- Clique em "Sign up"
- Escolha "Sign up with GitHub"

#### 2️⃣ Criar novo Web Service
- Clique em "New +"
- Selecione "Web Service"
- Conecte seu repositório GitHub

#### 3️⃣ Configurar
- **Name**: `tarefas`
- **Environment**: `Python 3.13`
- **Build Command**: 
  ```
  pip install -r requirements.txt && python manage.py migrate && python manage.py collectstatic --noinput
  ```
- **Start Command**: 
  ```
  gunicorn config.wsgi
  ```

#### 4️⃣ Adicionar variáveis
- Na seção "Environment", adicione:
  ```
  SECRET_KEY=sua-chave-secreta
  DEBUG=False
  ```

#### 5️⃣ Deploy
- Clique em "Create Web Service"
- Render fará deploy automaticamente!

---

## 📦 Opção 3: HEROKU (Legacy)

⚠️ **Nota**: Heroku descontinuou plano grátis em novembro de 2022.

Se você tiver créditos promocionais:

```bash
# Login
heroku login

# Criar app
heroku create tarefas-django

# Deploy
git push heroku main

# Migrar banco
heroku run python manage.py migrate
```

---

## 🖥️ Opção 4: PYTHON ANYWHERE

### Site: https://www.pythonanywhere.com

**Plano Grátis**: $0/mês (com limitações)
- 100 MB de armazenamento
- 1 app web
- Um banco de dados

### Passos rápidos:
1. Criar conta
2. Fazer upload do código via Git
3. Configurar virtual environment
4. Configurar Web App (Django)

---

## 🎓 Opção 5: REPLIT (Para Desenvolvimento)

### Site: https://replit.com

Ótimo para prototipagem rápida!

```bash
# Criar um novo Repl
# Selecionar Python
# Colar o código do repositório
# Executar: python manage.py runserver 0.0.0.0:8000
```

---

## 📝 Requirements.txt

Certifique-se que o arquivo `requirements.txt` existe com:

```txt
django>=4.1.0
python-dotenv>=1.2.1
gunicorn>=21.0.0
```

Criar com:
```powershell
pip freeze > requirements.txt
```

---

## 🔐 Variáveis de Ambiente Necessárias

Para qualquer plataforma, configure:

```env
SECRET_KEY=django-insecure-sua-chave-forte-aqui
DEBUG=False
DB_PATH=db.sqlite3
ALLOWED_HOSTS=seu-dominio.com,www.seu-dominio.com
```

---

## 🌐 Domínio Personalizado (Opcional)

### Railway:
- Acesse "Networking"
- Clique em "Add Custom Domain"
- Configure DNS no seu provedor

### Render:
- Acesse "Settings"
- Em "Custom Domains", adicione seu domínio

---

## ✅ Checklist Antes de Deploy

- [ ] `requirements.txt` criado
- [ ] `.env` configurado com `SECRET_KEY` forte
- [ ] `DEBUG=False` em produção
- [ ] `ALLOWED_HOSTS` configurado
- [ ] Banco SQLite funcional localmente
- [ ] Testes passando

---

## 🆘 Troubleshooting

### Erro: "ModuleNotFoundError: No module named 'django'"
- Certifique-se que `requirements.txt` existe
- Verifique o build command

### Erro: "ALLOWED_HOSTS invalid"
- Adicione seu domínio em `settings.py` ou variável de ambiente

### Erro: "SECRET_KEY não configurado"
- Adicione em variáveis de ambiente da plataforma

### Banco de dados não persiste
- SQLite funciona em Railway/Render, mas se reiniciar, dados podem ser perdidos
- Para produção, considere PostgreSQL (grátis no Railway/Render)

---

## 💾 Mudar para PostgreSQL (Recomendado para Produção)

### No Railway/Render:
1. Adicione uma instância PostgreSQL
2. Copie a URL de conexão
3. No `settings.py`, configure:

```python
import dj_database_url

DATABASES = {
    'default': dj_database_url.config(
        default='sqlite:///db.sqlite3',
        conn_max_age=600
    )
}
```

4. Adicione `dj-database-url` em `requirements.txt`

---

## 🚀 Próximos Passos

1. **Escolha a plataforma**: Railway (recomendado)
2. **Crie uma conta**: GitHub + plataforma
3. **Configure variáveis**: SECRET_KEY, DEBUG, etc
4. **Faça um push**: `git push origin main`
5. **Acompanhe o deploy**: Console da plataforma

**Seu app estará online em minutos!** ✨

---

## 📚 Referências

- [Railway Docs](https://docs.railway.app)
- [Render Docs](https://render.com/docs)
- [Django Deployment](https://docs.djangoproject.com/en/stable/howto/deployment/)

