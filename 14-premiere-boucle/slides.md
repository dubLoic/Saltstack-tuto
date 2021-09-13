%title: APPRENDRE SALT
%author: xavki


# SALT : Première boucle for


<br>

* salt > python > jinja

<br>

* pillar = souvent des dictionnaires à parcourir

<br>

Exemple précédent

-------------------------------------------------------------------

# SALT : Première boucle for


<br>

* modification de notre state

```
{% for user_name, user_params in pillar['users'].items() %}
  user.present:
    - name: {{ user_name }}
    - password: {{ user_params.password }}
    - uid: {{ user_params.uid }}
{% endfor %}
```

