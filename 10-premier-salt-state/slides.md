%title: APPRENDRE SALT
%author: xavki


# SALT : Premier SaLt State


<br>

Salt :

		* grains : facts d'une machine (variables génériques spécifiques)

		* pillars : variables non génériques dédiées à un contexte

		* state : actions dédiées à un but cohérent (application, système...)

		* formule : pillars + states avec un but cohérent d'ensemble

Note : exécution de haut en bas

<br>

* SLS = SaLt State file
		* format yaml

<br>

* déclaration d'un state :

```
id_state:
	module.fonction:
		paramètre1
		paramètre2:
			- a
			- b
			- c
```


