# ✅ Checklist Deploy Render + SQLite

## 🔍 Antes de Fazer Push

### Código
- [ ] `python manage.py check` - Verificar erros Django
- [ ] `python manage.py migrate --plan` - Verificar migrações
- [ ] `python manage.py collectstatic --noinput` - Static files OK
- [ ] Testar localmente: `python manage.py runserver`

### Arquivos Essenciais
- [ ] `Procfile` - Correto para `config.wsgi:application`
- [ ] `render.yaml` - Configuração Render presente
- [ ] `Dockerfile` - Image Docker presente
- [ ] `build.sh` - Script build presente
- [ ] `requirements.txt` - Dependências atualizadas
- [ ] `config/settings.py` - SECURE_SSL_REDIRECT=True

### Variáveis Ambiente
- [ ] `.env` local tem SECRET_KEY válida
- [ ] `.env.example` atualizado (sem valores reais)
- [ ] `.env` **NÃO** commitado no git

### Documentação
- [ ] `START_HERE.md` - Entrypoint criado
- [ ] `RENDER_SQLITE.md` - Quick start criado
- [ ] `GUIA_RENDER.md` - Guia completo criado
- [ ] `RENDER_CONFIG.md` - Config resumida criada

---

## 🚀 GitHub Push

```bash
# 1. Verificar status
git status

# 2. Adicionar tudo
git add .

# 3. Commit
git commit -m "Deploy Render SQLite ready"

# 4. Push
git push origin main
```

### Verificar
- [ ] GitHub Actions iniciou (verde ✅)
- [ ] Todos os testes passaram
- [ ] Django check passou

---

## 🌐 Render Setup

### Criar Web Service
- [ ] Acesse: https://render.com
- [ ] Dashboard → New
- [ ] Selecione: Web Service
- [ ] Conecte GitHub: claulis/tarefas
- [ ] Render lê `render.yaml` automaticamente

### Configurações Render
- [ ] Runtime: Python 3.13
- [ ] Build Command: `pip install -r requirements.txt && python manage.py migrate --noinput && python manage.py collectstatic --noinput --clear`
- [ ] Start Command: Vem do `render.yaml`
- [ ] Environment Variables: SECRET_KEY auto-gerada ✅

### Disco Persistente
- [ ] Name: `sqlite_data`
- [ ] Mount path: `/var/data`
- [ ] Size: 1 GB
- [ ] 📌 **CRÍTICO**: Sem isso, dados são perdidos!

---

## ✨ Durante Deploy

### Build (2-3 minutos)
- [ ] Logs mostram: "`pip install -r requirements.txt`" ✅
- [ ] Logs mostram: "`migrate`" ✅
- [ ] Logs mostram: "`collectstatic`" ✅
- [ ] Logs mostram: "`Gunicorn starting`" ✅

### Status
- [ ] Build completado (verde ✅)
- [ ] Container rodando
- [ ] Health check passando

---

## 🧪 Após Deploy

### Testar Aplicação
- [ ] Acessar: `https://seu-app.onrender.com` ✅
- [ ] Página carrega sem erro 500
- [ ] Css/JS carregam (verificar DevTools)
- [ ] Admin funciona: `/admin/`

### Tarefas
- [ ] Adicionar nova tarefa
- [ ] Marcar como concluída
- [ ] Deletar tarefa
- [ ] Recarregar página → dados persistem ✅

### Banco de Dados
- [ ] Dados não desaparecem após refresh
- [ ] Migrações já executadas
- [ ] Sem erros de banco de dados nos logs

---

## 👤 Gerenciar Usuários

### Criar Superuser (via Render Shell)
```bash
# No dashboard Render → seu app → Shell
python manage.py createsuperuser
```

### Acessar Admin
```
https://seu-app.onrender.com/admin/
```

---

## 📊 Monitoração

### Verificar Logs
- [ ] Dashboard Render → Logs
- [ ] Procurar por erros
- [ ] Performance OK?

### Métricas
- [ ] CPU: < 50% (normal no free tier)
- [ ] RAM: < 0.5 GB
- [ ] Requests: Respondendo

### Alertas
- [ ] Health check: PASSING ✅
- [ ] Sem erros 5xx
- [ ] Sem erros 4xx suspeitos

---

## 🔄 Keep-Alive (Opcional)

Para evitar sleep no free tier:

### UptimeRobot (Grátis)
1. https://uptimerobot.com
2. Sign up
3. New Monitor → HTTP(s)
4. URL: `https://seu-app.onrender.com/admin/`
5. Frequency: 5 min
6. Salvar

Pronto! App nunca dorme!

---

## 📈 Próximos Passos

### Curto Prazo
- [ ] Testar todas as features
- [ ] Convidar usuários
- [ ] Monitorar logs
- [ ] Fazer backup SQLite (opcional)

### Médio Prazo
- [ ] Adicionar mais features
- [ ] Otimizar performance
- [ ] Considerar upgrade se necessário

### Longo Prazo
- [ ] Acompanhar crescimento
- [ ] Avaliar custo vs free tier
- [ ] Migrar para banco prod se needed

---

## 🆘 Troubleshooting Rápido

| Problema | Solução |
|----------|---------|
| **Build falha** | Verificar logs, `python manage.py check` local |
| **500 erro** | Verificar logs Render, DEBUG=True temp |
| **Dados perdidos** | Confirmar disco /var/data montado |
| **Muito lento** | Free tier limitado, considerar Starter |
| **App dorme** | Normal free tier, use UptimeRobot |
| **Static files não aparecem** | `python manage.py collectstatic` local |

---

## 📞 Links Úteis

- Render Docs: https://render.com/docs
- Django Docs: https://docs.djangoproject.com
- SQLite Docs: https://www.sqlite.org/docs.html

---

**Status**: ✅ **PRONTO PARA PRODUÇÃO!**

Data: 12/11/2025
App: tarefas (Task Management)
Database: SQLite + Render Disk
Platform: Render.com Free Tier
