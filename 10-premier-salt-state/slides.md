%title: APPRENDRE SALT
%author: xavki


# SALT : Premier SaLt State


<br>

Salt :

		* grains : facts d'une machine (variables génériques spécifiques)

		* pillars : variables non génériques dédiées à un contexte

		* state : actions dédiées à un but cohérent (application, système...)

		* formule : pillars + states avec un but cohérent d'ensemble

----------------------------------------------------------------------------------------

# SALT : Premier SaLt State

<br>

* SLS = SaLt State file
		* format yaml

* attention : 
		* modules et fonctions spécifiques

```
sudo salt 'salt3' sys.list_state_modules
sudo salt 'salt3' sys.list_state_functions pkg
```

<br>

* se joue de haut en bas

<br>

* file_roots : localisation des fichiers SLS

----------------------------------------------------------------------------------------

# SALT : Premier SaLt State

<br>

* configuration du file_roots 
		* /etc/salt/master
		* /etc/salt/master.d/file-roots.conf

```
file_roots:
  base:
    - /srv/salt/base
    ...
```

Notes: 
		* restart du master
		* base = environement par défaut

----------------------------------------------------------------------------------------

# SALT : Premier SaLt State

<br>

* déclaration d'un state : /srv/salt/base/mystate.sls

<br>

```
id_state:
	module.fonction:
		paramètre1
		paramètre2:
			- a
			- b
			- c
```

----------------------------------------------------------------------------------------

# SALT : Premier SaLt State

<br>

* exemple installation de nginx

```
installation nginx:
  pkg.installed:
    - name:
      - nginx
```

----------------------------------------------------------------------------------------

# SALT : Premier SaLt State

<br>

* jouer le state

```
sudo salt '*' state.show_sls mystate
sudo salt '*' state.sls mystate test=true
sudo salt '*' state.sls mystate
```

