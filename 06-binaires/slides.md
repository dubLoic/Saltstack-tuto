%title: APPRENDRE SALT
%author: xavki


# SALT : Principaux Binaires


<br>

SALT-KEY

	* sur master

	* management des clefs
			* unaccepted
			* accepted
			* rejected
			* denied

	* acceptation/suppression des minions

	* génération de clef

	* vérification du fingerprint 

	* -l / -L > list clef pour un ou tous les minions

	* -a / -A > accepte 1 ou tous les minions en pending

	* -p / -P > affiche une clef publique

	* -d / -D > supprime une clef ou toutes (attention)

	* -f / -F > affiche un ou les fingerprint
	

---------------------------------------------------------------------------

# SALT : Principaux Binaires

<br>

SALT

	* jouer des modules, fonctions

	* jouer les states

	* filtrer les targets
			* -E : regexp pcre
			* -G : par grains
			* -C : en combinaison
			* -L : passer une liste
			* -S : sélection sur le cidr

	* `salt '*' module.fonction args`

	* --output : 
			* raw : en ligne
			* json : format json
			* yaml : format yaml
			* quiet : mode silencieux
			* nested : par défaut

	* --state-output : mode d'affichage des states dans l'output
			* none : default
			* full : tout
			* change : juste les changements
			* ...

	* --log-file : où loguer

	* --async : lancement en mode asynchrone

	* -b / --batch : préciser le nombre de minionspar cycle

	* --return : où envoyer l'output
			* elasticsearch
			* couchbase
			* cassandra
			* postgresql
			* sentry
			* slack
			* sms...

	* -t : préciser un timeout

	* --args-separator : préciser le séparateur d'arguments

	* -l : le log level
			* all
			* debug
			* info
			* error
			* warning (default)


