clustering -> script per fare cluster dei tre esperimenti

server -> script per lanciare i server

testing -> contiene dei test :
	- ParseTestGameSpeed -> test sulla velocità di gioco
	- ParseGoalScore -> test sul Goal Score
	- ParseStatistics -> test sulle statistiche di due armi (Time kill, kill streak, distance, precision)

tuning_single_objective -> dati sugli esperimenti fatti con GA a singolo obiettivo

tuning_single_weapon -> dati relativi a tuning di un'arma singola contro un'arma fissa

tuning_statistics -> data relativi al tuning con GA multiobiettivo
	- distance vs kill_streak
	- delta_time vs kill_streak
	- delta_time vs distance

test_weapons -> contiene script per testare armi nel gioco
