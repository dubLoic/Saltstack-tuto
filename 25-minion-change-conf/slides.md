%title: APPRENDRE SALT
%author: xavki


# SALT : Reconfiguration des Minions via Salt

<br>

Abonnez-vous et soutenez la chaine Xavki !!!

<br>

* Déploiement sur tous les minions d'une conf ?

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

-------------------------------------------------------------------------------------------------

# SALT : Reconfiguration des Minions via Salt


<br>

```
Restart minion:
  module.run:
    - name: cmd.run_bg
    - cmd: 'salt-call --local service.restart salt-minion'
    - onchanges:
      - file: Set mine on minion
```

-------------------------------------------------------------------------------------------------

# SALT : Reconfiguration des Minions via Salt


<br>

* Exemple édition d'un fichier sur une machine ?

```
Edit file:
  file.managed:
    - name: /tmp/xavki.txt
    - contents: |
        {%- for ip in salt['mine.get'](tgt='nodeexporter',tgt_type='nodegroup',fun='ip_address').values() %}
          {{ ip }}
        {%- endfor %}
```
