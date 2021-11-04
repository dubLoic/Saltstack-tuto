{% from "grafana/map.jinja" import grafana with context %}
{% from "grafana/map.jinja" import grafana_config with context %}

Add grafana repository:
  pkgrepo.managed:
    - name: {{ grafana_config.grafana_repo_url }}
    - file: /etc/apt/sources.list.d/grafana.list
    - gpgcheck: 1
    - key_url: {{ grafana_config.grafana_repo_key }}
    - refresh_db: true

Ensure grafana installed:
  pkg.installed:
    - pkgs:
      - grafana
    - cache_valid_time: 3600
    - refresh: True
    - require:
      - pkgrepo: Add grafana repository

Ensure grafana started:
  service.running:
    - name: grafana-server
    - enable: true
    - require:
      - pkg: Ensure grafana installed

Wait for grafana:
  http.wait_for_successful_query:
    - name: http://127.0.0.1:3000
    - status:
      - 200
    - status_type: list
    - wait_for: 30

Change default admin password:
  cmd.run:
    - name: grafana-cli admin reset-admin-password {{ grafana.grafana_password }}
    - hide_output: true
    - stateful: true
    - require:
      - pkg: Ensure grafana installed

Ensure prometheus data source is present:
  grafana4_datasource.present:
    - name: prometheus
    - type: prometheus
    - url: http://127.0.0.1:9090
    - is_default: true
    - access: proxy
    - require:
      - cmd: Change default admin password




