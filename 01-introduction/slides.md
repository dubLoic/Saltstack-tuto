%title: APPRENDRE SALT
%author: xavki


# SALTSTACK : INTRODUCTION


* Appelé Salt

* Origines :
		* Salt Lake City
		* mars 2011
		* langage python
		* fichiers descriptifs en yaml
		* templating : jinja2 (python)

* Licence Apache

* Gestion de configurations > infrastructure

* principe client serveur

* utilisation d'une queue de message ZeroMQ

* mix entre ansible et puppet

* mode pull > à partir d'agent (Minions)

* >> performance à toutes les échelles

* comme puppet : vérification des minions par le master
		* chiffrement via clefs AES

* différentes définitions :
		* Master
		* Minions
		* Pillars
		* Grains
		* Formules
		* Modules
		* State
		* Mine
		* Rôle
		...

Avantages:

	* Performance > rapidité

	* Gestion de parcs étendant

	* Polyvalence (network, serveurs, application...)

	* Facilité d'installation

	* Masterless

	* Langages courants

	* différents OS 

Inconvénients

	* les concepts nombreux

	* le templating

	* moins couramment utilisé que d'autres IaC








CheatSheet : https://github.com/eon01/SaltStackCheatSheet
