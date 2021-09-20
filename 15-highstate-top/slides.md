%title: APPRENDRE SALT
%author: xavki


# SALT : HighState et Top.sls


<br>

* vidéo précédente > erreur

	* variables non définies pour toutes les machines

	* si target de ttes les machines = users partout

	* comment définir quels states tournent où ?

=> TOP.SLS


sudo salt 'salt*' state.highstate test=true

----------------------------------------------------------------------------------------------------


# SALT : HighState et Top.sls


<br>

* idem au top.sls des pillars

* intérêt ? jouer salt sans se poser de questions sur 
		qu'est-ce qui tourne où ?
			* idem ansible playbook

/srv/
├── pillar
│   └── base
│       ├── top.sls
│       └── users
│           └── init.sls
└── salt
    └── base
        ├── nginx
        │   ├── files.sls
        │   ├── init.sls
        │   └── nginx.sls
        └── users
            └── init.sls

file_roots:
  base:
    - /srv/salt/base
pillar_roots:
  base:
    - /srv/pillar/base


----------------------------------------------------------------------------------------------------


# SALT : HighState et Top.sls

<br>

* édition du fichier top.sls

```
base:
  'salt[1-2]':
    - base.nginx
  'salt[3-4]':
    - base.users
```

----------------------------------------------------------------------------------------------------


# SALT : HighState et Top.sls

<br>

* adaptation de la configuration du master

```
file_roots:
  base:
    - /srv/salt/base
```

Rq : modifier les répertoires existants

 
----------------------------------------------------------------------------------------------------


# SALT : HighState et Top.sls

<br>

* adaptation des init de states

```
include:
  - nginx.nginx
  - nginx.files
```

* idem adaptation des pillars (top.sls)

----------------------------------------------------------------------------------------------------


# SALT : HighState et Top.sls

<br>

* vérification de l'interprétation par salt

```
sudo salt '*' state.show_top
```

* et dans le détail

```
sudo salt '*' state.show_highstate
```
