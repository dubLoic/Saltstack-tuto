{% from "prometheus/map.jinja" import prometheus with context %}

include:
  - minions_mine

Ensure prometheus installed:
  pkg.installed:
    - pkgs:
      - prometheus
    - cache_valid_time: 3600
    - refresh: True

{% for file in ['prometheus.yml','prometheus'] %}

Set {{ file }} configuration:
  file.managed:
    - name: /etc/prometheus/{{ file }}
    - template: jinja
    - source: salt://prometheus/templates/{{ file }}.j2
    - user: prometheus
    - group: prometheus
    - mode: 755
    - context:
        prometheus: {{ prometheus }}

{% endfor %}

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
