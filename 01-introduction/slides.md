%title: APPRENDRE SALT
%author: xavki


# SALTSTACK : INTRODUCTION


<br>

* Infrastructure as Code & Gestionnaire de configurations
		* event driven infrastruture

* Appelé Salt

* Acquis par VMWare en 2020

* Vrai fonctionnement de communauté :
		https://github.com/saltstack/community

Site : https://docs.saltproject.io/
Doc pdf : https://docs.saltproject.io/en/pdf/Salt-3003.1.pdf

------------------------------------------------------------------

# SALTSTACK : INTRODUCTION

<br>

* Origines :
		* Salt Lake City
		* mars 2011
		* langage python
		* fichiers descriptifs en yaml
		* templating : jinja2 (python)
		* queue zeromq
		* différents modes de déploiement
<br>

* Licence Apache - Apache Foundation

------------------------------------------------------------------

# SALTSTACK : INTRODUCTION

<br>

* principe client serveur

* utilisation d'une queue de message ZeroMQ

* mix entre ansible et puppet

* principalement mode pull > à partir d'agent (Minions)

* >> performance à toutes les échelles

* comme puppet : vérification des minions par le master
		* chiffrement via clefs AES

------------------------------------------------------------------

# SALTSTACK : INTRODUCTION

<br>

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

------------------------------------------------------------------

# SALTSTACK : INTRODUCTION

<br>

Avantages:

	* Performance > rapidité

	* Gestion de parcs étendus

	* Polyvalence (network, serveurs, application...)

	* Facilité d'installation

	* différents modes

	* Langages courants

	* différents OS 

------------------------------------------------------------------

# SALTSTACK : INTRODUCTION

<br>

Inconvénients

	* les concepts nombreux

	* le templating

	* moins couramment utilisé que d'autres IaC


CheatSheet : https://github.com/eon01/SaltStackCheatSheet
