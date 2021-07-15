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

------------------------------------------------------------------------------------

# SALT : Définitions & Concepts


<br>

MINIONS

* agents

* commande salt-minion

* référence à un master (ou non)

* vont chercher les informations sur le master (queue)

* masterless possible

* salt-proxy > specific à des appareils réseaux (routers...)

------------------------------------------------------------------------------------

# SALT : Définitions & Concepts


<br>

PILLARS

* ansible > équivalent des variables d'inventaires 

* variables spécifiques à des machines ou groupes de machines

<br>

GRAINS

* ansible > équivalent de gather_fact

* standards ou customs : os, interfaces, volumes...

------------------------------------------------------------------------------------

# SALT : Définitions & Concepts


<br>

STATES

* SLS : SaLt State File

* fichier regroupant une ou plusieurs actions à réaliser (modules/fonctions)

* format yaml et extension .sls

* une action / application d'un module avec des paramètres spécifiques

* une action dispose d'un ID (décrivant la tâche réalisée)

* highstate : jouer l'ensemble des states

<br>

TOP.sls

* fichier décrivant quels machines reçoivent quels state (actions)

------------------------------------------------------------------------------------

# SALT : Définitions & Concepts


<br>

SALT-MINE

* stockage de données des minions sur les master pour exploitation

* utilisable via le module `salt.modules.mine`

<br>

REACTOR

* permet de réaliser des actions suite à des évènements

* event driven

<br>

BEACON

* monitorer des processes (services etc...)

* éventuellement déclencher des actions (scaling, autorestart etc)

