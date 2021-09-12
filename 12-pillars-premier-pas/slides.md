%title: APPRENDRE SALT
%author: xavki


# SALT : Pillars


<br>

Salt :

		* grains : facts d'une machine (variables génériques spécifiques)

		* pillars : variables non génériques dédiées à un contexte

		* state : actions dédiées à un but cohérent (application, système...)

		* formule : pillars + states avec un but cohérent d'ensemble

------------------------------------------------------------------

# SALT : Pillars

<br>

* variables spécifiques à une ou des machines

* définition et configuraiton de modules d'exécution de minions

* données sensibles : les données sont fournies uniquement aux minions targetés

* données arbitraires : des donénes communes à des groupes etc


------------------------------------------------------------------

# SALT : Pillars

<br>

* configuration de la localisation de l'arborescence des pillars


sur le master

```
sudo vim /etc/salt/master
```

et restart du master

```
sudo systemctl restart salt-master
```

------------------------------------------------------------------

# SALT : Pillars

<br>

* création du répertoire d'environnement (base par défaut)

```
sudo mkdir -p /srv/pillar/base
```

Rq : doit correspondre aux répertoires des states

<br>

* création du fichier top.sls

```
cat /srv/pillar/top.sls 
base:
  'salt4':
  - mypillar
```

Rq: patterns utilisables (simple, composé...)

------------------------------------------------------------------

# SALT : Pillars

<br>

* premier pillar

```
sudo mkidr -p /srv/pillar/mypillar/

cat /srv/pillar/mypillar/init.sls 
mypillar:
  myvar: "je suis salt4 !!"
```

Rq: par convention la première clef est du nom du pillar

<br>

* refresh des pillars

```
sudo salt '*' saltutil.refresh_pillar
```

------------------------------------------------------------------

# SALT : Pillars


<br>

* utilisation d'un pillar

```
mkdir -p /srv/salt/base/mypillar/

cat base/mypillar/init.sls 
Add line toto.txt:
   file.managed:
    - name: /tmp/toto.txt
    - contents:
      - {{ pillar["mypillar"]["myvar"] }}
```
