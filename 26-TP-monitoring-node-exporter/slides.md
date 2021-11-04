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

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack


<br>

* importation du map.jinja

```
{% from "node-exporter/map.jinja" import node_exporter with context %}
```
<br>

* création de l'utilisateur/groupe

```
Add node exporter user:
  user.present:
    - name: {{ node_exporter.binary_user_group }}
    - createhome: false
    - nologinit: true
    - shell: /usr/sbin/nologin
    - system: true
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack


<br>

* téléchargement et décompression de l'archive

```
Download install node exporter:
  archive.extracted:
    - source: https://github.com/prometheus/node_exporter/releases/download/v{{ node_exporter.binary_version }}/node_exporter-{{ node_exporter.binary_version }}.linux-amd64.tar.gz
    - name: /tmp/
    - archive_format: tar
    - keep_source: false
    - source_hash: https://github.com/prometheus/node_exporter/releases/download/v{{ node_exporter.binary_version }}/sha256sums.txt
    - source_hash_name: node_exporter-{{ node_exporter.binary_version }}.linux-amd64.tar.gz
    - onlyif: 
      - test $(/usr/local/bin/node-exporter --version 2>&1 | head -1 | awk '{print $3}') != "{{ node_exporter.binary_version }}"
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack


<br>

* déplacement du binaire dans le répertoire cible

```
Move node exporter binary:
  file.copy:
    - source: /tmp/node_exporter-{{ node_exporter.binary_version }}.linux-amd64/node_exporter
    - name: {{ node_exporter.binary_directory }}/node-exporter
    - user: {{ node_exporter.binary_user_group }}
    - group: {{ node_exporter.binary_user_group }}
    - mode: 755
    - force: True
    - require:
      - archive: Download install node exporter
      - user: Add node exporter user
    - onlyif: 
      - test $(/usr/local/bin/node-exporter --version 2>&1 | head -1 | awk '{print $3}') != "{{ node_exporter.binary_version }}"
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack


<br>

* installation du service systemd

```
Install node exporter systemd service:
  file.managed:
    - name: /etc/systemd/system/node-exporter.service
    - template: jinja
    - source: salt://node-exporter/templates/node-exporter.service.j2
    - user: root
    - group: root
    - mode: 755
    - context:
        node_exporter: {{ node_exporter }}
```

---------------------------------------------------------------

# SALT : TP - Monitoring : prometheus stack


<br>

* démarrer le service systemd ou redémarrer

```
Ensure node exporter started:
  service.running:
    - name: node-exporter
    - enable: true
    - restart: true
    - watch:
      - file: Install node exporter systemd service
    - require:
      - archive: Download install node exporter
      - user: Add node exporter user
```

