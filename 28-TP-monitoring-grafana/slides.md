%title: APPRENDRE SALT
%author: xavki


# SALT : TP - Monitoring : prometheus stack

<br>

Abonnez-vous et soutenez la chaine Xavki !!!

<br>

Objectif :

		* node-exporter

		* prometheus

		* grafana ¤

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack

<br>

```
srv/
├── pillar
│   └── base
│       ├── grafana.sls
│       └── top.sls
└── salt
    └── base
        ├── grafana
        │   ├── files
        │   ├── init.sls
        │   └── map.jinja
        ├── minion-mine
        │   └── init.sls
        ├── node-exporter
        │   ├── init.sls
        │   ├── map.jinja
        │   └── templates
        │       └── node-exporter.service.j2
        ├── prometheus
        │   ├── init.sls
        │   ├── map.jinja
        │   └── templates
        │       ├── prometheus.j2
        │       └── prometheus.yml.j2
        └── top.sls
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack

<br>

* correctif sur prometheus : suppression node-exporter

```
Ensure prometheus-node-exporter stopped:
  service.dead:
    - name: prometheus-node-exporter
    - enable: False
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack

<br>

* init.sls : import des dictionnaires

```
{% from "grafana/map.jinja" import grafana with context %}
{% from "grafana/map.jinja" import grafana_config with context %}
```


---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack

<br>

* init.sls : installation du repo

```
Add grafana repository:
  pkgrepo.managed:
    - name: {{ grafana_config.grafana_repo_url }}
    - file: /etc/apt/sources.list.d/grafana.list
    - gpgcheck: 1
    - key_url: {{ grafana_config.grafana_repo_key }}
    - refresh_db: true
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack

<br>

* init.sls : installation du paquet grafana

```
Ensure grafana installed:
  pkg.installed:
    - pkgs:
      - grafana
    - cache_valid_time: 3600
    - refresh: True
    - require:
      - pkgrepo: Add grafana repository
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack

<br>

* init.sls : start et enable de grafana

```
Ensure grafana started:
  service.running:
    - name: grafana-server
    - enable: true
    - require:
      - pkg: Ensure grafana installed
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack

<br>

* init.sls : attente de grafana up

```
Wait for grafana:
  http.wait_for_successful_query:
    - name: http://127.0.0.1:3000
    - status:
      - 200
    - status_type: list
    - wait_for: 30
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack

<br>

* init.sls : changement du password de l'admin

```
Change default admin password:
  cmd.run:
    - name: grafana-cli admin reset-admin-password {{ grafana.grafana_password }}
    - hide_output: true
    - stateful: true
    - require:
      - pkg: Ensure grafana installed
```



---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack

<br>

* init.sls : ajout d'une datasource

```
Ensure prometheus data source is present:
  grafana4_datasource.present:
    - name: prometheus
    - type: prometheus
    - url: http://127.0.0.1:9090
    - is_default: true
    - access: proxy
    - require:
      - cmd: Change default admin password
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack

<br>

* map.jinja : 2 dictionnaires

```
{% set grafana_config = salt.pillar.get('grafana_config',{
  "grafana_repo_url": "deb https://packages.grafana.com/oss/deb stable main",
  "grafana_repo_key": "https://packages.grafana.com/gpg.key"
},merge = True) %}
{% set grafana = salt['pillar.get']('grafana') %}
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack

<br>

* pillar grafana

```
grafana:
  grafana_url: "http://127.0.0.1:3000"
  grafana_user: admin
  grafana_password: xavki
  grafana_timeout: 5
```
