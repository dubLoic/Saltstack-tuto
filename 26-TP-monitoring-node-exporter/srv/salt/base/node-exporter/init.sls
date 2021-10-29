{% from "node-exporter/map.jinja" import node_exporter with context %}

Add node exporter user:
  user.present:
    - name: {{ node_exporter.binary_user_group }}
    - createhome: false
    - nologinit: true
    - shell: /usr/sbin/nologin
    - system: true

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

Ensure node exporter started:
  service.running:
    - name: node-exporter
    - enable: true
    - reload: true
    - watch:
      - file: Install node exporter systemd service
    - require:
      - archive: Download install node exporter
      - user: Add node exporter user

