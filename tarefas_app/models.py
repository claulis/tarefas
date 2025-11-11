from django.db import models
from django.utils import timezone

class Tarefa(models.Model):
    titulo = models.CharField("Título", max_length=200)
    descricao = models.TextField("Descrição", blank=True, null=True)
    prazo = models.DateField("Prazo", null=True, blank=True)
    concluida = models.BooleanField("Concluída", default=False)
    data_criacao = models.DateTimeField("Criada em", auto_now_add=True)

    def prazo_vencido(self):
        if self.prazo and not self.concluida:
            return self.prazo < timezone.now().date()
        return False

    def __str__(self):
        return self.titulo

    class Meta:
        ordering = ['prazo', '-data_criacao']
        verbose_name = "Tarefa"
        verbose_name_plural = "Tarefas"