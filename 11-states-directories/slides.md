%title: APPRENDRE SALT
%author: xavki


# SALT : State & directories


<br>

Salt :

		* grains : facts d'une machine (variables génériques spécifiques)

		* pillars : variables non génériques dédiées à un contexte

		* state : actions dédiées à un but cohérent (application, système...)

		* formule : pillars + states avec un but cohérent d'ensemble

------------------------------------------------------------------

# SALT : State & directories

<br>

* premier pas : création d'un répertoire

```
vagrant@salt1:/srv/salt/base$ tree
.
└── nginx
    └── init.sls
```

Note :

		* init.sls > point d'entrée (cf ansible main.yml

------------------------------------------------------------------

# SALT : State & directories

<br>

* ajout d'une autre action

```
manage default index:
  file.managed:
    - name: /var/www/html/index.nginx-debian.html
    - contents: |
        Hello Xavki !!
        Bye :)
```

------------------------------------------------------------------

# SALT : State & directories

<br>

* si beaucoup d'actions à réaliser = split en fichiers cohérents

```
vagrant@salt1:/srv/salt/base$ tree
.
└── nginx
    ├── files.sls
    ├── init.sls
    └── nginx.sls
```

------------------------------------------------------------------

# SALT : State & directories

<br>

* fichier init composé d'includes

```
include:
  - nginx.nginx
  - nginx.files
```

