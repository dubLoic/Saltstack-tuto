%title: APPRENDRE SALT
%author: xavki


# SALT : Définitions & Concepts


<br>

MASTER

* serveur central

* commande salt-master

* multi-master possible (haute dispo)

* serveur portant la queue zero-mq

* salt-syndic : master intermédiaire entre master/agents


MINIONS

* agents

* commande salt-minion

* référence à un master (ou non)

* vont chercher les informations sur le master (queue)

* masterless possible

* salt-proxy > specific à des appareils réseaux (routers...)

PILLARS


GRAINS


STATES

* fichier regroupant une ou plusieurs actions à réaliser

* format yaml et extension .sls

* une action / application d'un module avec des paramètres spécifiques

* une action dispose d'un ID (décrivant la tâche réalisée)

* highstate : jouer l'ensemble des states

SLS

SALT-MINE

* stockage de données des minions sur les master pour exploitation

* utilisable via le module `salt.modules.mine`

Reactor






https://docs.saltproject.io/en/latest/topics/salt_system_architecture.html
