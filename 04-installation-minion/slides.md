%title: APPRENDRE SALT
%author: xavki


# INSTALLATION : MINION


<br>

ARCHITECTURE

https://docs.saltproject.io/en/latest/topics/salt_system_architecture.html

<br>

INSTALLATION

<br>

Plusieurs type d'installations

* python > pip

* shell de bootstrap 

https://github.com/saltstack/salt-bootstrap

* installation du dépôt et gestionnaire de paquet

-------------------------------------------------------------------------

# INSTALLATION : MINION


<br>

Installation via APT

* ubuntu 20.04

https://docs.saltproject.io/en/latest/topics/installation/ubuntu.html

-------------------------------------------------------------------------

# INSTALLATION : MINION

<br>

* installation du dépôt saltstack

```
wget -qO - https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest/salt-archive-keyring.gpg | sudo apt-key add -
echo "deb https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest focal main" | sudo tee /etc/apt/sources.list.d/salt.list
```

<br>

* installation des paquets

```
sudo apt -y install salt-minion
```

Notes:
  * ports : 4505 et 4506

-------------------------------------------------------------------------

# INSTALLATION : MINION


<br>

sur minion

* nom du salt master (dns) > `salt`

* nom du minion > `/etc/salt/minion_id`

```
sudo systemctl restart salt-minion
```

-------------------------------------------------------------------------

# INSTALLATION : MINION


<br>

* check des fingerprint

```
sudo salt-key -F salt1 # master
sudo salt-call --local key.finger
```

<br>

* liste des clefs à accepter

```
sudo salt-key -L
```

<br>

* acceptation d'une clef

```
sudo salt-key -a salt1
```

<br>

* ping

```
sudo salt 'salt1' test.ping
sudo salt '*' test.ping
```
