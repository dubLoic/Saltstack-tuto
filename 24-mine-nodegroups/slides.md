%title: APPRENDRE SALT
%author: xavki


# SALT : La Mine salt

<br>

Abonnez-vous et soutenez la chaine Xavki !!!

<br>

Limites des grains : la mise à jour et leur mode d'interogation

```
   They are automatically synced when state.highstate is called,
   or (as noted above) the grains can be manually synced and
   reloaded by calling the saltutil.sync_grains
   or saltutil.sync_all functions.
```

```
    When the grains_cache is set to False, the grains dictionary
    is built and stored in memory on the minion. Every time the
    minion restarts or saltutil.refresh_grains is run, the grain
    dictionary is rebuilt from scratch.
```

Mine > données mise à jour périodiquement et collectées par module.function
				* configurable sur les minions
				* donnée d'une target accessible depuis tous les minions			


-------------------------------------------------------------------------------------------------

# SALT : La Mine salt


<br>

* Configuration dans le minion

		/etc/salt/minion

    /etc/salt/minion.conf

-------------------------------------------------------------------------------------------------

# SALT : La Mine salt


<br>

* contenu

```
mine_functions:
  module.function: []
  module.function:
    key: value
```

Note : 
https://docs.saltproject.io/en/latest/ref/modules/all/index.html#execution-modules

-------------------------------------------------------------------------------------------------

# SALT : La Mine salt


<br>

* exemple:

```
mine_interval: 5
mine_functions:
  test.ping: []
  network.ip_addrs:
    interface: enp0s8
    cidr: 192.168.0.0/16
```

```
sudo salt '*' mine.update
sudo salt '*' mine.get '*' test.ping
sudo salt '*' mine.get '*' network.ip_addrs
sudo salt '*' mine.valid
```


-------------------------------------------------------------------------------------------------

# SALT : La Mine salt


<br>

* redéfinir vos propres fonctions ?

```
mine_functions:
  ip_address:
    - mine_function: grains.get
    - ip4_interfaces:enp0s8:0
```

Note:
https://docs.saltproject.io/en/latest/ref/modules/all/salt.modules.mine.html

```
sudo salt '*' mine.update
sudo salt '*' mine.flush
```

-------------------------------------------------------------------------------------------------

# SALT : La Mine salt


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
