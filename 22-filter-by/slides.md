%title: APPRENDRE SALT
%author: xavki


# SALT : Salt Cmd & Filter-By

<br>

Abonnez-vous et soutenez la chaine Xavki !!!

<br>

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

Documentation :
https://docs.saltproject.io/en/latest/ref/modules/all/salt.modules.grains.html

---------------------------------------------------------------------

# SALT : Filter-By

<br>

* Filter simple ?

```
{% set apache = salt['grains.filter_by']({
    'Debian': {'service': 'apache2'},
    'RedHat': {'service': 'httpd'}
}) %}
Edit debug file:
  file.managed:
    - name: /tmp/xavki.conf
    - contents: |
        {{ apache.service }}
```

---------------------------------------------------------------------

# SALT : Filter-By

<br>

* Définir le grain à utiliser ?

```
cat /etc/salt/minion.d/grains.conf 
grains:
  group: "group1"
  env: "production"
```

```
{% set apache = salt['grains.filter_by']({
    'group1': {'service': 'apache2'},
    'group2': {'service': 'httpd'}
},
grain="group") %}
%}
```

Rq: si pas de grain group définit ??

---------------------------------------------------------------------

# SALT : Filter-By

<br>

* Définir la valeur par défaut ?

```
{% set apache = salt['grains.filter_by']({
    'group2': {'service': 'apache2'},
    'group1': {'service': 'httpd'}
},
grain="group",
default="group2") %}
```

---------------------------------------------------------------------

# SALT : Filter-By

<br>

* Mais on peut utiliser une autre fonction ?

```
{% set myget = salt['grains.get']('oscodename',
default="mydefault",
delimiter=","
)
%}
```

```
sudo salt "salt1" grains.get oscodename

{% set myget = salt['cmd.run']('uptime') %}
```
