%title: APPRENDRE SALT
%author: xavki


# SALT : Création d'utilisateurs et de groupes


<br>

Documentations :
https://docs.saltproject.io/en/latest/ref/states/all/salt.states.group.html
https://docs.saltproject.io/en/latest/ref/states/all/salt.states.user.html


-----------------------------------------------------------------------------------------------

# SALT : Création d'utilisateurs et de groupes

<br>

MODULE : GROUP

```
sudo salt 'salt4' sys.list_state_modules
sudo salt 'salt4' sys.list_state_functions group
```

```
salt4:
    - group.absent
    - group.present
```

```
sudo salt 'salt4' sys.state_doc group
```

-----------------------------------------------------------------------------------------------

# SALT : Création d'utilisateurs et de groupes

GROUP.PRESENT :

* name (str): nom du groupe
        
* gid (str): créer un GID spécifique
        
* system (bool): créer un groupe de type system
        
* addusers (list): ajouter une liste d'utilisateurs dès la création du groupe
        
* delusers (list): être sûr que des users ne sont pas présents dans ce groupe
        
* members (list): remplacer complètement la liste des utilisateurs du groupe

GROUP.ABSENT :

* name (str): nom du groupe

-----------------------------------------------------------------------------------------------

# SALT : Création d'utilisateurs et de groupes


* simple création du groupe xavki :

```
xavki:
  group.present:
    - gid: 2000
    - addusers:
      - vagrant
```


-----------------------------------------------------------------------------------------------

# SALT : Création d'utilisateurs et de groupes


```
salt4:
    - user.absent
    - user.present
```

USER.ABSENT :

* name: nom de l'utilisateur
        
* purge: supprimer tous les fichiers de l'utilisateurs
        
* force: supprimer un utilisateur avec une session ouverte


-----------------------------------------------------------------------------------------------

# SALT : Création d'utilisateurs et de groupes


<br>

USER.PRESENT

* name: nom de l'utilisateur
        
* uid: UID prédéfini
        
* gid: association à un groupe par le GID ou le nom du groupe
        
* allow_uid_change: permettre la modification de l'UID à salt
        
* allow_gid_change: idem pour le GID
        
* usergroup: permettre la création d'un groupe du même nom
        
* groups (list): ajouter l'utilisateurà des groupes
         si vide, supprime de tous, sauf default
        
* optional_groups: groupes non obligatoires (pas de fail si absent)


-----------------------------------------------------------------------------------------------

# SALT : Création d'utilisateurs et de groupes

<br>

USER.PRESENT

* remove_groups: supprime les groupes dont l'utilisateur est membre
        
* home: définir la home de l'utilisateur (créé par défaut)
        
* createhome (true) : créé la home par défaut si elle n'existe pas
        
* nologinit (false) : n'ajoute pas le user à lastlog et faillog
        
* password : hash du password
        
* hash_password (false): permet de rentrer un password non hashé
        
* enforce_password (true): empêche de changer le mot de passe si il diffère du hash 
        
* empty_password (false): autoriser le sans password
        
* shell: le shell utilisé par défaut par l'utilisateur


-----------------------------------------------------------------------------------------------

# SALT : Création d'utilisateurs et de groupes

<br>

USER.PRESENT

* unique (true): avoir un UID unique
        
* system: utilisation d'un UID system ou non
        
* date: date de dernier changement de password (epoch)
        
* mindays: minimum de jour pour le changement de password
        
* maxdays: maximum de jour pour le changement de password
        
* inactdays: maximum de jour après expériation du password et avant le lock du compte
        
* warndays: nombre de jour pour prévenir avant le maxdays
        
* expire: date d'expiration du compte (en jour depuis epoch (01/01/1970)


-----------------------------------------------------------------------------------------------

# SALT : Création d'utilisateurs et de groupes

<br>

* utilisation du pillar pour stocker nos users (sans boucle pour le moment)

```
mkdir -p /srv/pillar/base/users/

mkpasswd -m sha-512

cat /srv/pillar/base/users/init.sls

users:
  xavki:
    name: xavki
    password: $6$...
    uid: 2000
  xavier:
    name: xavier
    password: $6$...
    uid: 2001
```


----------------------------------------------------------------------

# SALT : Création d'utilisateurs et de groupes

<br>

* création du state

```
mkdir -p /srv/salt/base/users/

cat /srv/salt/base/users/init.sls

Create user xavki:
  user.present:
    - name: {{ pillar['users']['xavki']['name']}}
    - password: {{ pillar['users']['xavki']['password'] }}
    - shell: /bin/bash
    - home: /home/xavki
    - uid: {{ pillar['users']['xavki']['uid'] }}
    - gid: 2000
    - groups:
      - sudo
      - vagrant
```
