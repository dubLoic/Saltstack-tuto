%title: APPRENDRE SALT
%author: xavki


# SALT : Regroupement - les nodegroups

<br>

Abonnez-vous et soutenez la chaine Xavki !!!

<br>

* Rappelons nous

```
sudo salt -G 'oscodename:focal' grains.item oscodename
```

-----------------------------------------------------------------

# SALT : Regroupement - les nodegroups

<br>

* Notion de groupe par les grains

```
cat /etc/salt/minion.d/grains.conf
grains:
  group: 'group1'
```

```
base:
  'group:group1':
    - match: grain
    - mybinary
```

Note : l'info est remonté par les minions

-----------------------------------------------------------------

# SALT : Regroupement - les nodegroups

<br>

* Utilisons plutôt les nodegroups

```
cat /etc/salt/master.d/nodegroups.conf 
nodegroups:
  groupA: 'salt[3-4]'
```

```
base:
  groupA:
    - match: nodegroup
    - mybinary
```

-----------------------------------------------------------------

# SALT : Regroupement - les nodegroups

<br>

* plus généralement le targeting nodegroup

```
salt -N group1 test.version
```
