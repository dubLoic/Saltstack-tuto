%title: APPRENDRE SALT
%author: xavki


# SALT : Modules & Fonctions


<br>

* ping

```
sudo salt '*' test.ping
```

Note :

		* test > module

		* ping > fonction du module ping

--------------------------------------------------------------

# SALT : Modules & Fonctions

<br>

* liste des modules

```
sudo salt '*' sys.list_modules
```

<br>

* liste des fonctions

```
sudo salt '*' sys.list_functions
sudo salt '*' sys.list_functions test
```

--------------------------------------------------------------

# SALT : Modules & Fonctions

<br>

* documentation

```
sudo salt '*' sys.doc test
sudo salt '*' sys.doc test.ping
```

```
sudo salt '*' sys.list_modules | grep pkg
```

--------------------------------------------------------------

# SALT : Modules & Fonctions

<br>

* installation de paquets

```
sudo salt '*' sys.doc pkg.install
```

```
sudo salt '*' pkg.install nginx
```

<br>

* stop/start...

```
sudo salt '*' sys.doc service
```
