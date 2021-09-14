%title: APPRENDRE SALT
%author: xavki


# SALT : HighState et Top.sls


<br>

* vidéo précédente > erreur

	* variables non définies pour toutes les machines

	* si target de ttes les machines = users partout

	* comment définir quels states tournent où ?

=> TOP.SLS


----------------------------------------------------------------------------------------------------


# SALT : HighState et Top.sls


<br>

* idem au top.sls des pillars

* intérêt ? jouer salt sans se posser de question sur quoi tourne où ?
			* idem ansible playbook

* édition du fichier top.sls

```
base:
  'salt[1-2]':
    - base.nginx
  'salt[3-4]':
    - base.users
```

* adaptation de la configuration du master

```
file_roots:
  base:
    - /srv/salt/
```

* adaptation des init

```
include:
  - base.nginx.nginx
  - base.nginx.files
```

* vérification de l'interprétation par salt

```
sudo salt '*' state.show_top
```

* et dans le détail

```
sudo salt '*' state.show_highstate
```
