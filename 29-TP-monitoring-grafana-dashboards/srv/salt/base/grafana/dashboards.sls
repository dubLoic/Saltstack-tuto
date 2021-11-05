{% from "grafana/map.jinja" import grafana_dashboards with context %}

{% for dashboard, source in grafana_dashboards.items() %}
Import {{ dashboard }} dashboard:
  file.managed:
    - source: {{ source }}
    - skip_verify: true
    - name: /var/lib/grafana/{{ dashboard }}.json
    - mode: 755

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
