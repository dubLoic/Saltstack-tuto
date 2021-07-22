%title: APPRENDRE SALT
%author: xavki


# SALT : Targeting


<br>

Commande : SALT

Objectif : Comment cibler des server si nécessaire ?


  * filtrer les targets dans les minions
      * glob
      * -E : regexp pcre
      * -G : par grains
      * -C : en combinaison
      * -L : passer une liste
      * -S : sélection sur le cidr

-------------------------------------------------------------------------------

# SALT : Targeting

<br>

GLOB

* faire tourner sur tous les minions

```
sudo salt '*' test.ping
```

<br>

* avec un ou plusieurs caractères manquants

```
sudo salt 's*lt*' test.ping
```

<br>

* ou avec une liste de caractère précis

```
sudo salt 's[a-z]lt*' test.ping
```

-------------------------------------------------------------------------------

# SALT : Targeting

<br>

REGEXP (perl compatible regular expression - pcre)

* contenant des caractères

```
sudo salt 'sa' test.ping
sudo salt -E 'sa' test.ping
```

<br>

* la wildcard

```
sudo salt -E '*' test.ping
sudo salt -E '.*' test.ping
```

-------------------------------------------------------------------------------

# SALT : Targeting

<br>

* énumérer

```
sudo salt -E '[a-z]{4}[0-2]' test.ping
```

<br>

* fin de ligne

```
sudo salt -E '.*[0-2]$' test.ping
```

* début de ligne

```
sudo salt -E '^s.*[0-2]$' test.ping
```

* ou

```
sudo salt -E '.*(1|4)' test.ping
```

-------------------------------------------------------------------------------

# SALT : Targeting

<br>

LIST

* simple liste

```
sudo salt -L 'salt1,salt3' test.ping
```



