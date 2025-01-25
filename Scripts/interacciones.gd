extends Node

var personajes_encontrados = []

func registrar_encuentro(npc: NPC):
	if not(npc in personajes_encontrados):
		personajes_encontrados.append(npc)


# Recibe un par de NPCs y devuelve el outcome de la interacción
func matchear(pj1: NPC, pj2: NPC):
	
	var quiere_1_y_tiene_2 = Utils.interseccion(pj1.quiere, pj2.tiene)	
	var quiere_2_y_tiene_1 = Utils.interseccion(pj2.tiene, pj1.quiere)
	
	var aborrece_1_y_tiene_2 = Utils.interseccion(pj1.aborrece, pj2.tiene)
	var aborrece_2_y_tiene_1 = Utils.interseccion(pj2.aborrece, pj1.tiene)
	
	var aborrecen_en_comun = Utils.interseccion(pj1.aborrece, pj2.aborrece)
	var tienen_en_comun = Utils.interseccion(pj1.tiene, pj2.tiene)
	var quieren_en_comun = Utils.interseccion(pj1.quiere, pj2.quiere)
	
	# Si ambos tienen algo que el otro aborrece
	if aborrece_1_y_tiene_2 and aborrece_2_y_tiene_1:
		# Espantoso, se trauman ambos
		aborrecer(pj1, pj2)
		aborrecer(pj2, pj1)
	
	# Si hay aborrecer unilateral 
	elif aborrece_1_y_tiene_2:
		if quiere_2_y_tiene_1:
			# Se adquieren deseos
			asombrar(pj2, pj1)
		
	elif len(aborrece_2_y_tiene_1):
		if quiere_1_y_tiene_2:
			# Se adquieren deseos
			asombrar(pj1, pj2)
		
	# Ninguno se aborrece
	else:
		
		# Se transmiten ideas
		if tienen_en_comun or aborrecen_en_comun:
			conversar(pj1, pj2)
			conversar(pj2, pj1)
			
		# Se transmiten aborrecencias
		if quieren_en_comun:
			sentenciar(pj1, pj2)
			sentenciar(pj2, pj1)
			
		# Se adquieren deseos
		if quiere_1_y_tiene_2:
			asombrar(pj1, pj2)
		if quiere_2_y_tiene_1:
			asombrar(pj2, pj1)
			
		# Chance se inspiran nuevos deseos
		if randf() < 0.5:
			inspirar(pj1, pj2)
		if randf() < 0.5:
			inspirar(pj2, pj1)

# aka Adquirir deseo. Le agrega a pj1.tiene todo lo de pj2.tiene que esté en pj1.quiere
func asombrar(pj1: NPC, pj2: NPC):
	var deseado = Utils.interseccion(pj1.quiere, pj2.tiene)
	pj2.tiene.append_array(deseado)

	
# Le agrega a pj1.aborrece algo random no repetido de pj2.tiene
func aborrecer(pj1: NPC, pj2: NPC):
	var algo_de_2 = Utils.pick_random(pj2.tiene, 1)
	while algo_de_2[0] in pj1.aborrece: 
		algo_de_2 = Utils.pick_random(pj2.tiene, 1)
	pj1.aborrece.append_array(algo_de_2)


# aka Adquirir ideas. Le agrega a pj1.tiene algo random no repetido de pj2.tiene
func conversar(pj1: NPC, pj2: NPC):
	
	# Si pj1 ya tiene todo de pj2, no hay nada que adquirir
	if len(Utils.interseccion(pj1.tiene, pj2.tiene)) == len(pj2.tiene):
		return
	
	# Buscamos algo de pj2 que pj1 no tenga
	var algo_de_2 = Utils.pick_random(pj2.tiene, 1)
	while algo_de_2[0] in pj1.tiene: 
		algo_de_2 = Utils.pick_random(pj2.tiene, 1)
		
	# Le agregamos a pj1 lo que hayamos encontrado
	pj1.tiene.append_array(algo_de_2)
	

# aka Adquirir aborrecencia. Le agrega a pj1.aborrece algo random no repetido de pj2.aborrece
func sentenciar(pj1: NPC, pj2: NPC):
	
	# Si pj1 ya aborrece todo lo que pj2 aborrece, no hay nada que adquirir
	if len(Utils.interseccion(pj1.aborrece, pj2.aborrece)) == len(pj2.aborrece):
		return
	
	# Buscamos algo de pj2 que pj1 no tenga
	var algo_de_2 = Utils.pick_random(pj2.aborrece, 1)
	while algo_de_2[0] in pj1.aborrece: 
		algo_de_2 = Utils.pick_random(pj2.aborrece, 1)
		
	# Le agregamos a pj1 lo que hayamos encontrado
	pj1.aborrece.append_array(algo_de_2)


# Le agrega a pj1.quiere algo random no repetido de pj2.quiere
func inspirar(pj1: NPC, pj2: NPC):
	# Si pj1 ya desea todo lo que pj2 desea, no hay nada que adquirir
	if len(Utils.interseccion(pj1.quiere, pj2.quiere)) == len(pj2.quiere):
		return
	
	# Buscamos algo de pj2 que pj1 no tenga
	var algo_de_2 = Utils.pick_random(pj2.quiere, 1)
	while algo_de_2[0] in pj1.quiere: 
		algo_de_2 = Utils.pick_random(pj2.quiere, 1)
		
	# Le agregamos a pj1 lo que hayamos encontrado
	pj1.quiere.append_array(algo_de_2)
