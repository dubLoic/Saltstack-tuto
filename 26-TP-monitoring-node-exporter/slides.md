%title: APPRENDRE SALT
%author: xavki


# SALT : TP - Monitoring : prometheus stack

<br>

Abonnez-vous et soutenez la chaine Xavki !!!

<br>

Objectif :

		* node-exporter ¤

		* prometheus

		* grafana

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack


<br>

* source :

https://github.com/prometheus/node_exporter/releases

<br>

* création de la structure

```
├── pillar
│   └── base
└── salt
    └── base
        ├── node-exporter
        │   ├── init.sls
        │   ├── map.jinja
        │   └── templates
        │       └── node-exporter.service.j2
        └── top.sls
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack


<br>

* le top.sls

```
base:
  '*':
    - node-exporter
```

<br>

* le map.jinja pour définir nos variables par défaut

```
{% set node_exporter = {
  'binary_directory': '/usr/local/bin',
  'binary_version': '1.2.2',
  'binary_user_group': 'node-exporter'
} %}
```




