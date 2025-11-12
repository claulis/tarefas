# 🚀 Deploy Render - SQLite

Seu projeto Django está **100% configurado** para deploy no Render usando SQLite!

## ⚡ Quick Start (5 minutos)

### 1️⃣ Preparar GitHub
```bash
git add .
git commit -m "Config Render SQLite"
git push origin main
```

### 2️⃣ Deploy no Render
- Acesse: https://render.com
- Nova Web Service
- Conecte seu repositório GitHub (claulis/tarefas)
- Render fará tudo automaticamente!

### 3️⃣ Acessar Aplicação
```
https://seu-app-name.onrender.com
```

## 📋 Checklist Pré-Deploy

- ✅ SECRET_KEY configurada (Render gera automaticamente)
- ✅ DEBUG=False em produção
- ✅ SQLite com persistência de dados
- ✅ Migrations automáticas
- ✅ Static files comprimidos
- ✅ HTTPS automático
- ✅ Health checks ativados

## 🔧 Configuração Render

### Variáveis de Ambiente (Render define automaticamente)
```
SECRET_KEY      = auto-gerado
DEBUG           = False
ALLOWED_HOSTS   = *.onrender.com
PYTHON_VERSION  = 3.13
DB_PATH         = /var/data/db.sqlite3
```

### Disco Persistente
- **Localização**: `/var/data/`
- **Tamanho**: 1 GB
- **Função**: Armazenar SQLite (db.sqlite3)

## ⚠️ Importante: Free Tier Render

### Limitações
- App dorme após 15 min sem requisições
- Redeploy se inativo > 30 dias
- 0.5 GB RAM
- 1 vCPU compartilhada

### Manter Ativo
Use uptimeRobot (grátis):
1. https://uptimerobot.com
2. Criar monitor HTTP
3. URL: `https://seu-app.onrender.com/admin/`
4. Check a cada 5 min

## 🐛 Troubleshooting

### SQLite não persiste dados?
- Verificar se `DB_PATH=/var/data/db.sqlite3`
- Confirmar disco persistente criado

### Erro 500?
- Logs: Dashboard Render → Logs
- Debug local: `DEBUG=True` temporariamente

### Migrations não rodaram?
- Render executa no buildCommand automaticamente
- Se falhar, verificar logs

## 📊 Monitoramento

No dashboard Render:
- **Events**: Histórico de deploys
- **Logs**: Tempo real da aplicação
- **Metrics**: CPU, RAM, Requests
- **Health**: Status do health check

## 🔄 Redeploy

Qualquer push para `main` dispara redeploy:
```bash
git add .
git commit -m "Nova feature"
git push origin main  # Redeploy automático!
```

## 💾 Backup SQLite

SQLite é local ao container. Para backup:
```bash
# Via SSH Render
sqlite3 /var/data/db.sqlite3 ".dump" > backup.sql
```

---

**Próximo passo?** Faça push para GitHub e crie seu Web Service no Render! 🎉
