%title: APPRENDRE SALT
%author: xavki


# SALT : States Archive

<br>

Abonnez-vous et soutenez la chaine Xavki !!!

<br>


Objectifs ?

		* copier des fichiers à partir du master

		* télécharger et décompresser des binaires


---------------------------------------------------------------------------------------

# SALT : States Archive


<br>

Quelques paramètres :

* name : répertoire cible

* source : localisation du fichier source

* source_hash : hash du fichier (avec type) ou fichier contenant les hash

* source_hash_name : correspondance du nom de l'archive dans le fichier de hash

* source_hash_update (false) : mise à jour auto si le hash a changé ET le fichier

* skip_files_list_verify (false) : mise à jour auto uniquement sur changement du hash

* skip_verify (false) : ne pas vérifier avec le hash

---------------------------------------------------------------------------------------

# SALT : States Archive


<br>

* keep_source (true) : pour supprimer l'archive du cache du minion après extraction

* keep (true) : idem keep_source

* password : le mot de passe du zip

* options: options à ajouter à l'estraction zip ou tar

* force (false) : attenion supprime les path déjà existants et recréé

* overwrite (false) : écrase les fichiers quoiqu'il arrive

* clean (false) : supprime tous les répertoires à partir de la racine du name

* clean_parent (false) : idem clean mais un niveau au-dessus

---------------------------------------------------------------------------------------

# SALT : States Archive


<br>

* user : owner

* group : groupe

* if_missing : path à vérifier pour extraire ou non l'archive (si existe déjà)

* trim_output (false) : pour réduire la sortie d'output si trop de fichiers

* use_cmd_unzip (false) : si true utilise la fonction définie dans archive.cmd_unzip

* extract_perms (true) : permet de conserver les permissions si unzip cmd

* enforce_toplevel (true) : pour extraire dans un répertoire supérieur (évite les tar bombes)

* enforce_ownership_on : ajout d'un répertoire alternatif en fonction du user

* archive_format : zip, tar, rar

---------------------------------------------------------------------------------------

# SALT : States Archive


<br>

* exemple node exporter

sudo mkdir -p /srv/salt/base/arch/files

wget https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz

sudo mv node_exporter-1.2.2.linux-amd64.tar.gz /srv/salt/base/arch/files/


---------------------------------------------------------------------------------------

# SALT : States Archive


<br>

* ne pas utiliser file.managed (pas d'extraction)

```
Push node exporter:
  file.managed:
    - name: /usr/local/bin/node-exporter.tar.gz
    - source: salt://arch/files/node_exporter-1.2.2.linux-amd64.tar.gz
```

---------------------------------------------------------------------------------------

# SALT : States Archive


<br>

* avec archive.extracted

```
Push node exporter and extract:
  archive.extracted:
    - name: /tmp/
    - source: salt://arch/files/node_exporter-1.2.2.linux-amd64.tar.gz
```

---------------------------------------------------------------------------------------

# SALT : States Archive


<br>

* enchainement pour déplacer le fichier dans le PATH

```
{% set node_exporter_version = "1.2.2.linux-amd64" %}
Push node exporter:
  archive.extracted:
    - name: /tmp/
    - source: salt://arch/files/node_exporter-{{ node_exporter_version }}.tar.gz
Move binary:
  file.managed:
    - source: /tmp/node_exporter-{{ node_exporter_version }}/node_exporter
    - name: /usr/local/bin/node-exporter
    - mode: 755
    - user: root
    - group: root
```

Rq : ne pas utiliser la définiton set (pillars ou map.jinja)


---------------------------------------------------------------------------------------

# SALT : States Archive


<br>

* jouer uniquement si le fichier manque

```
Push node exporter:
  archive.extracted:
    - name: /tmp/
    - source: salt://arch/files/node_exporter-{{ node_exporter_version }}.tar.gz
    - if_missing: /usr/local/bin/node-exporter
```

---------------------------------------------------------------------------------------

# SALT : States Archive


<br>

* uniquement sur changement on bouge

```
{% set node_exporter_version = "1.2.2.linux-amd64" %}
Push node exporter:
  archive.extracted:
    - name: /tmp/
    - source: salt://arch/files/node_exporter-{{ node_exporter_version }}.tar.gz
    - if_missing: /usr/local/bin/node-exporter
Move binary:
  file.managed:
    - source: /tmp/node_exporter-{{ node_exporter_version }}/node_exporter
    - name: /usr/local/bin/node-exporter
    - mode: 755
    - user: root
    - group: root
    - onchanges:
      - archive: Push node exporter
```

---------------------------------------------------------------------------------------

# SALT : States Archive


<br>

* vérification du hash et téléchargement

```
Push node exporter:
  archive.extracted:
    - name: /tmp/
    - source: https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-{{ node_exporter_version }}.tar.gz
    - if_missing: /usr/local/bin/node-exporter
    - source_hash: https://github.com/prometheus/node_exporter/releases/download/v1.2.2/sha256sums.txt
    - source_hash_name: node_exporter-1.2.2.linux-amd64.tar.gz
```

---------------------------------------------------------------------------------------

# SALT : States Archive


<br>

* cache

```
/var/cache/salt/minion/extrn_files/base/github.com/prometheus/node_exporter
```

* clean du tar.gz après (ne supprime pas les aures fichiers)

```
- keep_source: false
```
