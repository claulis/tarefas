#!/bin/bash
# 🚀 SCRIPT DE DEPLOY - Render + SQLite
# Execute os comandos abaixo em sequência

echo "=========================================="
echo "🎯 RENDER DEPLOY - SQLite"
echo "=========================================="
echo ""

# 1. VERIFICAR PROJETO LOCAL
echo "📋 Passo 1: Verificando projeto..."
echo "Executando: python manage.py check"
python manage.py check
if [ $? -ne 0 ]; then
    echo "❌ Erro no Django check!"
    exit 1
fi
echo "✅ Django OK"
echo ""

# 2. MIGRATIONS
echo "🗄️  Passo 2: Migrations..."
echo "Executando: python manage.py migrate --plan"
python manage.py migrate --plan
if [ $? -ne 0 ]; then
    echo "❌ Erro no migrations!"
    exit 1
fi
echo "✅ Migrations OK"
echo ""

# 3. STATIC FILES
echo "📁 Passo 3: Static files..."
echo "Executando: python manage.py collectstatic --noinput"
python manage.py collectstatic --noinput --clear
if [ $? -ne 0 ]; then
    echo "❌ Erro no collectstatic!"
    exit 1
fi
echo "✅ Static files OK"
echo ""

# 4. GIT PREPARE
echo "📤 Passo 4: Git preparado..."
echo "Status atual:"
git status
echo ""
echo "Adicionar tudo? (s/n)"
read response
if [ "$response" = "s" ]; then
    git add .
    echo "✅ Arquivos adicionados"
else
    echo "Abortado"
    exit 1
fi
echo ""

# 5. COMMIT
echo "💬 Passo 5: Commit..."
echo "Mensagem padrão: 'Deploy Render SQLite ready'"
echo "Usar esta mensagem? (s/n)"
read response
if [ "$response" = "s" ]; then
    git commit -m "Deploy Render SQLite ready"
else
    echo "Digite a mensagem:"
    read msg
    git commit -m "$msg"
fi
echo "✅ Commit OK"
echo ""

# 6. PUSH
echo "🚀 Passo 6: Push para GitHub..."
echo "Branch: main"
git push origin main
if [ $? -ne 0 ]; then
    echo "❌ Erro no push!"
    exit 1
fi
echo "✅ Push OK"
echo ""

# 7. RESUMO
echo "=========================================="
echo "✨ DEPLOY PREPARADO!"
echo "=========================================="
echo ""
echo "📋 Próximos passos:"
echo "  1. Acesse: https://render.com"
echo "  2. Dashboard → New Web Service"
echo "  3. Conecte: claulis/tarefas"
echo "  4. Render faz build automático (~3 min)"
echo "  5. Acesse: https://seu-app-name.onrender.com"
echo ""
echo "📚 Documentação:"
echo "  • START_HERE.md - Comece aqui!"
echo "  • RENDER_SQLITE.md - Quick start"
echo "  • GUIA_RENDER.md - Detalhes"
echo "  • DEPLOY_CHECKLIST.md - Checklist"
echo ""
echo "=========================================="
