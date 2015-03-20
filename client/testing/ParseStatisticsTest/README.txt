Script per parsing delle statistiche di due armi
Statistiche : Time kill, kill streak, distance, precision

result_* -> contiene i risultati di un esperimento con 2 armi, 100 simulazioni

	weapons -> contiene il cluster di armi provate (il test viene fatto con la media del cluster)

	statistics -> contiene i risultati così divisi:
		1° server
		        1°bot : 
				[time kill]
				[distance]
				[kill streak]
				[precision]
			2°bot :
				[time kill]
				[distance]
				[kill streak]
				[precision]
		***********************************
		2° server 
		...

		ci sono un tot di prove per server, sempre relative alle stesse due armi, per un totale di 100 simulazioni
		