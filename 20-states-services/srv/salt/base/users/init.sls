List user in file:
  file.managed:
    - name: /tmp/users.txt
    - source: salt://users/templates/users.txt.j2
    - template: jinja
    - defaults:
        users:
          xavki:
            uid: 10000
          pierre:
            uid: 5000
    - context:
        users: {{ pillar['users'] }}
