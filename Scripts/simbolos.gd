extends Node

# Devuelve una sublista al azar, sin repeticiones. 
func pick_random(lista: Array, n: int):
	var dup = lista.duplicate()
	var res = []
	for i in range(n):
		var elem = dup.pop_at(randi_range(0, dup.size() - 1))
		res.append(elem)
	return res
	
# Devueve la intersección de dos listas. 
func interseccion(lista1: Array, lista2: Array):
	var elems = []
	for elem in lista1: 
		if elem in lista2:
			elems.append(elem)
	return elems
	
# Contenido

var dominios = ['naturaleza', 'arte', 'progreso']

func dominios_random(n):
	return pick_random(dominios, n)

var simbolos = [
	{
		'nombre': 'agua',
		'imagen': preload('res://Assets/ICONOS/AGUA.png'),
		'dominio': 'naturaleza',
	},
	{
		'nombre': 'escritura',
		'imagen': preload('res://Assets/ICONOS/ESCRITURA.png'),
		'dominio': 'arte',
	},
	{
		'nombre': 'fabrica',
		'imagen': preload('res://Assets/ICONOS/FABRICA.png'),
		'dominio': 'progreso',
	},
	{
		'nombre': 'foco',
		'imagen': preload('res://Assets/ICONOS/FOCO.png'),
		'dominio': 'progreso',
	},
	{
		'nombre': 'fotografía',
		'imagen': preload('res://Assets/ICONOS/FOTOGRAFIA.png'),
		'dominio': 'progreso',
	},
	{
		'nombre': 'gas',
		'imagen': preload('res://Assets/ICONOS/GAS.png'),
		'dominio': 'progreso',
	},
	{
		'nombre': 'cultivo',
		'imagen': preload('res://Assets/ICONOS/MANOS.png'),
		'dominio': 'naturaleza',
	},
	{
		'nombre': 'montañas',
		'imagen': preload('res://Assets/ICONOS/MONTAÑAS.png'),
		'dominio': 'naturaleza',
	},
	{
		'nombre': 'pintura',
		'imagen': preload('res://Assets/ICONOS/PALETA.png'),
		'dominio': 'arte',
	},
	{
		'nombre': 'plantita',
		'imagen': preload('res://Assets/ICONOS/PLANTITA.png'),
		'dominio': 'naturaleza',
	},
	{
		'nombre': 'teatro',
		'imagen': preload('res://Assets/ICONOS/TEATRO.png'),
		'dominio': 'arte',
	},
	{
		'nombre': 'torre',
		'imagen': preload('res://Assets/ICONOS/TORRE ENERGIA.png'),
		'dominio': 'progreso',
	},
]

func traer(txt):
	for simbolo in simbolos:
		if simbolo['nombre'] == txt:
			return simbolo
	return null

var simbolos_de = {}

func simbolos_random_de(dominio, cuantos):
	if dominio not in simbolos_de:
		print('ERROR: ', dominio, ' no está entre nuestros dominios')
		return []
	return pick_random(simbolos_de[dominio], cuantos)

# Indexamos los símbolos por dominio
func _ready() -> void:
	for dominio in dominios:
		simbolos_de[dominio] = []

	for simbolo in simbolos:
		simbolos_de[simbolo['dominio']].append(simbolo)


# Recibe un par de NPCs y devuelve el outcome de la interacción
func matchear(pj1: NPC, pj2: NPC):
	
	var quiere_1_y_tiene_2 = interseccion(pj1.quiere, pj2.tiene)	
	var quiere_2_y_tiene_1 = interseccion(pj2.tiene, pj1.quiere)
	
	var aborrece_1_y_tiene_2 = interseccion(pj1.aborrece, pj2.tiene)
	var aborrece_2_y_tiene_1 = interseccion(pj2.aborrece, pj1.tiene)
	
	var aborrecen_en_comun = interseccion(pj1.aborrece, pj2.aborrece)
	var tienen_en_comun = interseccion(pj1.tiene, pj2.tiene)
	var quieren_en_comun = interseccion(pj1.quiere, pj2.quiere)
	
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
	var deseado = interseccion(pj1.quiere, pj2.tiene)
	pj2.tiene.append_array(deseado)

	
# Le agrega a pj1.aborrece algo random no repetido de pj2.tiene
func aborrecer(pj1: NPC, pj2: NPC):
	var algo_de_2 = pick_random(pj2.tiene, 1)
	while algo_de_2[0] in pj1.aborrece: 
		algo_de_2 = pick_random(pj2.tiene, 1)
	pj1.aborrece.append_array(algo_de_2)


# aka Adquirir ideas. Le agrega a pj1.tiene algo random no repetido de pj2.tiene
func conversar(pj1: NPC, pj2: NPC):
	
	# Si pj1 ya tiene todo de pj2, no hay nada que adquirir
	if len(interseccion(pj1.tiene, pj2.tiene)) == len(pj2.tiene):
		return
	
	# Buscamos algo de pj2 que pj1 no tenga
	var algo_de_2 = pick_random(pj2.tiene, 1)
	while algo_de_2[0] in pj1.tiene: 
		algo_de_2 = pick_random(pj2.tiene, 1)
		
	# Le agregamos a pj1 lo que hayamos encontrado
	pj1.tiene.append_array(algo_de_2)
	

# aka Adquirir aborrecencia. Le agrega a pj1.aborrece algo random no repetido de pj2.aborrece
func sentenciar(pj1: NPC, pj2: NPC):
	
	# Si pj1 ya aborrece todo lo que pj2 aborrece, no hay nada que adquirir
	if len(interseccion(pj1.aborrece, pj2.aborrece)) == len(pj2.aborrece):
		return
	
	# Buscamos algo de pj2 que pj1 no tenga
	var algo_de_2 = pick_random(pj2.aborrece, 1)
	while algo_de_2[0] in pj1.aborrece: 
		algo_de_2 = pick_random(pj2.aborrece, 1)
		
	# Le agregamos a pj1 lo que hayamos encontrado
	pj1.aborrece.append_array(algo_de_2)


# Le agrega a pj1.quiere algo random no repetido de pj2.quiere
func inspirar(pj1: NPC, pj2: NPC):
	# Si pj1 ya desea todo lo que pj2 desea, no hay nada que adquirir
	if len(interseccion(pj1.quiere, pj2.quiere)) == len(pj2.quiere):
		return
	
	# Buscamos algo de pj2 que pj1 no tenga
	var algo_de_2 = pick_random(pj2.quiere, 1)
	while algo_de_2[0] in pj1.quiere: 
		algo_de_2 = pick_random(pj2.quiere, 1)
		
	# Le agregamos a pj1 lo que hayamos encontrado
	pj1.quiere.append_array(algo_de_2)
