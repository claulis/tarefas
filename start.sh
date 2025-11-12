#!/usr/bin/env bash
set -e

# start.sh - detecta automaticamente o módulo WSGI correto e inicia o Gunicorn
# Tentativas:
# 1) config.wsgi:application
# 2) tarefas.tarefas.wsgi:application

echo "[start.sh] Detectando módulo WSGI..."

python - <<'PY'
import importlib, sys
candidates = ["config", "tarefas"]
found = None
for c in candidates:
    try:
        importlib.import_module(c)
        found = c
        break
    except Exception:
        pass
if found is None:
    print("ERR: Não foi possível importar 'config' nem 'tarefas' — verifique estrutura do projeto e PYTHONPATH.")
    sys.exit(2)
print(found)
PY

WSGI_MODULE=$(python - <<'PY'
import importlib
candidates = [("config", "config.wsgi:application"), ("tarefas", "tarefas.tarefas.wsgi:application")]
for pkg, module in candidates:
    try:
        importlib.import_module(pkg)
        print(module)
        break
    except Exception:
        continue
PY
)

if [ -z "$WSGI_MODULE" ]; then
  echo "ERRO: Não foi possível determinar WSGI_MODULE"
  exit 2
fi

echo "[start.sh] Usando WSGI_MODULE=$WSGI_MODULE"

# Opcional: ler PORT do ambiente, default 8000
PORT=${PORT:-8000}

CMD=(gunicorn "$WSGI_MODULE" --bind 0.0.0.0:${PORT} --workers 4 --worker-class sync --max-requests 1000 --timeout 60 --access-logfile - --error-logfile -)

echo "[start.sh] Executando: ${CMD[@]}"
exec "${CMD[@]}"
