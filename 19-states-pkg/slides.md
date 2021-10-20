%title: APPRENDRE SALT
%author: xavki


# SALT : States Pkg

<br>

Abonnez-vous et soutenez la chaine Xavki !!!

<br>


Objectifs ?

		* installer des paquets

		* installer des dépôts

		* multi OS

---------------------------------------------------------------------------------------

# SALT : States Pkg


<br>

* Download d'un package

sudo apt-cache policy haproxy

```
haproxy:
  pkg.downloaded:
    - disablerepo: updates,base
    - version: 2.0.13-2ubuntu0.3
```

* check

```
ls /var/cache/apt/archives/
```

---------------------------------------------------------------------------------------

# SALT : States Pkg

<br>

* Install d'une liste avec version

```
Install haproxy:
  pkg.installed:
    - pkgs:
      - haproxy: 2.0.13-2ubuntu0.3
```

---------------------------------------------------------------------------------------

# SALT : States Pkg

<br>

* Creates : ne joue pas le states si le fichier existe

```
Install haproxy:
  pkg.installed:
    - pkgs:
      - haproxy: 2.0.13-2ubuntu0.3
    - install_recommends: True
    - creates:
      - /tmp/xavki.txt
```

---------------------------------------------------------------------------------------

# SALT : States Pkg

<br>

* update du cache et durée de validité

```
Install haproxy:
  pkg.installed:
    - pkgs:
      - haproxy: 2.0.13-2ubuntu0.3
    - install_recommends: True
    - cache_valid_time: 3600
    - refresh: True
```

---------------------------------------------------------------------------------------

# SALT : States Pkg

<br>

* fixer la version

```
Install vim-haproxy:
  pkg.installed:
    - name: vim-haproxy
    - version: 2.0.13-2ubuntu0.3
    - install_recommends: True
    - cache_valid_time: 3600
    - refresh: True
    - hold: true
```

Forcer la mise à jour  > update_holds = True

---------------------------------------------------------------------------------------

# SALT : States Pkg

<br>

* s'assurer d'avoir la dernière version

```
Ensure latest version haproxy:
  pkg.latest:
    - name: haproxy
    - refresh: True
```

---------------------------------------------------------------------------------------

# SALT : States Pkg

<br>

* suppression d'un ou plusieurs packages

```
Remove haproxy:
  pkg.removed:
    - name: haproxy
```

---------------------------------------------------------------------------------------

# SALT : States Pkg

<br>

* upgrade des paquets

```
sudo apt list --upgradable

Ensure upgrade uptodate:
  pkg.uptodate:
    - name: None
```

---------------------------------------------------------------------------------------

# SALT : States Pkg

<br>

* Exemple docker : installation d'un repository (docker) 

```
Add docker repository:
  pkgrepo.managed:
    - name: deb [arch=amd64] https://download.docker.com/linux/{{ grains['os'] | lower }} {{ grains['oscodename'] }} stable
    - file: /etc/apt/sources.list.d/docker.list
    - keyid: 0EBFCD88
    - keyserver: https://download.docker.com/linux/ubuntu/gpg
    - refresh_db: true
```

---------------------------------------------------------------------------------------

# SALT : States Pkg

<br>

* Exemple docker : installation des packages

```
Install docker packages:
  pkg.installed:
    - pkgs:
      - docker-ce
      - docker-ce-cli
      - containerd.io
    - cache_valid_time: 3600
    - refresh: True
```

---------------------------------------------------------------------------------------

# SALT : States Pkg

<br>

* Exemple docker : ajout du user vagrant au groupe docker

```
Add vagrant user docker group:
  group.present:
    - name: docker
    - addusers:
      - vagrant
```

