from django.shortcuts import render, redirect, get_object_or_404
from django.views.decorators.http import require_POST
from django.utils import timezone
from .models import Tarefa

def lista_tarefas(request):
    if request.method == 'POST':
        titulo = request.POST.get('titulo')
        prazo_str = request.POST.get('prazo')
        prazo = None
        if prazo_str:
            from datetime import datetime
            prazo = datetime.strptime(prazo_str, '%Y-%m-%d').date()
        if titulo:
            Tarefa.objects.create(titulo=titulo, prazo=prazo)
        return redirect('lista_tarefas')

    tarefas = Tarefa.objects.all()
    return render(request, 'tarefas_app/lista_tarefas.html', {
        'tarefas': tarefas,
        'hoje': timezone.now().date(),
    })

@require_POST
def toggle_concluida(request, pk):
    tarefa = get_object_or_404(Tarefa, pk=pk)
    tarefa.concluida = not tarefa.concluida
    tarefa.save()
    return redirect(request.POST.get('next', 'lista_tarefas'))

@require_POST
def deletar_tarefa(request, pk):
    tarefa = get_object_or_404(Tarefa, pk=pk)
    tarefa.delete()
    return redirect('lista_tarefas')