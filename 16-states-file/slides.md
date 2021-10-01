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

---------------------------------------------------------------------------

# SALT : States File - part 1

<br>

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


---------------------------------------------------------------------------

# SALT : States File - part 1

<br>

* renommer ou pousser

```
Rename xavki file:
  file.rename:
    name: /tmp/mydir/xavki.bck
    makedirs: true
    source: /tmp/mydir/xavki.txt
```

---------------------------------------------------------------------------

# SALT : States File - part 1

<br>

* commenter des lignes

```
Comment /etc/hosts
  file.comment:
    - name: /etc/hosts
    - regex: ^1.*salt4
    - char: "#"
    - backup: ".bck"
```

---------------------------------------------------------------------------

# SALT : States File - part 1

<br>

* décommenter /etc/hosts

```
Comment /etc/hosts :
  file.uncomment:
    - name: /etc/hosts
    - regex: ^1.*salt4
    - char: "#"
    - backup: ".bck"
```


---------------------------------------------------------------------------

# SALT : States File - part 1

<br>

* décoder un contenu dans un fichier

```
Decode in xavki.txt :
  file.decode:
    - name: /tmp/xavki.txt
    - encoding_type: base64
    - encoded_data: |
        eGF2a2kK
```

---------------------------------------------------------------------------

# SALT : States File - part 1

<br>

ou via un pillar

```
Decode in xavki.txt :
  file.decode:
    - name: /tmp/xavki.txt
    - encoding_type: base64
    - contents_pillar: test:value
```

```
vagrant@salt1:~$ sudo cat /srv/pillar/base/test.sls
test:
  value: "eGF2a2kK"
```

---------------------------------------------------------------------------

# SALT : States File - part 1

<br>

* création d'un répertoire et ses droits

```
Create xavki directory in /tmp :
  file.directory:
    - name: /tmp/xavki
    - user: vagrant
    - group: vagrant
    - mode: 755
```

* Avec récursivité

```
Create xavki directory in /tmp :
  file.directory:
    - name: /tmp/xavki
    - user: vagrant
    - group: vagrant
    - mode: 755
    - file_mode: 644
    - recurse:
      - user
      - mode
```
