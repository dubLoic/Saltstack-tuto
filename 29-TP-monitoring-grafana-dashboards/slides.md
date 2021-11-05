%title: APPRENDRE SALT
%author: xavki


# SALT : TP - Monitoring : prometheus stack

<br>

Abonnez-vous et soutenez la chaine Xavki !!!

<br>

Objectif :

		* node-exporter

		* prometheus

		* grafana

    * grafana dashboards

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
        │   ├── dashboards.sls
        │   ├── files
        │   ├── init.sls
        │   ├── install.sls
        │   ├── map.jinja
        │   └── templates
        │       └── dashboard.yml.j2
...
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack

<br>

* éclaircir le code 

```
include:
  - grafana.install
  - grafana.dashboards
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack

<br>

* ajout d'une liste de dashboards dans le map.jinja

```
{% set grafana_dashboards = salt.pillar.get('grafana_dashboard',{
  "node-exporter": "https://raw.githubusercontent.com/rfrail3/grafana-dashboards/master/prometheus/node-exporter-full.json",
  "node-exporter-2": "https://raw.githubusercontent.com/rfrail3/grafana-dashboards/master/prometheus/node-exporter-full.json"
},merge = True) %}
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack

<br>

* importation du nouveau dictionnaire de dashboards

```
{% from "grafana/map.jinja" import grafana_dashboards with context %}
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack

<br>

* la boucle des dashboards - download

```
{% for dashboard, source in grafana_dashboards.items() %}
Import {{ dashboard }} dashboard:
  file.managed:
    - source: {{ source }}
    - skip_verify: true
    - name: /var/lib/grafana/{{ dashboard }}.json
    - mode: 755
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack

<br>

* la boucle des dashboards - installation

```
Install {{ dashboard }} dashboard:
  file.managed:
    - name: /etc/grafana/provisioning/dashboards/dashboard-{{ dashboard }}.yml
    - template: jinja
    - source: salt://grafana/templates/dashboard.yml.j2
    - user: grafana
    - group: grafana
    - mode: 755
    - context:
        dashboard: {{ dashboard }}
{% endfor %}
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack

<br>

* prévoir le restart de grafana en intégrant la boucle

```
Ensure grafana restarted:
  service.running:
    - name: grafana-server
    - enable: true
    - restart: true
    - watch:
{% for dashboard, source in grafana_dashboards.items() %}
      - file: Import {{ dashboard }} dashboard
      - file: Install {{ dashboard }} dashboard
{% endfor %}
```

