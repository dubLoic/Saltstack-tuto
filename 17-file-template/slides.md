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

---------------------------------------------------------------------------

# SALT : States File - Template - part 2


<br>

List user in file:
  file.managed:
    - name: /tmp/users.txt
    - contents: |
        test

<br>

List user in file:
  file.managed:
    - name: /tmp/users.txt
    - source: salt://users/test.txt

<br>

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

<br>

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

<br>

```
{% for user_name,user_specs in users.items() %}
{{ user_name}}
Specs:
{%   for spec_key,spec_value in user_specs.items() %}
{{ spec_key }} >> {{ spec_value }}
{%   endfor %}
{% endfor %}
```
