%title: APPRENDRE SALT
%author: xavki


# SALT : States File - part 1

<br>

Abonnez-vous et soutenez la chaine Xavki !!!

<br>


Objectifs ?

	* créer des fichiers

	* supprimer des fichiers

	* changer le contenu

	* gestion des liens symboliques

	* utilisation de templates

---------------------------------------------------------------------------

# SALT : States File - part 1


<br>

* vérifier si un fichier existe

```
Check file exist:
  file.exists:
    name: /etc/hosts
```

* créer un fichier avec récersivité

```
Create xavki.txt file:
  file.touch:
    name: /tmp/mydir/xavki.txt
    makedirs: true
```

* autre écriture

```
/tmp/mydir/xavki.txt:
  file.touch:
    - makedirs: true
    - atime: "1332681369"
```

Rq : autres paramètres atime/mtime


* renommer ou pousser

```
Rename xavki file:
  file.rename:
    name: /tmp/mydir/xavki.bck
    makedirs: true
    source: /tmp/mydir/xavki.txt
```

* commenter des lignes

```
Comment /etc/hosts
  file.comment:
    - name: /etc/hosts
    - regex: ^1.*salt4
    - char: "#"
    - backup: ".bck"
```

* décommenter /etc/hosts

```
Comment /etc/hosts :
  file.uncomment:
    - name: /etc/hosts
    - regex: ^1.*salt4
    - char: "#"
    - backup: ".bck"
```


