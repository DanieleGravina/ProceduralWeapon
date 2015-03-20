cluster eseguito con DBSCAN
eps = 0.2
min_samples = 5

Nel file "cluster.txt" ci sono i singoli individui contenuti nel cluster:

per ogni cluster :
	index : indice degli individui nella popolazione finale

	fitness : elenco [fitness, distanza, kill streak] dei singoli individui

	mean balance: media del bilanciamento

	std dev balance: standard deviation del bilanciamento

	mean obj1 : media distanza

	std dev obj1: standard deviation distanza

	mean obj2: media kill streak

	std dev obj2: standard deviation kill streak

	members : elenco delle armi dentro il cluster



cartella "example": contiene i grafici presi come esempio e inseriti nella tesi