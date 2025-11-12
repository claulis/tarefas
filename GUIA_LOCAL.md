# Guia de Uso - SQLite com Django

## ✅ Configuração Completa

Seu projeto agora está configurado para usar **SQLite** localmente. O banco de dados foi criado com sucesso!

### 📋 O que foi feito:

1. **Variáveis de Ambiente (`.env`)**: Configuradas para usar SQLite
2. **Banco de Dados**: Migrações aplicadas com sucesso
3. **Arquivo SQLite**: `db.sqlite3` criado automaticamente na raiz do projeto

---

## 🚀 Como Rodar o Projeto Localmente

### **Opção 1: Usando o Virtual Environment (Recomendado)**

```powershell
# Ativar o virtual environment
.\.venv\Scripts\Activate.ps1

# Rodar o servidor de desenvolvimento
python manage.py runserver
```

### **Opção 2: Sem ativar o virtual environment**

```powershell
.\.venv\Scripts\python.exe manage.py runserver
```

---

## 📱 Acessar a Aplicação

Após rodar o servidor, a aplicação estará disponível em:

- **URL**: [http://localhost:8000/](http://localhost:8000/)
- **Admin Django**: [http://localhost:8000/admin/](http://localhost:8000/admin/)

---

## 🔧 Comandos Úteis do Django

### Criar um super usuário (para acessar o admin)

```powershell
.\.venv\Scripts\python.exe manage.py createsuperuser
```

Depois preencha com:
- **Username**: seu_usuario
- **Email**: seu_email@exemplo.com
- **Password**: sua_senha

### Ver migrações pendentes

```powershell
.\.venv\Scripts\python.exe manage.py showmigrations
```

### Criar nova migração (após alterar models)

```powershell
.\.venv\Scripts\python.exe manage.py makemigrations
.\.venv\Scripts\python.exe manage.py migrate
```

### Shell interativo do Django

```powershell
.\.venv\Scripts\python.exe manage.py shell
```

---

## 📊 Banco de Dados SQLite

- **Local**: `./db.sqlite3` (na raiz do projeto)
- **Nativo**: Nenhuma instalação adicional necessária
- **Backup**: Basta copiar o arquivo `db.sqlite3`

### Visualizar dados do SQLite

Você pode usar ferramentas como:
- **DB Browser for SQLite** (gratuito): https://sqlitebrowser.org/
- **VS Code Extension**: "SQLite" by alexcvzz

---

## ⚠️ Limpeza do Banco de Dados

Para **resetar completamente** o banco de dados:

```powershell
# Apagar o arquivo do banco
Remove-Item db.sqlite3

# Recriar as tabelas
.\.venv\Scripts\python.exe manage.py migrate
```

---

## 📝 Resumo das Mudanças

| Antes (MySQL) | Agora (SQLite) |
|---|---|
| Requer servidor MySQL externo | Arquivo local `db.sqlite3` |
| Dependência: `mysqlclient` | Sem dependências extras (nativo do Python) |
| Configuração complexa | Configuração simples |
| Variáveis: `DB_NAME`, `DB_USER`, etc | Variável: `DB_PATH` |

---

## 🎯 Próximos Passos

1. ✅ Ativar o virtual environment
2. ✅ Rodar `python manage.py runserver`
3. ✅ Acessar http://localhost:8000/
4. ✅ Criar super usuário se precisar
5. ✅ Começar a desenvolver!

**Bom desenvolvimento! 🚀**
