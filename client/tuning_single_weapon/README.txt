tuning arma target contro arma fissa

armi : 
Weapon_Fixed = [1.05,  0.1,     30,      1,     8, 1350, 100,       42,      0, 220]

Weapon_Target = [1.1,   0.1,   30,      9,     2, 3500,  18,       20,      0, 0]

50_pop_50_iter_simulated_binary_final_* -> contiene risultati i-esima run
	- population -> contiene le popolazioni ottenute nelle 50 generazioni
	- population_cluster -> contiene popolazione finale
	- logbook -> contiene i risultati delle simulazioni ottenute dalle 100 generazioni + log della fitness media e massima per generazione 

pareto_of_pareto_single_weapon -> pareto di pareto delle 10 run
	- cluster -> contiene il cluster delle popolazioni finali 

error_single_weapon -> errore rispetto a valutazione con 40 goal_score
	- cluster -> contiene il cluster con la rivalutazione

recover-> script per recuperare run non finite

old_single_weapon -> vecchi test