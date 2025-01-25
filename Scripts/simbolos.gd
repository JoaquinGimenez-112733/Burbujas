extends Node


# Contenido

var dominios = ['naturaleza', 'arte', 'progreso']

func dominios_random(n):
	return Utils.pick_random(dominios, n)

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
	return Utils.pick_random(simbolos_de[dominio], cuantos)

# Indexamos los símbolos por dominio
func _ready() -> void:
	for dominio in dominios:
		simbolos_de[dominio] = []

	for simbolo in simbolos:
		simbolos_de[simbolo['dominio']].append(simbolo)
