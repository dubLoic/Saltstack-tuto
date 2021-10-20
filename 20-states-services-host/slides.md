%title: APPRENDRE SALT
%author: xavki


# SALT : States Service & Host

<br>

Abonnez-vous et soutenez la chaine Xavki !!!

<br>

Service ?

		* management des services (systemd)

		* stop/start, disable/enable

Host ?

		* gestion du /etc/hosts

-----------------------------------------------------------------------------

# SALT : States Service & Host


<br>

* démarrer un service (ou vérifier)

```
Install haproxy:
  pkg.installed:
    - pkgs:
      - haproxy
    - cache_valid_time: 3600
    - refresh: True
Ensure haproxy running:
  service.running:
    - name: haproxy
```

-----------------------------------------------------------------------------

# SALT : States Service & Host


<br>

* enable au boot et reload

```
Template mycfg:
  file.managed:
    - name: /tmp/my.cfg
    - contents: |
        test2
Ensure haproxy running:
  service.running:
    - name: haproxy
    - enable: true
    - reload: true
    - watch:
      - file: Template mycfg
```

-----------------------------------------------------------------------------

# SALT : States Service & Host


<br>

* stopper un service (y compris avec délai)

```
Ensure haproxy stopped:
  service.dead:
    - name: haproxy
    - enable: false
    - init_delay: 30
```

-----------------------------------------------------------------------------

# SALT : States Service & Host


<br>

* enable/disable uniquement

```
Ensure haproxy enabled:
  service.enabled:
    - name: haproxy
```

-----------------------------------------------------------------------------

# SALT : States Service & Host


<br>

* masked/unmasked service

```
Ensure haproxy stopped:
  service.masked:
    - name: haproxy
```
