cluster eseguito con DBSCAN
eps = 0.2
min_samples = 5

Nel file "cluster.txt" ci sono i singoli individui contenuti nel cluster:

per ogni cluster :
	index : indice degli individui nella popolazione finale

	fitness : elenco [fitness, hit time, distanza] dei singoli individui

	mean balance: media del bilanciamento

	std dev balance: standard deviation del bilanciamento

	mean obj1 : media hit time

	std dev obj1: standard deviation hit time

	mean obj2: media distanza

	std dev obj2: standard deviation distanza

	members : elenco delle armi dentro il cluster