{% from "prometheus/map.jinja" import prometheus with context %} 

Ensure prometheus installed:
  pkg.installed:
    - pkgs:
      - prometheus
    - cache_valid_time: 3600
    - refresh: True

Set prometheus default configuration:
  file.managed:
    - name: /etc/default/prometheus
    - template: jinja
    - source: salt://prometheus/templates/prometheus.j2           
    - user: prometheus
    - group: prometheus
    - mode: 755
    - context:
        prometheus: {{ prometheus }}

Set prometheus.yml configuration:
  file.managed:
    - name: /etc/prometheus/prometheus.yml
    - template: jinja
    - source: salt://prometheus/templates/prometheus.yml.j2           
    - user: prometheus
    - group: prometheus
    - mode: 755
    - context:
        prometheus: {{ prometheus }}

Ensure prometheus started restarted:
  service.running:
    - name: prometheus
    - enable: true
    - restart: true
    - watch:
      - file: Set prometheus default configuration
      - file: Set prometheus.yml configuration
    - require:
      - pkg: Ensure prometheus installed
      - file: Set prometheus default configuration
      - file: Set prometheus.yml configuration
