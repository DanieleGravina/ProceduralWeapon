tuning armi con GA a singolo obiettivo

single_objective_100_pop_50_iter_simulated_binary_final_* -> contiene risultati i-esima run
	- population -> contiene le popolazioni ottenute nelle 100 generazioni
	- population_cluster -> contiene popolazione finale
	- logbook -> contiene i risultati delle simulazioni ottenute dalle 100 generazioni + log della fitness media e massima per generazione 

avg_single_objective -> contiene la media delle 10 run
	- cluster -> contiene il cluster delle popolazioni finali 

error_single_objective -> errore rispetto a valutazione con goal_score = 40
	- cluster -> contiene il cluster con la rivalutazione

old_single_objective -> vari test fatti in precedenza