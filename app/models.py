from django.db import models

# Create your models here.

class Wheel(models.Model):
    img = models.CharField(max_length=300)
    class Meta:
        db_table = 'sf_wheel'
