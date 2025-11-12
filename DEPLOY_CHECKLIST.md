# 🚀 Checklist de Deploy - Tarefas Django

## ✅ Antes de Deploy

- [ ] Código testado localmente com `python manage.py runserver`
- [ ] Testes passando: `python manage.py test`
- [ ] `requirements.txt` atualizado: `pip freeze > requirements.txt`
- [ ] SECRET_KEY alterada (não usar valor padrão)
- [ ] DEBUG=False em produção
- [ ] ALLOWED_HOSTS configurado com seu domínio

## 📋 Banco de Dados

- [ ] Migrações criadas: `python manage.py makemigrations`
- [ ] Migrações testadas localmente: `python manage.py migrate`
- [ ] Backup do `db.sqlite3` (se houver dados importantes)

## 🔐 Segurança

- [ ] SECRET_KEY não está em `.env` do repositório
- [ ] Nenhuma senha/API key em hardcode
- [ ] `.gitignore` contém `.env`
- [ ] `ALLOWED_HOSTS` definido corretamente

## 📦 Docker (se usar)

- [ ] `Dockerfile` testado localmente
- [ ] Imagem build sem erros
- [ ] Container roda corretamente

## 🌐 Plataforma - Railway

- [ ] Conta Railway criada (https://railway.app)
- [ ] Repositório GitHub conectado
- [ ] Variáveis de ambiente configuradas:
  - [ ] `SECRET_KEY`
  - [ ] `DEBUG=False`
  - [ ] `ALLOWED_HOSTS`
- [ ] Build command configurado
- [ ] Start command: `gunicorn config.wsgi`
- [ ] Domínio configurado (opcional)

## 🌐 Plataforma - Render

- [ ] Conta Render criada (https://render.com)
- [ ] Repositório GitHub conectado
- [ ] Web Service configurado como Python
- [ ] Variáveis de ambiente configuradas
- [ ] Build command correto
- [ ] Start command correto
- [ ] Esperado primeira compilação: ~5 minutos

## 📊 Arquivo Estáticos

- [ ] `STATIC_URL = '/static/'` em settings.py
- [ ] `STATIC_ROOT` configurado
- [ ] `WhiteNoiseMiddleware` no MIDDLEWARE
- [ ] `collectstatic` rodado sem erros

## 🧪 Pós-Deploy

- [ ] Acessar URL do app em browser
- [ ] Verificar se estático (CSS, etc) carrega
- [ ] Testar formulário de nova tarefa
- [ ] Verificar logs de erro
- [ ] Admin acessível em `/admin/`

## 🔧 Troubleshooting

### Se o app não inicia

```bash
# Ver logs
heroku logs --tail  # ou no painel da plataforma

# Verificar variáveis
railway env  # ou no painel Render
```

### Se estáticos não carregam

```bash
python manage.py collectstatic --noinput
python manage.py collectstatic --noinput --clear
```

### Se banner não aparece

- Verificar `ALLOWED_HOSTS`
- Verificar `DEBUG=False`
- Limpar cache do navegador

### Erro: "ModuleNotFoundError"

- Verificar `requirements.txt`
- Rerodar `pip freeze > requirements.txt`

## 📝 Documentação

- [Django Deployment](https://docs.djangoproject.com/en/stable/howto/deployment/)
- [Railway Docs](https://docs.railway.app)
- [Render Docs](https://render.com/docs)
- [Gunicorn Settings](https://docs.gunicorn.org/en/latest/settings.html)

## 🎯 Deploy Final

```bash
# 1. Commitar mudanças
git add .
git commit -m "Preparar para deploy"

# 2. Push para GitHub
git push origin main

# 3. Monitorar CI/CD
# - GitHub Actions rodará build/test
# - Railway/Render fará deploy automático

# 4. Verificar em produção
# https://seu-app-name.railway.app
```

---

**✨ Seu app está online! Compartilhe com seus amigos! 🎉**
