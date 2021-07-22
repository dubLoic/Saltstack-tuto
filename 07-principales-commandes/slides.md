%title: APPRENDRE SALT
%author: xavki


# SALT : Principales commandes


<br>

SALT-KEY

<br>

	* sur master

<br>

	* management des clefs
			* unaccepted
			* accepted
			* rejected
			* denied

<br>

	* acceptation/suppression des minions

---------------------------------------------------------------------------

# SALT : Principales commandes

<br>

	* génération de clef

<br>

	* vérification du fingerprint 

<br>

	* -l / -L > list clef pour un ou tous les minions

<br>

	* -a / -A > accepte 1 ou tous les minions en pending

<br>

	* -p / -P > affiche une clef publique

<br>

	* -d / -D > supprime une clef ou toutes (attention)

<br>

	* -f / -F > affiche un ou les fingerprint
	
<br>


---------------------------------------------------------------------------

# SALT : Principales commandes

<br>

SALT

<br>

	* test=true : dry run

<br>

	* spéficier une branche git (plus tard)
		saltenv=testingBranch pillarenv=testingBranch

<br>

	* jouer des modules, fonctions

<br>

	* jouer les states

---------------------------------------------------------------------------

# SALT : Principales commandes

<br>

	* filtrer les targets
			* -E : regexp pcre
			* -G : par grains
			* -C : en combinaison
			* -L : passer une liste
			* -S : sélection sur le cidr

<br>

	* `salt '*' module.fonction args`

<br>

	* --output : 
			* raw : en ligne
			* json : format json
			* yaml : format yaml
			* quiet : mode silencieux
			* nested : par défaut

---------------------------------------------------------------------------

# SALT : Principales commandes

<br>

	* --state-output : mode d'affichage des states dans l'output
			* none : default
			* full : tout
			* change : juste les changements
			* ...

<br>

	* --log-file : où loguer

<br>

	* --async : lancement en mode asynchrone

<br>

	* -b / --batch : préciser le nombre de minionspar cycle

---------------------------------------------------------------------------

# SALT : Principales commandes

<br>

	* --return : où envoyer l'output
			* elasticsearch
			* couchbase
			* cassandra
			* postgresql
			* sentry
			* slack
			* sms...

<br>

	* -t : préciser un timeout

<br>

	* --args-separator : préciser le séparateur d'arguments

<br>

	* -l : le log level
			* all
			* debug
			* info
			* error
			* warning (default)


---------------------------------------------------------------------------

# SALT : Principales commandes

<br>

SALT-CALL


<br>

	* test=true : dry run

<br>

	* -g / --grains : liste de grains (idem grains.items)

<br>

	* --local : run local sans master

<br>

	* --file-root : localisation des fichiers de states

<br>

	* --pillar-root : localisation des pillars

<br>

	* --skip-grains

<br>

	* --refresh-grains-cache

