%title: APPRENDRE SALT
%author: xavki


# SALT : States File - Template - part 2

<br>

Abonnez-vous et soutenez la chaine Xavki !!!

<br>


Objectifs ?

	* créer des fichiers

	* supprimer des fichiers

	* changer le contenu

	* gestion des liens symboliques

	* utilisation de templates

Templates + Variables (pillars, grains ou autres) = Fichier final

---------------------------------------------------------------------------

# SALT : States File - Template - part 2


<br>

* première utilisation de file.managed

```
List user in file:
  file.managed:
    - name: /tmp/users.txt
    - contents: |
        test
```


---------------------------------------------------------------------------

# SALT : States File - Template - part 2



<br>

* utilisation d'un fichier source et copie sur la machine distante

```
List user in file:
  file.managed:
    - name: /tmp/users.txt
    - source: salt://users/test.txt
```

---------------------------------------------------------------------------

# SALT : States File - Template - part 2


<br>

* utilisation d'un format template avec une valeur par défaut

```
List user in file:
  file.managed:
    - name: /tmp/users.txt
    - source: salt://users/templates/users.txt.j2
    - template: jinja
    - defaults:
        users:
          xavki:
            password: mypassword
```

---------------------------------------------------------------------------

# SALT : States File - Template - part 2


<br>

* utilisation d'un pillar dans le contexte

```
List user in file:
  file.managed:
    - name: /tmp/users.txt
    - source: salt://users/templates/users.txt.j2
    - template: jinja
    - defaults:
        users:
          xavki:
            password: mypassword
    - context:
        users: {{ pillar['users'] }}
```

---------------------------------------------------------------------------

# SALT : States File - Template - part 2


<br>

* contenu du fichier de template

```
{% for user_name,user_specs in users.items() %}
{{ user_name}}
Specs:
{%   for spec_key,spec_value in user_specs.items() %}
{{ spec_key }} >> {{ spec_value }}
{%   endfor %}
{% endfor %}
```
