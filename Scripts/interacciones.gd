extends Node

# Recibe un par de NPCs y devuelve el outcome de la 
# interacción como una lista de acciones (para procesar después)
func interactuar(pj1: NPC, pj2: NPC):
	
	var interacciones = []
	
	var quiere_1_y_tiene_2 = Utils.interseccion(pj1.quiere, pj2.tiene)	
	var quiere_2_y_tiene_1 = Utils.interseccion(pj2.tiene, pj1.quiere)
	
	var aborrece_1_y_tiene_2 = Utils.interseccion(pj1.aborrece, pj2.tiene)
	var aborrece_2_y_tiene_1 = Utils.interseccion(pj2.aborrece, pj1.tiene)
	
	var aborrece_1_y_quiere_2 = Utils.interseccion(pj1.aborrece, pj2.quiere)
	var aborrece_2_y_quiere_1 = Utils.interseccion(pj2.aborrece, pj1.quiere)
	
	var aborrecen_en_comun = Utils.interseccion(pj1.aborrece, pj2.aborrece)
	var tienen_en_comun = Utils.interseccion(pj1.tiene, pj2.tiene)
	var quieren_en_comun = Utils.interseccion(pj1.quiere, pj2.quiere)
	
	#Si uno quiere lo que el otro aborrece y viceversa, se alienan
	if aborrece_1_y_quiere_2:
		interacciones.append({'accion': 'alienar','quien': pj1, 'a_quien': pj2 })
		
	if aborrece_2_y_quiere_1:	
		interacciones.append({'accion': 'alienar','quien': pj2, 'a_quien': pj1 })
	
	# Si ambos tienen algo que el otro aborrece
	if aborrece_1_y_tiene_2 and aborrece_2_y_tiene_1:
		# Espantoso, se trauman ambos
		interacciones.append({ 'accion': 'aborrecer', 'quien': pj1, 'a_quien': pj2})
		interacciones.append({ 'accion': 'aborrecer', 'quien': pj2, 'a_quien': pj1})
		
	# Si hay aborrecer unilateral 
	elif aborrece_1_y_tiene_2 or aborrece_2_y_tiene_1:
		 
		# Aun uno puede aprender del otro
		if aborrece_1_y_tiene_2:
			if quiere_2_y_tiene_1:
				# Se adquieren lo que se desea y el otro tenga
				interacciones.append({ 'accion': 'asombrar', 'quien': pj2, 'a_quien': pj1})
			
		if aborrece_2_y_tiene_1:
			if quiere_1_y_tiene_2:
				# Se adquieren lo que se desea y el otro tenga
				interacciones.append({ 'accion': 'asombrar', 'quien': pj1, 'a_quien': pj2})
		
	# Ninguno se aborrece
	else:
		
		# Se transmiten ideas
		if tienen_en_comun or aborrecen_en_comun:
			interacciones.append({ 'accion': 'conversar', 'quien': pj1, 'a_quien': pj2})
			interacciones.append({ 'accion': 'conversar', 'quien': pj2, 'a_quien': pj1})
			
		# Se transmiten aborrecencias
		if quieren_en_comun:
			interacciones.append({ 'accion': 'sentenciar', 'quien': pj1, 'a_quien': pj2})
			interacciones.append({ 'accion': 'sentenciar', 'quien': pj2, 'a_quien': pj1})
			
		# Se adquieren deseos
		if quiere_1_y_tiene_2:
			interacciones.append({ 'accion': 'asombrar', 'quien': pj1, 'a_quien': pj2})
		if quiere_2_y_tiene_1:
			interacciones.append({ 'accion': 'asombrar', 'quien': pj2, 'a_quien': pj1})
			
		# Chance se inspiran nuevos deseos
		if randf() < 0.5:
			interacciones.append({ 'accion': 'inspirar', 'quien': pj1, 'a_quien': pj2})
		if randf() < 0.5:
			interacciones.append({ 'accion': 'inspirar', 'quien': pj2, 'a_quien': pj1})
			
	return interacciones

# Recibe una acción a ejecutar y la despacha al handler apropiado
func despachar(interaccion): 
	var de = interaccion['quien']
	var a = interaccion['a_quien']
	if interaccion['accion'] == 'aborrecer':
		aborrecer(de, a)
	if interaccion['accion'] == 'asombrar':
		asombrar(de, a)
	if interaccion['accion'] == 'conversar':
		conversar(de, a)
	if interaccion['accion'] == 'sentenciar':
		sentenciar(de, a)
	if interaccion['accion'] == 'inspirar':
		inspirar(de, a)
	if interaccion['accion']	 == 'alienar':
		alienar(de, a)


func alienar(pj1: NPC, pj2: NPC):
	var opuestos = Utils.interseccion(pj1.quiere, pj2.aborrece)
	var opuesto = Utils.pick_random(opuestos, 1)[0]
	pj1.quiere.erase(opuesto)
	pj1.aborrece.append(opuesto)
	pj2.quiere.erase(opuesto)
	pj2.aborrece.append(opuesto)
	
	print('Alienar de ', pj1.nombre, ' con ', pj2.nombre, '... invirtiendo [', opuesto['nombre'], ']...')
	
	# Ver si se pueden paralelizar
	await pj1.on_alienar(opuesto)
	await pj2.on_alienar(opuesto)
	
	
# aka Adquirir deseo. Le agrega a pj1.tiene todo lo de pj2.tiene que esté en pj1.quiere
func asombrar(pj1: NPC, pj2: NPC):
	var deseado = Utils.interseccion(pj1.quiere, pj2.tiene)
	pj2.tiene.append_array(deseado)
	
	print(pj1.nombre, ' adquiriendo [', deseado[0]['nombre'] ,'] por asombro con ', pj2.nombre, '...')
	
	await pj1.on_asombrar(deseado)


# Le agrega a pj1.aborrece algo random no repetido de pj2.tiene
func aborrecer(pj1: NPC, pj2: NPC):
	var algo_de_2 = Utils.pick_random(pj2.tiene, 1)
	while algo_de_2[0] in pj1.aborrece: 
		algo_de_2 = Utils.pick_random(pj2.tiene, 1)
	pj1.aborrece.append_array(algo_de_2)
	
	print(pj1.nombre, ' aborreciendo [', algo_de_2[0]['nombre'] ,'] por aborrecemiento de ', pj2.nombre, '...')
	
	await pj1.on_aborrecer(algo_de_2[0])
	

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
	
	print(pj1.nombre, ' adquiriendo [', algo_de_2[0]['nombre'], '] de ', pj2.nombre, ' por conversación...')
	
	await pj1.on_conversar(algo_de_2[0])
	

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
	
	print(pj1.nombre, ' aborreciendo [', algo_de_2[0]['nombre'], '] por andar sentenciando con ', pj2.nombre, '...')
	
	await pj1.on_sentenciar(algo_de_2[0])


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
	
	print(pj1.nombre, ' queriendo [', algo_de_2[0]['nombre'], '] inspirado por ', pj2.nombre)
	
	await pj1.on_inspirar(algo_de_2[0])
