

Install haproxy:
  pkg.installed:
    - name: haproxy
    - cache_valid_time: 3600
    - refresh: true

Edit template:
  file.managed:
    - name: /tmp/mycfg.cfg
    - contents: |
        xavki2

Ensure haproxy running:
  service.unmasked:
    - name: haproxy
