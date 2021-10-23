%title: APPRENDRE SALT
%author: xavki


# SALT : Map Jinja

<br>

Abonnez-vous et soutenez la chaine Xavki !!!

<br>

Quand utiliser les map.jinja ?

		* variables par défaut (discutable)

		* variables typées par grains

		* pas les secrets

		* pas ce qui est spécifique aux machines

		* exemple : versions par défaut, dépôt, directory...


-------------------------------------------------------------------------------

# SALT : Map Jinja


<br>

* comment appeler un map.jinja à partir d'un state ?

```
{% from "node_exporter/map.jinja" import apache with context %}
Test:
  file.managed:
    - name: /tmp/xavki.txt
    - contents: |
        {{ apache.service }}
```

-------------------------------------------------------------------------------

# SALT : Map Jinja


<br>

* créer un map.jinja simple ?

```
{% set apache = {
        'service': 'apache2',
        'conf': '/etc/apache2/apache.conf',
} %}
```

-------------------------------------------------------------------------------

# SALT : Map Jinja

<br>

* Comment le map.jinja peut s'adapter au grain ?

```
{% set apache = salt['grains.filter_by']({
    'Debian': {
        'service': 'apache2',
        'conf': '/etc/apache2/apache.conf',
    },
    'RedHat': {
        'server': 'httpd',
        'service': 'httpd',
        'conf': '/etc/httpd/httpd.conf',
    },
}) %}
```

-------------------------------------------------------------------------------

# SALT : Map Jinja

<br>

* Comment s'en servir pour agréger également les pillars ?

```
{% set apache = salt['grains.filter_by']({
    'Debian': {
        'service': 'apache2',
        'conf': '/etc/apache2/apache.conf',
    },
    'RedHat': {
        'server': 'httpd',
        'service': 'httpd',
        'conf': '/etc/httpd/httpd.conf',
    },
}, merge=salt['pillar.get']('apache:config')) %}
```

-------------------------------------------------------------------------------

# SALT : Map Jinja

<br>

* Avec un pillar :

```
apache:
  config:
    tmpl: salt://apache/files/httpd.conf
```

-------------------------------------------------------------------------------

# SALT : Map Jinja

<br>

* Du coup comment surcharger les variables par défaut avec le pillar ?

```
{% set apache = salt['grains.filter_by']({
    'Debian': {
        'service': 'apache2',
        'conf': '/etc/apache2/apache.conf',
    },
    'RedHat': {
        'server': 'httpd',
        'service': 'httpd',
        'conf': '/etc/httpd/httpd.conf',
    },
}, merge=salt['pillar.get']('apache')) %}
```

-------------------------------------------------------------------------------

# SALT : Map Jinja

<br>

* Du coup comment surcharger les variables par défaut avec le pillar ?

```
apache:
  config:
    tmpl: salt://apache/files/httpd.conf
  service: "mysvc"
```
