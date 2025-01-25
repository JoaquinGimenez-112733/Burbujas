extends Node

var simbolos = {
	 'agua' :  {
		'imagen': preload('res://Assets/ICONOS/AGUA.png'),
		'dominio': 'naturaleza',
	},
	 'escritura' :  {
		'imagen': preload('res://Assets/ICONOS/ESCRITURA.png'),
		'dominio': 'arte',
	},
	 'fabrica' :  {
		'imagen': preload('res://Assets/ICONOS/FABRICA.png'),
		'dominio': 'progreso',
	},
	 'foco' :  {
		'imagen': preload('res://Assets/ICONOS/FOCO.png'),
		'dominio': 'progreso',
	},
	 'fotografía' :  {
		'imagen': preload('res://Assets/ICONOS/FOTOGRAFIA.png'),
		'dominio': 'progreso',
	},
	 'gas' :  {
		'imagen': preload('res://Assets/ICONOS/GAS.png'),
		'dominio': 'progreso',
	},
	 'cultivo' :  {
		'imagen': preload('res://Assets/ICONOS/MANOS.png'),
		'dominio': 'naturaleza',
	},
	 'montañas' :  {
		'imagen': preload('res://Assets/ICONOS/MONTAÑAS.png'),
		'dominio': 'naturaleza',
	},
	 'pintura' :  {
		'imagen': preload('res://Assets/ICONOS/PALETA.png'),
		'dominio': 'arte',
	},
	 'plantita' :  {
		'imagen': preload('res://Assets/ICONOS/PLANTITA.png'),
		'dominio': 'naturaleza',
	},
	 'teatro' :  {
		'imagen': preload('res://Assets/ICONOS/TEATRO.png'),
		'dominio': 'arte',
	},
	 'torre' :  {
		'imagen': preload('res://Assets/ICONOS/TORRE ENERGIA.png'),
		'dominio': 'progreso',
	},
}

# Recibe un par de NPCs y se devuelve los matches entre
# el 'tiene' de uno y el 'quiere' del otro, o null si no hay
func matchear(pj1: NPC, pj2: NPC):
	var de_2_a_1 = []
	for simbolo in pj1.quiere:
		if simbolo in pj2.tiene:
			de_2_a_1.append(pj1.quiere)
	
	var de_1_a_2 = []
	for simbolo in pj2.quiere:
		if simbolo in pj1.tiene:
			de_1_a_2.append(pj1.quiere)
			
	if len(de_1_a_2) > 0 or len(de_2_a_1) > 0:
		return [de_1_a_2, de_2_a_1]
	else:
		return null
	
	
