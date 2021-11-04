%title: APPRENDRE SALT
%author: xavki


# SALT : TP - Monitoring : prometheus stack

<br>

Abonnez-vous et soutenez la chaine Xavki !!!

<br>

Objectif :

		* node-exporter

		* prometheus ¤

		* grafana

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack

<br>

* structure cible

```
srv/
├── pillar
│   └── base
└── salt
    └── base
        ├── minions_mine
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

* top.sls cible

```
base:
  '*':
    - minions-mine
    - node-exporter
  'salt1':
    - prometheus
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack


<br>

* création du nodegroup pour node-exporter sur le master

```
cat /etc/salt/master.d/nodegroups.conf
nodegroups:
  node-exporter: 'salt*'
```

```
systemctl restart salt-master
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack


<br>

* mise en place de la mine pour collecter les ip des nodes-exporter

```
Set mine on minion:
  file.managed:
    - name: /etc/salt/minion.d/mine.conf
    - contents: |
        mine_interval: 60
        mine_functions:
          ip_address:
            - mine_function: grains.get
            - 'ip4_interfaces:enp0s8:0'
```


---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack


<br>

* redémarrer le salt minion à distance (sans erreur)

```
Restart minion:
  module.run:
    - name: cmd.run_bg
    - cmd: 'salt-call --local service.restart salt-minion'
    - onchanges:
      - file: Set mine on minion
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack


<br>

* installation de prometheus : map.jinja

```
{% set prometheus = {
  'config_directory': '/etc/prometheus',
  'retention_time': '/usr/local/bin',
  'default_scrape_interval': '30s',
  'config_node_exporter_enabled': true
} %}
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack


<br>

* init.sls : import du map.jinja

```
{% from "prometheus/map.jinja" import prometheus with context %}
```

<br>

* init.sls : inclusion des states minions_mine

```
include:
  - minions-mine
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack


<br>

* init.sls : installation de prometheus

```
Ensure prometheus installed:
  pkg.installed:
    - pkgs:
      - prometheus
    - cache_valid_time: 3600
    - refresh: True
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack


<br>

* ajout des templates (même si faux template pour 1)

cf fichiers joints

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack


<br>

* init.sls : ajout du premier template

```
Set prometheus configuration:
  file.managed:
    - name: /etc/default/prometheus
    - template: jinja
    - source: salt://prometheus/templates/prometheus.j2
    - user: prometheus
    - group: prometheus
    - mode: 755
    - context:
        prometheus: {{ prometheus }}
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack


<br>

* init.sls : ajout du premier template

```
Set prometheus configuration:
  file.managed:
    - name: /etc/default/prometheus
    - template: jinja
    - source: salt://prometheus/templates/prometheus.j2
    - user: prometheus
    - group: prometheus
    - mode: 755
    - context:
        prometheus: {{ prometheus }}

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack


<br>

* init.sls : démarrage ou restart du prometheus

```
Ensure prometheus started restarted:
  service.running:
    - name: prometheus
    - enable: true
    - restart: true
    - watch:
      - file: Set prometheus configuration
    - require:
      - pkg: Ensure prometheus installed
      - file: Set prometheus.yml configuration
      - file: Set prometheus configuration
```

<br>

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack


<br>

