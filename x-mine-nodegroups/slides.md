%title: APPRENDRE SALT
%author: xavki


# SALT : Map Jinja

<br>

Abonnez-vous et soutenez la chaine Xavki !!!

<br>

vagrant@salt1:~$ cat /etc/salt/master.d/nodegroups.conf 
nodegroups:
  nodeexporter: 'salt*'



Set mine on minion:
  file.managed:
    - name: /etc/salt/minion.d/mine.conf
    - contents: |
        # Mine settings
        mine_interval: 60
        mine_functions:
          ip_address:
            - mine_function: grains.get
            - 'ip4_interfaces:enp0s8:0'

minion_restart:
  module.run:
    - name: cmd.run_bg
    - cmd: 'salt-call --local service.restart salt-minion'
    - onchanges:
      - file: Set mine on minion

Edit file:
  file.managed:
    - name: /tmp/xavki.txt
    - contents: |
        {%- for server in salt['mine.get'](tgt='nodeexporter',tgt_type='nodegroup',fun='ip_address').values() %}
          {{ server }}
        {%- endfor %}

