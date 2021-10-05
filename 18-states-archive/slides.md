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

* keep_source (true) : pour supprimer l'archive du cache du minion après extraction

* keep (true) : idem keep_source

* password : le mot de passe du zip

* options: options à ajouter à l'estraction zip ou tar

* force (false) : attenion supprime les path déjà existants et recréé

* overwrite (false) : écrase les fichiers quoiqu'il arrive

* clean (false) : supprime tous les répertoires à partir de la racine du name

* clean_parent (false) : idem clean mais un niveau au-dessus

* user : owner

* group : groupe

* if_missing : path à vérifier pour extraire ou non l'archive (si existe déjà)

* trim_output (false) : pour réduire la sortie d'output si trop de fichiers

* use_cmd_unzip (false) : si true utilise la fonction définie dans archive.cmd_unzip

* extract_perms (true) : permet de conserver les permissions si unzip cmd

* enforce_toplevel (true) : pour extraire dans un répertoire supérieur (évite les tar bombes)

* enforce_ownership_on : ajout d'un répertoire alternatif en fonction du user

* archive_format : zip, tar, rar
