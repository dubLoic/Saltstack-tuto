%title: APPRENDRE SALT
%author: xavki


# SALT : Custom grains & Saltutil


<br>

* éditer /etc/salt/minion

```
grains:
  environment: production
  type: database
  datacenter: DC
```

------------------------------------------------------------------------------------

# SALT : Custom grains & Saltutil


<br>

* rafraichir les grains

```
sudo salt 'salt2' sys.list_functions saltutil
sudo salt 'salt2' saltutil.sync_grains
sudo salt 'salt2' grains.items
```

```
saltutil.pillar_refresh
saltutil.sync_all
```

------------------------------------------------------------------------------------

# SALT : Custom grains & Saltutil

<br>

* ou sinon /etc/salt/grains

```
device: virtual
```

------------------------------------------------------------------------------------

# SALT : Custom grains & Saltutil

<br>

* grains custom via script  `/srv/salt/_grains/mygrain.py`

```
#!/usr/bin/python3
import socket
import logging
log = logging.getLogger(__name__)
def environment():
    hostname = socket.gethostname()
    log.debug("envtypegrain hostname: " + hostname)
    if "salt2" == hostname:
        return {'envtype':'dev'}
    else:
        return {'envtype':'others'}
if __name__ == "__main__":
    print(environment())
```

------------------------------------------------------------------------------------

# SALT : Custom grains & Saltutil


<br>


* restart master et sync pour vérifier

```
sudo salt 'salt2' saltutil.sync_all
sudo salt 'salt2' grains.item envtype
```
