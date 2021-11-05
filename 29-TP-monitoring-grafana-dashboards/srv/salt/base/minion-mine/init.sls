Set mine on minion:
  file.managed:
    - name: /etc/salt/minion.d/mine.conf
    - contents: |
        mine_interval: 60
        mine_functions:
          ip_address:
            - mine_function: grains.get
            - 'ip4_interfaces:enp0s8:0'

Restart minion:
  module.run:
    - name: cmd.run_bg
    - cmd: 'salt-call --local service.restart salt-minion'       
    - onchanges:
      - file: Set mine on minion

